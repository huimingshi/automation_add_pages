#----------------------------------------------------------------------------------------------------#
import time

from Citron.public_switch.pubLib import *
from Citron.public_switch.public_switch_py import IMPLICIT_WAIT
from public_settings_and_variable import *
from selenium.webdriver.common.keys import Keys
from obtain_meeting_link_lib import obtain_meeting_link
from else_public_lib import paste_on_a_non_windows_system, user_accept_disclaimer
from else_public_lib import make_sure_enter_call as m_s_e_c
from else_public_lib import end_call_for_all as user_end_call_for_all
from else_public_lib import refresh_browser_page as refresh_page
from selenium import webdriver
from selenium.webdriver import ActionChains
import warnings

#----------------------------------------------------------------------------------------------------#
# define python Library
def open_debug_dialog_check_resolution(driver):
    """
    通话过程中打开Debug，查找Resolution
    :param driver:
    :return:
    """
    public_check_element(driver,invite_user_div,'点击右上角三个横杠失败')
    public_check_element(driver, enter_debug_page, '进入debug_page失败')
    resolution_get = get_xpath_element(driver,'//span[@id="pubresolution"]',description = '进入debug查找resolution').get_attribute("textContent")
    print(resolution_get)
    public_assert(driver,resolution_get , '1280x720',action='resolution不是1280x720')

def open_invite_3rd_participant_dialog(driver,enter_send_invite = 'yes'):
    """
    打开邀请第三位通话者的界面
    :param driver:
    :param enter_send_invite: 是否需要进入send invite页面，默认’yes‘进入，其他表示不进入
    :return:
    """
    # 确保进入call
    m_s_e_c(driver)
    public_check_element(driver, invite_user_div, '右上角三个横杠按钮未展示',if_click = None,if_show = 1)
    public_click_element(driver, invite_user_div, description='右上角三个横杠按钮')
    public_check_element(driver, enter_invite_user_page, 'Invite图标未展示',if_click = None,if_show = 1)
    public_click_element(driver, enter_invite_user_page, description='Invite图标')
    if enter_send_invite == 'yes':
        public_check_element(driver, send_invite_in_calling, '进入send_invite页面失败')
    elif enter_send_invite != 'yes':
        public_check_element(driver, contacts_list_in_calling, '进入contacts_list页面失败',if_click=None)

def send_invite_in_calling_page(driver,if_send = 'not_send'):
    """
    通话过程中获取send invite的link
    :param driver:
    :param if_send:是否发送，默认不发送not_send，发送为send
    :return:返回会议link
    """
    # 进入send invite页面
    open_invite_3rd_participant_dialog(driver)
    # 复制
    public_check_element(driver, '//div[@class="image-container"]', '点击复制按钮失败')
    # 粘贴
    sys_type = get_system_type()   # 判断是哪种操作系统，Windows和非Windows的粘贴操作不一样
    if sys_type == 'Windows':
        public_click_element(driver, my_help_space_message, description='Windows操作系统message输入框')
        get_xpath_element(driver,my_help_space_message,description = 'Windows操作系统message输入框').send_keys(Keys.CONTROL, 'v')
    else:
        paste_on_a_non_windows_system(driver, my_help_space_message)
    # 验证复制后粘贴结果正确
    invite_url = get_xpath_element(driver,get_invite_link,description = 'link链接').get_attribute("textContent")  # Get the invitation link
    print('复制的link为:', invite_url)
    attribute = get_xpath_element(driver,my_help_space_message,description = 'message输入框').get_attribute('value')
    print('粘贴的link为:', attribute)
    # 验证复制后粘贴结果正确
    public_assert(driver,attribute , invite_url,action='复制和粘贴的内容不一致')
    if if_send == 'send':
        # 输入email
        email_ele = get_xpath_element(driver,send_link_email_input,description = 'email输入框')
        public_click_element(driver,send_link_email_input,description = 'email输入框')
        email_ele.send_keys('Huiming.shi.helplightning+123456789@outlook.com')
        # 点击Send Invite按钮
        public_click_element(driver,send_link_send_invite,description = 'email发送按钮')
    return invite_url    # 返回会议link

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
        click_show_directory_when_invite_3rd(driver)

def click_show_directory_when_invite_3rd(driver):
    """
    在邀请第三位用户进入Call的页面上，点击‘Show Directory’按钮
    :param driver:
    :return:
    """
    public_check_element(driver, '//div[@id="inviteDialog-pane-1"]//input[@type="checkbox"]', '勾选Show_Directory失败')
    time.sleep(3)

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

def user_end_call_by_self(driver):
    """
    用户自己主动END Call
    :param driver2:
    :return:
    """
    # End call
    public_check_element(driver, end_call_before_connecting, '主动End_call失败')

def enter_contacts_search_user(driver,search_name,if_click= 'no_click_show',search_result = 'has_user_data'):
    """
    # 通话过程中进入Contacts列表页面，并根据name进行查询
    :param driver:
    :param search_name: 要查询的name，同时也是预期的name
    :param if_click: 是否勾选‘Show Directory’；默认'no_click_show'不勾选；'click_show'为勾选
    :param search_result: 查询的结果；默认查询'has_user_data'有用户数据；'has_no_user_data'没有用户数据
    :return:
    """
    # 进入到邀请第三位用户的Contacts页面
    open_invite_3rd_participant_dialog(driver,'no_enter')
    # 判断是否需要点击‘Show Directory’按钮的
    tag = True
    if if_click == 'click_show':
        time.sleep(5)
        click_show_directory_when_invite_3rd(driver)
        tag = False
        time.sleep(2)
    # 通过name查询
    search_element = get_xpath_element(driver,'//input[@id="quick-search-text-box"]',description = '查询框')
    search_element.clear()
    time.sleep(2)
    public_click_element(driver,'//input[@id="quick-search-text-box"]',description = '查询框')
    search_element.send_keys(search_name)
    if not tag:
        time.sleep(2)
    ele_list = get_xpath_elements(driver,f'//div[@class="contact-name" and contains(.,"{search_name}")]')
    # 断言
    if search_result == 'has_user_data':
        public_assert(driver,len(ele_list) , 1,condition='>=',action='查询的user数据与预期不符')
    elif  search_result == 'has_no_user_data':
        public_assert(driver,len(ele_list) , 0,action='查询的user数据与预期不符')

def close_invite_3th_page(driver):
    """
    关闭邀请第三位用户进入call的页面
    :param driver:
    :return:
    """
    # 关闭
    public_check_element(driver, close_invite_3th_page_xpath, '关闭invite_page失败')

def click_user_in_contacts_call(driver,username,can_reach = 'can_reach'):
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

def make_call_between_four_role(driver1,driver2,driver3,who):
    """
    # Make calls between four role
    :param driver1:
    :param driver2:
    :param driver3:
    :param who:
    :return:
    """
    # make calls with who
    element = get_xpath_element(driver1, search_input,description = '查询框')
    public_click_element(driver1, search_input,description = '查询框')
    element.send_keys(who)
    time.sleep(3)
    public_click_element(driver1,click_call_button,description = 'Call按钮')    # click Call button
    # who anwser calls
    public_check_element(driver2, anwser_call_button, '点击ANWSER按钮失败')
    time.sleep(10)
    # 进入send invite 页面
    open_invite_3rd_participant_dialog(driver1)
    time.sleep(2)
    # get call link
    invite_url =get_xpath_element(driver1,get_invite_link,description = '邀请链接').get_attribute("textContent")  # Get the invitation link
    print(invite_url)
    public_click_element(driver1,close_invite_3th_page_xpath,description = '关闭invite_page按钮')
    print("邀请链接为:",invite_url)
    js = "window.open('{}','_blank');"
    # cross enterprise join call
    driver3.execute_script(js.format(invite_url))
    driver3.switch_to.window(driver3.window_handles[-1])  # 切换到最新页面
    # Accept Disclaimer
    user_accept_disclaimer(driver3)
    # Anwser cross enterprise call request
    public_check_element(driver1, external_join_call_anwser_button, '接受cross_enterprise的call失败')
    if SMALL_RANGE_BROWSER_TYPE == 'Chrome':
        driver4 = webdriver.Chrome(options=option)
    elif SMALL_RANGE_BROWSER_TYPE == 'Firefox':
        driver4 = webdriver.Firefox(options=option,firefox_profile=profile)
    driver4.implicitly_wait(int(6))
    driver4.get(invite_url)
    driver4.maximize_window()
    # Accept Disclaimer
    user_accept_disclaimer(driver4)
    # Anwser Anonymous User call request
    public_check_element(driver1, external_join_call_anwser_button, '接受Anonymous的call失败')

    # call on hold
    time.sleep(int(10))
    # screenshots
    public_check_element(driver2, select_your_role, '点击失败')
    public_check_element(driver2, '//div[@class="user-list"]/div[1]', '点击失败')
    public_check_element(driver2, '//div[@class="user-list"]/div[2]', '点击失败')
    public_check_element(driver2, '//button[@class="btn btn-primary" and contains(.,"Continue")]', '点击continue失败')
    for i in range(3):
        public_check_element(driver2, '//input[@class="capture_button"]', 'screenshots失败')
        time.sleep(3)
    # End Call for All
    user_end_call_for_all(driver2)
    return driver4

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
        driver = webdriver.Chrome(options=option)
    elif SMALL_RANGE_BROWSER_TYPE == 'Firefox':
        driver = webdriver.Firefox(options=option,firefox_profile=profile)
    driver.implicitly_wait(int(6))
    driver.get(meeting_link)
    driver.maximize_window()
    # 怎么处理Disclaimer；ACCCEPT OR DECLINE
    if deal_with_disclaimer == 'accept':
        ele_list = get_xpath_elements(driver,accept_disclaimer)
        if len(ele_list) == 1:
            public_click_element(driver,accept_disclaimer,description='ACCCEPT_Disclaimer')
            time.sleep(3)
            driver.implicitly_wait(5)
            ele_list = get_xpath_elements(driver, accept_disclaimer)
            if len(ele_list) == 1:
                print('还需要再一次ACCCEPT_Disclaimer')
                public_click_element(driver, accept_disclaimer, description='再一次ACCCEPT_Disclaimer')
            driver.implicitly_wait(int(IMPLICIT_WAIT))
    elif deal_with_disclaimer == 'decline':
        ele_list = get_xpath_elements(driver, decline_disclaimer)
        if len(ele_list) == 1:
            public_click_element(driver, decline_disclaimer, description='DECLINE_Disclaimer')
        # ele_list = get_xpath_elements(driver,'//div[@id="whiteboard_message" and text()="Waiting for an incoming call..."]')
        # public_assert(driver, len(ele_list), 1, action='未出现Waiting for an incoming call...')
    return driver

def user_make_call_via_meeting_link(driver,meeting_link):
    """
    # user打开这个会议link，需要处理Discliaimer
    :param meeting_link: 会议link
    """
    # 打开meeting link
    js = "window.open('{}','_blank');"
    driver.execute_script(js.format(meeting_link))
    driver.switch_to.window(driver.window_handles[-1])  # 切换到最新页面
    # 处理Discliaimer
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
    elif type == 'in_calling':
        public_check_element(driver, decline_call, 'user_decline_call失败')

def user_anwser_call(driver,anwser_type = 'direct'):
    """
    # User接受call
    :param driver:
    :param anwser_type: 应答类型，分为直接Anwser和外部用户加入Anwser，默认直接Anwser;    direct  or  no_direct
    :return:
    """
    if anwser_type == 'direct':
        public_check_element(driver, anwser_call_button, '没找到直接接受Call的按钮')
    elif anwser_type == 'no_direct':
        public_check_element(driver, external_join_call_anwser_button, '没找到间接接受Call的按钮')

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

def contacts_witch_page_make_call(driver1,driver2,witch_page,who = 'on-call group 1',accept='accept'):
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
    # 选择Audio
    audio_xpath = f'//div[text()="{who}"]/../../../..//span[text()="Audio+"]/..'
    public_click_element(driver1,audio_xpath,description='启动Audio按钮')
    # 需要Accept Declaimer
    driver1.implicitly_wait(5)
    count = get_xpath_elements(driver1, accept_disclaimer)
    if len(count) == 1:
        public_click_element(driver1, accept_disclaimer, '点击accept_disclaimer失败')
    driver1.implicitly_wait(IMPLICIT_WAIT)
    # # 断言是否呼叫成功
    # count = get_xpath_elements(driver1, end_call_before_connecting)
    # public_assert(driver1, len(count), 1, action='发起call失败')
    # 另一端ACCEPT OR DECLINE
    if accept == 'accept':
        public_check_element(driver2, anwser_call_button, '点击ANWSER按钮失败')
    elif accept == 'no_accept':
        public_check_element(driver2, decline_disclaimer, '点击DECLINE按钮失败')

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
    if check_otu == 'check_otu':
        try:
            assert meeting_link.startswith(r'https://app-stage.helplightning.net.cn/meet/link')
        except AssertionError:
            raise AssertionError('当前邮件不是OTU邮件')
    return meeting_link

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

def enter_face_to_face_mode(driver):
    """
    进入Face to Face模式
    :param driver:
    :return:
    """
    public_check_element(driver, '//*[@*="#rh_on"]', '进入f2f模式第一步失败')
    public_check_element(driver, '//*[@*="#f2f_off"]/../..', '进入f2f模式第二步失败')

def enter_giver_mode(driver,who_give_help,who_receive_help,roles = '3',has_dialog = 'has_dialog',give_or_receive = 'give'):
    """
    进入giver模式
    :param driver:
    :param who_give_help:  选择giver的name
    :param who_receive_help:  选择receiver的name
    :param roles: 通话者数目
    :param has_dialog: 是否有对话框出现
    :param give_or_receive: 想进入哪种模式；默认是give为giver模式，其他为receiver模式
    :return:
    """
    if roles == '3':
        public_check_element(driver, f2f_on_mode, '点击失败')
        public_check_element(driver, f'//div[@class="user-base"]/strong[text()="{who_give_help}"]', '第一步失败')
        public_check_element(driver, f'//div[@class="user-base"]/strong[text()="{who_receive_help}"]', '第二步失败')
        public_check_element(driver, '//div[@class="user-footer"]/button[text()="Continue"]', '第三步失败')
    elif has_dialog == 'has_dialog' and roles == '2' and give_or_receive == 'give':
        public_check_element(driver, '//span[text()="I will give help"]', '选择I_will_give_help失败')
    elif has_dialog == 'has_dialog' and roles == '2' and give_or_receive != 'give':
        public_check_element(driver, '//span[text()="I need help"]', '选择I_need_help失败')
    elif has_dialog == 'has_no_dialog' and roles == '2':
        public_check_element(driver, f2f_on_mode, '点击第一步失败')
        public_check_element(driver, '//*[@*="#rh_off"]/../..', '点击第二步失败')

def enter_FGD_mode(driver,witch_mode):
    """
    切换Freeze/GHoP/Doc Share三种模式
    :param driver:
    :param witch_mode:
    :return:
    """
    if witch_mode == "Document":
        public_click_element(driver,video_on_button,ec='ec',description='点击video按钮')
        time.sleep(2)
        public_click_element(driver,'//div[@class="submenu-content"]//span[text()="Document"]/..',ec='ec',description='选择Document')
        get_xpath_element(driver,upload_file,ec='ec',description='上传pdf文件').send_keys(get_picture_path('test_citron.pdf'))
        # 返回原始状态
        public_click_element(driver, pdf_on_button, ec='ec', description='pdf_on_button')
        ele_list = get_xpath_elements(driver,return_vidoe_on)
        if len(ele_list) == 1:
            time.sleep(5)
            public_click_element(driver,return_vidoe_on, description='返回原始状态')
        else:
            public_click_element(driver, pdf_on_button, description='pdf_on_button')
    elif witch_mode == "Photo":
        ele_list = get_xpath_elements(driver, video_on_button)
        if len(ele_list) == 1:
            public_click_element(driver,video_on_button,ec='ec',description='点击video按钮')
        else:
            public_click_element(driver, pdf_on_button, ec='ec', description='点击video按钮')
        time.sleep(2)
        public_click_element(driver,'//div[@class="submenu-content"]//span[text()="Photo"]/..',ec='ec',description='选择Photo')
        get_xpath_element(driver,upload_file,ec='ec',description='上传jpg文件').send_keys(get_picture_path())
        # 返回原始状态
        public_click_element(driver,ghop_on_button,ec='ec',description='ghop_on_button')
        ele_list = get_xpath_elements(driver,return_vidoe_on)
        if len(ele_list) == 1:
            time.sleep(5)
            public_click_element(driver,return_vidoe_on, description='返回原始状态')
        else:
            public_click_element(driver, ghop_on_button,description='ghop_on_button')
    elif witch_mode == "Swap Camera":
        public_click_element(driver,video_on_button,ec='ec',description='点击video按钮')
        time.sleep(2)
        public_click_element(driver,'//div[@class="submenu-content"]//span[text()="Swap Camera"]/..',ec='ec')
        screen_shot_func(driver, 'MAC电脑上查看下点击Swap_Camera后页面状态')
    elif witch_mode == "Freeze":
        public_click_element(driver,video_on_button,ec='ec',description='点击video按钮')
        time.sleep(2)
        public_click_element(driver,'//div[@class="submenu-content"]//span[text()="Freeze"]/..',ec='ec')
        screen_shot_func(driver, 'MAC电脑上查看下点击Freeze后页面状态')

def back_to_face_to_face_mode(driver):
    """
    回到Face to Face模式
    :param driver:
    :return:
    """
    public_check_element(driver, select_your_role, '点击右上角的小手失败')
    public_check_element(driver, '//*[@*="#f2f_off"]/../..', '进入f2f模式失败')

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
        public_assert(args[0],len(ele_list) , 1,action='第一个浏览器开启or关闭record的提示信息不正确')
        for one in args[1:]:
            ele_list = get_xpath_elements(one,enable_recording_call.format(who_do_it))
            public_assert(one, len(ele_list), 1, action='剩下的浏览器开启or关闭record的提示信息不正确')
    elif if_record == 'do_not_record':
        public_click_element(args[0],do_not_record,description = 'do_not_record')
        ele_list = get_xpath_elements(args[0],turn_off_recording_call.format(who_do_it))
        public_assert(args[0], len(ele_list), 1, action='第一个浏览器开启or关闭record的提示信息不正确')
        for one in args[1:]:
            ele_list = get_xpath_elements(one,turn_off_recording_call.format(who_do_it))
            public_assert(one, len(ele_list), 1, action='剩下的浏览器开启or关闭record的提示信息不正确')

def proceed_with_camera_off(driver):
    """
    Proceed with my camera Off
    :param driver:
    :return:
    """
    ele_list = get_xpath_elements(driver,webglCameraOff)
    if len(ele_list) == 1:
        public_click_element(driver,webglCameraOff,description='proceed_with_camera_off按钮')

def click_audio_only(driver):
    ele_list = get_xpath_elements(driver,Audio_Only_button)
    if len(ele_list) == 1:
        public_click_element(driver,Audio_Only_button,description='Audio_Only按钮')

if __name__ == '__main__':
    from else_public_lib import driver_set_up_and_logIn, logout_citron
    # driver1 = driver_set_up_and_logIn('Huiming.shi.helplightning+9988776655@outlook.com','*IK<8ik,8ik,')
    # driver2 = driver_set_up_and_logIn('Huiming.shi.helplightning+99887766551@outlook.com', '*IK<8ik,8ik,')
    # driver3 = driver_set_up_and_logIn('Huiming.shi.helplightning+99887766553@outlook.com', '*IK<8ik,8ik,')
    # driver4 = driver_set_up_and_logIn('Huiming.shi.helplightning+for_oncall@outlook.com', '*IK<8ik,8ik,')
    # driver5 = driver_set_up_and_logIn('Huiming.shi.helplightning+belong_two_WS@outlook.com', '*IK<8ik,8ik,')
    driver6 = driver_set_up_and_logIn('Huiming.shi.helplightning+99887766551@outlook.com', '*IK<8ik,8ik,')
    driver7 = driver_set_up_and_logIn('Huiming.shi.helplightning+99887766553@outlook.com', '*IK<8ik,8ik,')
    # driver8 = driver_set_up_and_logIn('Huiming.shi.helplightning+9988776655@outlook.com', '*IK<8ik,8ik,')
    # driver9 = driver_set_up_and_logIn('Huiming.shi.helplightning+test_WS3_branding_A@outlook.com ', '*IK<8ik,8ik,')
    # driver10 = driver_set_up_and_logIn('Huiming.shi.helplightning+test_WS3_branding_B@outlook.com ', '*IK<8ik,8ik,')
    # driver11 = driver_set_up_and_logIn('Huiming.shi.helplightning+TU1@outlook.com', '*IK<8ik,8ik,')
    # driver12 = driver_set_up_and_logIn('Huiming.shi.helplightning+Expert_B@outlook.com', '*IK<8ik,8ik,')
    # driver13 = driver_set_up_and_logIn('Huiming.shi.helplightning+TU1@outlook.com', '*IK<8ik,8ik,')
    # driver14 = driver_set_up_and_logIn('Huiming.shi.helplightning+test_WS_branding_A@outlook.com', '*IK<8ik,8ik,')
    # driver15 = driver_set_up_and_logIn('Huiming.shi.helplightning+test_WS_branding_B@outlook.com', '*IK<8ik,8ik,')
    # driver16 = driver_set_up_and_logIn('Huiming.shi.helplightning+test_WS_branding_C@outlook.com', '*IK<8ik,8ik,')
    # driver17 = driver_set_up_and_logIn('Huiming.shi.helplightning+EU5@outlook.com', '*IK<8ik,8ik,')
    # driver18 = driver_set_up_and_logIn('Huiming.shi.helplightning+enterprise_user@outlook.com', '*IK<8ik,8ik,')
    # driver19 = driver_set_up_and_logIn('big_admin', 'asdQWE123')
    # driverxyz = driver_set_up_and_logIn('emily.huang+bsb', 'abc123')
    # driver20 = driver_set_up_and_logIn('huiming.shi@helplightning.com', '*IK<8ik,8ik,')
    # driver21 = driver_set_up_and_logIn('Huiming.shi.helplightning+test_WS3_branding_B@outlook.com', '*IK<8ik,8ik,')
    time.sleep(10000)
    print()