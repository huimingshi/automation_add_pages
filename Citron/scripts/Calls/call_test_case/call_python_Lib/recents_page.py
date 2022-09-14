# _*_ coding: utf-8 _*_ #
# @Time     :9/6/2022 2:23 PM
# @Author   :Huiming Shi

from Citron.public_switch.pubLib import *
from Citron.scripts.Calls.call_test_case.call_python_Lib.public_settings_and_variable import first_time_call_started, \
    contacts_page, recents_page


def verify_username_in_recents_page(driver,*args):
    """
    在Recents页面校验参与Call的name是否正确
    :param driver:
    :param args: 需要校验的name列表
    :return:
    """
    expect_username_list = list(args)
    print('预期的username列表',expect_username_list)
    count = len(expect_username_list)
    get_username_list = []
    for i in range(count):
        public_click_element(driver, '//button[text()="Refresh"]', description='Refresh按钮')
        get_username_list.append(get_xpath_element(driver,f'//div[@row-index="{i}"]//div[@class="cardName"]',description = '参会者').get_attribute("textContent"))
    get_username_list.sort()
    print('排序后的实际username列表', get_username_list)
    expect_username_list.sort()
    print('排序后的预期username列表', expect_username_list)
    public_assert(driver, get_username_list, expect_username_list, condition='=', action='recents页面预期name和实际不一致')

def anonymous_user_call_can_not_call_again(driver):
    """
    判断在Recents页面，匿名用户的通话记录没有Call按钮
    :param driver:
    :return:
    """
    ele_list = get_xpath_elements(driver,'//div[@title="Anonymous User"]/../../../..//button[@class="k-button callButton"]')
    public_assert(driver,len(ele_list) , 0,action='Anonymous_User有Call按钮')

def get_start_time_of_the_last_call(driver):
    """
    # 获取最近一次的通话开始时间
    :param driver:
    :return: time_started   最近一次的通话开始时间
    """
    driver.switch_to.window(driver.window_handles[0])  # 切换到第一个页面
    time.sleep(2)
    try:
        public_click_element(driver,contacts_page,description = 'Contacts页面')  # 进入Contacts页面
        time.sleep(2)
        public_click_element(driver,recents_page,description = 'Recents页面')  # 进入Recents页面
        time.sleep(5)
    except Exception as e:
        print('切换页面失败',e)
        screen_shot_func(driver, '切换页面失败')
        raise Exception
    time_started = 'there is no call record'
    count = get_xpath_elements(driver,first_time_call_started)
    if len(count) != 0:
        time_started = get_xpath_element(driver,first_time_call_started,description = '最近一次通话开始时间').get_attribute("textContent")
    return time_started

def get_recents_page_records_occurred_time(driver,rows = '2'):
    """
    获取Recents页面前n行数据的Occurred time列表
    :param driver:
    :param rows: 前多少行；默认为前两行；
    :return:前n行数据的Occurred time列表
    """
    occurred_time_list = []
    for i in range(int(rows)):
        ele_list = get_xpath_elements(driver,f'//div[@row-index="{i}"]/div[@col-id="timeCallStarted"]')
        if len(ele_list) >= 1:
            occurred_time = get_xpath_element(driver,f'//div[@row-index="{i}"]/div[@col-id="timeCallStarted"]',description = '通话开始时间').get_attribute("textContent")
            occurred_time_list.append(occurred_time)
        else:
            public_click_element(driver,'//button[text()="Refresh"]',description = 'refresh按钮')
            occurred_time = get_xpath_element(driver,f'//div[@row-index="{i}"]/div[@col-id="timeCallStarted"]',description = '通话开始时间').get_attribute("textContent")
            occurred_time_list.append(occurred_time)
    return occurred_time_list

def two_list_has_one_same_element(driver,list1,list2):
    """
    获取Recents页面前n行数据的Occurred time列表，判断是否新增了数据
    :param driver:
    :param list1:
    :param list2:
    :return:
    """
    public_assert(driver,list1[0] , list2[-1],action='两组数据没有重复的记录')

def judge_reachable_in_recents(driver,username):
    """
    判断在Recents页面，用户展示reachable
    :param driver:
    :param username: 需要校验的user的username
    :return:
    """
    class_attr = get_xpath_element(driver,f'//div[@class="cardName" and contains(.,"{username}")]/../../../..').get_attribute('class')
    print(class_attr)
    public_assert(driver,'unreachable' , class_attr,condition='not in',action='本不该置灰展示user的但置灰展示了')