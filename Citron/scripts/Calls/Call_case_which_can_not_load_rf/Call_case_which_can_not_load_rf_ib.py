#----------------------------------------------------------------------------------------------------#
import time
import platform
from selenium import webdriver
from Citron.public_switch.pubLib import *
from Citron.public_switch.public_switch_py import CITRON_BROWSER_TYPE, IMPLICIT_WAIT

if CITRON_BROWSER_TYPE == 'Chrome':
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
elif CITRON_BROWSER_TYPE == 'Firefox':
    from selenium.webdriver.firefox.options import Options
    option = Options()
    option.add_argument("--disable-infobars")
    option.add_argument("start-maximized")
    option.add_argument("--disable-extensions")

    # Pass the argument 1 to allow and 2 to block
    option.set_capability("prefs", {
        "profile.default_content_setting_values.notifications": 1,
        "profile.default_content_setting_values.media_stream_mic": 1
    })
    option.add_argument('--ignore-certificate-errors')
    profile = webdriver.FirefoxProfile()
    profile.set_preference('intl.accept_languages', 'en-US, en')
#----------------------------------------------------------------------------------------------------#
# variable
test_web = 'https://app-stage.helplightning.net.cn/'
username_input = '//input[@autocomplete="username"]'
password_input = '//input[@autocomplete="current-password"]'
next_button = '//button[text()="Next"]'
login_button = '//button[text()="Log In"]'
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
    if CITRON_BROWSER_TYPE == 'Chrome':
        driver = webdriver.Chrome()
    elif CITRON_BROWSER_TYPE == 'Firefox':
        driver = webdriver.Firefox()
    driver.implicitly_wait(IMPLICIT_WAIT)
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
    if CITRON_BROWSER_TYPE == 'Chrome':
        driver = webdriver.Chrome(options=option)
    elif CITRON_BROWSER_TYPE == 'Firefox':
        driver = webdriver.Firefox(options=option,firefox_profile=profile)
    driver.implicitly_wait(int(IMPLICIT_WAIT))
    driver.get(test_web)
    driver.maximize_window()
    # try:    # enter email
    public_click_element(driver,username_input,description = '用户名输入框')
    get_xpath_element(driver,username_input,description = '用户名输入框').send_keys(username)
    username_value = get_xpath_element(driver,username_input,description = '用户名输入框').get_attribute('value')
    if username_value == username:
        time.sleep(1)
        public_click_element(driver,next_button,description = 'NEXT按钮')
    # 输入密码
    driver.implicitly_wait(1)
    # try:
    for i in range(100):
        time.sleep(1)
        ele_list = get_xpath_elements(driver, '//input[@style="display: block;"]')
        ele_list_next = get_xpath_elements(driver, next_button)
        if len(ele_list) == 1:
            get_xpath_element(driver, password_input,description = 'password输入框').send_keys(password)
            public_click_element(driver, login_button,description = 'LOGIN按钮')
            time.sleep(1)
            break
        elif len(ele_list_next) == 1:
            public_click_element(driver, next_button,description = 'NEXT按钮')
        elif i == 99:
            print('password输入框还是未出现')
            raise Exception
    # 校验是否进入到主页
    for i in range(200):
        time.sleep(1)
        currentPageUrl = driver.current_url
        print("当前页面的url是：", currentPageUrl)
        if currentPageUrl == test_web:
            break
        ele_list_login = get_xpath_elements(driver, login_button)
        if len(ele_list_login) == 1:
            public_click_element(driver, login_button,description = 'NEXT按钮')
        elif i == 199:
            print('再次点击登录按钮未进入首页')
            screen_shot_func(driver, '再次登陆失败')
            raise Exception
    driver.implicitly_wait(int(8))
    # close Disclaimer
    if accept == 'accept':
        count = get_xpath_elements(driver,accept_disclaimer)
        if len(count) == 1:  # close Disclaimer
            public_click_element(driver,accept_disclaimer,description = 'accept_disclaimer')
            # time.sleep(2)
            # driver.implicitly_wait(int(2))
            # count = get_xpath_elements(driver,accept_disclaimer)
            # if len(count) == 1:  # close Disclaimer
            #     # try:
            #     public_click_element(driver,accept_disclaimer,description = 'accept_disclaimer')
    driver.implicitly_wait(int(8))
    # close Tutorial
    if close_bounced == 'close_bounced':
        # try:  # close Tutorial
        public_click_element(driver,close_tutorial_button,description = 'close_tutorial')
    driver.implicitly_wait(int(IMPLICIT_WAIT))
    time.sleep(2)
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
    # try:
    index = int(index)
    public_click_element(driver,f'//div[@class="ag-header-row"]/div[{index}]//button[@ref="eButtonShowMainFilter"]',description = f'第{index}列的下拉框')
    public_click_element(driver,filterType,description = '选择框')
    public_click_element(driver,'//option[contains(.,"Not contains")]',description = 'Not_contains选择器')
    public_click_element(driver,filterText,description = '文本输入框')
    get_xpath_element(driver,filterText,description = '文本输入框').send_keys(search_text)
    time.sleep(5)    # 等待输入查询字段后页面刷新
    list_count = get_xpath_elements(driver,list_data_count)
    for i in range(len(list_count)):
        text = get_xpath_element(driver,f'//div[@class ="ag-center-cols-container"]/div[{i}+1]/div[@col-id="{text_id}"]',description = '文本值').get_attribute("textContent")
        public_assert(driver,search_text , text,condition='not in',action='与预期不符')

def filter_by_duration_greater_than_60_second(driver):
    """
    # filter by duration greater than 60 second
    :param driver:
    :return:
    """
    system_type = get_system_type()
    if system_type == 'Windows':
        public_click_element(driver,'//div[@class="ag-header-row"]/div[7]//button[@ref="eButtonShowMainFilter"]',description = 'Duration的右下角按钮')
        public_click_element(driver,filterType,description = '筛选条件')
        public_click_element(driver,'//option[@value="greaterThan" and contains(.,"Greater than")]',description = 'Greater_than选项')
        public_click_element(driver,filterText,description = '输入框')
        get_xpath_element(driver,filterText,description = '输入框').send_keys('60')
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
        ele_list = get_xpath_elements(driver,list_data_count)
        for i in range(len(ele_list)):
            get_text = get_xpath_element(driver,f'//div[@class="ag-center-cols-container"]/div[@row-index="{i}"]//div[@col-id="callDuration"]',description = '通话时长').get_attribute("textContent")
            print(get_text)
            result = conversion_of_precise_time(get_text)
            public_assert(driver,result , 'Less than a minute',condition='!=',action='通话时长有小于60s的')
        return   "Pass"

def enter_calls_page(driver,which_tree = 2):
    """
    进入Calls页面
    :param driver:
    :param which_tree: 哪个目录树，2 or 3；默认是2
    :return:
    """
    public_click_element(driver,f'//div[@role="tree"]/div[{which_tree}]',description = f'{which_tree}目录树')
    time.sleep(1)
    public_click_element(driver,calls_page,description = 'Call页面')
    time.sleep(5)

def switch_last_365_days(driver):
    """
    切换到last_365_days
    :param driver:
    :return:
    """
    public_click_element(driver,'//select[@id="occured-within"]',description = '时长下拉框')
    time.sleep(1)
    public_click_element(driver,'//select[@id="occured-within"]/option[@value="last_365_days"]',description = '365days选择器')
    time.sleep(5)
    ele_list = get_xpath_elements(driver,list_data_count)
    public_assert(driver,len(ele_list) , 1,condition='>=',action='切换到Last_365_days后页面没数据')
    time.sleep(10)

def exit_this_driver(driver):
    """
    # Browser Exit
    :param driver:
    :return:
    """
    kill_all_browser()

def select_one_of_value(driver):
    """
    # Select one of value in 'Occurred Within' field
    :param driver:
    :return:
    """
    system_type = get_system_type()
    if system_type == 'Windows':
        time.sleep(5)
        if CITRON_BROWSER_TYPE == 'Chrome':
            get_xpath_element(driver,occurred_input,description = '日历时间输入框').send_keys('11/12/2021')
            time.sleep(5)
            for i in range(10):
                count = get_xpath_elements(driver,list_data_count)
                print(len(count))
                if len(count) == 4:
                    break
                elif i == 9:
                    public_assert(driver,len(count) , 4,action='数据不是4个')
                else:
                    time.sleep(1)

def make_sure_TaC_status_correct(driver,status):
    """
    # make sure After Call: Tagging and Comments status correct
    :param driver:
    :param status:  'open_TaC'表示打开；'close_TaC'表示关闭
    :return:
    """
    public_click_element(driver,second_tree,description = '第二目录树')
    time.sleep(1)
    public_click_element(driver,"//span[contains(.,'Workspace Settings')]",description = 'WS设置')
    time.sleep(3)
    if status == 'open_TaC':
        count = get_xpath_elements(driver,open_TaC_button)
        if len(count) == 1:
            public_click_element(driver,open_TaC_button,description = 'open_TaC')
            time.sleep(3)
    elif status == 'close_TaC':
        count = get_xpath_elements(driver,close_TaC_button)
        if len(count) == 1:
            public_click_element(driver,close_TaC_button,description = 'close_TaC')
            time.sleep(3)

def click_call_tag_link_to_filter_call(driver):
    """
    # filter by tag
    :param driver:
    :return:
    """
    public_click_element(driver,'//div[@class="ag-header-row"]/div[8]//button[@ref="eButtonShowMainFilter"]',description = 'tag选择器')
    get_xpath_element(driver,filterText,description = 'tag输入框').send_keys('11 tag')
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
        get_text = get_xpath_element(driver,f'//div[@class="ag-center-cols-container"]/div[@row-index="{i}"]//div[@col-id="tags"]',description = 'tag值').get_attribute("textContent")
        print(get_text)
        if '11 tag' not in get_text:
            result_flag = 0
    if result_flag == 0:
        screen_shot_func(driver,'预期的10条tag与实际不符')
        raise Exception

#----------------------------------------------------------------------------------------------------#
if __name__ == '__main__':
    # set up
    driver = test_filter_set_up()
    # log in with workspace admin
    log_in_lib(driver,'Huiming.shi.helplightning@outlook.com','*IK<8ik,8ik,')
    # filter by dialer/participant
    filter_by_different_fields(driver,1,'Huiming.shi.helplightning+123456789')