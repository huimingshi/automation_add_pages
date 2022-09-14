# _*_ coding: utf-8 _*_ #
# @Time     :9/6/2022 2:29 PM
# @Author   :Huiming Shi


from Citron.public_switch.pubLib import *


def expand_which_setting(driver,which_setting):
    """
    EXPAND某个setting配置项
    :param driver:
    :param which_setting: 具体的某个配置项的全称
    :return:
    """
    public_check_element(driver, f'//h1[contains(.,"{which_setting}")]/../..//button[contains(.,"Expand")]', 'EXPAND某个setting失败')