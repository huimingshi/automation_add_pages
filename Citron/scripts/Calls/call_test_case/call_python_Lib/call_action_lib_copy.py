#----------------------------------------------------------------------------------------------------#
import time

from Citron.public_switch.pubLib import *
from Citron.public_switch.public_switch_py import IMPLICIT_WAIT
from Citron.scripts.Calls.call_test_case.call_python_Lib.public_lib import change_driver_implicit_wait
from public_settings_and_variable_copy import *
from selenium.webdriver.common.keys import Keys
from obtain_meeting_link_lib import obtain_meeting_link
from about_call import make_sure_enter_call as m_s_e_c
from else_public_lib import refresh_browser_page as refresh_page, paste_on_a_non_windows_system
from selenium import webdriver
from selenium.webdriver import ActionChains
import warnings
from Citron.scripts.Calls.call_test_case.call_python_Lib.else_public_lib import scroll_into_view as SIV
from Citron.Lib.python_Lib.ui_keywords import check_zipFile_exists as CZE
from pykeyboard import PyKeyboard
from pymouse import PyMouse
import pyperclip
import pywinauto
#----------------------------------------------------------------------------------------------------#
# define python Library
def click_participants_div(driver):
    """
    # 点击participants按钮
    :param driver:
    :return:
    """
    public_click_element(driver, participants_div, description='点击邀请user进入call的入口按钮')
    time.sleep(2)
    ele_list = get_xpath_elements(driver,close_participants_page_xpath)
    if len(ele_list) != 1:
        public_click_element(driver, participants_div, description='再次点击邀请user进入call的入口按钮')

def open_participants_dialog(driver):
    """
    打开call页面左侧的PARTICIPANTS标签页
    :param driver:
    :return:
    """
    # 确保进入call
    m_s_e_c(driver)
    # 点击邀请user进入call的入口按钮
    click_participants_div(driver)

def close_invite_3th_page(driver):
    """
    关闭邀请第三位用户进入call的页面
    :param driver:通话结束
    :return:
    """
    # 关闭
    ele_list = get_xpath_elements(driver, close_participants_page_xpath)
    if len(ele_list) == 1:
        public_click_element(driver, close_participants_page_xpath, description='关闭invite_page')
    time.sleep(2)
    driver.implicitly_wait(3)
    ele_list = get_xpath_elements(driver,close_participants_page_xpath)
    if len(ele_list) == 1:
        public_click_element(driver, close_participants_page_xpath, description='再次关闭invite_page')
    driver.implicitly_wait(IMPLICIT_WAIT)

def open_invite_3rd_participant_dialog(driver,which_dialog = "Contacts"):
    """
    打开邀请第三位通话者的界面，可选择是进入Contacts标签页还是New Invitation标签页
    :param driver:
    :param which_dialog: 进入到Contacts、directory、New Invitation
    :return:
    """
    # 打开call页面左侧的PARTICIPANTS标签页
    open_participants_dialog(driver)
    # 点击Add People按钮
    public_click_element(driver, enter_add_user_page, description='Add_People按钮')
    if which_dialog == 'New Invitation':
        # 点击New Invitation标签
        SIV(driver,new_invite_in_calling)
        public_click_element(driver, new_invite_in_calling, description='进入New_Invitation标签页')
        # 校验New Invitation标签被选中
        public_check_element(driver, invitation_list_in_calling, 'invitation标签页', if_click=None)
    elif which_dialog == 'directory':
        # 点击directory标签
        SIV(driver, new_invite_in_calling)
        public_click_element(driver, directory_checkbox, description='进入Directory标签页')
        # 校验directory标签被选中
        public_check_element(driver, directory_list_in_calling, 'contacts列表标签页', if_click=None)
    else:
        # 校验Contacts标签被选中
        SIV(driver, contacts_list_in_calling)
        public_check_element(driver, contacts_list_in_calling, 'contacts列表标签页', if_click=None)

def send_new_invite_in_calling(driver,if_send = 'not_send'):
    """
    通话过程中获取New Invitation的link
    :param driver:
    :param if_send:是否发送，默认不发送not_send，发送为send
    :return:返回会议link
    """
    # 进入New Invitation标签页
    open_invite_3rd_participant_dialog(driver, which_dialog="New Invitation")
    # 复制
    public_check_element(driver, '//div[@class="image-container"]', '点击复制按钮失败')
    # 粘贴
    sys_type = get_system_type()  # 判断是哪种操作系统，Windows和非Windows的粘贴操作不一样
    if sys_type == 'Windows':
        public_click_element(driver, my_help_space_message, description='Windows操作系统message输入框')
        get_xpath_element(driver, my_help_space_message, description='Windows操作系统message输入框').send_keys(Keys.CONTROL,
                                                                                                        'v')
    else:
        paste_on_a_non_windows_system(driver, my_help_space_message)
    # 验证复制后粘贴结果正确
    invite_url = get_xpath_element(driver, get_invite_link, description='link链接').get_attribute(
        "textContent")  # Get the invitation link
    print('复制的link为:', invite_url)
    attribute = get_xpath_element(driver, my_help_space_message, description='message输入框').get_attribute('value')
    print('粘贴的link为:', attribute)
    # 验证复制后粘贴结果正确
    public_assert(driver, attribute, invite_url, action='复制和粘贴的内容不一致')
    if if_send != 'not_send':
        # 输入email
        email_ele = get_xpath_element(driver, send_link_email_input, description='email输入框')
        public_click_element(driver, send_link_email_input, description='email输入框')
        email_ele.send_keys('Huiming.shi.helplightning+123456789@outlook.com')
        # 点击Send Invite按钮
        public_click_element(driver, new_invitation_send, description='email发送按钮')
    # 关闭邀请第三位用户进入call的页面
    close_invite_3th_page(driver)
    return invite_url  # 返回会议link

def make_calls_with_who(driver1, driver2, who, answer='anwser',is_personal='not_personal'):
    """
    Make calls with someone
    :param driver1:
    :param driver2:
    :param who:
    :param answer: 是否应答，默认anwser应答，no_anwser为不应答
    :param is_personal: 是否呼叫的是personal标签页中的user，默认不是
    :return:
    """
    # 这段代码是给这个方法添加个建议不使用的警告，但仍然可以使用
    warnings.warn('make_calls_with_who id deprecated, please user contacts_witch_page_make_call instead',DeprecationWarning)
    if is_personal == 'not_personal':
        element = get_xpath_element(driver1, search_input,description = '搜索框')
        element.clear()
        time.sleep(2)
        public_click_element(driver1, search_input,description = '搜索框')
        element.send_keys(who)
        time.sleep(5)
        user_name = who.split('@')[0]
        ele_ment = get_xpath_elements(driver1,f'//div[@class="card"]/div[text()="{user_name}"]')
        print('0000000000000000000000000000000000',len(ele_ment))
        if len(ele_ment) < 1:
            refresh_page(driver1)
            element = get_xpath_element(driver1,search_input,description = '搜索框')
            public_click_element(driver1,search_input,description = '搜索框')
            element.send_keys(who)
            time.sleep(5)
        public_check_element(driver1, f'//div[@class="card"]/div[text()="{user_name}"]', f'{user_name}未加载出',if_click = None,if_show = 1)
        public_check_element(driver1, click_call_button, '点击Call按钮失败')
    else:
        public_check_element(driver1, '//a[@id="user-tabs-tab-2"]', '点击personal_contacts页面失败')
        time.sleep(3)
        element = get_xpath_element(driver1,'//div[@id="user-tabs-pane-2"]//input[@id="filter-text-box"]',description = 'personal标签页搜索框')
        element.clear()
        time.sleep(2)
        public_click_element(driver1,'//div[@id="user-tabs-pane-2"]//input[@id="filter-text-box"]',description = 'personal标签页搜索框进行点击')
        element.send_keys(who)
        time.sleep(3)
        for i in range(3):
            time.sleep(2)
            ele_count = get_xpath_elements(driver1,'//div[@id="user-tabs-pane-2"]//div[@class="ag-center-cols-container"]/div')
            if len(ele_count) == 1:
                time.sleep(2)
                public_click_element(driver1,click_call_button,description = 'Call按钮')  # click Call button
                time.sleep(5)
                break
    # user anwser calls
    if answer == 'anwser':
        ele_list = get_xpath_elements(driver2,anwser_call_button)
        if len(ele_list) == 1:
            public_click_element(driver2,anwser_call_button,description='ANWSER_CALL按钮')
        else:
            ele_list = get_xpath_elements(driver2,anwser_call_button)
            if len(ele_list) == 1:
                public_click_element(driver2,anwser_call_button,description='ANWSER_CALL按钮')
            else:
                screen_shot_func(driver1,'点击ANSWER按钮失败')
                raise Exception('点击ANSWER按钮失败')

def inCall_enter_contacts_search_user(driver,search_name,search_result = 'has_user_data'):
    """
    在in call页面的Contacts列表中查询user
    :param driver:
    :param search_name: 需要查询的username
    :param search_result: 查询的结果；默认查询'has_user_data'有用户数据；'has_no_user_data'没有用户数据
    :return:
    """
    # 进入到邀请第三位用户的PARTICIPANTS页面
    open_invite_3rd_participant_dialog(driver)
    # 通过name查询
    search_element = get_xpath_element(driver,inviteDialog_search_user_input,description = '查询框')
    search_element.clear()
    time.sleep(2)
    public_click_element(driver,inviteDialog_search_user_input,description = '查询框')
    search_element.send_keys(search_name)
    ele_list = get_xpath_elements(driver,f'//div[@class="contact-name" and contains(.,"{search_name}")]')
    # 断言
    if search_result == 'has_user_data':
        public_assert(driver,len(ele_list) , 1,condition='>=',action='查询的user数据与预期不符')
    elif  search_result == 'has_no_user_data':
        public_assert(driver,len(ele_list) , 0,action='查询的user数据与预期不符')

def click_user_in_contacts_list(driver,username,can_reach = 'can_reach'):
    """
    校验在通话中Contacts页面中的user，点击后是否可以邀请进入到call
    :param driver:
    :param username: 需要点击的username
    :param can_reach: 是否可以邀请进入到call，默认为可以邀请，如果为can_not_reach，会弹出{username} is unreachable的提示信息
    :return:
    """
    public_check_element(driver, f'//div[@class="contact-name" and (text()="{username}")]', f'点击{username}失败')
    if can_reach == 'can_not_reach':
        public_check_element(driver, f'//div[@class="message" and contains(.,"{username} is unreachable.")]', f'未出现{username}_is_unreachable_提示信息',if_click = None,if_show = 1)

def anonymous_open_meeting_link(meeting_link,deal_with_disclaimer = 'accept'):
    """
    # anonymous user打开这个会议link，并ACCCEPT Disclaimer，需要新起一个driver
    :param meeting_link: 会议link
    :param deal_with_disclaimer: 怎么处理disclaimer，ACCEPT or DECLINE，默认ACCEPT
    :return: driver实例
    """
    if not meeting_link.startswith('https'):
        print('获取meeting link失败')
        return '获取meeting link失败'
    # try: # 启动driver打开meeting link
    if SMALL_RANGE_BROWSER_TYPE == 'Chrome':
        driver = webdriver.Chrome(options=optionc)
    elif SMALL_RANGE_BROWSER_TYPE == 'Firefox':
        driver = webdriver.Firefox(options=optionf,firefox_profile=profile)
    driver.get(meeting_link)
    driver.maximize_window()
    # 怎么处理Disclaimer；ACCCEPT OR DECLINE
    if deal_with_disclaimer == 'accept':
        try:
            public_click_element(driver, accept_disclaimer, description='ACCCEPT_Disclaimer')
        except:
            print("没有ACCCEPT_Disclaimer按钮")
    elif deal_with_disclaimer == 'decline':
        ele_list = get_xpath_elements(driver, decline_disclaimer)
        if len(ele_list) == 1:
            public_click_element(driver, decline_disclaimer, description='DECLINE_Disclaimer')
    return driver

def user_make_call_via_meeting_link(driver,meeting_link,check_disclaimer = 'check'):
    """
    # user打开这个会议link，需要处理Discliaimer
    :param meeting_link: 会议link
    :param check_disclaimer: 是否需要处理Discliaimer，默认check处理
    """
    # 打开meeting link
    js = "window.open('{}','_blank');"
    driver.execute_script(js.format(meeting_link))
    driver.switch_to.window(driver.window_handles[-1])  # 切换到最新页面
    # 处理Discliaimer
    if check_disclaimer == 'check':
        ele_list = get_xpath_elements(driver,accept_disclaimer)
        if len(ele_list) == 1:
            public_click_element(driver,accept_disclaimer,description='处理Discliaimer')

def user_decline_call(driver,type = 'direct'):
    """
    User declines call.
    :param driver:
    :param type:Decline Call 的类型；分为直接decline 和在通话页面上decline；默认直接decline；direct or in_calling
    :return:
    """
    if type == 'direct':
        public_check_element(driver, decline_disclaimer, 'user_decline_call失败')
    elif type != 'direct':
        public_check_element(driver, decline_call, 'user_decline_call失败')

def user_anwser_call(driver,anwser_type = 'direct'):
    """
    # User接受call
    :param driver:
    :param anwser_type: 应答类型，分为直接Anwser和外部用户加入Anwser，默认直接Anwser;    direct  or  no_direct
    :return:
    """
    if anwser_type == 'direct':
        public_click_element(driver, anwser_call_button, '没找到直接接受Call的按钮')
    elif anwser_type != 'direct':
        public_click_element(driver, external_join_call_anwser_button, '没找到间接接受Call的按钮')

def contacts_witch_page_make_call(driver1,driver2,witch_page,who = 'on-call group 1',accept='accept',audio = 'audio'):
    """
    Contacts页面进行call操作
    :param driver1:
    :param driver2:
    :param witch_page: 哪个page? Favorites/Team/Personal/Directory四个页面
    :param who: 与谁进行call? on-call group或者是某个user
    :param accept:对端是否accept此次call
    :return:
    """
    contacts_search_input_format = contacts_search_input.format(witch_page.lower())    # 目前只做了Contacts页面的make call
    # 查询on-call group或者是某个user
    element = get_xpath_element(driver1, contacts_search_input_format, description='查询框')
    element.clear()
    time.sleep(1)
    public_click_element(driver1, contacts_search_input_format, description='查询框')
    element.send_keys(who)
    time.sleep(5)
    contacts_search_result = f'//div[@id="user-tabs-pane-{witch_page.lower()}"]//div[text()="{who}"]'
    ele_ment = get_xpath_elements(driver1, contacts_search_result)
    print(f'{witch_page}输入框个数', len(ele_ment))
    if len(ele_ment) < 1:
        refresh_page(driver1)
        element = get_xpath_element(driver1, contacts_search_input_format, description='搜索框')
        public_click_element(driver1, contacts_search_input_format, description='搜索框')
        element.send_keys(who)
        time.sleep(5)
    public_check_element(driver1, contacts_search_result,f'{who}未加载出', if_click=None, if_show=1)
    # 鼠标悬停
    ellipsis_xpath = f'//div[text()="{who}"]/../../../..//div[@class="ellipsis-menu-div"]'
    ellipsis = get_xpath_element(driver1,ellipsis_xpath,description='悬浮按钮')
    ActionChains(driver1).move_to_element(ellipsis).perform()
    # 选择Audio或者video
    if audio == 'audio':
        audio_xpath = f'//div[text()="{who}"]/../../../..//span[text()="Audio+"]/..'
        public_click_element(driver1,audio_xpath,description='启动Audio按钮')
    else:
        video_xpath = f'//div[text()="{who}"]/../../../..//span[text()="Video"]/..'
        public_click_element(driver1, video_xpath, description='启动Video按钮')
    # 需要Accept Declaimer
    driver1.implicitly_wait(5)
    count = get_xpath_elements(driver1, accept_disclaimer)
    if len(count) == 1:
        public_click_element(driver1, accept_disclaimer, 'accept_disclaimer按钮')
    driver1.implicitly_wait(IMPLICIT_WAIT)
    # 另一端ACCEPT OR DECLINE
    if accept == 'accept':
        public_click_element(driver2, anwser_call_button, 'ANWSER按钮')
    elif accept == 'no_accept':
        public_click_element(driver2, decline_disclaimer, 'DECLINE按钮')

def make_call_to_onCall(driver1,driver2,on_call_group_name = 'on-call group 1',accept='accept'):
    """
    # 给on-call group 进行call
    :param driver1:
    :param driver2:
    :param on_call_group_name: 需要与之进行call的on-call-group的name
    :param accept: 是否接受Call；默认accept接受;no_accept为不接受;no_care为不管这个
    :return:
    """
    # 这段代码是给这个方法添加个建议不使用的警告，但仍然可以使用
    warnings.warn('make_call_to_onCall id deprecated, please user contacts_witch_page_make_call instead', DeprecationWarning)
    # 查询Oncall
    element = get_xpath_element(driver1, search_input,description = '查询框')
    element.clear()
    time.sleep(1)
    public_click_element(driver1, search_input,description = '查询框')
    element.send_keys(on_call_group_name)
    time.sleep(5)
    ele_ment = get_xpath_elements(driver1, f'//div[@class="group-card"]/div[text()="{on_call_group_name}"]')
    print('0000000000000000000000000000000000', len(ele_ment))
    if len(ele_ment) < 1:
        refresh_page(driver1)
        element = get_xpath_element(driver1, search_input, description='搜索框')
        public_click_element(driver1, search_input, description='搜索框')
        element.send_keys(on_call_group_name)
        time.sleep(5)
    public_check_element(driver1, f'//div[@class="group-card"]/div[text()="{on_call_group_name}"]', f'{on_call_group_name}未加载出', if_click=None,if_show=1)
    public_check_element(driver1, click_call_button, '点击Call按钮失败')
    # public_check_element(driver1, click_call_button, '首行数据还未展示')
    time.sleep(3)
    count = get_xpath_elements(driver1,end_call_before_connecting)
    public_assert(driver1,len(count) , 1,action='发起call失败')
    # ACCEPT OR DECLINE
    if accept == 'accept':
        public_check_element(driver2, anwser_call_button, '点击ANWSER按钮失败')
    elif accept == 'no_accept':
        public_check_element(driver2, decline_disclaimer, '点击DECLINE按钮失败')

def obtain_meeting_link_from_email(check_otu = 'no_check_otu'):
    """
    # 从邮箱获取meeting link
    :param check_otu:  是否检查OTUlink，默认不检查
    :return: meeting link
    """
    meeting_link = obtain_meeting_link()
    if check_otu != 'no_check_otu':
        try:
            assert meeting_link.startswith(r'https://app-stage.helplightning.net.cn/meet/link')
        except AssertionError:
            raise AssertionError('当前邮件不是OTU邮件')
    return meeting_link

def click_screen_capture_button(*drivers):
    """
    点击截图按钮
    :param driver:
    :return:
    """
    for i in range(len(drivers)):
        public_click_element(drivers[i],capture_button,description=f'第{i + 1}driver点击截图按钮')
        time.sleep(3)

def in_call_click_message_button(driver,operation='open'):
    """
    通话过程中点击message图标，打开Message会话
    :param driver:
    :param operation: 操作类型，打开还是关闭；默认打开
    :return:
    """
    # 点击Message图标
    public_check_element(driver, message_chat_icon, '点击Message图标')
    time.sleep(2)
    # 校验
    ele_list = get_xpath_elements(driver, left_ChatDrawer)
    if operation == 'open':
        # 校验是否打开message对话框至于通话界面左侧
        public_assert(driver, 1, len(ele_list), action='校验是否打开message对话框至于通话界面左侧')
    elif operation == 'close':
        # 校验message对话框关闭
        public_assert(driver,0,len(ele_list),action='校验message对话框关闭')

def in_call_send_message_data(driver,test_data,data_type='text',send = 'send'):
    """
    测试用不同的数据类型发送message
    :param driver:
    :param test_data:
    :param data_type:是哪种数据类型，分为text和url
    :return:
    """
    # 点击输入框
    message_input = get_xpath_element(driver, message_textarea, 'in_call输入框message')
    message_input.click()
    message_input.send_keys(test_data)
    if send == 'send':
        public_click_element(driver,send_message_button,description='聊天内容发送按钮')
        if data_type == 'text':
            ele_list = get_xpath_elements(driver,in_call_lastMessages_text.format(test_data))
            public_assert(driver, len(ele_list), 1, action=f'{test_data}未成功发送')
        elif data_type == 'url':
            ele_list = get_xpath_elements(driver,in_call_lastMessages_text.format(test_data))
            public_assert(driver, len(ele_list), 1, action=f'{test_data}未成功发送')

def in_call_download_file(driver,attach_name):
    """
    点击附件进行下载
    :param driver:
    :param attach_name: 附件名
    :return:
    """
    # 滑动到可见
    ele_xpath = attach_particial_xpath.format(attach_name)
    SIV(driver, ele_xpath)
    # 如果不加这个等待时间的话，下面的click会报错，目前不知道啥原因导致的
    time.sleep(3)
    # 点击图片左下角三个点
    public_click_element(driver, AttachmentOptionsMenu.format(attach_name), description='点击附件的三个点')
    # 点击Download
    public_click_element(driver,AttachmentOptionsMenu_selecting_button.format("Download"),description='点击Download按钮')
    time.sleep(20)
    result = CZE(attach_name)
    print(result)
    public_assert(driver, 1, result[1], action='点击附件下载')

def share_in_main_screen(driver,attach_name,file_type = 'jpg'):
    """
    图片展示在主屏幕
    :param driver:
    :param attach_name:
    :return:
    """
    # 滑动到可见
    ele_xpath = in_call_lastMessages_attach.format(attach_name)
    SIV(driver, ele_xpath)
    # 点击图片左下角三个点
    public_click_element(driver, AttachmentOptionsMenu.format(attach_name), description='点击附件的三个点')
    # 点击Share按钮
    public_click_element(driver, AttachmentOptionsMenu_selecting_button.format("Share"), description='点击Share按钮')
    # 判断
    if file_type == 'jpg':
        driver.implicitly_wait(60)
        ele_list = get_xpath_elements(driver, PanZoomTools)
        public_assert(driver,1,len(ele_list),action='jpg展示在主屏幕')
    elif file_type == 'pdf':
        driver.implicitly_wait(30)
        ele_list = get_xpath_elements(driver, PanZoomTools)
        public_assert(driver, 0, len(ele_list), action='pdf展示在主屏幕')

def inCall_message_click_upload_attach(driver):
    """
    通话过程中message标签页点击上传附件按钮，has options: Photo; camera;Document
    :param driver:
    :return:
    """
    public_click_element(driver,message_toolbarButton,description='点击上传附件按钮')
    photo_list = get_xpath_elements(driver,'//input[@accept="video/*,image/*"]/..')
    public_assert(driver,1,len(photo_list),action='Photo按钮出现')
    camera_list = get_xpath_elements(driver,'//div[@class="CameraInput"]')
    public_assert(driver, 1, len(camera_list), action='Camera按钮出现')
    document_list = get_xpath_elements(driver,'//input[@accept="*"]')
    public_assert(driver, 1, len(document_list), action='Document按钮出现')
    public_click_element(driver, message_toolbarButton, description='再次点击上传附件按钮')

def make_show_recording_settings(driver):
    """
    确保通话过程中左上角的recording settings按钮能显示
    :param driver:
    :return:
    """
    while True:
        ele_list = get_xpath_elements(driver,call_top_message)
        if len(ele_list) != 0:
            public_click_element(driver,call_top_message,description='top提示信息')
        else:
            break

def rec_is_on_or_off(driver,witch_status = 'on',change_or_not = 'can_not_change',click_share = False):
    """
    通话过程中REC的状态，是否可切换状态
    :param driver:
    :param witch_status:   on or off；默认on为开，off为关，none为不展示REC图标
    :param change_or_not:   can_not_change or can_change；默认can_not_change为不可改变，can_change为可改变
    :param click_share: 是否出现Share蓝色按钮，默认没有，若有的话需要点击
    :return:
    """
    # try:
    if change_or_not == 'can_not_change' and witch_status == 'on':
        if click_share:
            public_click_element(driver, share_button, description='Share按钮')
        ele_list = get_xpath_elements(driver,recording_settings)
        public_assert(driver,len(ele_list) , 0,action='实际REC不是预期状态')
        ele_list = get_xpath_elements(driver,'//div[@class="InCall"]/img[@class="Rec"]')
        public_assert(driver, len(ele_list), 1, action='实际REC不是预期状态')
    elif change_or_not == 'can_change' and witch_status == 'on':
        if click_share:
            public_click_element(driver, share_button, description='Share按钮')
        public_click_element(driver,recording_settings,description = 'recording_setting')
        time.sleep(2)
        ele_list = get_xpath_elements(driver,do_not_record)
        public_click_element(driver,recording_settings,description = 'recording_setting')
        time.sleep(2)
        print('再次点击切换按钮')
        public_assert(driver, len(ele_list), 1, action='实际REC不是预期状态')
    elif change_or_not == 'can_change' and witch_status == 'off':
        if click_share:
            public_click_element(driver, share_button, description='Share按钮')
        public_click_element(driver,recording_settings,description = 'recording_setting')
        time.sleep(2)
        ele_list = get_xpath_elements(driver,record_this_session)
        public_click_element(driver,recording_settings,description = 'recording_setting')
        time.sleep(2)
        print('再次点击切换按钮')
        public_assert(driver, len(ele_list), 1, action='实际REC不是预期状态')
    elif change_or_not == 'can_not_change' and witch_status == 'none':
        if click_share:
            public_click_element(driver, share_button, description='Share按钮')
        ele_list = get_xpath_elements(driver,recording_settings)
        public_assert(driver, len(ele_list), 0, action='实际REC不是预期状态')
        ele_list = get_xpath_elements(driver,'//div[@class="InCall"]/img[@class="Rec"]')
        public_assert(driver, len(ele_list), 0, action='实际REC不是预期状态')

def enter_video_connection(driver):
    """
    如果出现了“Retry Video Connection”按钮，就点击进入到Video 模式
    share camera需要video模式
    merge需要video模式
    :param driver:
    :return:
    """
    # 点击Retry Video Connection按钮
    ele_list = get_xpath_elements(driver, retry_video_connection)
    if len(ele_list) == 1:
        public_click_element(driver, retry_video_connection, description="RVC按钮")
    time.sleep(3)

def return_ULB_mode(driver):
    """
    点击Return to Ultra-Low Bandwidth按钮
    :param driver:
    :return:
    """
    public_click_element(driver,return_to_ultra_low_bandwidth,description="return_ULB按钮")

def click_merge_button(driver):
    """
    点击Merge按钮，进入到giver角色
    :param driver:
    :return:
    """
    public_click_element(driver,merge_on_button,description="merge_on按钮")
    public_click_element(driver,preview_merge_button,description="preview_merge按钮")

def stop_merge_action(driver):
    """
    停止merge操作
    :param driver:
    :return:
    """
    public_click_element(driver, merge_off_button, description="merge_on按钮")
    time.sleep(2)

def freeze_operation(driver,is_freeze = "freeze",check_notification = 'check'):
    """
    freeze或者unFreeze的操作
    :param driver:
    :param is_freeze: freeze表示freeze，其他则表示unfreeze
    :param check_notification: 是否检查提示信息，check表示检查，其他则表示不检查
    :return:
    """
    if is_freeze == 'freeze':
        public_click_element(driver,freeze_on_action,description="freeze按钮")
        if check_notification == 'check':
            ele_list = get_xpath_elements(driver, task_field_is_frozen)
            public_assert(driver, len(ele_list), 1, action="freeze的提示信息")
    else:
        public_click_element(driver,freeze_off_action,description="unFreeze按钮")
        if check_notification == 'check':
            ele_list = get_xpath_elements(driver, task_field_is_unfrozen)
            public_assert(driver, len(ele_list), 1, action="unFreeze的提示信息")

def click_right_share_button(*drivers):
    """
    # 点击右侧的share按钮
    :param drivers:
    :return:
    """
    # 点击右侧的share按钮
    for i in range(len(drivers)):
        public_click_element(drivers[i], right_share_button, description=f"第{i+1}个driver右侧SHARE按钮")
        time.sleep(3)

def upload_file_in_mac(file):
    """
    在mac系统上上传文件
    :param file:
    :return:
    """
    # 判断操作系统类型
    system_type = get_system_type()
    if system_type == 'Windows':
        # 通过窗口打开
        app = pywinauto.Desktop()
        # 通过弹框名称进入控件中
        win = app['打开']
        time.sleep(2)
        # 输入上传图片的地址
        win['Edit'].type_keys(file)
        time.sleep(2)
        # 点击打开按钮
        win['Button'].click()
        time.sleep(2)
    else:
        k = PyKeyboard()
        m = PyMouse()
        filepath = '/'
        time.sleep(5)
        # 模拟键盘点击 Command + Shift + G
        k.press_keys(['Command', 'Shift', 'G'])
        time.sleep(3)
        # 获取当前屏幕尺寸
        x_dim, y_dim = m.screen_size()
        m.click(x_dim // 2, y_dim // 2, 1)
        time.sleep(3)
        # 复制文件路径开头的斜杠/，如果不加斜杠的话，脚本会缺少头部的斜杠
        pyperclip.copy(filepath)
        time.sleep(3)
        # 粘贴斜杠/
        k.press_keys(['Command', 'V'])
        time.sleep(3)
        # 输入文件全路径
        k.type_string(file)
        time.sleep(2)
        k.press_key('Return')
        time.sleep(2)
        k.press_key('Return')

def share_photo_on_special_dialog(driver,action = "share",file_type = "Photo",file_name = 'test_citron.pdf',if_wait = 'wait'):
    """
    在下方的Audio+ Mode特殊对话框中，点击Share a Photo按钮来上传图片
    :param driver:
    :param action: Share/take a Photo/Share a Document
    :param file_type: 文件类型  Photo/document
    :param file_name: 文件名
    :param if_wait: 是否等待？默认等待
    :return:
    """
    # 点击上传按钮，并先获取文件绝对路径
    if action == "share":
        if file_type.upper() == "PHOTO":
            public_click_element(driver, Share_a_photo, description="share_photo按钮")
            file = get_picture_path(is_input = "not_input")
        else:
            public_click_element(driver, Share_a_document, description="share_PDF按钮")
            file = get_picture_path(file_name,is_input = "not_input")
        # mac上传文件
        upload_file_in_mac(file)
    elif action == "take":
        public_click_element(driver, Take_a_photo, description="share_photo按钮")
        public_click_element(driver,capture_and_share,description="capture_and_share按钮")
    else:
        raise Exception("请输入正确的操作类型take/share")
    if if_wait == 'wait':
        time.sleep(10)

def inCall_upload_photo_PDF(driver,file_type = "Photo",file_name = 'test_citron.pdf',if_wait = 'wait'):
    """
    通话中点击右侧的Share按钮，上传photo或者PDF文件
    :param driver:
    :param file_type: 文件类型
    :param file_name: 文件名
    :param if_wait: 是否等待？默认等待
    :return:
    """
    # 确保文件类型输入正确
    if file_type.upper() != "PHOTO" and file_type.upper() != "PDF":
        print("请输入正确的文件名：Photo or PDF")
        raise Exception("请输入正确的文件名：Photo or PDF")
    # 点击右侧的share按钮
    click_right_share_button(driver)
    # 点击上传按钮，并先获取文件绝对路径
    if file_type.upper() == "PHOTO":
        public_click_element(driver, TPPW_share.format("Photo from Library"), description="share_photo按钮")
        if file_name == 'test_citron.pdf':
            file = get_picture_path(is_input = "not_input")
        else:
            file = get_picture_path(file_name, is_input="not_input")
    elif file_type.upper() == "PDF":
        public_click_element(driver, TPPW_share.format("PDF Document"), description="share_PDF按钮")
        file = get_picture_path(file_name,is_input = "not_input")
    # mac上传文件
    upload_file_in_mac(file)
    if if_wait == 'wait':
        time.sleep(10)

def take_a_new_photo(driver):
    """
    在通话界面中点击右侧的share按钮，并Take a New Photo
    :param driver:
    :return:
    """
    # 点击右侧的share按钮
    click_right_share_button(driver)
    # 点击Take a New Photo按钮
    public_click_element(driver, TPPW_share.format("Take a New Photo"), description="Take_a_New_Photo按钮")
    time.sleep(10)   # 等待摄像头画面捕捉到
    # 点击Capture and Share按钮
    public_click_element(driver,capture_and_share,description="Capture_and_Share按钮")

def share_me(driver):
    """
    在通话界面中点击右侧的share按钮，并share My Camera
    :param driver:
    :return:
    """
    # 点击右侧的share按钮
    click_right_share_button(driver)
    # 点击My camera按钮
    public_click_element(driver, my_camera_button, description="My_camera按钮")
    time.sleep(5)

def share_whiteboard(driver):
    """
    在通话界面中点击右侧的share按钮，并share Whiteboard
    :param driver:
    :return:
    """
    # 点击右侧的share按钮
    click_right_share_button(driver)
    # 点击Whiteboard按钮
    public_click_element(driver, TPPW_share.format("Whiteboard"), description="Whiteboard按钮")
    time.sleep(5)

def stop_sharing_to_f2f(driver):
    """
    Stop Sharing后进入f2f模式
    :param driver:
    :return:
    """
    # 点击右侧的share按钮
    public_click_element(driver, right_share_button, description="右侧SHARE按钮")
    # 点击Stop Sharing按钮
    public_click_element(driver,stop_sharing_button,description="Stop_Sharing按钮")
    time.sleep(5)

def share_live_video_from_sb(driver,user,if_wait = 'wait'):
    """
    右侧的Share按钮点击后，选择Live Video From谁
    :param driver:
    :param user:  选择哪个user来share
    :param if_wait: 操作后是否需要进行几秒钟的等待
    :return:
    """
    # 点击右侧的share按钮
    click_right_share_button(driver)
    # 点击Share live video from somebody：
    public_click_element(driver,live_video_from_sb.format(user),description=f"右侧的share_live_video_from_{user}")
    if if_wait == 'wait':
        time.sleep(5)

def share_page(driver):
    """
    在上传PDF之后，左下角有Share Page按钮，点击这个按钮
    点击后才可以Merge
    :param driver:
    :return:
    """
    public_click_element(driver,share_page_button)

def click_return_after_share_page(driver):
    """
    在上传PDF之后，点击左下角的Share Page按钮后，会出现Return按钮
    :param driver:
    :return:
    """
    public_click_element(driver, return_page_button)

def record_or_do_not_record(if_record,who_do_it,*args):
    """
    开启/关闭record
    :param if_record: Record this session  OR  Do not record
    :param who_do_it: 操作人的username
    :param args: driver的传参列表
    :return:
    """
    public_click_element(args[0],recording_settings,description = 'recording_setting')
    time.sleep(2)
    print('点了切换按钮')
    if if_record == 'record':
        public_click_element(args[0],record_this_session,description = 'record_this_session')
        print('点了打开')
        ele_list = get_xpath_elements(args[0],enable_recording_call.format(who_do_it))
        print(len(ele_list))
        public_assert(args[0],len(ele_list) , 1,action='第一个浏览器开启or关闭record的提示信息不正确')
        for one in args[1:]:
            ele_list = get_xpath_elements(one,enable_recording_call.format(who_do_it))
            print(len(ele_list))
            public_assert(one, len(ele_list), 1, action='剩下的浏览器开启or关闭record的提示信息不正确')
    elif if_record == 'do_not_record':
        public_click_element(args[0],do_not_record,description = 'do_not_record')
        ele_list = get_xpath_elements(args[0],turn_off_recording_call.format(who_do_it))
        print(len(ele_list))
        public_assert(args[0], len(ele_list), 1, action='第一个浏览器开启or关闭record的提示信息不正确')
        for one in args[1:]:
            ele_list = get_xpath_elements(one,turn_off_recording_call.format(who_do_it))
            print(len(ele_list))
            public_assert(one, len(ele_list), 1, action='剩下的浏览器开启or关闭record的提示信息不正确')

def click_audio_only(driver):
    """
    点击Audio Only按钮
    :param driver:
    :return:
    """
    ele_list = get_xpath_elements(driver,Audio_Only_button)
    if len(ele_list) == 1:
        public_click_element(driver,Audio_Only_button,description='Audio_Only按钮')

def click_share_a_photo(driver,fileName):
    """
    点击Share a Photo按钮，不区分giver/hepler
    :param driver:
    :param fileName: 文件名
    :return:
    """
    public_click_element(driver, Share_a_photo, description='点击Share_a_photo按钮')
    picture_path = get_picture_path(fileName)
    get_xpath_element(driver, input_type_file, ec='ec').send_keys(picture_path)

def click_cancel_send_button(driver):
    """
    点击Cancel按钮，取消上传图片
    :param driver:
    :return:
    """
    public_click_element(driver,cancel_send_photo,description='Cancel上传图片按钮')

def clicks_the_hollow_dot(driver):
    """
    通话过程中点击空心的○
    :param driver:
    :return:
    """
    public_click_element(driver,nav_hollow,description="点击空心○")
    time.sleep(2)

def click_nav_right(driver):
    """
    通话页面点击右移，展示剩下的入会者
    :param driver:
    :return:
    """
    public_click_element(driver,nav_right,description="点击右移按钮")

def click_nav_left(driver):
    """
    通话页面点击左移，展示剩下的入会者
    :param driver:
    :return:
    """
    public_click_element(driver, nav_left, description="点击左移按钮")

def turn_on_co_host_for_sb(driver,username,can_turn_on = 'can'):
    """
    打开某个人的Co-host
    :param driver:
    :param username:
    :param can_turn_on: 是否可以开启，默认can可以，can_not不可以，gray无法选中
    :return:
    """
    # 点击左侧的Participants按钮进行展开
    click_participants_div(driver)
    # 点击>
    public_click_element(driver,co_host_right_button.format(username),description=f"{username}旁的>按钮")
    if can_turn_on == 'can':
        # 进行开启co-host操作
        public_click_element(driver, turn_on_co_host_button, description="Co-host打开按钮")
    elif can_turn_on == 'can_not':
        ele_list = get_xpath_elements(driver,co_host_button_unusable)
        public_assert(driver, len(ele_list), 1, action="Co-host应该无法开启")
    else:
        ele_list = get_xpath_elements(driver, co_host_button_gray)
        public_assert(driver, len(ele_list), 1, action="Co-host应该无法开启")
    # 点击"x"按钮进行收起
    close_invite_3th_page(driver)

def turn_off_co_host_for_sb(driver,username,can_turn_off = 'can'):
    """
    关闭某个人的Co-host
    :param driver:
    :param username:
    :param can_turn_off: 是否可以关闭，默认可以
    :return:
    """
    # 点击左侧的Participants按钮进行展开
    click_participants_div(driver)
    # 点击>
    public_click_element(driver,co_host_right_button.format(username),description=f"{username}旁的>按钮")
    # public_click_element(driver,'//span[text()="Co-host"]/../../following-sibling::div[1]//*[@*="#angle_right"]/..',description="Co-host旁的>按钮")
    if can_turn_off == "can":
        # 进行关闭co-host操作
        public_click_element(driver,turn_off_co_host_button,description="Co-host关闭按钮")
    else:
        ele_list = get_xpath_elements(driver,co_host_button_unusable)
        public_assert(driver,len(ele_list),1,action="Co-host无法关闭")
    # 点击"x"按钮进行收起
    close_invite_3th_page(driver)

def turns_off_on_camera(driver,action = 'off'):
    """
    打开或者关闭左侧的camera
    :param driver:
    :param action: off表示关闭Camera，on为打开
    :return:
    """
    if action == 'off':
        public_click_element(driver,off_on_camera.format('on'),description="turn_off——Camera")
    else:
        public_click_element(driver,off_on_camera.format('off'),description='turn_on——Camera')

def co_host_remove_sb(driver,username,can_remove = 'can',if_remove = 'yes',role = 'observer',click_x = 'yes'):
    """
    remove某个人的Co-host
    :param driver:
    :param username:
    :param can_remove: 是否可以remove
    :param if_remove: 是否remove
    :param role: remove的是那种角色？giver？receiver？observer？
    :param click_x:是否"x"按钮进行收起
    :return:
    """
    # 点击左侧的Participants按钮进行展开
    click_participants_div(driver)
    # 点击>
    public_click_element(driver,co_host_right_button.format(username),description=f"{username}旁的>按钮")
    if can_remove == 'can':
        public_click_element(driver,'//div[@class="remove-button " and text()="Remove"]',description=f'Remove_{username}')
        if role == 'observer':
            ele_list = get_xpath_elements(driver,f'//div[text()="Are you sure you want to remove {username}?"]')
            public_assert(driver,len(ele_list),1,action="remove时的message正确")
        elif role == 'giver':
            ele_list = get_xpath_elements(driver, '//div[text()="If you remove this Giver, call will end for all the participants."]')
            public_assert(driver, len(ele_list), 1, action="remove时的message正确")
        else:
            ele_list = get_xpath_elements(driver,'//div[text()="If you remove this Receiver, call will end for all the participants."]')
            public_assert(driver, len(ele_list), 1, action="remove时的message正确")
        if if_remove == 'yes':
            public_click_element(driver,'//div[@class="modal-content"]//button[text()="OK"]',description="OK按钮")
        else:
            public_click_element(driver, '//button[@class="btn btn-default" and text()="Cancel"]', description="Cancel按钮")
    else:
        ele_list = get_xpath_elements(driver,'//div[@class="remove-button disableRemove" and text()="Remove"]')
        public_assert(driver,len(ele_list),1,action=f"{username}不可remove")
    if click_x == 'yes':
        # 点击"x"按钮进行收起
        close_invite_3th_page(driver)

def co_host_mute_sb(driver,mute = 'mute',can_operate = 'can',*usernames):
    """
    co-host给user进行静音或者取消静音
    :param driver:
    :param mute：mute静音，非mute取消静音
    :param can_operate:是否可以进行静音或者非静音
    :param usernames:
    :return:
    """
    # 点击左侧的Participants按钮进行展开
    click_participants_div(driver)
    # 给user进行静音或者取消静音
    for user in usernames:
        if mute == 'mute':
            public_click_element(driver,mute_which_participant.format(user),description=f"给{user}静音")
            time.sleep(1)
            ele_list = get_xpath_elements(driver,unmute_which_participant.format(user))
            public_assert(driver,len(ele_list),1,action=f"给{user}静音成功")
        else:
            public_click_element(driver, unmute_which_participant.format(user), description=f"给{user}取消静音")
            time.sleep(1)
            if can_operate == 'can':
                ele_list = get_xpath_elements(driver, mute_which_participant.format(user))
                public_assert(driver, len(ele_list), 1, action=f"不应无法给{user}取消静音")
            else:
                ele_list = get_xpath_elements(driver, mute_which_participant.format(user))
                public_assert(driver, len(ele_list), 0, action=f"应无法给{user}取消静音")
    close_invite_3th_page(driver)

def turns_on_mic_by_himself(*drivers):
    """
    入会者自己解除静音成功
    :param drivers:
    :return:
    """
    for i in range(len(drivers)):
        public_click_element(drivers[i], turns_on_mic, description=f"第{i + 1}driver自己解除静音")
        ele_list = get_xpath_elements(drivers[i],mic_is_on)
        public_assert(drivers[i],len(ele_list),1,action=f"第{i + 1}driver自己解除静音成功")

def select_co_host_back(driver,username = 'Huiming.shi.helplightning+EU2',can_turn_on = 'can',action = 'turn_on'):
    """
    # 选择co-host后返回
    :param driver:
    :param username:需要设置为另一个共同主持的user name
    :param can_turn_on: 这个user是否可以开启co-host
    :param action: 打开还是关闭；默认是打开:turn_on
    :return:
    """
    # 点击>
    public_click_element(driver, co_host_right_button.format(username), description=f"{username}旁的>按钮")
    if can_turn_on == 'can':
        # 进行开启co-host操作
        if action == 'turn_on':
            public_click_element(driver, turn_on_co_host_button, description="Co-host打开按钮")
        else:
            public_click_element(driver, turn_off_co_host_button, description="Co-host关闭按钮")
    else:
        # 校验co-host开关不可用
        ele_list = get_xpath_elements(driver, co_host_button_gray)
        public_assert(driver, len(ele_list), 1, action="Co-host无法开启")
    # 点击Participants的Back按钮
    public_click_element(driver,'//div[@class="return-button"]',description="Participants的Back按钮")

def clear_shared_content_action(driver):
    """
    点击Clear Shared Content按钮
    :param driver:
    :return:
    """
    public_click_element(driver,Clear_Shared_Content,description="Clear_Shared_Content按钮")

def switch_to_mode_from_call_quality(driver,mode = "SD"):
    """
    点击右上角三个横杠，切换模式
    :param driver:
    :param mode: HD?SD?Ultra-Low Bandwidth
    :return:
    """
    public_click_element(driver, option_menu, description=f"右上角三个横杠")
    public_click_element(driver,call_quality_span,description="call_quality按钮")
    if mode == "HD":
        public_click_element(driver, '//span[text()="HD Video"]', description="HD_Video按钮")
    elif mode == "SD":
        public_click_element(driver, '//span[text()="SD Video"]', description="SD_Video按钮")
    else:
        public_click_element(driver, '//span[text()="Ultra-Low Bandwidth"]', description="ULB按钮")


if __name__ == '__main__':
    import tkinter as tk
    root = tk.Tk()
    print(root.winfo_screenwidth())
    print(root.winfo_screenheight())
    root.destroy()

    # from else_public_lib import driver_set_up_and_logIn, logout_citron
    # driver6 = driver_set_up_and_logIn('Huiming.shi.helplightning+99887766551@outlook.com', '*IK<8ik,8ik,')
    # driver7 = driver_set_up_and_logIn('Huiming.shi.helplightning+99887766553@outlook.com', '*IK<8ik,8ik,')
    # time.sleep(10000)
    # print()