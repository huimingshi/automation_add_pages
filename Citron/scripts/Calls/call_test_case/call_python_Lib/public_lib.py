# _*_ coding: utf-8 _*_ #
# @Time     :10/21/2022 11:15 AM
# @Author   :Huiming Shi
from Citron.public_switch.pubLib import *
from Citron.scripts.Calls.call_test_case.call_python_Lib.public_settings_and_variable import close_tutorial_button

def change_driver_implicit_wait(func):
    """
    短暂性修改隐式等待时间
    :param func:
    :return:
    """
    def inner(*args):
        args[0].implicitly_wait(30)
        func(*args)
        args[0].implicitly_wait(IMPLICIT_WAIT)
    return inner

def close_tutorial_action(driver):
    """
    关闭导航页面
    :param driver:
    :return:
    """
    for i in range(3):
        ele_list = get_xpath_elements(driver, close_tutorial_button)
        if len(ele_list) == 1:
            public_click_element(driver, close_tutorial_button, description='close_tutorial按钮')
            break
        elif i == 2:
            public_assert(driver, len(ele_list), 1, action='关闭导航页面未出现')
        else:
            time.sleep(10)

def if_has_tutorial_then_close(func):
    """
    如果导航页面出现，那就关闭
    :param driver:
    :return:
    """
    def inner(driver):
        func()
        ele_list = get_xpath_elements(driver, close_tutorial_button)
        if len(ele_list) == 1:
            public_click_element(driver, close_tutorial_button, description='close_tutorial按钮')
    return inner

# def if_has_tutorial_then_close(driver):
#     """
#     如果导航页面出现，那就关闭
#     :param driver:
#     :return:
#     """
#     ele_list = get_xpath_elements(driver, close_tutorial_button)
#     if len(ele_list) == 1:
#         public_click_element(driver, close_tutorial_button, description='close_tutorial按钮')