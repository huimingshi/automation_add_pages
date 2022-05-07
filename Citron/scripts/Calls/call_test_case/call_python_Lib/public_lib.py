# _*_ coding: utf-8 _*_ #
# @Time     :4/6/2022 10:23 AM
# @Author   :Huiming Shi

import time
from Citron.public_switch.pubLib import get_system_type, get_xpath_elements, get_xpath_element

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
                    get_xpath_element(driver,xpath).click()
                    # ele_list[0].click()
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

if __name__ == '__main__':
    kill_all_browser()