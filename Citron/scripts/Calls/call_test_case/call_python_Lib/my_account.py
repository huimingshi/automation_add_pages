# _*_ coding: utf-8 _*_ #
# @Time     :9/6/2022 2:54 PM
# @Author   :Huiming Shi

from Citron.public_switch.pubLib import *
from Citron.scripts.Calls.call_test_case.call_python_Lib.public_settings_and_variable_copy import current_account, \
    my_account_name, input_type_file, updated_settings_successfully

def click_my_account(driver):
    """
    点击我的账号
    :param driver:
    :return:
    """
    public_click_element(driver, current_account, '点击我的账号失败')
    public_check_element(driver, '//div[@class="dropdown open btn-group btn-group-lg btn-group-link"]', '展开我的账号失败',if_click=None, if_show=1)

def enter_my_account_settings_page(driver):
    """
    进入My Account的Settings页面
    :param driver:
    :return:
    """
    click_my_account(driver)
    public_click_element(driver, '//li[@role="presentation"]//span[contains(.,"Settings")]', '进入My_Account_Settings页面失败')

def enter_my_account_subpage(driver):
    """
    进入My Account页面
    :param driver:
    :return:
    """
    click_my_account(driver)
    public_click_element(driver, '//span[text()="My Account"]', '进入My_Account页面失败')

def my_account_change_name_and_avator(driver,change_name,change_avator,picture_path,back_to_contact = 'no_back_to_contact'):
    """
    在My Account页面更改name和avator
    :param driver:
    :param change_name: 需要更改成为的name
    :param change_avator: 判断是否需要更改avator，如果需要--就是'change'，不需要--就是'delete'
    :param picture_path: 修改图片的绝对路径
    :return:
    """
    time.sleep(5)
    click_my_account(driver)
    public_check_element(driver, '//span[contains(.,"My Account")]','进入My_Account_Settings页面失败')
    # 判断是否需要更改name
    name_attribute = get_xpath_element(driver,my_account_name,description = '我的账号').get_attribute('value')
    if name_attribute != change_name:
        get_xpath_element(driver,my_account_name,description = '我的账号').clear()
        time.sleep(2)
        get_xpath_element(driver,my_account_name,description = '我的账号').send_keys(change_name)
    # 判断是否需要更改avator
    if change_avator == 'change':
        get_xpath_element(driver,input_type_file,ec='ec').send_keys(picture_path)
    elif change_avator == 'delete':
        # 获取alert对话框的按钮，点击按钮，弹出alert对话框
        public_click_element(driver,'//button[contains(.,"Remove avatar")]',description = 'Remove_avatar按钮')
        time.sleep(1)
        public_click_element(driver,'//button[@class="k-button k-primary ml-4" and text()="Ok"]',description = 'OK按钮')
        time.sleep(1)
    public_check_element(driver, '//button[@type="submit" and contains(.,"Update")]', '点击Update失败')
    for i in range(10):
        element_list = get_xpath_elements(driver,updated_settings_successfully)
        if len(element_list) == 1:
            break
        elif i == 9:
            screen_shot_func(driver, '没有出现绿色的提示信息')
            raise Exception
        else:
            time.sleep(1)
    if back_to_contact == 'back_to_contact':
        public_check_element(driver, '//span[contains(.,"Contacts")]', '返回Contacts页面失败')