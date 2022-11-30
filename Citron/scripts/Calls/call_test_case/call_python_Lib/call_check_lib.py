# _*_ coding: utf-8 _*_ #
# @Time     :11/28/2022 1:19 PM
# @Author   :Huiming Shi
#----------------------------------------------------------------------------------------------------#
from Citron.public_switch.pubLib import *
from Citron.public_switch.public_switch_py import IMPLICIT_WAIT
from Citron.scripts.Calls.call_test_case.call_python_Lib.call_action_lib import \
    click_show_directory_when_invite_3rd as CSDWI3, \
    in_call_click_message_button as ICCMB, click_invite_user_div as CIUD
from public_settings_and_variable import *

#----------------------------------------------------------------------------------------------------#


def check_user_show_up_or_not_when_invite_3rd(driver,count_expect,if_click = 'no_click_show'):
    """
    check 'Show Directory' button show up or not when invite 3rd user
    :param driver:
    :param count_expect: 预期count of user
    :param if_click: 是否勾选‘Show Directory’；默认'no_click_show'不勾选；'click_show'为勾选
    :return:
    """
    # try:
    if int(count_expect) == 1:
        public_check_element(driver, '//label[contains(.,"Show Directory")]', 'Show Directory字段未出现', if_click=None)
    elif int(count_expect) == 0:
        public_check_element(driver, '//label[contains(.,"Show Directory")]', 'Show Directory字段出现了', if_click=None, if_show = None)
    public_check_element(driver, '//div[@id="inviteDialog"]//div[@class="ag-center-cols-container"]//div', 'Contacts列表没有数据', if_click=None)
    if if_click != 'no_click_show':
        CSDWI3(driver)

def user_end_call_by_self(driver):
    """
    用户自己主动END Call
    :param driver:
    :return:
    """
    # End call
    public_check_element(driver, end_call_before_connecting, '主动End_call失败')

def show_incoming_call_name_avator(driver1,driver2,expect_src,expect_name):
    """
    断言进来的call，所展示的avator和name是否正确
    :param driver1:
    :param driver2:
    :param expect_src: 预期的avator，是src属性值中的字符串
    :param expect_name: 预期的name
    :return:
    """
    # 获取进来的call所显示的avator和name
    src_attribute = get_xpath_element(driver1,'//div[@id="incoming_avatarImage"]/img',description = 'avatar').get_attribute('src')
    print(src_attribute)
    print(expect_src)
    name_attribute = get_xpath_element(driver1,'//div[@id="incoming_caller_name"]',description = 'name').get_attribute("textContent")
    print(name_attribute)
    print(expect_name)
    # 进行avator和name的断言
    public_assert(driver1,expect_src , src_attribute,condition='in',action='预期的avator和实际上的avator不一致')
    public_assert(driver1, str(name_attribute) , str(expect_name), action='预期的name和实际上的name不一致')
    # End call
    user_end_call_by_self(driver2)

def display_name_avator_in_contact_list(driver,search_name,expect_src):
    """
    # 通话过程中进入Contacts列表页面，所展示的avator和name是否正确
    :param driver:
    :param search_name: 要查询的name，同时也是预期的name
    :param expect_src:预期的avator，是src属性值中的字符串
    :return:
    """
    # 获取name和avator
    xpath_src = f'//div[@class="contact-name" and contains(.,"{search_name}")]/../../../../div[@col-id="avatar.url"]//img'
    src_attribute = get_xpath_element(driver,xpath_src,description = 'avatar').get_attribute('src')
    print(src_attribute)
    name_xpath = f'//div[@class="contact-name" and contains(.,"{search_name}")]'
    name_attribute = get_xpath_element(driver,name_xpath,description = 'name').get_attribute('textContent')
    print(name_attribute)
    # 进行avator和name的断言
    public_assert(driver,expect_src , src_attribute,condition='in',action='预期的avator和实际上的avator不一致')
    public_assert(driver, str(name_attribute) , str(search_name), action='预期的name和实际上的name不一致')

def check_call_can_reach_to_or_not(driver_master,driver_support,meeting_link,flag = '1'):
    """
    校验call是否可以建立，需要ACCEPT Disclaimer
    :param driver_master:
    :param driver_support:
    :param meeting_link:
    :param flag: 1代表call can reach；0代表call can not reach
    :return:
    """
    js = "window.open('{}','_blank');"
    driver_support.execute_script(js.format(meeting_link))
    driver_support.switch_to.window(driver_support.window_handles[-1])  # 切换到最新页面
    driver_support.implicitly_wait(3)
    for i in range(40):
        ele_list_2 = get_xpath_elements(driver_support,please_wait)
        ele_list_1 = get_xpath_elements(driver_support, zhuanquanquan)
        ele_list = get_xpath_elements(driver_support,'//div[@id="connecting_call_label" and text()="Waiting for an incoming call..."]')
        if len(ele_list) == 0 and len(ele_list_1) == 0 and len(ele_list_2) == 0:
            break
        elif i == 39:
            screen_shot_func(driver_support, '未处于可以判断是否可以拨通call的状态')
            raise Exception('未处于可以判断是否可以拨通call的状态')
        else:
            time.sleep(3)
    driver_support.implicitly_wait(IMPLICIT_WAIT)
    count = get_xpath_elements(driver_support,accept_disclaimer)
    if len(count) == 1:
        public_click_element(driver_support,accept_disclaimer,description = 'accept_disclaimer按钮')
    time.sleep(8)
    count_support = get_xpath_elements(driver_support,end_call_before_connecting)
    driver_master.implicitly_wait(int(8))
    count_master_1 = get_xpath_elements(driver_master,anwser_call_button)
    count_master_2 = get_xpath_elements(driver_master,external_join_call_anwser_button)
    driver_master.implicitly_wait(int(IMPLICIT_WAIT))
    print('如果下面assert断言出现AssertionError了，则表示电话不应该打通的却打通了，或者电话应该打通却没有打通')
    try:
        if flag == '1':
            assert len(count_support) == int(flag)
            assert len(count_master_1) == int(flag) or len(count_master_2) == int(flag)
        elif flag == '0':
            assert len(count_master_1) == int(flag) and len(count_master_2) == int(flag)
    except AssertionError:
        print('Assert断言失败')
        screen_shot_func(driver_support,'辅助browser断言失败')
        screen_shot_func(driver_master, 'browser断言失败')
        raise AssertionError
    if int(flag) == 1:
        public_click_element(driver_support,end_call_before_connecting,description = '提前End_call按钮')

def in_call_show_count_of_message(driver,message_count = '1'):
    """
    校验未读消息数
    :param driver:
    :param message_count: 预期未读消息数
    :return:
    """
    ele_list = get_xpath_elements(driver,f'//div[@class="Badge"]/div[text()="{int(message_count)}"]')
    public_assert(driver,1,len(ele_list),f'校验未读消息数为{int(message_count)}')

def in_call_check_receive_message(driver,content,open_dialog='true',content_count='1'):
    """
    通话过程中检查收到的message内容
    :param driver:
    :param content: 预期收到的消息内容
    :return:
    """
    # 通话过程中点击message图标，打开Message会话
    ICCMB(driver)
    # 通话过程中检查收到的message内容和数量
    ele_list = get_xpath_elements(driver,in_call_lastMessages_text.format(content))
    public_assert(driver, len(ele_list), 1, action=f'{content}未收到')

def in_call_check_receive_attach(driver,attach_name,attach_count='1'):
    """
    通话过程中检查收到的附件内容和数量
    :param driver:
    :param attach_name: 附件名
    :param attach_count: 预期的附件个数，默认为1
    :return:
    """
    ele_list = get_xpath_elements(driver, in_call_lastMessages_attach.format(attach_name))
    print(len(ele_list))
    print(int(attach_count))
    public_assert(driver, len(ele_list), int(attach_count), action=f'{attach_name}未找到')

def file_is_too_large(driver):
    """
    There is an alert message to pop. The big file isn't uploaded.
    :param driver:
    :return:
    """
    get_content = get_xpath_element(driver,'//div[@class="modal-body"]').get_attribute("textContent")
    public_assert(driver,get_content,"The file you have selected is too large and cannot be uploaded. The limit is 5MB.",action='断言提示信息')
    # 点击OK关闭弹窗
    public_click_element(driver,'//button[@class="btn btn-default" and text()="OK"]')
    # 再次点击上传附件按钮，关闭上传
    public_click_element(driver, message_toolbarButton, description='再次点击上传附件按钮')

def participants_icon_is_visible(driver,visible = "yes"):
    """
    在call通话中，右侧的参与者图标是否展示
    :param driver:
    :param visible:参与者图标是否可见，默认yes可见
    :return:
    """
    ele_list = get_xpath_elements(driver, f2f_on_mode)
    if visible == "yes":
        public_assert(driver, 1, len(ele_list), action="参与者图标应该可见")
    else:
        public_assert(driver, 0, len(ele_list), action="参与者图标应该不可见")

def invite_button_should_be_hidden(driver,hidden = "yes"):
    """
    通话过程中的invite按钮不可见
    :param driver:
    :param hidden: 是否隐藏？默认yes隐藏
    :return:
    """
    CIUD(driver)
    ele_list = get_xpath_elements(driver,enter_invite_user_page)
    if hidden == "yes":
        public_assert(driver, 0, len(ele_list), action="invite按钮应该被隐藏")
    else:
        public_assert(driver, 1, len(ele_list), action="invite按钮不应该被隐藏")
    CIUD(driver)

def check_participants_correct(driver,*args):
    """
    点击入会者按钮，检查每个入会者名称按照顺序正确
    :param driver:
    :param args: 每个入会者的name
    :return:
    """
    ele_list = get_xpath_elements(driver,every_participant_name)
    public_assert(driver,len(args),len(ele_list),action="入会者数量正确")
    for i in range(len(args)):
        participant = ele_list[i].get_attribute("textContent")
        public_assert(driver,participant,args[i],action="每个入会者名称按照顺序正确")

def check_two_dots(driver):
    """
    检查在5-8个入会者的情况下，入会者是否有两页
    :param driver:
    :return:
    """
    ele_left = get_xpath_elements(driver, nav_left)
    public_assert(driver,1,len(ele_left),action="左移按钮")
    ele_solid = get_xpath_elements(driver, nav_solid)
    public_assert(driver, 1, len(ele_solid), action="固定按钮")
    ele_hollow = get_xpath_elements(driver, nav_hollow)
    public_assert(driver, 1, len(ele_hollow), action="空心按钮")
    ele_right = get_xpath_elements(driver, nav_right)
    public_assert(driver, 1, len(ele_right), action="右移按钮")

def check_current_participants(driver,*args):
    """
    检查当前页面的入会者
    :param driver:
    :param args: 入会者name
    :return:
    """
    for i in range(len(args)):
        participant = get_xpath_element(driver,current_participant_div.format(i)).get_attribute("textContent")
        print(participant,args[i])
        public_assert(driver, participant, args[i], action=f"第{i+1}个入会者正确")
    ele_list = get_xpath_elements(driver,current_participant_div.format(len(args)+1))
    public_assert(driver, 0, len(ele_list), action=f"当前页面只有{len(args)}个入会者")

def check_f2f_mode_show(driver,show = "show"):
    """
    是否展示切换role的图标
    :param driver:
    :param show:  是否展示切换role图标，默认展示
    :return:
    """
    ele_list = get_xpath_elements(driver,f2f_on_mode)
    if show == "show":
        public_assert(driver, 1, len(ele_list), action="应该展示切换role的图标")
    else:
        public_assert(driver, 0, len(ele_list), action="不应该展示切换role的图标")

def participants_display_4_columns(driver):
    """
    Participants window displays with 4 columns: Participant, Mute, Co-Host, Remove
    :param driver:
    :return:
    """
    title_list = [None,"Participant","Mute","Co-Host","Remove"]
    ele_list = get_xpath_elements(driver,participants_title)
    public_assert(driver,5,len(ele_list),action="展示Participants,Mute,Co-Host,Remove")
    for i in range(1,5):
        title = ele_list[i].get_attribute("textContent")
        print(title)
        public_assert(driver,title,title_list[i],action=f"title{title_list[i]}正确")

def Co_Host_is_turned_on(driver,username,status = "on"):
    """
    Co-Host is turned on or off
    :param driver:
    :param username:
    :param status:  预期状态，默认为on开
    :return:
    """
    if status == "on":
        ele_list = get_xpath_elements(driver, co_host_on.format(username))
        public_assert(driver,1,len(ele_list),action=f"{username}的Co-Host状态应该是on")
    else:
        ele_list = get_xpath_elements(driver, co_host_off.format(username))
        public_assert(driver, 1, len(ele_list), action=f"{username}的Co-Host状态应该是off")

def co_host_can_not_turn_off(driver,username):
    """
    断言这个角色的co-host不能被turn-off
    :param driver:
    :param username:
    :return:
    """
    ele_list = get_xpath_elements(driver,can_not_turn_off.format(username))
    public_assert(driver, 1, len(ele_list), action=f"{username}的Co-Host状态不能被关闭")

def can_not_remove_participant(driver,username):
    """
    断言这个角色不能从入会者中被remove
    :param driver:
    :param username:
    :return:
    """
    ele_list = get_xpath_elements(driver, can_not_remove.format(username))
    public_assert(driver, 1, len(ele_list), action=f"{username}不能被移除")

def check_mic_is_off(driver,status = "off"):
    """
    断言麦克风被静音
    :param driver:
    :param status: 是否被静音，默认off被静音
    :return:
    """
    if status == "off":
        ele_list = get_xpath_elements(driver, mic_is_off)
        public_assert(driver,1,len(ele_list),action="麦克风应该关闭")
    else:
        ele_list = get_xpath_elements(driver, mic_is_on)
        public_assert(driver, 1, len(ele_list), action="麦克风应该开启")

def check_after_click_remove(driver,username):
    """
    检查点击移除co-host后出现的提示信息
    :param driver:
    :param username:
    :return:
    """
    ele_list = get_xpath_elements(driver, f"//div[text()='Are you sure you want to remove {username}?']")
    public_assert(driver, 1, len(ele_list), action="移除co-host出现提示信息")
    ele_list = get_xpath_elements(driver,confirm_remove)
    public_assert(driver, 1, len(ele_list), action="移除co-host出现OK按钮")
    ele_list = get_xpath_elements(driver, cancel_remove)
    public_assert(driver, 1, len(ele_list), action="移除co-host出现Cancel按钮")

def check_removed_end_call_message(driver):
    """
    断言移除之后通话结束页面的提示信息正确
    :param driver:
    :return:
    """
    ele_list = get_xpath_elements(driver,"//div[@id='end_call_message' and text()='A Host has removed you from the call.']")
    public_assert(driver,1,len(ele_list),action="移除之后通话结束页面的提示信息正确")

def show_title_text_under_mode(driver):
    """
    Title is “You are currently in Face to Face mode" under MODE. Text "Select who will Give Help" shows under title.
    :param driver:
    :return:
    """
    # Title is “You are currently in Face to Face mode" under MODE.
    ele_list = get_xpath_elements(driver,"//span[text()='You are currently in Face to Face mode.']")
    public_assert(driver,1,len(ele_list),action="MODE下的title正确")
    # Text "Select who will Give Help" shows under title.
    ele_list = get_xpath_elements(driver, "//h3[text()='Select who will Give Help.']")
    public_assert(driver, 1, len(ele_list), action="MODE下的text正确")
    # Step 1 of 2 displays in the bottom.
    ele_list = get_xpath_elements(driver, "//span[@class='steps' and text()='Step 1 of 2']")
    public_assert(driver, 1, len(ele_list), action="MODE最下面的Step描述正确")

def check_every_role(driver,*args):
    """
    点击切换role的图标后，展示的user按顺序排序
    :param driver:
    :param args:
    :return:
    """
    ele_list = get_xpath_elements(driver,every_role)
    public_assert(driver,len(args),len(ele_list),action=f"应该展示{len(ele_list)}个user")
    for i in range(len(ele_list)):
        username = ele_list[i].get_attribute("textContent")
        print(username)
        public_assert(driver,args[i],username,action=f"{username}按顺序排序")

def mode_submenu_should_not_display(driver):
    """
    Non co-host clicks on mode icon.	VP: mode submenu should not display.
    :param driver:
    :return:
    """
    ele_list = get_xpath_elements(driver, f2f_on_mode)
    public_assert(driver, 0, len(ele_list), action=f"不应该展示切换role的图标")

def show_title_text_under_mode_after_choose_giver(driver):
    """
    VP: Text changes to "Select who will Receive Help". Step 2 of 2 displays in the bottom.
    :param driver:
    :return:
    """
    # Text changes to "Select who will Receive Help"
    ele_list = get_xpath_elements(driver,"//h3[text()='Select who will Receive Help.']")
    public_assert(driver,1,len(ele_list),action="MODE下的text正确")
    # Step 2 of 2 displays in the bottom.
    ele_list = get_xpath_elements(driver,"//span[@class='steps' and text()='Step 2 of 2']")
    public_assert(driver,1,len(ele_list),action="MODE最下面的Step描述正确")

def user_is_selected_status(driver,username,selected = 'yes'):
    """
    MODE下的user被选中
    :param driver:
    :param username:
    :param selected:
    :return:
    """
    # User 1 is selected status.
    ele_list = get_xpath_elements(driver, f"//div[@class='user width30 selected']//strong[text()='{username}']")
    if selected == "yes":
        public_assert(driver,1,len(ele_list),action=f"f{username}应该被选中为giver")
    else:
        public_assert(driver, 0, len(ele_list), action=f"f{username}应该未被选中")

def back_button_displays_in_the_bottom(driver):
    """
    选择giver后，Back按钮展示在底部
    :param driver:
    :return:
    """
    ele_list = get_xpath_elements(driver,back_button_in_bottom)
    public_assert(driver,1,len(ele_list),action="Back按钮展示在底部")

def continue_button_appears_in_the_bottom(driver):
    """
    选择giver和receiver后，continue按钮展示在底部
    :param driver:
    :return:
    """
    ele_list = get_xpath_elements(driver, continue_button_in_bottom)
    public_assert(driver, 1, len(ele_list), action="Continue按钮展示在底部")

def mode_icon_displays_as(driver,mode = "giver"):
    """
    检查user当前在什么模式下
    :param driver:
    :param mode:
    :return:
    """
    if mode == "giver":
        ele_list = get_xpath_elements(driver,giver_help_mode)
        public_assert(driver,1,len(ele_list),action="当前应该在giver模式下")
    elif mode == "receiver":
        ele_list = get_xpath_elements(driver, receiver_help_mode)
        public_assert(driver, 1, len(ele_list), action="当前应该在receiver模式下")
    elif mode == "observer":
        ele_list = get_xpath_elements(driver, observer_mode)
        public_assert(driver, 1, len(ele_list), action="当前应该在observer模式下")
    else:
        raise Exception("请输入正确的模式")

def check_observer_permission(driver):
    """
    检查observer模式下的user的权限
    :param driver:
    :return:
    """
    ele_list = get_xpath_elements(driver,Share_a_document)
    public_assert(driver,0,len(ele_list),action="应该没有Share_a_document按钮")
    ele_list = get_xpath_elements(driver, Share_a_photo)
    public_assert(driver, 0, len(ele_list), action="应该没有Share_a_photo按钮")