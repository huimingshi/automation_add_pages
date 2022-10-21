# _*_ coding: utf-8 _*_ #
# @Time     :10/21/2022 11:15 AM
# @Author   :Huiming Shi
from Citron.public_switch.pubLib import *
from Citron.scripts.Deletion_of_a_Recordings_and_Screen_Captures.make_a_call_lib import *


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