# _*_ coding: utf-8 _*_ #
# @Time     :3/14/2023 5:19 PM
# @Author   :Huiming Shi

import time
from selenium.webdriver.common.by import By
from Citron.scripts.Calls.call_test_case.call_python_Lib.else_public_lib import switch_to_diffrent_page, scroll_into_view
from Citron.scripts.Calls.call_test_case.call_python_Lib.login_lib import driver_set_up_and_logIn
site_admin = 'Huiming.shi.helplightning+8888888888@outlook.com'


# 搜索group
def search_by_group(group_name):
    # 根据group_name来搜索
    search_ele = driver.find_element(By.ID,"filter-text-box")
    search_ele.clear()
    search_ele.click()
    search_ele.send_keys(group_name)
    time.sleep(2)
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

# 搜索WS
def search_by_workspace(workspace_name="workspace_name"):
    # 根据group_name来搜索
    search_ele = driver.find_element(By.ID,"filter-text-box")
    search_ele.clear()
    search_ele.click()
    search_ele.send_keys(workspace_name)
    # 点击Details按钮
    while True:
        ele_list = driver.find_elements(By.XPATH,f'//div[contains(.,"{workspace_name}")]/../../../..//button[@class="k-button detailsButton" and text()="Details"]')
        if len(ele_list):
            driver.find_element(By.XPATH,f'//div[contains(.,"{workspace_name}")]/../../../..//button[@class="k-button detailsButton" and text()="Details"]').click()
            time.sleep(2)
            # 如果是Active状态，就改为Inactive
            status_ele_list = driver.find_elements(By.XPATH,'//button[text()="Activate Workspace"]')
            if status_ele_list:
                driver.find_element(By.XPATH, '//div[@class="WorkspaceEdit"]//button[text()="Cancel"]').click()
            else:
                driver.find_element(By.XPATH, '//button[text()="Deactivate Workspace"]').click()
                driver.find_element(By.XPATH, '//button[text()="Ok"]').click()
            time.sleep(4)
        else:
            break

if __name__ == '__main__':
    # site Admin登录
    driver = driver_set_up_and_logIn(site_admin)
    # 切换到WS
    # user_switch_to_second_workspace(driver,"auto_default_workspace")
    driver.implicitly_wait(5)
    # 进入到ADMINISTRATION的Groups页面
    switch_to_diffrent_page(driver, 'Groups', '//h1[text()="Groups"]', '//div[@class="ag-center-cols-container"]/div',switch_tree='switch_tree', which_tree='2')
    # 先搜索on_call_group1来删除
    search_by_group('on_call_group1')
    # 再搜索standard_group1来删除
    search_by_group('standard_group1')
    # # 进入到SITE的Workspaces页面
    # switch_to_diffrent_page(driver, 'Workspaces', '//h1[text()="Workspaces"]', '//div[@class="ag-center-cols-container"]/div',switch_tree='switch_tree', which_tree='3')
    # # 搜索WS
    # search_by_workspace()
    # 关闭浏览器
    driver.close()