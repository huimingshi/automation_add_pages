# _*_ coding: utf-8 _*_ #
# @Time     :4/6/2022 10:23 AM
# @Author   :Huiming Shi

import time
import os

def public_check_element(driver,xpath,description,if_click = 1,if_show = 1):
    """
    :param driver:
    :param xpath:   元素的xpath
    :param if_show:   是否需要出现该元素
    :param if_click:    是否需要点击
    :param description:    元素未出现的描述信息
    :return:
    """
    for i in range(5):
        ele_list = driver.find_elements_by_xpath(xpath)
        if if_show and if_click:
            if len(ele_list) >= 1:
                ele_list[0].click()
                break
        elif if_show and not if_click:
            if len(ele_list) >= 1:
                break
        elif not if_show:
            if len(ele_list) == 0:
                break
        elif i == 4:
            print(description)
            raise Exception(description)
        else:
            time.sleep(1)

def kill_all_browser():
    # kill所有的chromedriver进程
    os.system('taskkill /F /im chromedriver.exe')
    # 退出所有的浏览器
    os.system('taskkill /f /t /im chrome.exe')