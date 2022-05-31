# _*_ coding: utf-8 _*_ #
# @Time     :5/7/2022 1:43 PM
# @Author   :Huiming Shi
import os
import platform
import time
import traceback
from selenium.common.exceptions import WebDriverException
from selenium.webdriver.support import expected_conditions as EC
from selenium.webdriver.support.wait import WebDriverWait
from Citron.public_switch.public_switch_py import *


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
        if SMALL_RANGE_BROWSER_TYPE == 'Chrome':
            # kill所有的chromedriver进程
            os.system('taskkill /F /im chromedriver.exe')
            # 退出所有的浏览器，也会kill所有的chromedriver进程
            os.system('taskkill /f /t /im chrome.exe')
        if CITRON_BROWSER_TYPE == 'Chrome':
            # kill所有的chromedriver进程
            os.system('taskkill /F /im chromedriver.exe')
            # 退出所有的浏览器，也会kill所有的chromedriver进程
            os.system('taskkill /f /t /im chrome.exe')
        if SMALL_RANGE_BROWSER_TYPE == 'Firefox':
            # kill所有的firefoxdriver进程
            os.system("taskkill /im geckodriver.exe /f")
            # 退出所有的浏览器，也会kill所有的firefoxdriver进程
            os.system('taskkill /f /t /im firefox.exe')
        if CITRON_BROWSER_TYPE == 'Firefox':
            # kill所有的firefoxdriver进程
            os.system("taskkill /im geckodriver.exe /f")
            # 退出所有的浏览器，也会kill所有的firefoxdriver进程
            os.system('taskkill /f /t /im firefox.exe')
    else:
        if SMALL_RANGE_BROWSER_TYPE == 'Chrome':
            # kill所有的chromedriver进程
            os.system("kill -9 `ps -ef | grep chromedriver  | awk '{print $2}'`")
            # 退出所有的浏览器，也会kill所有的chromedriver进程
            os.system("kill -9 `ps -ef | grep hrome  | awk '{print $2}'`")
        if CITRON_BROWSER_TYPE == 'Chrome':
            # kill所有的chromedriver进程
            os.system("kill -9 `ps -ef | grep chromedriver  | awk '{print $2}'`")
            # 退出所有的浏览器，也会kill所有的chromedriver进程
            os.system("kill -9 `ps -ef | grep hrome  | awk '{print $2}'`")
        if SMALL_RANGE_BROWSER_TYPE == 'Firefox':
            # kill所有的firefoxdriver进程
            os.system("kill -9 `ps -ef | grep geckodriver  | awk '{print $2}'`")
            # 退出所有的浏览器，也会kill所有的firefoxdriver进程
            os.system("kill -9 `ps -ef | grep irefox  | awk '{print $2}'`")
        if CITRON_BROWSER_TYPE == 'Firefox':
            # kill所有的firefoxdriver进程
            os.system("kill -9 `ps -ef | grep geckodriver  | awk '{print $2}'`")
            # 退出所有的浏览器，也会kill所有的firefoxdriver进程
            os.system("kill -9 `ps -ef | grep irefox  | awk '{print $2}'`")

def screen_shot_func(driver,screen_name):
    current_time = time.strftime("%Y-%m-%d-%H-%M-%S", time.localtime(time.time()))
    sys_type = get_system_type()
    if sys_type == 'Windows':
        driver.save_screenshot('.\\' + current_time + screen_name + 'screenshot.png')
    else:
        driver.save_screenshot('./' + current_time + screen_name + 'screenshot.png')

def get_xpath_element(driver,locator,ec = None,select='xpath',description = '元素',timeout = WEBDRIVERWAIT_TIMEOUT):
    """
    通过xpath寻找元素，driver.find_element_by_xpath(xpath)
    :param driver: 浏览器驱动
    :param locator: 元素的locator
    :param ec: 是否需要使用EC来进行显示等待，默认需要
    :param select: 默认是xpath寻找，也可以进行切换成id
    :param description: 描述信息
    :return:
    """
    if not ec:
        try:
            return WebDriverWait(driver, timeout, POLL_FREQUENCY).until(EC.visibility_of_element_located((select,locator)))
        except Exception as e:
            print('元素未找到',e)
            msg = traceback.format_exc()
            print(msg)
            screen_shot_func(driver,f'{description}未找到')
            raise Exception
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

def public_click_element(driver,locator,ec = None,select='xpath',description = '元素'):
    """
        通过xpath点击元素
        :param driver: 浏览器驱动
        :param locator: 元素的locator
        :param ec: 是否需要使用EC来进行显示等待，默认需要
        :param select: 默认是xpath寻找，也可以进行切换成id
        :return:
        """
    try:
        get_xpath_element(driver, locator, ec, select, description).click()
    except Exception as e:
        print('元素不可点击', e)
        msg = traceback.format_exc()
        print(msg)
        screen_shot_func(driver, f'{description}不可点击')
        raise Exception

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
        time.sleep(2)
        ele_list = get_xpath_elements(driver, xpath)
        if if_show and if_click:
            if len(ele_list) >= 1:
                public_click_element(driver,xpath,description=description)
                break
        elif if_show and not if_click:
            if len(ele_list) >= 1:
                break
        elif not if_show:
            if len(ele_list) == 0:
                break
        elif i == 4:
            print(description)
            screen_shot_func(driver, description)
            raise Exception

def get_picture_path(picture_name = 'avatar1.jpg'):
    """
    # 获取avatar1.jpg绝对路径
    :return: avatar1.jpg绝对路径
    """
    dir_path = os.path.dirname(os.path.abspath(__file__))
    print('当前目录绝对路径:',dir_path)
    system_type = get_system_type()
    if system_type == 'Windows':
        dir_list = dir_path.split('\\')
        print(dir_list)
        dir_list[-1] = 'publicData'
        join_str = '\\\\'
        final_path = join_str.join(dir_list)
        modify_picture_path = final_path + f'\\\\{picture_name}'
        return  modify_picture_path
    else:
        dir_list = dir_path.split('/')
        print(dir_list)
        dir_list[-1] = 'publicData'
        join_str = '//'
        final_path = join_str.join(dir_list)
        print(final_path)
        modify_picture_path = final_path + f'//{picture_name}'
        print(modify_picture_path)
        return modify_picture_path

def public_assert(driver,string1,string2,condition = '=',action=None):
    """
    公共的断言方法
    :param driver:
    :param string1:
    :param string2:
    :param condition:
    :param action:
    :return:
    """
    try:
        if condition == '=':
            assert string1 == string2
        elif condition == 'in':
            assert string1 in string2
        elif condition == 'not in':
            assert string1 not in string2
        elif condition == '!=':
            assert string1 != string2
        elif condition == '>=':
            assert string1 >= string2
        elif condition == 'startswith':
            assert string1.startswith(string2)
    except AssertionError:
        screen_shot_func(driver,action)
        raise AssertionError

# 定义一个装饰器，当打开citron时出现WebDriverException：ERR_NAME_NOT_RESOLVED时进行截图
def ERR_NAME_NOT_RESOLVED(func):
    def inner(driver,*args,**kwargs):
        try:
            func(driver,*args,**kwargs)
        except WebDriverException:
            print('网页打开报错')
            screen_shot_func(driver,'网页打开报错')
            raise WebDriverException('网页打开报错')
    return inner

if __name__ == '__main__':
    print(get_picture_path())