# _*_ coding: utf-8 _*_ #
# @Time     :9/6/2022 2:47 PM
# @Author   :Huiming Shi
from public_settings_and_variable import *
from Citron.public_switch.pubLib import *
from Citron.public_switch.public_switch_py import TEST_WEB
from Citron.scripts.Calls.call_test_case.call_python_Lib.public_settings_and_variable import not_disturb, \
    make_available_button
from Citron.scripts.Deletion_of_a_Recordings_and_Screen_Captures.make_a_call_lib import username_input, next_button, \
    password_input, login_button, accept_disclaimer, close_tutorial_button
from selenium import webdriver

def start_an_empty_window():
    """
    启动一个空的窗口
    :return:
    """
    if SMALL_RANGE_BROWSER_TYPE == 'Chrome':
        driver = webdriver.Chrome(options=optionc)
    elif SMALL_RANGE_BROWSER_TYPE == 'Firefox':
        driver = webdriver.Firefox(options=optionf,firefox_profile=profile)
    driver.implicitly_wait(int(IMPLICIT_WAIT))
    driver.maximize_window()
    return driver

@ERR_NAME_NOT_RESOLVED
def open_citron_url(driver):
    """
    打开Citron网址
    :param driver:
    :return:
    """
    driver.get(TEST_WEB)

@ERR_NAME_NOT_RESOLVED
def logIn_citron(driver,username,password,check_toturial = 'no_check_toturial',close_bounced='close_bounced',accept = 'accept',disturb = 'not_set_disturb'):
    """
    封装页面的登录操作和关闭弹框操作
    :param driver: 浏览器驱动
    :param username: 用户名
    :param password: 密码
    :param close_bounced: 是否关闭教程，默认关闭
    :param accept: 是否接受免责声明，默认accept接受
    :param disturb: 是否设置为免打扰模式，默认not_set_disturb不设置；set_disturb为设置
    :param check_toturial:是否检查导航页面的welcome信息，默认不检查no_check_toturial，检查check_toturial
    :return:
    """
    # try:    # enter email
    public_click_element(driver,username_input,description = '用户名输入框')
    get_xpath_element(driver,username_input,description = '用户名输入框').send_keys(username)
    username_value = get_xpath_element(driver,username_input,description = '用户名输入框').get_attribute('value')
    if username_value == username:
        time.sleep(1)
        public_click_element(driver,next_button,description = 'NEXT按钮')
    # 输入密码
    driver.implicitly_wait(0.1)
    # try:
    for i in range(100):
        time.sleep(1)
        ele_list = get_xpath_elements(driver, '//input[@style="display: block;"]')
        ele_list_next = get_xpath_elements(driver, next_button)
        if len(ele_list) == 1:
            get_xpath_element(driver, password_input,description = '密码输入框').send_keys(password)
            public_click_element(driver, login_button,description = 'LOGIN按钮')
            time.sleep(1)
            break
        elif len(ele_list_next) == 1:
            public_click_element(driver, next_button,description = 'NEXT按钮')
        elif i == 99:
            print('password输入框还是未出现')
            screen_shot_func(driver, '登陆时输入password失败')
            raise Exception('password输入框还是未出现')
    # 校验是否进入到主页
    for i in range(200):
        time.sleep(1)
        currentPageUrl = driver.current_url
        print("当前页面的url是：", currentPageUrl)
        if currentPageUrl == TEST_WEB:
            break
        ele_list_login = get_xpath_elements(driver, login_button)
        if len(ele_list_login) == 1:
            public_click_element(driver, login_button,description = 'LOGIN按钮')
        elif i == 199:
            print('再次点击登录按钮未进入首页')
            screen_shot_func(driver, '再次登陆失败')
            raise Exception('再次点击登录按钮未进入首页')
    # close Disclaimer
    driver.implicitly_wait(int(6))
    if accept == 'accept':
        count = get_xpath_elements(driver,accept_disclaimer)
        if len(count) == 1:  # close Disclaimer
            public_click_element(driver,accept_disclaimer,description = '接受Disclaimer按钮')
    # close Tutorial
    if close_bounced == 'close_bounced':
        # check Tutorial
        if check_toturial == 'check_toturial':
            ele_list = get_xpath_elements(driver,'//h1[text()="Welcome to Help Lightning!"]')
            public_assert(driver,len(ele_list),1,condition = '=',action='展示的不是Welcome to Help Lightning!')
        # close Tutorial
        ele_list = get_xpath_elements(driver,close_tutorial_button)
        if len(ele_list) == 1:
            public_click_element(driver, close_tutorial_button, description='关闭tutorial按钮')
    if disturb == 'not_set_disturb':
        ele_list = get_xpath_elements(driver,not_disturb)
        if len(ele_list) == 0:
            public_click_element(driver,make_available_button,description = 'make_available按钮')
    elif disturb == 'set_disturb':
        set_do_not_disturb(driver)
    driver.implicitly_wait(int(IMPLICIT_WAIT))

def driver_set_up_and_logIn(username,password='*IK<8ik,8ik,',check_toturial = 'no_check_toturial',close_bounced='close_bounced',accept = 'accept',disturb = 'not_set_disturb'):
    """
    # driver set up And LogIn
    :param username: 用户名
    :param password: 密码
    :param close_bounced: 是否关闭教程，默认关闭
    :param accept: 是否接受免责声明，默认accept接受
    :param disturb: 是否设置为免打扰模式，默认not_set_disturb不设置；set_disturb为设置
    :param check_toturial:是否检查导航页面的welcome信息，默认不检查no_check_toturial，检查check_toturial
    :return:
    """
    driver = start_an_empty_window()
    driver.set_page_load_timeout(PAGE_LOAD_TIMEOUT)
    open_citron_url(driver)
    logIn_citron(driver, username, password, check_toturial, close_bounced, accept, disturb)
    return driver

def set_do_not_disturb(driver):
    """
    User设置比Do Not Disturb请勿打扰模式
    :param driver:
    :return:
    """
    # try:
    ele_list = get_xpath_elements(driver,not_disturb)
    if len(ele_list) == 1:
        public_click_element(driver,not_disturb,description = 'not_disturb按钮')
        textarea_ele = get_xpath_element(driver,'//textarea[@placeholder="Status Message (optional)"]',description='请勿打扰输入框')
        public_click_element(driver,'//textarea[@placeholder="Status Message (optional)"]',description='请勿打扰输入框')
        textarea_ele.send_keys('Please Do not disturb')
        public_click_element(driver,'//button[@type="submit" and text()="Save"]',description = '保存按钮')
        ele_list = get_xpath_elements(driver,make_available_button)
        public_assert(driver,len(ele_list),1,condition='=',action='设置免打扰模式失败')
        assert len(ele_list) == 1
    textContent = get_xpath_element(driver,'//div[@role="alert"]/div',description = '免受打扰文本').get_attribute('textContent')
    print(textContent)
    public_assert(driver,textContent,'Your status is currently set to Do Not Disturb.Make Available',condition='=',action='设置免打扰模式后文本信息不正确')