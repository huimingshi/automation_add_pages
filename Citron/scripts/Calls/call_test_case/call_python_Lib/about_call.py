# _*_ coding: utf-8 _*_ #
# @Time     :9/6/2022 2:31 PM
# @Author   :Huiming Shi
import time

from Citron.public_switch.pubLib import *
from Citron.scripts.Calls.call_test_case.call_python_Lib.else_public_lib import switch_to_last_window as STLW
from Citron.scripts.Calls.call_test_case.call_python_Lib.public_lib import if_has_tutorial_then_close
from Citron.scripts.Calls.call_test_case.call_python_Lib.public_settings_and_variable_copy import *


def click_first_line_details(driver):
    """
    点击首行数据的Details按钮
    :param driver:
    :return:
    """
    public_check_element(driver, first_line_details_button, '点击首行数据的Details按钮失败')

def close_details_page(driver):
    """
    关闭Details页面
    :param driver:
    :return:
    """
    public_check_element(driver, close_details_xpath, '关闭Details页面失败')

def del_tags_in_call_details(driver):
    """
    删除第一个tag
    :param driver:
    :return:
    """
    # 点击首行数据的Details按钮
    click_first_line_details(driver)
    # 删除第一个tag
    public_click_element(driver, '//ul[@role="listbox"]/li[1]/span[@aria-label="delete"]', description='删除第一个tag失败')
    public_click_element(driver, '//div[@class="Tags container-box"]//button[@class="k-button k-primary pull-right"]', description='点击保存tag按钮失败')
    close_details_page(driver)

def give_star_rating(driver,star):
    """
    # Give a star rating
    :param driver:
    :param star:   Value range：From 1 to 5
    :return:
    """
    public_check_element(driver, f'//div[@class="stars"]/span[{int(star)}]/i', '给出星级评价失败')

def make_sure_enter_call(driver):
    """
    确保进入通话状态中
    :param driver:
    :return:
    """
    driver.implicitly_wait(3)
    for i in range(40):
        ele_list_2 = get_xpath_elements(driver, please_wait)
        ele_list_1 = get_xpath_elements(driver,zhuanquanquan)
        ele_list = get_xpath_elements(driver, '//div[@id="connecting_call_label" and text()="Joining Call..."]')
        if len(ele_list) == 0 and len(ele_list_1) == 0 and len(ele_list_2) == 0:
            break
        elif i == 39:
            screen_shot_func(driver, '通话还未拨通成功')
            raise Exception('通话还未拨通成功')
        else:
            time.sleep(int(3))
    driver.implicitly_wait(IMPLICIT_WAIT)

def first_call_record_tag_and_comment(driver,expect_tag,*args):
    """
    检查首行call记录的tag和comment是否正确
    :param driver:
    :param expect_tag: 预期的tag名称
    :return:
    """
    # 获取首行call记录的tag
    print(expect_tag)
    for i in range(3):
        get_tag = get_xpath_element(driver,'//div[@class="ag-center-cols-container"]/div[@row-index="0"]/div[@col-id="tags"]',description = '首行call数据的tag').get_attribute('textContent')
        print(get_tag)
        if get_tag == expect_tag:
            break
        else:
            time.sleep(2)
        print(i)
        public_assert(driver, i, 2, condition='!=', action='tag与预期不一致')
    # 点击首行数据的Details按钮
    click_first_line_details(driver)
    # 获取首行call记录的comment列表
    comment_ele_list = get_xpath_elements(driver,'//div[@class="comment-text row"]')
    i = 0
    for ele in comment_ele_list:
        comment_text = ele.get_attribute('textContent')
        print(args[i], comment_text)
        public_assert(driver,args[i] , comment_text,action='comment与预期不一致')
        i = i + 1
    # 关闭Details页面
    close_details_page(driver)

def get_all_tag_after_call(driver):
    """
    在通话结束页面，获取所有的tags
    :param driver:
    :return:
    """
    tag_list = []
    public_click_element(driver,add_tag_input,description = '添加tag')  # 点击Add tags
    ele_list = get_xpath_elements(driver,f'//div[@class="k-list-scroller"]//li')
    for ele in ele_list:
        get_tag = ele.get_attribute("textContent")
        print(get_tag)
        tag_list.append(get_tag)
    return tag_list

def check_tag_and_com_switch_success(driver,has_tag = 0):
    """
    # 校验关闭Call tag and Comment配置项后，通话结束后没有tag和comment
    :param driver:
    :param has_tag:是否出现tag和comment，默认没出现;  0-不出现； 1-出现
    :return:
    """
    for i in range(3):
        count = get_xpath_elements(driver,five_star_high_praise)
        if len(count) == 1:
            break
        time.sleep(2)
    tag_count = get_xpath_elements(driver,'//span[@class="k-widget k-multiselect k-header"]')
    print(tag_count)
    public_assert(driver,len(tag_count),int(has_tag),action=f'tag输入框的个数应该为{int(has_tag)}')
    com_count = get_xpath_elements(driver,add_comment)
    print(len(com_count))
    public_assert(driver,len(com_count) , int(has_tag),action=f'comment输入框的个数应该为{int(has_tag)}')

def check_survey_switch_success(driver,status = '0',click_button = 'no_click'):
    """
    # 校验切换After Call: End of Call Survey配置项后，通话结束后有没有 a link to take a survey
    :param driver:
    :param status: ‘0’ or ‘1’；‘0’表示不出现，‘1’表示出现；默认为‘0’
    :param click_button:出现按钮后是否点击；默认不点击
    :return:
    """
    for i in range(3):
        count = get_xpath_elements(driver,five_star_high_praise)
        if len(count) == 1:
            break
        time.sleep(2)
    count = get_xpath_elements(driver,take_survey_after_call)
    if status == '0':
        public_assert(driver,len(count) , 0,'不该出现take_survey按钮的')
    elif status == '1':
        public_assert(driver,len(count) , 1,action='该出现take survey按钮的')
        if click_button == 'click':
            public_click_element(driver,take_survey_after_call,description = 'take_survery按钮')
            time.sleep(6)       # 等待Survey页面加载出来

@if_has_tutorial_then_close
def close_call_ending_page(driver):
    """
    # 关闭通话结束展示页面
    :param driver:
    :return:
    """
    STLW(driver)  # 切换到最新页面
    ele_list = get_xpath_elements(driver,close_end_call_page_button)
    if len(ele_list) == 1:
        print('可以关闭通话结束页面')
        public_click_element(driver,close_end_call_page_button,description='关闭通话结束页面')
    elif len(ele_list) == 0:
        print('没有通话结束页面')

def close_call_ending_page_RF(driver):
    """
    # 关闭通话结束展示页面
    :param driver:
    :return:
    """
    STLW(driver)  # 切换到最新页面
    ele_list = get_xpath_elements(driver,close_end_call_page_button)
    if len(ele_list) == 1:
        print('可以关闭通话结束页面')
        public_click_element(driver,close_end_call_page_button,description='关闭通话结束页面')
    elif len(ele_list) == 0:
        print('没有通话结束页面')
    # 关闭tutorial
    ele_list = get_xpath_elements(driver, close_tutorial_button)
    if len(ele_list) == 1:
        public_click_element(driver, close_tutorial_button, description='close_tutorial按钮')

def get_all_comments_in_call_end(driver,*args):
    """
    通话结束页面，获取所有的comments
    :param driver:
    :param args:
    :return:
    """
    # try:
    ele_list = get_xpath_elements(driver,'//div[@class="comment-text row"]')
    for i in range(len(ele_list)):
        get_comment = ele_list[i].get_attribute("textContent")   # 获取comment
        public_assert(driver,get_comment,args[i],action='获取的comments和预期不符')