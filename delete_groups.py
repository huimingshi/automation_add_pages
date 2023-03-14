# _*_ coding: utf-8 _*_ #
# @Time     :3/14/2023 5:19 PM
# @Author   :Huiming Shi

import time
from selenium.webdriver.common.by import By
from Citron.scripts.Calls.call_test_case.call_python_Lib import public_settings_and_variable_copy
from Citron.scripts.Calls.call_test_case.call_python_Lib.else_public_lib import switch_to_diffrent_page, \
    scroll_into_view
from Citron.scripts.Calls.call_test_case.call_python_Lib.login_lib import driver_set_up_and_logIn
site_admin = 'huiming.shi@helplightning.com'


# 先搜索on_call_group1
def search_by_group(group_name):
    # 根据group_name来搜索
    search_ele = driver.find_element(By.ID,"filter-text-box")
    search_ele.clear()
    search_ele.click()
    search_ele.send_keys(group_name)
    # 点击Details按钮
    while True:
        ele_list = driver.find_elements(By.XPATH,f'//div[contains(.,"{group_name}")]/../../../..//button[@class="k-button detailsButton" and text()="Details"]')
        if len(ele_list):
            details_ele = driver.find_element(By.XPATH,f'//div[contains(.,"{group_name}")]/../../../..//button[@class="k-button detailsButton" and text()="Details"]')
            details_ele.click()
            time.sleep(2)
            # 点击DELETE GROUP按钮
            scroll_into_view(driver, '//button[text()="Delete Group"]')
            driver.find_element(By.XPATH,'//button[text()="Delete Group"]').click()
            driver.find_element(By.XPATH,'//button[text()="Ok"]').click()
            time.sleep(4)
        else:
            break

if __name__ == '__main__':
    # site Admin登录
    driver = driver_set_up_and_logIn(site_admin)
    driver.implicitly_wait(5)
    # 进入到ADMINISTRATION
    switch_to_diffrent_page(driver, 'Groups', '//h1[text()="Groups"]', '//div[@class="ag-center-cols-container"]/div',switch_tree='switch_tree', which_tree='2')
    # 先搜索on_call_group1来删除
    search_by_group('on_call_group1')
    # 再搜索standard_group1来删除
    search_by_group('standard_group1')
    # 关闭浏览器
    driver.close()