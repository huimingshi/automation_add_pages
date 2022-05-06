# _*_ coding: utf-8 _*_ #
# @Time     :4/6/2022 10:23 AM
# @Author   :Huiming Shi

import os
import time
import platform
from selenium.webdriver.common.by import By
from selenium.webdriver.support.wait import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC

from Citron.public_switch.public_switch_py import BROWSER_TYPE


def get_system_type():
    """
    # get current system type
    # Windows or Mac
    :return: system type
    """
    system_type = platform.system()
    print(system_type)
    return system_type

def screen_shot_func(driver,screen_name):
    current_time = time.strftime("%Y-%m-%d-%H-%M-%S", time.localtime(time.time()))
    sys_type = get_system_type()
    if sys_type == 'Windows':
        driver.save_screenshot('.\\' + current_time + screen_name + 'screenshot.png')
    else:
        driver.save_screenshot('./' + current_time + screen_name + 'screenshot.png')

def public_check_element(driver,xpath,description,if_click = 1,if_show = 1):
    """
    :param driver:
    :param xpath:   元素的xpath
    :param if_show:   是否需要出现该元素
    :param if_click:    是否需要点击
    :param description:    元素未出现的描述信息
    :return:
    """
    try:
        for i in range(5):
            time.sleep(2)
            ele_list = get_xpath_elements(driver, xpath)
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
                raise Exception
    except Exception:
        screen_shot_func(driver, description)
        raise Exception

def kill_all_browser():
    if BROWSER_TYPE == 'Chrome':
        # kill所有的chromedriver进程
        os.system('taskkill /F /im chromedriver.exe')
        # 退出所有的浏览器
        os.system('taskkill /f /t /im chrome.exe')
    elif BROWSER_TYPE == 'Firefox':
        # kill所有的firefoxdriver进程
        os.system("taskkill /im geckodriver.exe /f")
        # 退出所有的浏览器
        os.system('taskkill /f /t /im firefox.exe')

def get_xpath_element(driver,xpath,ec = None):
    """
    通过xpath寻找元素，driver.find_element_by_xpath(xpath)
    :param driver: 浏览器驱动
    :param xpath: 元素的xpath
    :return:
    """
    if not ec:
        return WebDriverWait(driver, 20, 0.5).until(EC.visibility_of_element_located(('xpath',xpath)))
    else:
        return driver.find_element('xpath', xpath)

def get_xpath_elements(driver,xpath):
    """
    通过xpath寻找元素，driver.find_element_by_xpath(xpath)
    :param driver: 浏览器驱动
    :param xpath: 元素的xpath
    :return:
    """
    elements_list = driver.find_elements('xpath', xpath)
    return elements_list




if __name__ == '__main__':
    kill_all_browser()