#----------------------------------------------------------------------------------------------------#
# set up
import time
import platform
# import sys,os
# add_path = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
# print(add_path)
# sys.path.append(add_path)
# sys.path.remove(add_path)
# # from Lib import ui_keywords
from selenium import webdriver
from selenium.webdriver.chrome.options import Options
option = Options()
option.add_argument("--disable-infobars")
option.add_argument("start-maximized")
option.add_argument("--disable-extensions")

# Pass the argument 1 to allow and 2 to block
option.add_experimental_option("prefs", {
    "profile.default_content_setting_values.notifications": 1,
    "profile.default_content_setting_values.media_stream_mic": 1
})
#----------------------------------------------------------------------------------------------------#
# variable
test_web = 'https://app-stage.helplightning.net.cn/'
username_input = '//input[@autocomplete="username"]'
password_input = '//input[@autocomplete="current-password"]'
submit_button = '//button[@type="submit"]'
accept_disclaimer = '//button[contains(.,"ACCEPT")]'
open_TaC_button = '//h1[contains(.,"After Call: Tagging and Comments")]/../..//div[@class="react-toggle"]'
close_TaC_button = '//h1[contains(.,"After Call: Tagging and Comments")]/../..//div[@class="react-toggle react-toggle--checked"]'
calls_page = "//span[contains(.,'Calls')]"
filterType =  '//select[@id="filterType"]'
filterText=  '//input[@id="filterText"]'
list_data_count = '//div[@class="ag-center-cols-container"]/div'    # 列表数据行数
second_tree = '//div[@role="tree"]/div[2]'
occurred_input = '//input[@class="ag-filter-filter"]'
close_tutorial_button = '//div[@class="modal-header"]//button[@class="close"]'
make_available_button = '//button[text()="Make Available"]'   # 取消免打扰模式
#----------------------------------------------------------------------------------------------------#
# define python Library

def get_system_type():
    """
    # get current system type
    # Windows or Mac
    :return: system type
    """
    system_type = platform.system()
    print(system_type)
    return system_type

def conversion_of_precise_time(time_string):
    """
    # Conversion of precise time
    :param time_string:
    :return:
    """
    convert_time = time_string.split(':')
    if int(convert_time[1]) >= 1:
        return  'More than a minute'
    else:
        return  'Less than a minute'

def test_filter_set_up():
    """
    # Browser Front-loading
    :return:
    """
    driver = webdriver.Chrome()
    driver.implicitly_wait(10)
    driver.get(test_web)
    driver.maximize_window()
    return driver

def log_in_lib(username,password,close_bounced='close_bounced',accept = 'accept'):
    """
    # driver set up And LogIn
    :param username: 用户名
    :param password: 密码
    :param close_bounced: 是否关闭教程，默认关闭
    :param accept: 是否接受免责声明，默认accept接受
    :return:
    """
    driver = webdriver.Chrome(chrome_options=option)
    driver.implicitly_wait(int(8))
    driver.get(test_web)
    driver.maximize_window()
    try:    # enter email
        driver.find_element_by_xpath(username_input).click()
        driver.find_element_by_xpath(username_input).send_keys(username)
        driver.find_element_by_xpath(submit_button).click()
    except Exception as e:
        print('登陆时输入email失败',e)
        screen_shot_func(driver, '登陆时输入email失败')
        raise Exception
    else:
        print('登陆时输入email成功')
    try:    # enter password
        driver.find_element_by_xpath(password_input).click()
        driver.find_element_by_xpath(password_input).send_keys(password)
        driver.find_element_by_xpath(submit_button).click()
    except Exception as e:
        print('登陆时输入password失败',e)
        screen_shot_func(driver, '登陆时输入password失败')
        raise Exception
    else:
        print('登陆时输入password成功')
    if accept == 'accept':
        count = driver.find_elements_by_xpath(accept_disclaimer)
        if len(count) == 1:  # close Disclaimer
            try:
                driver.find_element_by_xpath(accept_disclaimer).click()
            except Exception as e:
                print('登陆成功后接受免责声明失败', e)
                screen_shot_func(driver, '登录后接受免责声明失败')
                raise Exception
            else:
                print('登陆成功后接受免责声明成功')
    if close_bounced == 'close_bounced':
        try:  # close Tutorial
            driver.find_element_by_xpath(close_tutorial_button).click()
        except Exception as e:
            print('登陆成功后关闭教程失败', e)
            screen_shot_func(driver, '登录成功后关闭教程失败')
            raise Exception
        else:
            print('登陆成功后关闭教程成功')
    return driver

def filter_by_different_fields(driver,index,search_text,text_id):
    """
    # filter by different fields
    :param driver:
    :param index: 第几列数据
    :param search_text: 查询的文本
    :param text_id: 字段对应的html属性
    :return:
    """
    try:
        index = int(index)
        driver.find_element_by_xpath(f'//div[@class="ag-header-row"]/div[{index}]//button[@ref="eButtonShowMainFilter"]').click()
        ele_list = driver.find_elements_by_xpath(filterType)
        if ele_list != 1:
            driver.find_element_by_xpath(f'//div[@class="ag-header-row"]/div[{index}]//button[@ref="eButtonShowMainFilter"]').click()
        else:
            driver.find_element_by_xpath(filterType).click()
        time.sleep(2)
        driver.find_element_by_xpath('//option[contains(.,"Not contains")]').click()
        driver.find_element_by_xpath(filterText).click()
        driver.find_element_by_xpath(filterText).send_keys(search_text)
        time.sleep(5)    # 等待输入查询字段后页面刷新
    except Exception as e:
        print('筛选过程失败', e)
        screen_shot_func(driver, '筛选过程失败')
        raise Exception
    else:
        print('筛选过程成功')
    list_count = driver.find_elements_by_xpath(list_data_count)
    for i in range(len(list_count)):
        text = driver.find_element_by_xpath(f'//div[@class ="ag-center-cols-container"]/div[{i}+1]/div[@col-id="{text_id}"]').get_attribute("textContent")
        try:
            assert search_text not in text
        except AssertionError:
            screen_shot_func(driver, '与预期不符')
            raise AssertionError

def filter_by_duration_greater_than_60_second(driver):
    """
    # filter by duration greater than 60 second
    :param driver:
    :return:
    """
    system_type = get_system_type()
    if system_type == 'Windows':
        try:
            driver.find_element_by_xpath('//div[@class="ag-header-row"]/div[7]//button[@ref="eButtonShowMainFilter"]').click()
        except Exception as e:
            print('点击Duration的右下角按钮失败', e)
            screen_shot_func(driver, '点击Duration的右下角按钮失败')
            raise Exception
        try:
            driver.find_element_by_xpath(filterType).click()
        except Exception as e:
            print('点击筛选条件失败', e)
            screen_shot_func(driver, '点击筛选条件失败')
            raise Exception
        try:
            driver.find_element_by_xpath('//option[@value="greaterThan" and contains(.,"Greater than")]').click()
        except Exception as e:
            print('选择Greater than条件失败', e)
            screen_shot_func(driver, '选择Greater_than条件失败')
            raise Exception
        try:
            driver.find_element_by_xpath(filterText).click()
            driver.find_element_by_xpath(filterText).send_keys('60')
        except Exception as e:
            print('输入框输入60失败', e)
            screen_shot_func(driver, '输入框输入60失败')
            raise Exception
        time.sleep(10)

def check_greater_than_60(driver):
    """
    # Check the results of the filter by duration greater than 60 second
    :param driver:
    :return: if pass,return Pass;
             if fail,return Fail
    """
    system_type = get_system_type()
    if system_type == 'Windows':
        ele_list = driver.find_elements_by_xpath(list_data_count)
        for i in range(len(ele_list)):
            get_text = driver.find_element_by_xpath(f'//div[@class="ag-center-cols-container"]/div[@row-index="{i}"]//div[@col-id="callDuration"]').get_attribute("textContent")
            print(get_text)
            result = conversion_of_precise_time(get_text)
            if result == 'Less than a minute':
                screen_shot_func(driver, '通话时长有小于60s的')
                raise Exception
        return   "Pass"

def enter_calls_page(driver,which_tree = 2):
    """
    进入Calls页面
    :param driver:
    :param which_tree: 哪个目录树，2 or 3；默认是2
    :return:
    """
    try:
        driver.find_element_by_xpath(f'//div[@role="tree"]/div[{which_tree}]').click()
        time.sleep(1)
        driver.find_element_by_xpath(calls_page).click()
        time.sleep(5)
    except Exception as e:
        print('进入calls页面失败', e)
        screen_shot_func(driver, '进入calls页面失败')
        raise Exception
    else:
        print('进入calls页面成功')

def switch_last_365_days(driver):
    """
    切换到last_365_days
    :param driver:
    :return:
    """
    try:
        driver.find_element_by_xpath('//select[@id="occured-within"]').click()
        driver.find_element_by_xpath('//select[@id="occured-within"]/option[@value="last_365_days"]').click()
    except Exception as e:
        print('切换到Last 365 Days失败',e)
        screen_shot_func(driver, '切换到Last_365_days失败')
        raise Exception
    else:
        try:
            time.sleep(5)
            ele_list = driver.find_elements_by_xpath(list_data_count)
            assert len(ele_list) >= 1
        except AssertionError:
            screen_shot_func(driver, '切换到Last_365_days后页面没数据')
            raise AssertionError
        else:
            print('切换到Last 365 Days成功')

def exit_this_driver(driver):
    """
    # Browser Exit
    :param driver:
    :return:
    """
    driver.quit()
    time.sleep(2)

def select_one_of_value(driver):
    """
    # Select one of value in 'Occurred Within' field
    :param driver:
    :return:
    """
    system_type = get_system_type()
    if system_type == 'Windows':
        time.sleep(5)
        system_type = get_system_type()
        if system_type == 'Windows':
            driver.find_element_by_xpath(occurred_input).send_keys('11/12/2021')
        else:
            driver.find_element_by_xpath(occurred_input).send_keys('2021/11/12')
        time.sleep(5)
        count = driver.find_elements_by_xpath(list_data_count)
        print(len(count))
        try:
            assert len(count) == 4
        except AssertionError as e:
            print('数据不是4个',e)
            screen_shot_func(driver, '数据不是4个')
            raise AssertionError
        else:
            print('数据是4个')

def make_sure_TaC_status_correct(driver,status):
    """
    # make sure After Call: Tagging and Comments status correct
    :param driver:
    :param status:  'open_TaC'表示打开；'close_TaC'表示关闭
    :return:
    """
    try:
        driver.find_element_by_xpath(second_tree).click()
        time.sleep(1)
        driver.find_element_by_xpath("//span[contains(.,'Workspace Settings')]").click()
        time.sleep(3)
    except Exception as e:
        print('Workspace Settings页面失败', e)
        screen_shot_func(driver, '进入workspace_settings页面失败')
        raise Exception
    else:
        print('Workspace Settings页面成功')
    if status == 'open_TaC':
        count = driver.find_elements_by_xpath(open_TaC_button)
        if len(count) == 1:
            try:
                driver.find_element_by_xpath(open_TaC_button).click()
            except Exception as e:
                print('打开TaC设置失败',e)
                screen_shot_func(driver, '打开TaC设置失败')
                raise Exception
            time.sleep(3)
    elif status == 'close_TaC':
        count = driver.find_elements_by_xpath(close_TaC_button)
        if len(count) == 1:
            try:
                driver.find_element_by_xpath(close_TaC_button).click()
            except Exception as e:
                print('关闭TaC设置失败',e)
                screen_shot_func(driver, '关闭TaC设置失败')
                raise Exception
            time.sleep(3)

def click_call_tag_link_to_filter_call(driver):
    """
    # filter by tag
    :param driver:
    :return:
    """
    try:
        driver.find_element_by_xpath('//div[@class="ag-header-row"]/div[8]//button[@ref="eButtonShowMainFilter"]').click()
    except Exception as e:
        print('点击tag筛选失败', e)
        screen_shot_func(driver, '点击tag筛选失败')
        raise Exception
    else:
        print('点击tag筛选成功')
    try:
        driver.find_element_by_xpath(filterText).click()
        driver.find_element_by_xpath(filterText).send_keys('11 tag')
    except Exception as e:
        print('根据tag筛选失败',e)
        screen_shot_func(driver, '根据tag筛选失败')
        raise Exception
    else:
        print('根据tag筛选成功')
    time.sleep(5)

def check_filter_by_tag(driver):
    """
    # Check the results of the filter by tag
    :param driver:
    :return: if pass,return Pass;
             if fail,return Fail
    """
    result_flag = 1
    for i in range(10):
        try:
            get_text = driver.find_element_by_xpath(f'//div[@class="ag-center-cols-container"]/div[@row-index="{i}"]//div[@col-id="tags"]').get_attribute("textContent")
        except Exception as e:
            print('预期tag与实际不符',e)
            screen_shot_func(driver,'预期tag与实际不符')
            raise Exception
        print(get_text)
        if '11 tag' not in get_text:
            result_flag = 0
    if result_flag == 0:
        screen_shot_func(driver,'预期的10条tag与实际不符')
        raise Exception

def screen_shot_func(driver,screen_name):
    current_time = time.strftime("%Y-%m-%d-%H-%M-%S", time.localtime(time.time()))
    sys_type = get_system_type()
    if sys_type == 'Windows':
        driver.save_screenshot('.\\' + current_time + screen_name + 'screenshot.png')
    else:
        driver.save_screenshot('./' + current_time + screen_name + 'screenshot.png')

#----------------------------------------------------------------------------------------------------#
if __name__ == '__main__':
    # set up
    driver = test_filter_set_up()
    # log in with workspace admin
    log_in_lib(driver,'Huiming.shi.helplightning@outlook.com','*IK<8ik,8ik,')
    # filter by dialer/participant
    filter_by_different_fields(driver,1,'Huiming.shi.helplightning+123456789')