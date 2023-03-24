# _*_ coding: utf-8 _*_ #
# @Time     :9/6/2022 2:35 PM
# @Author   :Huiming Shi
import time

from Citron.public_switch.pubLib import *
from Citron.scripts.Calls.call_test_case.call_python_Lib.about_call import make_sure_enter_call as MSEC
from Citron.scripts.Calls.call_test_case.call_python_Lib.public_settings_and_variable_copy import *


def hang_up_the_phone(driver):
    """
    点击红色的挂断电话按钮
    :param driver:
    :return:
    """
    # public_check_element(driver, end_call_button, '挂断按钮')
    public_click_element(driver, end_call_button, description='挂断按钮')

def circle_check_button_exists(driver,button,description):
    """
    循环检查是否满足挂断电话的条件
    :param driver:
    :param button: End_call_for_all按钮，Leave_call按钮，直接Yes按钮这些按钮对应的xpath
    :param description: End_call_for_all按钮，Leave_call按钮，直接Yes按钮
    :return:
    """
    for i in range(5):
        hang_up_the_phone(driver)  # 点击红色的挂断电话按钮
        ele_list_1 = get_xpath_elements(driver, visibility_finishi_call)
        ele_list = get_xpath_elements(driver, button)
        if len(ele_list_1) == 1 and len(ele_list) == 1:
            for i in range(2):
                hang_up_the_phone(driver)  # 点击红色的挂断电话按钮
                time.sleep(2)
            public_click_element(driver, button, description=description)
            break
        elif i == 4:
            print(f'找不到{description}')
            screen_shot_func(driver, f'找不到{description}')
            raise Exception(f'找不到{description}')
        else:
            time.sleep(5)
            hang_up_the_phone(driver)  # 点击红色的挂断电话按钮
        time.sleep(5)

def end_call_for_all(driver,check_dialog = 'no_check',call_time='0'):
    """
    End Call for All
    :param driver:
    :param check_dialog: 是否检查退出通话时的提示框信息
    :return:
    """
    # 维持通话
    time.sleep(int(call_time))
    # 确保进入通话中
    MSEC(driver)
    # 点击End_Call_for_All
    circle_check_button_exists(driver, end_call_for_all_button, 'End_call_for_all按钮')
    if check_dialog != "no_check":
        get_xpath_element(driver,'//div[text()="Are you sure you want to end this call for all participants?"]',description="end_call_for_all时应该有提示信息")
    # 点击yes
    public_click_element(driver, ECFA_YES_button, 'end_call_for_all时找不到Yes按钮')

def leave_call(driver,call_time='0'):
    """
    # Leave call
    :param driver:
    :param call_time:通话持续时间
    :return:
    """
    # 维持通话
    time.sleep(int(call_time))
    # 确保进入通话中
    MSEC(driver)
    # User Leave call
    circle_check_button_exists(driver, leave_call_button, 'Leave_call按钮')

def exit_call(driver,call_time='0'):
    """
    # 结束call
    :param driver:
    :return:
    """
    # 维持通话
    time.sleep(int(call_time))
    # 确保进入通话中
    MSEC(driver)
    # User exit call
    circle_check_button_exists(driver, exit_call_yes, 'Yes按钮')
    time.sleep(2)

def end_call_for_all_in_participants(driver):
    """
    在Participants页面End Call for All
    :param driver:
    :return:
    """
    # 确保进入通话中
    MSEC(driver)
    # 在Participants页面点击End_Call_for_All
    public_click_element(driver,PPECFA_button,description="PPECFA_button按钮")
    # Confirmation dialog: “Are you sure you want to end this call for all participants?” OK/Cancel
    ele_list = get_xpath_elements(driver,'//div[text()="Are you sure you want to end this call for all participants?"]')
    public_assert(driver,len(ele_list),1,action="有提示信息")
    ele_list = get_xpath_elements(driver,'//button[@variant="primary" and contains(.,"No")]')
    public_assert(driver, len(ele_list), 1, action="有No按钮")
    # 点击Yes按钮
    public_click_element(driver, ECFA_YES_button, 'end_call_for_all时找不到Yes按钮')