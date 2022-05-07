# _*_ coding: utf-8 _*_ #
# @Time     :5/7/2022 1:43 PM
# @Author   :Huiming Shi
import os
import platform
from selenium.webdriver.support import expected_conditions as EC
from selenium.webdriver.support.wait import WebDriverWait
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

def kill_all_browser():
    system_type = get_system_type()
    if system_type == 'Windows':
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
    else:
        if BROWSER_TYPE == 'Chrome':
            # kill所有的chromedriver进程
            os.system('''ps -ef | grep chromedriver | grep -v grep | awk '{print "kill -9" $2}'| sh''')
            # 退出所有的浏览器
            os.system("ps -ef | grep 'Google Chrome Helper' | awk '{print $2}' | xargs kill -9")
        elif BROWSER_TYPE == 'Firefox':
            # kill所有的firefoxdriver进程
            os.system('''ps -ef | grep geckodriver | grep -v grep | awk '{print "kill -9" $2}'| sh''')
            # 退出所有的浏览器
            os.system("kill -9 $(ps -x | grep 'firefox' | awk '{print $1}')")

def get_xpath_element(driver,locator,ec = None,select='xpath'):
    """
    通过xpath寻找元素，driver.find_element_by_xpath(xpath)
    :param driver: 浏览器驱动
    :param locator: 元素的locator
    :param ec: 是否需要使用EC来进行显示等待，默认需要
    :param select: 默认是xpath寻找，也可以进行切换成id
    :return:
    """
    if not ec:
        return WebDriverWait(driver, 20, 0.5).until(EC.visibility_of_element_located((select,locator)))
    else:
        return driver.find_element(select, locator)

def get_xpath_elements(driver,xpath):
    """
    通过xpath寻找元素，driver.find_element_by_xpath(xpath)
    :param driver: 浏览器驱动
    :param xpath: 元素的xpath
    :return:
    """
    elements_list = driver.find_elements('xpath', xpath)
    return elements_list