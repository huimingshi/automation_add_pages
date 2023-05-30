# _*_ coding: utf-8 _*_ #
# @Time     :10/21/2022 11:15 AM
# @Author   :Huiming Shi
from Citron.public_switch.pubLib import *
from Citron.scripts.Calls.call_test_case.call_python_Lib.public_settings_and_variable_copy import *

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

def modify_implicit_wait(implicit_wait_time):
    """
    短暂性修改隐式等待时间
    :param func:
    :return:
    """
    def outer(func):
        def inner(*args):
            args[0].implicitly_wait(int(implicit_wait_time))
            res = func(*args)
            args[0].implicitly_wait(IMPLICIT_WAIT)
            return res
        return inner
    return outer

def close_tutorial_action(driver):
    """
    关闭导航页面
    :param driver:
    :return:
    """
    ele_list = get_xpath_elements(driver, close_tutorial_button)
    if len(ele_list) == 1:
        public_click_element(driver, close_tutorial_button, description='close_tutorial按钮')

def if_has_tutorial_then_close(func):
    """
    如果导航页面出现，那就关闭
    :param driver:
    :return:
    """
    def inner(driver):
        func()
        close_tutorial_action(driver)
        # ele_list = get_xpath_elements(driver, close_tutorial_button)
        # if len(ele_list) == 1:
        #     public_click_element(driver, close_tutorial_button, description='close_tutorial按钮')
    return inner

def cancel_workbox_details(func):
    """
    通话结束页面弹出的WorkBox Details对话框，莫名其妙
    :param driver:
    :return:
    """
    def inner(*args,**kwargs):
        args[0].implicitly_wait(3)
        ele_list = get_xpath_elements(args[0],'//span[text()="Cancel"]')
        if len(ele_list) != 0:
            public_click_element(args[0],'//span[text()="Cancel"]',description="CANCEL按钮")
        args[0].implicitly_wait(int(IMPLICIT_WAIT))
        return func(*args,**kwargs)
    return inner

def py_get_random():
    """
    得到随机数
    :return:
    """
    return int(time.time() * 1000000)

def switch_to_default_content(driver):
    """
    从iframe中再次切换到主html文档中
    :param driver:
    :return:
    """
    # 切回主html文档
    driver.switch_to.default_content()