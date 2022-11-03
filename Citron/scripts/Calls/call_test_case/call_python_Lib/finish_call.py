# _*_ coding: utf-8 _*_ #
# @Time     :9/6/2022 2:35 PM
# @Author   :Huiming Shi

from Citron.public_switch.pubLib import *
from Citron.scripts.Calls.call_test_case.call_python_Lib.about_call import make_sure_enter_call as MSEC
from Citron.scripts.Calls.call_test_case.call_python_Lib.public_settings_and_variable import count_of_call_user, \
    end_call_button, visibility_finishi_call, end_call_for_all_button, leave_call_button, exit_call_yes


def hang_up_the_phone(driver):
    """
    点击红色的挂断电话按钮
    :param driver:
    :return:
    """
    # public_check_element(driver, end_call_button, '挂断按钮')
    public_click_element(driver, end_call_button, description='挂断按钮')

def end_call_for_all(driver,call_time='0'):
    """
    End Call for All
    :param driver:
    :return:
    """
    # 维持通话
    time.sleep(int(call_time))
    # 确保进入通话中
    MSEC(driver)
    for i in range(10):
        ele_list = get_xpath_elements(driver,count_of_call_user)
        if len(ele_list) > 2:
            break
        elif i == 9:
            screen_shot_func(driver, '当前参与通话的人数不到3人')
            raise Exception
        else:
            time.sleep(10)
    # 点击End_Call_for_All
    for i in range(5):
        hang_up_the_phone(driver)     # 点击红色的挂断电话按钮
        ele_list = get_xpath_elements(driver,visibility_finishi_call)
        ele_list_end_call = get_xpath_elements(driver,end_call_for_all_button)
        if len(ele_list) == 1 and len(ele_list_end_call) == 1:
            for i in range(2):
                hang_up_the_phone(driver)  # 点击红色的挂断电话按钮
                time.sleep(2)
            public_click_element(driver,end_call_for_all_button,description='End_call_for_all按钮')
            break
        elif i == 4:
            print('找不到End_Call_for_All按钮')
            screen_shot_func(driver, '找不到End_Call_for_All按钮')
            raise Exception('找不到End_Call_for_All按钮')
        else:
            time.sleep(5)
            hang_up_the_phone(driver)  # 点击红色的挂断电话按钮
            time.sleep(5)
    public_check_element(driver, '//button[@variant="secondary" and contains(.,"Yes")]', 'end_call_for_all时找不到Yes按钮')

def leave_call(driver,select_co_host = 'no_need_select',username = 'Huiming.shi.helplightning+EU2',call_time='0',check_user_count='check'):
    """
    # Leave call
    :param driver:
    :param call_time:通话持续时间
    :param select_co_host:是否需要选择另一个共同主持；默认no_need_select不需要；need_select为需要
    :param username:需要设置为另一个共同主持的user name
    :return:
    """
    # 维持通话
    time.sleep(int(call_time))
    # 确保进入通话中
    MSEC(driver)
    if check_user_count == 'check':
        for i in range(5):
            ele_list = get_xpath_elements(driver,count_of_call_user)
            if len(ele_list) > 2:
                break
            elif i == 4:
                screen_shot_func(driver, '当前参与通话的人数不到3人')
                raise Exception
            else:
                time.sleep(int(IMPLICIT_WAIT))
    # User Leave call
    for i in range(5):
        hang_up_the_phone(driver)     # 点击红色的挂断电话按钮
        ele_list = get_xpath_elements(driver,visibility_finishi_call)
        ele_list_leave_call = get_xpath_elements(driver,leave_call_button)
        if len(ele_list) == 1 and len(ele_list_leave_call) == 1:
            for i in range(2):
                hang_up_the_phone(driver)  # 点击红色的挂断电话按钮
                time.sleep(2)
            public_click_element(driver,leave_call_button,description='leave_call_button')
            break
        elif i == 4:
            print('找不到Leave_call按钮')
            screen_shot_func(driver,'找不到Leave_call按钮')
            raise Exception('找不到Leave_call按钮')
        else:
            hang_up_the_phone(driver)     # 点击红色的挂断电话按钮
            time.sleep(5)
    if select_co_host == 'need_select':
        public_click_element(driver,f'//strong[text()="{username}"]/../../../../..//div[@class="react-toggle-track"]',description = '选择host')
        time.sleep(2)
        public_click_element(driver,leave_call_button,description = 'leave_call按钮')
        time.sleep(1)
        ele_list = get_xpath_elements(driver,leave_call_button)
        public_assert(driver,len(ele_list),0,action='未选择另一个共同主持')

def exit_call(driver,check_user_count='check',call_time='0'):
    """
    # 结束call
    :param driver:
    :param check_user_count:是否检查参会人数，默认检查，但有时候会议界面不展示参会人数
    :return:
    """
    # 维持通话
    time.sleep(int(call_time))
    # 确保进入通话中
    MSEC(driver)
    if check_user_count == 'check':
        for i in range(5):
            ele_list = get_xpath_elements(driver,count_of_call_user)
            if len(ele_list) >= 2:
                break
            elif i == 4:
                screen_shot_func(driver, '当前参与通话的人数不到2人')
                raise Exception('当前参与通话的人数不到2人')
            else:
                time.sleep(int(IMPLICIT_WAIT))
    # User exit call
    for i in range(5):
        hang_up_the_phone(driver)    # 点击红色的挂断电话按钮
        ele_list = get_xpath_elements(driver,visibility_finishi_call)
        ele_list_yes = get_xpath_elements(driver,exit_call_yes)
        if len(ele_list_yes) == 1 and len(ele_list) == 1:
            for i in range(2):
                hang_up_the_phone(driver)  # 点击红色的挂断电话按钮
                time.sleep(2)
            public_click_element(driver,exit_call_yes,description='Yes按钮')
            break
        elif i == 4:
            print('找不到Yes按钮')
            screen_shot_func(driver,'找不到Yes按钮')
            raise Exception('找不到Yes按钮')
        else:
            time.sleep(5)
            hang_up_the_phone(driver)  # 点击红色的挂断电话按钮
            time.sleep(5)