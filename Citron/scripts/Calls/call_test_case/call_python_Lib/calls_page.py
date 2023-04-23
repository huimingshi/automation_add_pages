# _*_ coding: utf-8 _*_ #
# @Time     :4/23/2023 11:12 AM
# @Author   :Huiming Shi
import time

from selenium.webdriver import ActionChains
from Citron.public_switch.pubLib import get_xpath_element, get_xpath_elements, public_assert, public_click_element
from Citron.scripts.Calls.call_test_case.call_python_Lib.else_public_lib import scroll_into_view as SIV
from Citron.scripts.Calls.call_test_case.call_python_Lib.public_settings_and_variable_copy import attachment_selectable, \
    close_details_xpath
from Citron.scripts.Calls.call_test_case.call_python_Lib.public_lib import modify_implicit_wait


def get_screen_captures_count(driver,count):
    """

    :param driver:
    :param count
    :return:
    """
    ele_list = get_xpath_elements(driver,attachment_selectable)
    public_assert(driver,len(ele_list),int(count),action="预期的截图数正确")

@modify_implicit_wait(5)
def switch_to_WS_calls_page(driver):
    """
    进入到WS下的Calls页面
    :param driver:
    :return:
    """
    ele_list = get_xpath_elements(driver,'//div[@id="k-panelbar-item-default-.1" and @aria-hidden="false"]')
    if len(ele_list) != 1:
        public_click_element(driver,'//div[@id="k-panelbar-item-default-.1" and @aria-hidden="true"]',description="展开WS菜单")
    public_click_element(driver,'//div[@id="k-panelbar-item-default-.1"]//span[text()="Calls"]',description="Calls菜单")

def calls_click_first_details(driver):
    """
    点击首行的Details按钮
    :param driver:
    :return:
    """
    public_click_element(driver,'//div[@class="ag-center-cols-container"]/div[@row-index="0"]//button[@class="k-button detailsButton"]',description="点击首个Details按钮")
    get_xpath_element(driver,'//b[text()="Call Info"]',description="进入了Details界面")

def click_on_download_menu(driver):
    """
    click on download menu  点击下载按钮
    :param driver:
    :return:
    """
    # 滑动到可见
    SIV(driver,attachment_selectable)
    public_click_element(driver,attachment_selectable,description="附件")
    element = get_xpath_element(driver,'//i[@class="fa fa-download"]',description="下载按钮")
    # 对定位到的元素执行鼠标双击操作
    ActionChains(driver).double_click(element).perform()
    # 点击download
    public_click_element(driver,'//a[text()="Download"]',description="Download按钮")
