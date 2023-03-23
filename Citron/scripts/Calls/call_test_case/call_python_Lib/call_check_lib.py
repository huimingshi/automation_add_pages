# _*_ coding: utf-8 _*_ #
# @Time     :11/28/2022 1:19 PM
# @Author   :Huiming Shi
#----------------------------------------------------------------------------------------------------#
from Citron.public_switch.pubLib import *
from Citron.public_switch.public_switch_py import IMPLICIT_WAIT
from Citron.scripts.Calls.call_test_case.call_python_Lib.call_action_lib_copy import click_participants_div as CPD, \
    in_call_click_message_button as ICCMB, click_right_share_button as CRSB, close_invite_3th_page as CI3P
from Citron.scripts.Calls.call_test_case.call_python_Lib.finish_call import hang_up_the_phone as HUTP
from public_settings_and_variable_copy import *

#----------------------------------------------------------------------------------------------------#
def has_no_directory_checkbox(driver,if_has = 'has'):
    """
    邀请user进入call时，校验Directory展不展示
    :param driver:
    :param if_has: has为展示，否则为不展示
    :return:
    """
    ele_list = get_xpath_elements(driver,directory_checkbox)
    if if_has == 'has':
        public_assert(driver,len(ele_list),1,action="应该展示Directory框")
    else:
        public_assert(driver, len(ele_list), 0, action="不应该展示Directory框")

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

def participants_icon_is_visible(visible = "yes",*drivers):
    """
    在call通话中，做侧的参与者图标是否展示
    :param driver:
    :param visible:参与者图标是否可见，默认yes可见
    :return:
    """
    for i in range(len(drivers)):
        ele_list = get_xpath_elements(drivers[i], participants_div)
        if visible == "yes":
            public_assert(drivers[i], 1, len(ele_list), action=f"第{i+1}个driver的参与者图标应该可见")
        else:
            public_assert(drivers[i], 0, len(ele_list), action=f"第{i+1}个driver的参与者图标应该不可见")

def invite_button_is_hidden(*drivers):
    """
    校验Invite button is hidden for all participants
    :param drivers: driver
    :return:
    """
    for i in range(len(drivers)):
        # 点击Participants按钮，展开
        CPD(drivers[i])
        # 断言没有add user按钮
        ele_list = get_xpath_elements(drivers[i],enter_add_user_page)
        public_assert(drivers[i],len(ele_list),0,action=f"第{i+1}个driver已达6人应该不可再邀请")
        # 点击"x"按钮，收起
        CI3P(drivers[i])

def check_in_photo_pdf_whiteboard_mode(mode,*drivers):
    """
    校验处于photo、pdf或者whiteboard模式中
    :param mode:哪种模式
    :param drivers:
    :return:
    """
    for i in range(len(drivers)):
        if mode == 'pdf':
            ele_list = get_xpath_elements(drivers[i],zoom_in_photo)
            print(len(ele_list))
            public_assert(drivers[i],len(ele_list),0,action=f"第{i+1}个driver不处于photo或whiteboard模式中")
            ele_list= get_xpath_elements(drivers[i],share_page_button)
            print(len(ele_list))
            public_assert(drivers[i], len(ele_list), 1, action=f"第{i + 1}个driver处于pdf模式中")
        elif mode == 'photo' or mode == 'whiteboard':
            ele_list = get_xpath_elements(drivers[i],zoom_in_photo)
            public_assert(drivers[i],len(ele_list),1,action=f"第{i+1}个driver处于photo或whiteboard模式中")

def check_in_live_video_mode(*drivers):
    """
    校验处于photo或者pdf模式中
    :param drivers:
    :return:
    """
    for i in range(len(drivers)):
        ele_list = get_xpath_elements(drivers[i],zoom_in_button)
        public_assert(drivers[i],len(ele_list),0,action=f"第{i+1}个driver处于live_video模式中")

def check_only_can_share_themself(*drivers):
    """
    校验仅可以share自己
    :param drivers:
    :return:
    """
    for i in range(len(drivers)):
        # 将右侧的Share按钮展开
        CRSB(drivers[i])
        # 检查尽可以share自己
        ele_list = get_xpath_elements(drivers[i],live_video_from_sb.format("My Camera"))
        public_assert(drivers[i],len(ele_list),1,action=f"第{i+1}个driver仅可以share自己")
        # 将右侧的Share按钮收起
        CRSB(drivers[i])

def check_has_merged(*drivers):
    """
    检查已经merge了
    :param drivers:
    :return:
    """
    for i in range(len(drivers)):
        ele_list = get_xpath_elements(drivers[i],merge_off_button)
        public_assert(drivers[i],len(ele_list),1,action=f"第{i+1}个driver应该已经merge了")

def check_has_no_merged(*drivers):
    """
    检查还没有merge
    :param drivers:
    :return:
    """
    for i in range(len(drivers)):
        ele_list = get_xpath_elements(drivers[i],merge_on_button)
        public_assert(drivers[i],len(ele_list),1,action=f"第{i+1}个driver应该还没有merge")

def check_has_merge_menu(*drivers):
    """
    检查有Merge按钮
    :param drivers:
    :return:
    """
    for i in range(len(drivers)):
        ele_list = get_xpath_elements(drivers[i], merge_on_button)
        public_assert(drivers[i], len(ele_list), 1, action=f"第{i+1}个driver的merge按钮应该展示")

def check_has_no_merge_menu(*drivers):
    """
    检查没有Merge按钮
    :param drivers:
    :return:
    """
    for i in range(len(drivers)):
        for j in range(3):
            ele_list = get_xpath_elements(drivers[i], merge_on_button)
            if len(ele_list) == 0:
                break
            elif j < 2:
                time.sleep(5)
            else:
                public_assert(drivers[i], len(ele_list), 0, action=f"第{i + 1}个driver的merge按钮应该不展示")

def check_in_f2f_mode(driver):
    """
    检查当前处于f2f模式
    :param driver:
    :return:
    """
    # ele_list = get_xpath_elements(driver, '//button[@class="AudioPlusModeIndicator"]')
    for i in range(3):
        merge_on_button_list = get_xpath_elements(driver, merge_on_button)
        if len(merge_on_button_list) == 0:
            break
        elif i < 1:
            time.sleep(5)
        else:
            public_assert(driver, len(merge_on_button_list), 0, action="应该on处于f2f模式")
    for i in range(3):
        merge_off_button_list = get_xpath_elements(driver, merge_off_button)
        if len(merge_off_button_list) == 0:
            break
        elif i < 1:
            time.sleep(5)
        else:
            public_assert(driver,len(merge_off_button_list),0,action="应该off处于f2f模式")

def check_show_share_live_video_from(*drivers):
    """
    校验底部的Share live video from按钮展示
    :param drivers:
    :return:
    """
    for i in range(len(drivers)):
        ele_list = get_xpath_elements(drivers[i],share_live_video_button)
        public_assert(drivers[i],len(ele_list),1,action=f"第{i+1}个driver的share_live_video按钮应该展示")

def check_not_show_share_live_video_from(*drivers):
    """
    校验底部的Share live video from按钮展示
    :param drivers:
    :return:
    """
    for i in range(len(drivers)):
        ele_list = get_xpath_elements(drivers[i],share_live_video_button)
        public_assert(drivers[i], len(ele_list), 0, action=f"第{i+1}个driver的share_live_video按钮应该不展示")

def check_can_share_sb_live_video(driver,*users):
    """
    点击右侧的share按钮后，检查可以share哪些人的live video
    :param driver:
    :param users:
    :return:
    """
    for user in users:
        # 将右侧的Share按钮展开
        CRSB(driver)
        # 校验可以share哪些人的live video
        ele_list = get_xpath_elements(driver,live_video_from_sb.format(user))
        public_assert(driver,len(ele_list),1,action=f"{user}可以被share")
        # 将右侧的Share按收起
        CRSB(driver)

def check_has_freeze_button(*drivers):
    """
    校验有freeze按钮
    :param drivers:
    :return:
    """
    for i in range(len(drivers)):
        ele_list = get_xpath_elements(drivers[i],freeze_on_action)
        public_assert(drivers[i],len(ele_list),1,action=f"第{i+1}个driver应该有freeze按钮")

def check_has_unFreeze_button(*drivers):
    """
    校验有unFreeze按钮
    :param drivers:
    :return:
    """
    for i in range(len(drivers)):
        ele_list = get_xpath_elements(drivers[i],freeze_off_action)
        public_assert(drivers[i],len(ele_list),1,action=f"第{i+1}个driver应该有unFreeze按钮")

def check_has_capture_button(*drivers):
    """
    检查有截图按钮
    :param drivers:
    :return:
    """
    for i in range(len(drivers)):
        ele_list = get_xpath_elements(drivers[i],capture_button)
        public_assert(drivers[i],len(ele_list),1,action=f"第{i+1}个driver应该有截图按钮")

def check_has_no_capture_button(*drivers):
    """
    检查没有截图按钮
    :param drivers:
    :return:
    """
    for i in range(len(drivers)):
        ele_list = get_xpath_elements(drivers[i],capture_button)
        public_assert(drivers[i],len(ele_list),0,action=f"第{i+1}个driver应该没有截图按钮")

def has_no_take_a_new_photo_option(driver,can_new = 'can_not'):
    """
    检查没有take a new photo选项
    :param drivers:
    :param can_new: 是否有take a new photo选项，默认没有
    :return:
    """
    # 将右侧的Share按钮展开
    CRSB(driver)
    # 校验是否有take a new photo选项
    ele_list = get_xpath_elements(driver, TPPW_share.format("Take a New Photo"))
    if can_new == 'can_not':
        public_assert(driver, len(ele_list), 0, action=f"不应该有take_a_new_photo_option")
    else:
        public_assert(driver, len(ele_list), 1, action=f"应该有take_a_new_photo_option")
    # 将右侧的Share按收起
    CRSB(driver)

def check_has_photo_PDF_whiteboard(*drivers):
    """
    检验有Take_a_New_Photo、PDF Document、Whiteboard按钮
    :param drivers:
    :return:
    """
    for i in range(len(drivers)):
        # 将右侧的Share按钮展开
        CRSB(drivers[i])
        ele_list = get_xpath_elements(drivers[i],TPPW_share.format("Photo from Library"))
        public_assert(drivers[i],len(ele_list),1,action=f"第{i+1}个driver应该有share_photo按钮")
        ele_list = get_xpath_elements(drivers[i], TPPW_share.format("PDF Document"))
        public_assert(drivers[i], len(ele_list), 1, action=f"第{i+1}个driver应该有share_PDF按钮")
        ele_list = get_xpath_elements(drivers[i], TPPW_share.format("Whiteboard"))
        public_assert(drivers[i], len(ele_list), 1, action=f"第{i+1}个driver应该有Whiteboard按钮")
        # 将右侧的Share按钮收起
        CRSB(drivers[i])

def check_if_is_highlight(driver,mode,is_highlight = "is_highlight"):
    """
    检查是否高亮显示
    :param driver:
    :param mode: “Take a New Photo”，“Photo from library“，”PDF Document“，”Whiteboard“
    :param is_highlight: 是否高亮显示
    :return:
    """
    # 将右侧的Share按钮展开
    CRSB(driver)
    # 检查是否高亮显示
    if is_highlight == "is_highlight":
        if mode == "Take a New Photo":
            public_check_element(driver,'//*[@*="#share_camera_selected"]/..',description="camera应该高亮显示",if_click = 0)
        elif mode == "Photo from library":
            public_check_element(driver,'//*[@*="#share_photo_selected"]/..',description="Photo应该高亮显示",if_click = 0)
        elif mode == "PDF Document":
            public_check_element(driver,'//*[@*="#share_file_selected"]/..',description="PDF应该高亮显示",if_click = 0)
        elif mode == "Whiteboard":
            public_check_element(driver,'//*[@*="#white_board_selected"]/..',description="Whiteboard应该高亮显示",if_click = 0)
    else:
        if mode == "Take a New Photo":
            public_check_element(driver,'//*[@*="#share_camera"]/..',description="camera不应该高亮显示",if_click = 0)
        elif mode == "Photo from library":
            public_check_element(driver,'//*[@*="#share_photo"]/..',description="Photo不应该高亮显示",if_click = 0)
        elif mode == "PDF Document":
            public_check_element(driver,'//*[@*="#share_file"]/..',description="PDF不应该高亮显示",if_click = 0)
        elif mode == "Whiteboard":
            public_check_element(driver,'//*[@*="#white_board"]/..',description="Whiteboard不应该高亮显示",if_click = 0)
    # 将右侧的Share按钮收起
    CRSB(driver)

def invite_button_should_be_hidden(driver,hidden = "yes"):
    """
    通话过程中的Add user按钮不可见
    :param driver:
    :param hidden: 是否隐藏？默认yes隐藏
    :return:
    """
    # 点击Participants按钮，展开
    CPD(driver)
    ele_list = get_xpath_elements(driver,enter_add_user_page)
    if hidden == "yes":
        public_assert(driver, 0, len(ele_list), action="invite按钮应该被隐藏")
    else:
        public_assert(driver, 1, len(ele_list), action="invite按钮不应该被隐藏")
    # 点击"x"按钮，收起
    CI3P(driver)

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
    ele_list = get_xpath_elements(driver,current_participant_div.format(len(args)+1))
    print(len(ele_list))
    public_assert(driver, 0, len(ele_list), action=f"当前页面应该只有{len(args)}个入会者")
    for i in range(len(args)):
        print(current_participant_div.format(i))
        participant = get_xpath_element(driver,current_participant_div.format(i),description=f"获取第{i+1}个入会者name").get_attribute("textContent")
        print(participant,args[i])
        public_assert(driver, args[i], participant, condition='in',action=f"第{i+1}个入会者正确")

def participants_display_4_columns(driver):
    """
    Participants window displays with 4 columns: Participant, Mute, Co-Host, Remove
    :param driver:
    :return:
    """
    # 点击Participants按钮，展开
    CPD(driver)
    title_list = [None,"Participant","Mute","Co-Host","Remove"]
    ele_list = get_xpath_elements(driver,participants_title)
    public_assert(driver,5,len(ele_list),action="展示Participants,Mute,Co-Host,Remove")
    for i in range(1,5):
        title = ele_list[i].get_attribute("textContent")
        print(title)
        public_assert(driver,title,title_list[i],action=f"title{title_list[i]}正确")
    # 点击"x"按钮，收起
    CI3P(driver)

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

def check_has_end_call_button(driver,*buttons):
    """
    检查有哪些结束call的操作
    :param driver:
    :param buttons: 1表示：end_call_for_all_button，2表示：leave_call_button
    :return:
    """
    # 点击红色的挂断电话按钮展开
    HUTP(driver)
    time.sleep(2)
    for button in buttons:
        if button == '1':
            ele_list = get_xpath_elements(driver, end_call_for_all_button)
            public_assert(driver, len(ele_list), 1, action="有End_call_for_all按钮")
        elif button == '2':
            ele_list = get_xpath_elements(driver, leave_call_button)
            public_assert(driver, len(ele_list), 1, action="有Leave_call按钮")
    # 点击红色的挂断电话按钮收起
    HUTP(driver)
    time.sleep(2)

def display_users_as_joined_order(driver,*username):
    """
    检查按顺序加入通话的
    :param driver:
    :param username:
    :return:
    """
    # 点击Participants按钮，展开
    CPD(driver)
    ele_list = get_xpath_elements(driver,'//span[@class="submenu noarrow"]//div[@ref="eBodyViewport"]//div[@col-id="name"]')
    for i in range(len(ele_list)):
        name = ele_list[i].get_attribute("textContent")
        public_assert(driver,name,username[i],action="joiner按顺序加入")
    # 点击"x"按钮，收起
    CI3P(driver)

def who_is_co_host(driver,*whos):
    """
    判断谁是co-host
    :param driver:
    :param who:
    :return:
    """
    # 点击Participants按钮，展开
    CPD(driver)
    for who in whos:
        ele_list = get_xpath_elements(driver,f'//span[text()="Co-host"]/../../..//span[text()="{who}"]')
        public_assert(driver,len(ele_list),1,action=f'{who}是co-host')
    # 点击"x"按钮，收起
    CI3P(driver)

def you_must_select_another_co_host(driver):
    """
    # 出现文本"You must select another co-host before you can Leave Call."
    :param driver:
    :return:
    """
    ele_list = get_xpath_elements(driver, '//p[text()="You must select another co-host before you can Leave Call."]')
    public_assert(driver, len(ele_list), 1, action="断言有提示信息出现")

def participants_page_end_call_for_all(driver):
    """
    Participants页面的 "End Call for All" 按钮可用
    :param driver:
    :return:
    """
    ele_list = get_xpath_elements(driver, PPECFA_button)
    public_assert(driver,len(ele_list),1,action="end_call_for_all按钮可用")

def participants_page_leave_call_disable(driver,usable = 'disable'):
    """
    Participants页面的 "Leave Call" 按钮是否可用
    :param driver:
    :param usable:  是否可用，默认disable不可用
    :return:
    """
    #  "Leave Call" 按钮是否可用
    result = get_xpath_element(driver, '//div[@class="submenu-content"]//button[text()="Leave Call"]').is_enabled()
    print(result)
    # 如果不可用
    if usable == 'disable':
        public_assert(driver, result, False, action="Leave_call按钮应该不可用")
    # 如果可用
    else:
        public_assert(driver, result, True, action="Leave_call按钮应该可用")

def check_with_collaboration_mode(driver,collaboration_mode = 'yes'):
    """
    检查是否with Collaboration mode
    :param driver:
    :param collaboration_mode: 是否是Collaboration mode，默认是
    :return:
    """
    ele_list = get_xpath_elements(driver,collaboration_mode_flag)
    if collaboration_mode == 'yes':
        public_assert(driver,len(ele_list),1,action="当前应该处于collaboration_mode")
    else:
        public_assert(driver, len(ele_list), 0, action="当前不应该处于collaboration_mode")

def check_can_or_not_stop_share(driver,can = 'can_not'):
    """
    校验是否可以进行stop sharing
    :param driver:
    :param can: 是否可以进行stop sharing，默认不可以
    :return:
    """
    # 点击右侧的share按钮
    public_click_element(driver, right_share_button, description="右侧SHARE按钮")
    time.sleep(2)
    ele_list = get_xpath_elements(driver, stop_sharing_button)
    if can == 'can_not':
        public_assert(driver, len(ele_list), 0, action="Stop_Sharing按钮不应该展示")
    else:
        public_assert(driver,len(ele_list),1,action="Stop_Sharing按钮应该展示")
    # 点击右侧的share按钮，收起
    public_click_element(driver, right_share_button, description="右侧SHARE按钮")
    time.sleep(2)

def check_is_receiver(driver):
    """
    检验user当前是receiver
    :param driver:
    :return:
    """
    check_has_no_merge_menu(driver)
    check_has_freeze_button(driver)

def check_is_giver(driver):
    """
    检验user当前是giver
    :param driver:
    :return:
    """
    check_has_merged(driver)
    check_has_freeze_button(driver)

def should_see_camera_button(driver,see = 'see',status = 'on'):
    """
    是否能看到左侧的相机按钮
    :param driver:
    :param see: 是否能看到相机按钮，默认可以
    :param status: 相机打开或者关闭状态，默认打开
    :return:
    """
    if see == 'see':
        ele_list = get_xpath_elements(driver,off_on_camera.format(status))
        public_assert(driver,len(ele_list),1,action=f"相机状态应该是{status}")
    else:
        ele_list = get_xpath_elements(driver,camera_icon)
        public_assert(driver,len(ele_list),0,action="应该没有相机图标")