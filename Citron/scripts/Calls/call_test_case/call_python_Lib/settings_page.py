# _*_ coding: utf-8 _*_ #
# @Time     :9/6/2022 2:25 PM
# @Author   :Huiming Shi

from Citron.public_switch.pubLib import *
from Citron.scripts.Calls.call_test_case.call_python_Lib.public_settings_and_variable import debug_tools_close_xpath


def open_debug_tools_in_settings(driver):
    """
    在Settings打开Debug Tools配置
    :param driver:
    :return:
    """
    ele_list = driver.find_elements_by_xpath(debug_tools_close_xpath)
    if len(ele_list) == 1:
        public_check_element(driver, debug_tools_close_xpath, '打开Debug_Tools配置失败')
        time.sleep(1)
    else:
        print('Debug Tools配置已经打开了')