#----------------------------------------------------------------------------------------------------#
import time
from public_lib import screen_shot_func,get_system_type,public_check_element
from public_settings_and_variable import *
from selenium.webdriver.common.keys import Keys
from obtain_meeting_link_lib import obtain_meeting_link
from else_public_lib import paste_on_a_non_windows_system,user_accept_disclaimer,get_picture_path
from else_public_lib import end_call_for_all as user_end_call_for_all
from else_public_lib import refresh_browser_page as refresh_page
from selenium import webdriver
from selenium.webdriver.common.action_chains import ActionChains

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
    try:
        resolution_get = driver.find_element_by_xpath('//span[@id="pubresolution"]').get_attribute("textContent")
        assert resolution_get == '1280x720'
    except AssertionError:
        screen_shot_func(driver,'resolution不是1280x720')
        raise AssertionError
    except Exception as e:
        print('进入debug查找resolution失败',e)
        screen_shot_func(driver, '进入debug查找resolution失败')
        raise Exception

def open_invite_3rd_participant_dialog(driver,enter_send_invite = 'yes'):
    """
    打开邀请第三位通话者的界面
    :param driver:
    :param enter_send_invite: 是否需要进入send invite页面，默认’yes‘进入，其他表示不进入
    :return:
    """
    public_check_element(driver, invite_user_div, '右上角三个横杠按钮不可点击')
    public_check_element(driver, enter_invite_user_page, 'Invite图标不可点击')
    if enter_send_invite == 'yes':
        public_check_element(driver, send_invite_in_calling, '进入send_invite页面失败')
    elif enter_send_invite != 'yes':
        public_check_element(driver, contacts_list_in_calling, '进入contacts_list页面失败')

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
        try:
            ele = driver.find_element_by_xpath(my_help_space_message)
            ele.click()
            ele.send_keys(Keys.CONTROL, 'v')
        except Exception as e:
            print('Windows操作系统粘贴失败',e)
            screen_shot_func(driver, 'Windows操作系统粘贴失败')
            raise Exception
        else:
            print('Windows操作系统粘贴成功')
    else:
        paste_on_a_non_windows_system(driver, my_help_space_message)
    # 验证复制后粘贴结果正确
    try:
        invite_url = driver.find_element_by_xpath(get_invite_link).get_attribute("textContent")  # Get the invitation link
        print('复制的link为:', invite_url)
        attribute = driver.find_element_by_xpath(my_help_space_message).get_attribute('value')
        print('粘贴的link为:', attribute)
    except Exception as e:
        print('获取复制粘贴的link失败',e)
        screen_shot_func(driver, '获取复制粘贴的link失败')
        raise Exception
    try:
        assert attribute == invite_url  # 验证复制后粘贴结果正确
    except AssertionError:
        screen_shot_func(driver, '复制和粘贴的内容不一致')
        raise AssertionError
    if if_send == 'send':
        try:
            # 输入email
            email_ele = driver.find_element_by_xpath(send_link_email_input)
            email_ele.click()
            email_ele.send_keys('Huiming.shi.helplightning+123456789@outlook.com')
            # 点击Send Invite按钮
            driver.find_element_by_xpath(send_link_send_invite).click()
        except Exception as e:
            print('输入信息失败', e)
            screen_shot_func(driver, '输入信息失败')
            raise Exception
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
    if is_personal == 'not_personal':
        try:
            element = driver1.find_element_by_id(search_input)
            element.clear()
            time.sleep(2)
            element.click()
            element.send_keys(who)
            time.sleep(5)
        except Exception as e:
            print(f'输入{who}失败', e)
            screen_shot_func(driver1, f'输入{who}失败')
            raise Exception
        else:
            print(f'输入{who}成功')
        user_name = who.split('@')[0]
        ele_ment = driver1.find_elements_by_xpath(f'//div[@class="card"]/div[text()="{user_name}"]')
        print('0000000000000000000000000000000000',len(ele_ment))
        if len(ele_ment) < 1:
            refresh_page(driver1)
            element = driver1.find_element_by_id(search_input)
            element.click()
            element.send_keys(who)
            time.sleep(5)
        public_check_element(driver1, f'//div[@class="card"]/div[text()="{user_name}"]', f'{user_name}未加载出',if_click = None,if_show = 1)
        public_check_element(driver1, click_call_button, '点击Call按钮失败')
    else:
        public_check_element(driver1, '//a[@id="user-tabs-tab-2"]', '点击personal_contacts页面失败')
        time.sleep(3)
        try:
            element = driver1.find_element_by_xpath('//div[@id="user-tabs-pane-2"]//input[@id="filter-text-box"]')
            element.clear()
            time.sleep(2)
            element.click()
            element.send_keys(who)
            time.sleep(3)
            for i in range(3):
                time.sleep(2)
                ele_count = driver1.find_elements_by_xpath('//div[@id="user-tabs-pane-2"]//div[@class="ag-center-cols-container"]/div')
                if len(ele_count) == 1:
                    time.sleep(2)
                    driver1.find_element_by_xpath(click_call_button).click()  # click Call button
                    time.sleep(5)
                    break
        except Exception as e:
            print('点击call失败', e)
            screen_shot_func(driver1, '点击call失败')
            raise Exception
        else:
            print('点击call成功')
    # user anwser calls
    if answer == 'anwser':
        try:
            ele_list = driver2.find_elements_by_xpath(anwser_call_button)
            if len(ele_list) == 1:
                ele_list[0].click()
            else:
                ele_list = driver2.find_elements_by_xpath(anwser_call_button)
                if len(ele_list) == 1:
                    ele_list[0].click()
                else:
                    raise Exception('点击ANSWER按钮失败')
        except Exception as e:
            print(f'点击ANSWER按钮失败',e)
            screen_shot_func(driver1,'辅助查看点击ANSWER按钮失败')
            screen_shot_func(driver2,'点击ANSWER按钮失败')
            raise Exception

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
    try:
        src_attribute = driver1.find_element_by_xpath('//div[@id="incoming_avatarImage"]/img').get_attribute('src')
        print(src_attribute)
        print(expect_src)
        name_attribute = driver1.find_element_by_xpath('//div[@id="incoming_caller_name"]').get_attribute("textContent")
        print(name_attribute)
        print(expect_name)
    except Exception as e:
        print('未获取到打进来的call',e)
        screen_shot_func(driver1, '未获取到打进来的call')
        raise AssertionError
    # 进行avator和name的断言
    try:
        assert expect_src in src_attribute
    except AssertionError:
        screen_shot_func(driver1, '预期的avator和实际上的avator不一致')
        raise AssertionError('预期的avator和实际上的avator不一致')
    try:
        assert str(name_attribute) == str(expect_name)
    except AssertionError:
        screen_shot_func(driver1, '预期的name和实际上的name不一致')
        raise AssertionError('预期的name和实际上的name不一致')
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
    try:
        search_element = driver.find_element_by_xpath('//input[@id="quick-search-text-box"]')
        search_element.clear()
        time.sleep(2)
        search_element.click()
        search_element.send_keys(search_name)
        if not tag:
            time.sleep(2)
    except Exception as e:
        print('通过name查询失败',e)
        screen_shot_func(driver, '通过name查询失败')
        raise Exception('通过name查询失败')
    else:
        print('通过name查询成功')
    ele_list = driver.find_elements_by_xpath(f'//div[@class="contact-name" and contains(.,"{search_name}")]')
    try:
        if search_result == 'has_user_data':
            assert len(ele_list) >= 1
        elif  search_result == 'has_no_user_data':
            assert len(ele_list) == 0
    except AssertionError:
        screen_shot_func(driver, '查询的user数据与预期不符')
        raise AssertionError('查询的user数据与预期不符')

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
    try:
        xpath_src = f'//div[@class="contact-name" and contains(.,"{search_name}")]/../../../../div[@col-id="avatar.url"]//img'
        src_attribute = driver.find_element_by_xpath(xpath_src).get_attribute('src')
        print(src_attribute)
        name_xpath = f'//div[@class="contact-name" and contains(.,"{search_name}")]'
        name_attribute = driver.find_element_by_xpath(name_xpath).get_attribute('textContent')
        print(name_attribute)
    except Exception as e:
        print('通话过程中Contacts列表页面未查到指定User',e)
        screen_shot_func(driver, '通话过程中Contacts列表页面未查到指定User')
        raise Exception
    # 进行avator和name的断言
    try:
        assert expect_src in src_attribute
    except AssertionError:
        screen_shot_func(driver, '预期的avator和实际上的avator不一致')
        raise AssertionError('预期的avator和实际上的avator不一致')
    try:
        assert str(name_attribute) == str(search_name)
    except AssertionError:
        screen_shot_func(driver, '预期的name和实际上的name不一致')
        raise AssertionError('预期的name和实际上的name不一致')

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
    try:
        element = driver1.find_element_by_id(search_input)
        element.click()
        element.send_keys(who)
        time.sleep(3)
        driver1.find_element_by_xpath(click_call_button).click()  # click Call button
    except Exception as e:
        print(f'向{who}发起call失败',e)
        screen_shot_func(driver1, f'向{who}发起call失败')
        raise Exception
    else:
        print(f'向{who}发起call成功')
    # who anwser calls
    public_check_element(driver2, anwser_call_button, '点击ANWSER按钮失败')
    time.sleep(10)
    # 进入send invite 页面
    open_invite_3rd_participant_dialog(driver1)
    time.sleep(2)
    # get call link
    try:
        invite_url = driver1.find_element_by_xpath(get_invite_link).get_attribute("textContent")    # Get the invitation link
        print(invite_url)
        driver1.find_element_by_xpath(close_invite_3th_page_xpath).click()  # 关闭 invite page
        print("邀请链接为:",invite_url)
        js = "window.open('{}','_blank');"
    except Exception as e:
        print('获取会议link失败',e)
        screen_shot_func(driver1, '获取会议link失败')
        raise Exception
    else:
        print('获取会议link成功')
    # cross enterprise join call
    driver3.execute_script(js.format(invite_url))
    driver3.switch_to.window(driver3.window_handles[-1])  # 切换到最新页面
    # Accept Disclaimer
    user_accept_disclaimer(driver3)
    # Anwser cross enterprise call request
    public_check_element(driver1, external_join_call_anwser_button, '接受cross_enterprise的call失败')
    driver4 = webdriver.Chrome(chrome_options=option)
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
    public_check_element(driver2, '//div[@class="menu roleMenu"]/div[@class="menu withsub  "]', '点击失败')
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
    try: # 启动driver打开meeting link
        driver = webdriver.Chrome(chrome_options=option)
        driver.implicitly_wait(int(6))
        driver.get(meeting_link)
        driver.maximize_window()
        if deal_with_disclaimer == 'accept':
            ele_list = driver.find_elements_by_xpath(accept_disclaimer)
            if len(ele_list) == 1:
                ele_list[0].click()
        elif deal_with_disclaimer == 'decline':
            ele_list = driver.find_elements_by_xpath(decline_disclaimer)
            if len(ele_list) == 1:
                ele_list[0].click()
                ele_list = driver.find_elements_by_xpath('//div[@id="whiteboard_message" and text()="Disclaimer must be accepted."]')
                assert len(ele_list) == 1
    except AssertionError:
        print('未出现message_disclaimer_must_be_accepted')
        screen_shot_func(driver, '未出现message_disclaimer_must_be_accepted')
        raise Exception
    except Exception as e:
        print('打开meeting link网页失败',e)
        screen_shot_func(driver, '打开meeting link网页失败')
        raise Exception
    else:
        print('打开meeting link网页成功')
    return driver

def user_make_call_via_meeting_link(driver,meeting_link):
    """
    # user打开这个会议link，需要处理Discliaimer
    :param meeting_link: 会议link
    """
    try:
        # 打开meeting link
        js = "window.open('{}','_blank');"
        driver.execute_script(js.format(meeting_link))
        driver.switch_to.window(driver.window_handles[-1])  # 切换到最新页面
    except Exception as e:
        print('user打开meeting link网页失败',e)
        screen_shot_func(driver, 'user打开meeting link网页失败')
        raise Exception
    else:
        print('user打开meeting link网页成功')
    try:
        ele_list = driver.find_elements_by_xpath(accept_disclaimer)
        if len(ele_list) == 1:
            ele_list[0].click()
    except Exception as e:
        print('user处理Discliaimer失败',e)
        screen_shot_func(driver, 'user处理Discliaimer失败')
        raise Exception
    else:
        print('user处理Discliaimer成功')

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
    count = driver_support.find_elements_by_xpath(accept_disclaimer)
    if len(count) == 1:
        driver_support.find_element_by_xpath(accept_disclaimer).click()
    time.sleep(8)
    count_support = driver_support.find_elements_by_xpath(end_call_before_connecting)
    driver_master.implicitly_wait(int(8))
    count_master_1 = driver_master.find_elements_by_xpath(anwser_call_button)
    count_master_2 = driver_master.find_elements_by_xpath(external_join_call_anwser_button)
    driver_master.implicitly_wait(int(15))
    print('如果下面assert断言出现AssertionError了，则表示电话不应该打通的却打通了，或者电话应该打通却没有打通')
    try:
        assert len(count_support) == int(flag)
        assert len(count_master_1) == int(flag) or len(count_master_2) == int(flag)
    except AssertionError:
        print('Assert断言失败')
        screen_shot_func(driver_support,'辅助browser断言失败')
        screen_shot_func(driver_master, 'browser断言失败')
        raise AssertionError
    if int(flag) == 1:
        try:
            driver_support.find_element_by_xpath(end_call_before_connecting).click()
        except Exception as e:
            print('取消call失败',e)
            screen_shot_func(driver_support, '辅助browser取消call失败')
            screen_shot_func(driver_master, 'browser取消call失败')
            raise Exception
        else:
            print('取消call成功')

def make_call_to_onCall(driver1,driver2,on_call_group_name = 'on-call group 1',accept='accept'):
    """
    # 给on-call group 进行call
    :param driver1:
    :param driver2:
    :param on_call_group_name: 需要与之进行call的on-call-group的name
    :param accept: 是否接受Call；默认accept接受;no_accept为不接受;no_care为不管这个
    :return:
    """
    try:
        element = driver1.find_element_by_id(search_input)
        element.clear()
        time.sleep(1)
        element.click()
        element.send_keys(on_call_group_name)
        time.sleep(5)
        public_check_element(driver1, click_call_button, '首行数据还未展示')
    except Exception as e:
        print('点击call失败', e)
        screen_shot_func(driver1, '点击call失败')
        raise Exception
    else:
        print('点击call成功')
    time.sleep(3)
    try:
        count = driver1.find_elements_by_xpath(end_call_before_connecting)
        assert  len(count) == 1
    except AssertionError as e:
        print('发起call失败',e)
        screen_shot_func(driver1, '发起call失败')
        raise Exception
    else:
        print('发起call成功')
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

def rec_is_on_or_off(driver,witch_status = 'on',change_or_not = 'can_not_change'):
    """
    通话过程中REC的状态，是否可切换状态
    :param driver:
    :param witch_status:   on or off；默认on为开，off为关，none为不展示REC图标
    :param change_or_not:   can_not_change or can_change；默认can_not_change为不可改变，can_change为可改变
    :return:
    """
    try:
        if change_or_not == 'can_not_change' and witch_status == 'on':
            ele_list = driver.find_elements_by_xpath(recording_settings)
            assert len(ele_list) == 0
            ele_list = driver.find_elements_by_xpath('//div[@class="InCall"]/img[@class="Rec"]')
            assert len(ele_list) == 1
        elif change_or_not == 'can_change' and witch_status == 'on':
            driver.find_element_by_xpath(recording_settings).click()
            time.sleep(2)
            ele_list = driver.find_elements_by_xpath(do_not_record)
            driver.find_element_by_xpath(recording_settings).click()
            time.sleep(2)
            print('再次点击切换按钮')
            assert len(ele_list) == 1
        elif change_or_not == 'can_change' and witch_status == 'off':
            driver.find_element_by_xpath(recording_settings).click()
            time.sleep(2)
            ele_list = driver.find_elements_by_xpath(record_this_session)
            driver.find_element_by_xpath(recording_settings).click()
            time.sleep(2)
            print('再次点击切换按钮')
            assert len(ele_list) == 1
        elif change_or_not == 'can_not_change' and witch_status == 'none':
            ele_list = driver.find_elements_by_xpath(recording_settings)
            assert len(ele_list) == 0
            ele_list = driver.find_elements_by_xpath('//div[@class="InCall"]/img[@class="Rec"]')
            assert len(ele_list) == 0
    except AssertionError:
        screen_shot_func(driver, '实际REC不是预期状态')
        raise AssertionError
    except Exception as e:
        print('切换REC状态失败', e)
        screen_shot_func(driver, '切换REC状态失败')
        raise Exception

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
    try:
        if witch_mode == "Document":
            driver.find_element_by_xpath(video_on_button).click()
            driver.find_element_by_xpath('//div[@class="submenu-content"]//span[text()="Document"]/..').click()
            driver.find_element_by_xpath('//input[@name="upload-file"]').send_keys(get_picture_path('test_citron.pdf'))
            ele_list = driver.find_elements_by_xpath('//div[@class="DocToolBar show"]/button[text()="Share"]')
            assert len(ele_list) == 1
            driver.find_element_by_xpath("//div[@class='InCall']//*[@*='#pdf_on']").click()
            driver.find_element_by_xpath(return_vidoe_on).click()
        elif witch_mode == "Photo":
            driver.find_element_by_xpath(video_on_button).click()
            driver.find_element_by_xpath('//div[@class="submenu-content"]//span[text()="Photo"]/..').click()
            driver.find_element_by_xpath('//input[@name="upload-file"]').send_keys(get_picture_path())
            ele_list = driver.find_elements_by_xpath('//div[text()="Now Entering Photo Mode"]')
            assert len(ele_list) == 1
            driver.find_element_by_xpath("//div[@class='InCall']//*[@*='#ghop_on']/../..").click()
            driver.find_element_by_xpath(return_vidoe_on).click()
        elif witch_mode == "Swap Camera":
            driver.find_element_by_xpath(video_on_button).click()
            driver.find_element_by_xpath('//div[@class="submenu-content"]//span[text()="Swap Camera"]/..').click()
            screen_shot_func(driver, 'MAC电脑上查看下点击Swap_Camera后页面状态')
        elif witch_mode == "Freeze":
            driver.find_element_by_xpath(video_on_button).click()
            driver.find_element_by_xpath('//div[@class="submenu-content"]//span[text()="Freeze"]/..').click()
            screen_shot_func(driver, 'MAC电脑上查看下点击Freeze后页面状态')
    except AssertionError:
        screen_shot_func(driver, '切换FGD模式失败')
        raise AssertionError
    except Exception as e:
        print('切换FGD模式失败',e)
        screen_shot_func(driver,'切换FGD模式失败')
        raise Exception

def record_or_do_not_record(if_record,who_do_it,*args):
    """
    开启/关闭record
    :param if_record: Record this session  OR  Do not record
    :param who_do_it: 操作人的username
    :param args: driver的传参列表
    :return:
    """
    try:
        args[0].find_element_by_xpath(recording_settings).click()
        time.sleep(2)
        print('点了切换按钮')
        if if_record == 'record':
            args[0].find_element_by_xpath(record_this_session).click()
            print('点了打开')
            ele_list = args[0].find_elements_by_xpath(f'//div[@class="message" and contains(.,"{who_do_it} has enabled recording for this call.")]')
            assert len(ele_list) == 1
            for one in args[1:]:
                ele_list = one.find_elements_by_xpath(f'//div[@class="message" and contains(.,"{who_do_it} has enabled recording for this call.")]')
                assert len(ele_list) == 1
        elif if_record == 'do_not_record':
            args[0].find_element_by_xpath(do_not_record).click()
            ele_list = args[0].find_elements_by_xpath(f'//div[@class="message" and contains(.,"{who_do_it} has turned off recording for this call.")]')
            assert len(ele_list) == 1
            for one in args[1:]:
                ele_list = one.find_elements_by_xpath(f'//div[@class="message" and contains(.,"{who_do_it} has turned off recording for this call.")]')
                assert len(ele_list) == 1
    except AssertionError:
        screen_shot_func(args[0],'开启/关闭record的提示信息不正确')
        raise AssertionError
    except Exception as e:
        print('开启or关闭record失败', e)
        screen_shot_func(args[0], '开启or关闭record失败')
        raise Exception


if __name__ == '__main__':
    from else_public_lib import driver_set_up_and_logIn, logout_citron
    # driver1 = driver_set_up_and_logIn('Huiming.shi.helplightning+9988776655@outlook.com','*IK<8ik,8ik,')
    # driver2 = driver_set_up_and_logIn('Huiming.shi.helplightning+99887766551@outlook.com', '*IK<8ik,8ik,')
    # driver3 = driver_set_up_and_logIn('Huiming.shi.helplightning+99887766553@outlook.com', '*IK<8ik,8ik,')
    # driver4 = driver_set_up_and_logIn('Huiming.shi.helplightning+for_oncall@outlook.com', '*IK<8ik,8ik,')
    # driver5 = driver_set_up_and_logIn('Huiming.shi.helplightning+belong_two_WS@outlook.com', '*IK<8ik,8ik,')
    # driver6 = driver_set_up_and_logIn('Huiming.shi.helplightning+99887766551@outlook.com', '*IK<8ik,8ik,')
    # driver7 = driver_set_up_and_logIn('Huiming.shi.helplightning+99887766553@outlook.com', '*IK<8ik,8ik,')
    # driver8 = driver_set_up_and_logIn('Huiming.shi.helplightning+9988776655@outlook.com', '*IK<8ik,8ik,')
    driver9 = driver_set_up_and_logIn('Huiming.shi.helplightning+EU5@outlook.com', '*IK<8ik,8ik,')
    driver10 = driver_set_up_and_logIn('Huiming.shi.helplightning+EU2@outlook.com', '*IK<8ik,8ik,')
    # driver11 = driver_set_up_and_logIn('Huiming.shi.helplightning+EU3@outlook.com', '*IK<8ik,8ik,')
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