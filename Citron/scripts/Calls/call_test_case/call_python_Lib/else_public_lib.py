#----------------------------------------------------------------------------------------------------#
import time

from Citron.public_switch.pubLib import *
from Citron.public_switch.public_switch_py import *
from public_settings_and_variable import *
from selenium.webdriver.common.keys import Keys
from selenium.webdriver.common.action_chains import ActionChains
from selenium.webdriver.support.select import Select

#----------------------------------------------------------------------------------------------------#
# define python Library
def switch_to_last_window(driver):
    """
    # 切换到最新页面
    :param driver:
    :return:
    """
    driver.switch_to.window(driver.window_handles[-1])  # 切换到最新页面

def start_an_empty_window():
    """
    启动一个空的窗口
    :return:
    """
    if SMALL_RANGE_BROWSER_TYPE == 'Chrome':
        driver = webdriver.Chrome(options=option)
    elif SMALL_RANGE_BROWSER_TYPE == 'Firefox':
        driver = webdriver.Firefox(options=option,firefox_profile=profile)
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
    driver.implicitly_wait(IMPLICIT_WAIT)
    if accept == 'accept':
        count = get_xpath_elements(driver,accept_disclaimer)
        if len(count) == 1:  # close Disclaimer
            public_click_element(driver,accept_disclaimer,description = '接受Disclaimer按钮')
            # time.sleep(2)
            # driver.implicitly_wait(int(2))
            # count = get_xpath_elements(driver,accept_disclaimer)
            # if len(count) == 1:  # close Disclaimer
            #     public_click_element(driver,accept_disclaimer,description = '接受Disclaimer按钮')
    driver.implicitly_wait(int(8))
    # close Tutorial
    if close_bounced == 'close_bounced':
        # try:  # close Tutorial
        if check_toturial == 'check_toturial':
            ele_list = get_xpath_elements(driver,'//h1[text()="Welcome to Help Lightning!"]')
            public_assert(driver,len(ele_list),1,condition = '=',action='展示的不是Welcome to Help Lightning!')
            # assert len(ele_list) == 1
        ele_list = get_xpath_elements(driver,close_tutorial_button)
        if len(ele_list) == 1:
            public_click_element(driver,close_tutorial_button,description = '关闭tutorial按钮')
    if disturb == 'not_set_disturb':
        ele_list = get_xpath_elements(driver,not_disturb)
        if len(ele_list) == 0:
            public_click_element(driver,make_available_button,description = 'make_available按钮')
    elif disturb == 'set_disturb':
        set_do_not_disturb(driver)
    driver.implicitly_wait(int(IMPLICIT_WAIT))

def driver_set_up_and_logIn(username,password,check_toturial = 'no_check_toturial',close_bounced='close_bounced',accept = 'accept',disturb = 'not_set_disturb'):
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
    # driver.get(TEST_WEB)
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

def do_not_disturb_become_available(driver):
    """
    Do Not Disturb后设置为可用
    :param driver:
    :return:
    """
    # try:
    ele_list = get_xpath_elements(driver,make_available_button)
    if len(ele_list) == 1:
        public_click_element(driver,make_available_button,description = '取消免受打扰按钮')
        ele_list = get_xpath_elements(driver,not_disturb)
        if len(ele_list) != 1:
            public_click_element(driver, make_available_button, description='再次取消免受打扰按钮')
            ele_list = get_xpath_elements(driver, not_disturb)
        public_assert(driver,len(ele_list),1,condition='=',action='make_available按钮依然存在')

def click_my_account(driver):
    """
    点击我的账号
    :param driver:
    :return:
    """
    public_check_element(driver, current_account, '点击我的账号失败')
    public_check_element(driver, '//div[@class="dropdown open btn-group btn-group-lg btn-group-link"]', '展开我的账号失败',if_click=None, if_show=1)

def enter_my_account_settings_page(driver):
    """
    进入My Account页面
    :param driver:
    :return:
    """
    click_my_account(driver)
    public_check_element(driver, '//li[@role="presentation"]//span[contains(.,"Settings")]', '进入My_Account_Settings页面失败')

def my_account_change_name_and_avator(driver,change_name,change_avator,picture_path,back_to_contact = 'no_back_to_contact'):
    """
    在My Account页面更改name和avator
    :param driver:
    :param change_name: 需要更改成为的name
    :param change_avator: 判断是否需要更改avator，如果需要--就是'change'，不需要--就是'delete'
    :param picture_path: 修改图片的绝对路径
    :return:
    """
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
        get_xpath_element(driver,'//input[@type="file"]',ec='ec').send_keys(picture_path)
    elif change_avator == 'delete':
        # 获取alert对话框的按钮，点击按钮，弹出alert对话框
        public_click_element(driver,'//button[contains(.,"Remove avatar")]',description = 'Remove_avatar按钮')
        time.sleep(1)
        public_click_element(driver,'//button[@class="k-button k-primary ml-4" and text()="Ok"]',description = 'OK按钮')
        time.sleep(1)
    public_check_element(driver, '//button[@type="submit" and contains(.,"Update")]', '点击Update失败')
    for i in range(10):
        element_list = get_xpath_elements(driver,notification_content)
        if len(element_list) == 1:
            break
        elif i == 9:
            screen_shot_func(driver, '没有出现绿色的提示信息')
            raise Exception
        else:
            time.sleep(1)
    if back_to_contact == 'back_to_contact':
        public_check_element(driver, '//span[contains(.,"Contacts")]', '返回Contacts页面失败')

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

def hang_up_the_phone(driver):
    """
    点击红色的挂断电话按钮
    :param driver:
    :return:
    """
    public_check_element(driver, end_call_button, '找不到挂断按钮')

def leave_call(driver,select_co_host = 'no_need_select',username = 'Huiming.shi.helplightning+EU2',call_time=25):
    """
    # Leave call
    :param driver:
    :param call_time:通话持续时间
    :param select_co_host:是否需要选择另一个共同主持；默认no_need_select不需要；need_select为需要
    :param username:需要设置为另一个共同主持的user name
    :return:
    """
    # 维持通话25s
    time.sleep(int(call_time))
    # 确保进入通话中
    make_sure_enter_call(driver)
    for i in range(5):
        ele_list = get_xpath_elements(driver,count_of_call_user)
        if len(ele_list) > 2:
            break
        elif i == 4:
            screen_shot_func(driver, '当前参与通话的人数不到3人')
            raise Exception
        else:
            time.sleep(int(IMPLICIT_WAIT))
    # User Leave call
    for i in range(5):
        hang_up_the_phone(driver)     # 点击红色的挂断电话按钮
        ele_list = get_xpath_elements(driver,visibility_finishi_call)
        ele_list_leave_call = get_xpath_elements(driver,leave_call_button)
        if len(ele_list) == 1 and len(ele_list_leave_call) == 1:
            public_click_element(driver,leave_call_button,description='leave_call_button')
            break
        elif i == 4:
            print('找不到Leave_call按钮')
            screen_shot_func(driver,'找不到Leave_call按钮')
            raise Exception('找不到Leave_call按钮')
        else:
            hang_up_the_phone(driver)     # 点击红色的挂断电话按钮
            time.sleep(5)
    if select_co_host == 'need_select':
        public_click_element(driver,f'//strong[text()="{username}"]/../../../../..//div[@class="react-toggle-track"]',description = '选择host')
        time.sleep(2)
        public_click_element(driver,leave_call_button,description = 'leave_call按钮')
        time.sleep(1)
        ele_list = get_xpath_elements(driver,leave_call_button)
        public_assert(driver,len(ele_list),0,action='未选择另一个共同主持')

def make_sure_enter_call(driver):
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

def exit_call(driver,check_user_count='check',call_time=10):
    """
    # 结束call
    :param driver:
    :param check_user_count:是否检查参会人数，默认检查，但有时候会议界面不展示参会人数
    :return:
    """
    # 维持通话10s
    time.sleep(int(call_time))
    # 确保进入通话中
    make_sure_enter_call(driver)
    if check_user_count == 'check':
        for i in range(5):
            ele_list = get_xpath_elements(driver,count_of_call_user)
            if len(ele_list) >= 2:
                break
            elif i == 4:
                screen_shot_func(driver, '当前参与通话的人数不到2人')
                raise Exception('当前参与通话的人数不到2人')
            else:
                time.sleep(int(IMPLICIT_WAIT))
    # User exit call
    for i in range(5):
        hang_up_the_phone(driver)    # 点击红色的挂断电话按钮
        ele_list = get_xpath_elements(driver,visibility_finishi_call)
        ele_list_yes = get_xpath_elements(driver,exit_call_yes)
        if len(ele_list_yes) == 1 and len(ele_list) == 1:
            public_click_element(driver,exit_call_yes,description='Yes按钮')
            # ele_list_yes[0].click()    # 可能会报错Message: stale element reference: element is not attached to the page document，参考：https://blog.csdn.net/zhangvalue/article/details/102921631
            break
        elif i == 4:
            print('找不到Yes按钮')
            screen_shot_func(driver,'找不到Yes按钮')
            raise Exception('找不到Yes按钮')
        else:
            time.sleep(5)
            hang_up_the_phone(driver)  # 点击红色的挂断电话按钮
            time.sleep(5)

def end_call_for_all(driver,call_time=25):
    """
    End Call for All
    :param driver:
    :return:
    """
    # 维持通话25s
    time.sleep(int(call_time))
    # 确保进入通话中
    make_sure_enter_call(driver)
    for i in range(10):
        ele_list = get_xpath_elements(driver,count_of_call_user)
        if len(ele_list) > 2:
            break
        elif i == 9:
            screen_shot_func(driver, '当前参与通话的人数不到3人')
            raise Exception
        else:
            time.sleep(10)
    # 点击End_Call_for_All
    for i in range(5):
        hang_up_the_phone(driver)     # 点击红色的挂断电话按钮
        ele_list = get_xpath_elements(driver,visibility_finishi_call)
        ele_list_end_call = get_xpath_elements(driver,end_call_for_all_button)
        if len(ele_list) == 1 and len(ele_list_end_call) == 1:
            public_click_element(driver,end_call_for_all_button,description='End_call_for_all按钮')
            break
        elif i == 4:
            print('找不到End_Call_for_All按钮')
            raise Exception('找不到End_Call_for_All按钮')
        else:
            time.sleep(5)
            hang_up_the_phone(driver)  # 点击红色的挂断电话按钮
            time.sleep(5)
    public_check_element(driver, '//button[@variant="secondary" and contains(.,"Yes")]', 'end_call_for_all时找不到Yes按钮', )

def which_page_is_currently_on(driver,page_tag_xpath,currently_on = 'currently_on'):
    """
    判断当前在哪个页面，或者不在哪个页面（以页面上出现的元素的xpath决定）
    :param driver:
    :param page_tag_xpath: 页面上出现的元素的xpath
    :param currently_on: 是否在当前页面，默认是在；在：currently_on；不在：not_currently_on
    :return:
    """
    if currently_on == 'currently_on':
        get_xpath_element(driver, page_tag_xpath, ec=None, select='xpath', description='当前页面与预期页面不一致', timeout=int(60))
    elif currently_on == 'not_currently_on':
        ele_list = get_xpath_elements(driver,page_tag_xpath)
        print(ele_list)
        public_assert(driver,len(ele_list),0,action='当前页面与预期页面不一致')

def give_star_rating(driver,star):
    """
    # Give a star rating
    :param driver:
    :param star:   Value range：From 1 to 5
    :return:
    """
    public_check_element(driver, f'//div[@class="stars"]/span[{int(star)}]/i', '给出星级评价失败')

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
    # 点击首行数据的Details按钮
    click_first_line_details(driver)
    # 删除第一个tag
    public_check_element(driver, '//ul[@role="listbox"]/li[1]/span[@aria-label="delete"]', '删除第一个tag失败')
    public_check_element(driver, '//div[@class="CallInfo container-box"]//button[@class="k-button k-primary pull-right"]', '点击保存按钮失败')
    close_details_page(driver)

def add_tags_and_comment(driver,which_tag = 1,which_comment = 'good_experience'):
    """
    # add tags and comment
    :param driver:
    :param which_tag:添加tag时选择第几个tag，默认为第一个
    :return: tag的文本值
    """
    tag_xpath = f'//div[@class="k-list-scroller"]//li[{int(which_tag)}]'
    ele_list = get_xpath_elements(driver,tag_xpath)
    if len(ele_list) == 1:
        ele_tag = get_xpath_element(driver,tag_xpath,description = '添加tag')
        first_tag_text = ele_tag.get_attribute("textContent")
        print(first_tag_text)
        public_click_element(driver,tag_xpath,description = '添加tag')
    else:
        public_click_element(driver,add_tag_input,description='添加tag')
        ele_tag = get_xpath_element(driver,tag_xpath,description = '添加tag')
        first_tag_text = ele_tag.get_attribute("textContent")
        print(first_tag_text)
        public_click_element(driver,tag_xpath,description = '添加tag')
    public_click_element(driver,add_comment,description = '添加comment')
    get_xpath_element(driver,add_comment,description = '添加comment').send_keys(which_comment)
    public_click_element(driver,'//div[@class="call-info-form-group form-group"]//button[contains(.,"Save")]',description = 'Save按钮')
    return  first_tag_text

def exit_driver(*args):
    """
    # exit drivers
    :param driver1:
    :param driver2:
    :return:
    """
    # exit driver
    kill_all_browser()

def exit_one_driver(*args):
    """
    # exit drivers
    :param driver1:
    :param driver2:
    :return:
    """
    # exit driver
    for driver in args:
        try:
            # driver.quit()
            for i in range(len(driver.window_handles)):
                driver.switch_to.window(driver.window_handles[i - 1])
                driver.close()
            time.sleep(1)
        except Exception:
            print(f'当前{driver}不存在')

def user_accept_disclaimer(driver):
    """
    关闭Disclaimer
    :param driver:
    :return:
    """
    # 关闭Disclaimer
    driver.implicitly_wait(6)
    count = get_xpath_elements(driver,accept_disclaimer)
    if len(count) == 1:  # close Disclaimer
        public_check_element(driver, accept_disclaimer, '接受免责声明失败')
    driver.implicitly_wait(IMPLICIT_WAIT)

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

def close_call_ending_page(driver):
    """
    # 关闭通话结束展示页面
    :param driver:
    :return:
    """
    switch_to_last_window(driver)  # 切换到最新页面
    ele_list = get_xpath_elements(driver,'//div[@class="EndCallPageContent"]//span[@role="presentation"]')
    if len(ele_list) == 1:
        print('可以关闭通话结束页面')
        public_click_element(driver,'//div[@class="EndCallPageContent"]//span[@role="presentation"]',description='关闭通话结束页面')
    elif len(ele_list) == 0:
        print('没有通话结束页面')

def check_tutorial_screen_shows_up(driver):
    """
    # After ending call,	VP: The tutorial screen shows up.
    :param driver:
    :return:
    """
    # try:
    count = get_xpath_elements(driver,close_tutorial_button)
    public_assert(driver,len(count) , 1,action='该出现tutorial的')

def paste_on_a_non_windows_system(driver,paste_xpath):
    """
    非windows系统上粘贴
    :param driver:
    :param paste_xpath:需要进行粘贴的元素的xpath
    :return:
    """
    ele = get_xpath_element(driver,paste_xpath,description = '非Windows操作系统粘贴')
    actions = ActionChains(driver)
    actions.move_to_element(ele)
    actions.click(ele)  # select the element where to paste text
    actions.key_down(Keys.META)
    actions.send_keys('v')
    actions.key_up(Keys.META)
    actions.perform()

def open_send_meeting_dialog(driver,which_meeting):
    """
    # 打开发起MHS或者OTU会议的对话框
    :param driver:
    :param which_meeting: MHS或者OTU
    """
    public_click_element(driver, send_my_help_space_invitation, description = '打开Send_My_Help_Space_Invitation窗口')
    if which_meeting == 'MHS':
        # 去勾选
        text_value = get_xpath_element(driver,checkbox_xpath,description = 'checkbox').get_attribute('value')
        if text_value == 'true':
            public_click_element(driver,checkbox_xpath,description = 'checkbox')
            time.sleep(2)
    elif which_meeting == 'OTU':
        # 勾选
        text_value = get_xpath_element(driver,checkbox_xpath,description = 'checkbox').get_attribute('value')
        if text_value == 'false':
            public_click_element(driver,checkbox_xpath,description = 'checkbox')
            time.sleep(2)

def send_meeting_room_link(driver,which_meeting,if_send = 'no_send'):
    """
    # User发起MHS或者OTU会议，并且检查link的复制粘贴功能是否OK
    :param driver:
    :param which_meeting: MHS或者OTU
    :param if_send: 是否发送，‘send’表示发送，‘no_send’表示不发送，默认为no_send
    :return: MHS或者OTU会议的link
    """
    open_send_meeting_dialog(driver,which_meeting)
    # 复制
    for i in range(5):
        text = get_xpath_element(driver,'//div[@class="invite-link"]',description = '邀请链接').get_attribute("textContent")
        print(text)
        if text.startswith(r'https://'):
            break
        elif i == 4:
            public_check_element(driver, '//form[@class="InviteToHelpSpaceView form-horizontal"]//button[text()="Cancel"]', '点击取消按钮失败')
            open_send_meeting_dialog(driver, which_meeting)
            for i in range(5):
                text = get_xpath_element(driver,'//div[@class="invite-link"]',description = '邀请链接').get_attribute("textContent")
                print(text)
                if text.startswith(r'https://'):
                    break
                elif i == 4:
                    screen_shot_func(driver,'url信息未出现')
                    raise Exception
                else:
                    time.sleep(10)
        else:
            time.sleep(10)
    public_check_element(driver, '//i[@class="far fa-copy "]', '复制按钮未出现')
    sys_type = get_system_type()
    if sys_type == 'Windows':
        ele = get_xpath_element(driver,my_help_space_message,description = 'message输入框')
        public_click_element(driver,my_help_space_message,description = 'message输入框')
        ele.send_keys(Keys.CONTROL, 'v')
    else:
        paste_on_a_non_windows_system(driver, my_help_space_message)
    # 验证复制后粘贴结果正确
    invite_url = get_xpath_element(driver,get_invite_link,description = '邀请链接').get_attribute("textContent")  # Get the invitation link
    print('复制的link为:',invite_url)
    attribute = get_xpath_element(driver,my_help_space_message,description = 'message输入框').get_attribute('value')
    print('粘贴的link为:',attribute)
    public_assert(driver,attribute , invite_url,action='复制和粘贴内容不一致')    # 验证复制后粘贴结果正确
    if if_send == 'send':
        # 输入email
        email_ele = get_xpath_element(driver,send_link_email_input,description = 'email输入框')
        public_click_element(driver,send_link_email_input,description = 'email输入框')
        email_ele.send_keys('Huiming.shi.helplightning+123456789@outlook.com')
        # 点击Send Invite按钮
        public_click_element(driver,send_link_send_invite,description = '发送按钮')
    elif if_send == 'no_send':
        public_check_element(driver, '//div[@class="modal-content"]//button[text()="Cancel"]', '点击Cancel按钮失败')
    return invite_url

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

def click_switch_ws_button(driver,sleep_time = 5):
    """
    点击切换workspace按钮
    :param driver:
    :return:
    """
    public_check_element(driver, '//span[@role="listbox"]//i', '点击切换workspace按钮失败')
    time.sleep(int(sleep_time))

def user_switch_to_first_workspace(driver):
    """
    # switch to first workspace
    :param driver:
    :return:
    """
    # 点击切换WS按钮
    click_switch_ws_button(driver)
    public_click_element(driver, '//div[@class="k-list-scroller"]//li[1]', description = '切换到第一个workspace失败')
    time.sleep(2)
    # 关闭Disclaimer
    user_accept_disclaimer(driver)

def user_switch_to_second_workspace(driver,which_ws = 'Canada'):
    """
    # switch to second workspace
    :param driver:
    :return:
    """
    # 点击切换WS按钮
    click_switch_ws_button(driver)
    public_click_element(driver, f'//div[@class="k-list-scroller"]//li[contains(.,"{which_ws}")]',description = f'{which_ws}这个WS')
    time.sleep(2)
    # 关闭Disclaimer
    user_accept_disclaimer(driver)

def switch_to_other_tab(driver,tab_xpath):
    """
    切换到其他的tab页面
    :param driver:
    :param tab_xpath: tab页的xpath
    :return:
    """
    public_check_element(driver, tab_xpath, '切换元素失败')
    time.sleep(3)

def contacts_different_page_search_user(driver,which_page,search_user):
    """
    在不同的页面进行user查询
    :param driver:
    :param which_page: Contacts下的哪个页面? Favorites/Team/Personal/Directory四个页面
    :param search_user: 要查询的用户
    :return:
    """
    contacts_search_input_format = contacts_search_input.format(which_page.lower())
    ele = get_xpath_element(driver,contacts_search_input_format,description = f'{which_page}页面查询输入框')
    ele.clear()
    time.sleep(1)
    public_click_element(driver,contacts_search_input_format,description = f'{which_page}页面查询输入框')
    ele.send_keys(search_user)
    for i in range(3):
        user_xpath = f'//div[@id="user-tabs-pane-{which_page.lower()}"]//div[text()="{search_user}"]'
        element_list = get_xpath_elements(driver,user_xpath)
        if len(element_list) == 1:
            break
        elif i == 2:
            screen_shot_func(driver,f'没查到{search_user}')
            raise Exception
        else:
            time.sleep(int(IMPLICIT_WAIT))

def contacts_judge_reachable_or_not(driver,which_page,which_user,unreachable = 'unreachable'):
    """
    判断用户是否reachable
    :param driver:
    :param which_page: Contacts下的哪个页面? Favorites/Team/Personal/Directory四个页面
    :param which_user: 要判断是否在线的用户
    :param unreachable: 是否unreachable，默认为unreachable
    :return:
    """
    user_xpath = f'//div[@id="user-tabs-pane-{which_page.lower()}"]//div[text()="{which_user}"]/../../..'
    # 等待数据出现
    public_check_element(driver, user_xpath, '数据未出现', if_click = None)
    class_attr = get_xpath_element(driver,user_xpath,ec='ec').get_attribute('class')
    print(class_attr)
    if unreachable == 'unreachable':
        public_assert(driver,'unreachableText',class_attr,condition='in',action='本该置灰user却没置灰')
    elif unreachable == 'reachable':
        public_assert(driver, 'unreachableText', class_attr, condition='not in', action='不该置灰user却置灰了')

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

def logout_citron(driver):
    """
    logout from citron
    :param driver:
    :return:
    """
    public_check_element(driver, current_account, '点击我的账号失败')
    public_check_element(driver, log_out_button, '点击退出按钮失败')
    element_list = get_xpath_elements(driver,username_input)
    public_assert(driver,len(element_list) , 1,action='退出登录后不是登录页面')

def re_login_citron(driver,username,password='*IK<8ik,8ik,'):
    # enter email
    public_click_element(driver,username_input,description = 'username输入框')
    get_xpath_element(driver,username_input,description = 'username输入框').send_keys(username)
    public_click_element(driver,next_button,description = 'NEXT按钮')
    # enter password
    public_click_element(driver,password_input,description = 'password输入框')
    get_xpath_element(driver,password_input,description = 'password输入框').send_keys(password)
    public_click_element(driver,login_button,description = 'LOGIN按钮')
    # 获取登陆失败的提示信息
    ele_list = get_xpath_elements(driver,'//span[text()="Authentication Failed"]')
    public_assert(driver,len(ele_list) , 1,action='没出现登陆失败的提示信息Authentication_Failed')

def switch_to_settings_page(driver,whitch_setting = 'Workspace Settings',which_tree = '2', if_click_tree = 'click_tree'):
    """
    切换到Settings页面
    :param driver:
    :param whitch_setting: 可以是Workspace Settings，也可以是Site Settings，默认Workspace Settings
    :param which_tree:点击哪个目录树，默认是第二个目录树
    :param if_click_tree:是否需要点击目录树，默认点击为'click_tree'，不点击为'no_click_tree'
    :return:
    """
    if if_click_tree == 'click_tree':
        public_check_element(driver, f'//div[@role="tree"]/div[{int(which_tree)}]', '切换菜单失败')
        time.sleep(2)
    public_check_element(driver, f'//span[contains(.,"{whitch_setting}")]', '点击settings页面失败')
    time.sleep(2)
    if whitch_setting == 'Workspace Settings':
        ele_list = get_xpath_elements(driver,'//h1[text()="Workspace Settings"]')
        public_assert(driver,len(ele_list) , 1,action=f'未进入{whitch_setting}页面')
    elif whitch_setting == 'Settings':
        ele_list = get_xpath_elements(driver,'//h1[text()="Debug Tools"]')
        public_assert(driver, len(ele_list), 1, action=f'未进入{whitch_setting}页面')

def switch_to_diffrent_page(driver,switch_page,switch_success_tag,data_show,switch_tree = 'no_switch_tree',which_tree = '1'):
    """
    切换到不同的页面
    :param driver:
    :param switch_page: 切换的页面
    :param switch_success_tag: 切换成功的标志的xpath
    :param data_show: 展示数据的xpath
    :param switch_tree: 是否需要切换目录树，默认不需要切换
    :param which_tree: 哪个层级的目录树
    :return:
    """
    switch_to_last_window(driver)  # 切换到最新页面
    if switch_tree == 'switch_tree':
        public_click_element(driver,f'//div[@role="tree"]/div[{int(which_tree)}]',description = f'{which_tree}目录树')
        time.sleep(1)
    if switch_page == 'Favorites' or switch_page == 'Directory' or switch_page == 'Personal':
        public_click_element(driver, '//span[contains(.,"Contacts")]', description='Contacts页面')
    public_click_element(driver,f'//span[contains(.,"{switch_page}")]',description = f'{switch_page}页面')
    time.sleep(1)
    if switch_page == 'Favorites' or switch_page == 'Directory' or switch_page == 'Personal':
        for i in range(5):
            element_list = get_xpath_elements(driver, switch_success_tag)
            if len(element_list) == 1:
                time.sleep(2)
                element_list_data = get_xpath_elements(driver, f'//div[@id="user-tabs-pane-{switch_page.lower()}"]//div[@class="ag-center-cols-container"]/div')
                if len(element_list_data) > 0:
                    break
            elif i == 4:
                print(f'未切换到Contacts下的{switch_page}页面')
                screen_shot_func(driver, f'未切换到Contacts下的{switch_page}页面')
                raise Exception(f'未切换到Contacts下的{switch_page}页面')
            else:
                time.sleep(1)
    else:
        for i in range(5):
            element_list = get_xpath_elements(driver,switch_success_tag)
            if len(element_list) == 1:
                time.sleep(2)
                element_list_data = get_xpath_elements(driver,data_show)
                if len(element_list_data) > 0:
                    break
                elif i == 4:
                    print(f'切换到{switch_page}页面后数据未加载出')
                    if switch_page == 'Recents':
                        public_click_element(driver,'//button[text()="Refresh"]',description = 'Refresh按钮')
                        public_check_element(driver, data_show, f'刷新{switch_page}页面后数据仍然未加载出', if_click=0, if_show=1)
                else:
                    time.sleep(1)
            elif i == 4:
                print(f'未切换到{switch_page}页面')
                screen_shot_func(driver,f'未切换到{switch_page}页面')
                raise Exception(f'未切换到{switch_page}页面')
            else:
                time.sleep(1)

def get_all_data_on_the_page(driver,witch_page,search_key = 'cardName'):
    """
    获取当前页面的所有user数据
    :param driver:
    :param witch_page: 哪个页面
    :param search_key:xpath中的关键值，普通页面（Directory或者Users页面）的search_key = 'cardName'；通话中邀请第三位用户的页面的search_key = 'contact-name'
    :return: user list
    """
    i = 0
    user_list = []
    quarter_of_the_height_n = 0
    size = driver.get_window_size()  # 获取当前浏览器的像素
    height_size = int(size['height'])  # 获取当前浏览器的高度像素
    quarter_of_the_height = int(height_size/4)  # 获取当前浏览器的高度像素的四分之一，作为每次滑动的增加值
    print(size)
    print(height_size)
    print(quarter_of_the_height)
    driver.implicitly_wait(int(6))
    while True:
        if witch_page == 'Directory':
            ele_list_1 = driver.find_elements_by_xpath(f'//div[@id="user-tabs-pane-directory"]//div[@class="ag-center-cols-container"]/div[@row-index="{i}"]//div[@class="{search_key}"]')  # 取每次循环的第一行数据（每4条数据一次循环）
            ele_list_2 = driver.find_elements_by_xpath(f'//div[@id="user-tabs-pane-directory"]//div[@class="ag-center-cols-container"]/div[@row-index="{i + 3}"]//div[@class="{search_key}"]')  # 取每次循环的最后一行数据（每4条数据一次循环）
        else:
            ele_list_1 = driver.find_elements_by_xpath(f'//div[@class="ag-center-cols-container"]/div[@row-index="{i}"]//div[@class="{search_key}"]')   # 取每次循环的第一行数据（每4条数据一次循环）
            ele_list_2 = driver.find_elements_by_xpath(f'//div[@class="ag-center-cols-container"]/div[@row-index="{i+3}"]//div[@class="{search_key}"]')   # 取每次循环的最后一行数据（每4条数据一次循环）
        if len(ele_list_1) == 1 and len(ele_list_2) == 1:  # 如果当前循环下，首条和尾条数据都存在，就获取name放到user_list中
            print('获取一轮4条数据')
            if witch_page == 'Directory':
                for j in range(i,i+4):  # 获取4条数据的name放到user_list中
                    get_name = get_xpath_element(driver,f'//div[@id="user-tabs-pane-directory"]//div[@class="ag-center-cols-container"]/div[@row-index="{j}"]//div[@class="{search_key}"]').get_attribute("textContent")
            else:
                for j in range(i, i + 4):  # 获取4条数据的name放到user_list中
                    get_name = get_xpath_element(driver,f'//div[@class="ag-center-cols-container"]/div[@row-index="{j}"]//div[@class="{search_key}"]').get_attribute("textContent")
            user_list.append(get_name)
            i = i + 4   # 设置每4次一个循环
            print(i)
        else:
            # 如果当前循环下，尾条数据不存在，就进行向下滑动(每次向下滑动 当前浏览器的高度像素的四分之一)
            quarter_of_the_height_n = quarter_of_the_height_n + quarter_of_the_height
            if witch_page == 'Directory':
                js = f'document.getElementsByClassName("ag-body-viewport ag-layout-normal ag-row-no-animation")[2].scrollTop={quarter_of_the_height_n}'
            else:
                js = f'document.getElementsByClassName("ag-body-viewport ag-layout-normal ag-row-no-animation")[0].scrollTop={quarter_of_the_height_n}'
            driver.execute_script(js)
            # 判断滑动后，尾条数据是否还能展示
            print(i+3)
            ele_list_3 = driver.find_elements_by_xpath(f'//div[@class="ag-center-cols-container"]/div[@row-index="{i+3}"]//div[@class="{search_key}"]')
            # 滑动后，尾条数据不展示
            print('滑动后，尾条数据不展示')
            if len(ele_list_3) != 1:
                # 判断尾条前一条数据是否展示
                print(i + 2)
                ele_list_3 = driver.find_elements_by_xpath(f'//div[@class="ag-center-cols-container"]/div[@row-index="{i+2}"]//div[@class="{search_key}"]')
                # 数据不展示，就打印下数据不展示
                if len(ele_list_3) != 1:
                    print(f'{i+3}行元素不显示了')
                # 数据展示，就把最后一轮循环的数据添加到user_list中
                else:
                    print(f'添加到{i+3}行数据')
                    for j in range(i, i + 3):
                        get_name = get_xpath_element(driver,f'//div[@class="ag-center-cols-container"]/div[@row-index="{j}"]//div[@class="{search_key}"]').get_attribute("textContent")
                        # get_name = driver.find_element_by_xpath(f'//div[@class="ag-center-cols-container"]/div[@row-index="{j}"]//div[@class="{search_key}"]').get_attribute("textContent")
                        user_list.append(get_name)
                    break
                # 后面都是这个逻辑，往前推一个数据进行判断
                print(i + 1)
                ele_list_3 = driver.find_elements_by_xpath(f'//div[@class="ag-center-cols-container"]/div[@row-index="{i+1}"]//div[@class="{search_key}"]')
                if len(ele_list_3) != 1:
                    print(f'{i+2}行元素不显示了')
                else:
                    print(f'添加到{i+2}行数据')
                    for j in range(i, i + 2):
                        get_name = get_xpath_element(driver,f'//div[@class="ag-center-cols-container"]/div[@row-index="{j}"]//div[@class="{search_key}"]').get_attribute("textContent")
                        # get_name = driver.find_element_by_xpath(f'//div[@class="ag-center-cols-container"]/div[@row-index="{j}"]//div[@class="{search_key}"]').get_attribute("textContent")
                        user_list.append(get_name)
                    break
                print(i)
                ele_list_3 = driver.find_elements_by_xpath(f'//div[@class="ag-center-cols-container"]/div[@row-index="{i}"]//div[@class="{search_key}"]')
                if len(ele_list_3) != 1:
                    print(f'{i+1}行元素不显示了')
                else:
                    print(f'添加到{i+1}行数据')
                    for j in range(i, i + 1):
                        get_name = get_xpath_element(driver,f'//div[@class="ag-center-cols-container"]/div[@row-index="{j}"]//div[@class="{search_key}"]').get_attribute("textContent")
                        # get_name = driver.find_element_by_xpath(f'//div[@class="ag-center-cols-container"]/div[@row-index="{j}"]//div[@class="{search_key}"]').get_attribute("textContent")
                        user_list.append(get_name)
                    break
                # print(i)
                # ele_list_3 = driver.find_elements_by_xpath(f'//div[@class="ag-center-cols-container"]/div[@row-index="{i}"]//div[@class="{search_key}"]')
                # if len(ele_list_3) != 1:
                #     print(f'{i+1}行元素不显示了')
                # else:
                #     print(f'添加到{i+1}行数据')
                #     get_name = get_xpath_element(driver,f'//div[@class="ag-center-cols-container"]/div[@row-index="{i}"]//div[@class="{search_key}"]').get_attribute("textContent")
                #     # get_name = driver.find_element_by_xpath(f'//div[@class="ag-center-cols-container"]/div[@row-index="{i}"]//div[@class="{search_key}"]').get_attribute("textContent")
                #     user_list.append(get_name)
                #     break
                print(i-1)
                ele_list_3 = driver.find_elements_by_xpath(f'//div[@class="ag-center-cols-container"]/div[@row-index="{i-1}"]//div[@class="{search_key}"]')
                if len(ele_list_3) != 1:
                    print(f'{i}行元素不显示了')
                    break
                else:
                    print(f'只显示到{i}行元素')
                    break
    print(len(user_list))
    return user_list

# def get_all_data_on_the_page(driver,search_key = 'cardName'):
#     """
#     获取当前页面的所有user数据
#     :param driver:
#     :param search_key:xpath中的关键值，普通页面（Directory或者Users页面）和通话中邀请第三位用户的页面的user对应的xpath不同
#     :return: user list
#     """
#     i = 0
#     user_list = []
#     quarter_of_the_height_n = 0
#     size = driver.get_window_size()  # 获取当前浏览器的像素
#     height_size = int(size['height'])  # 获取当前浏览器的高度像素
#     quarter_of_the_height = int(height_size/4)  # 获取当前浏览器的高度像素的四分之一，作为每次滑动的增加值
#     print(size)
#     print(height_size)
#     print(quarter_of_the_height)
#     driver.implicitly_wait(int(6))
#     while True:
#         ele_list_1 = driver.find_elements_by_xpath(f'//div[@class="ag-center-cols-container"]/div[@row-index="{i}"]//div[@class="{search_key}"]')   # 取每次循环的第一行数据（每5条数据一次循环）
#         ele_list_2 = driver.find_elements_by_xpath(f'//div[@class="ag-center-cols-container"]/div[@row-index="{i+4}"]//div[@class="{search_key}"]')   # 取每次循环的最后一行数据（每5条数据一次循环）
#         if len(ele_list_1) == 1 and len(ele_list_2) == 1:  # 如果当前循环下，首条和尾条数据都存在，就获取name放到user_list中
#             for j in range(i,i+5):  # 获取5条数据的name放到user_list中
#                 get_name = get_xpath_element(driver,f'//div[@class="ag-center-cols-container"]/div[@row-index="{j}"]//div[@class="{search_key}"]').get_attribute("textContent")
#                 # get_name = driver.find_element_by_xpath(f'//div[@class="ag-center-cols-container"]/div[@row-index="{j}"]//div[@class="{search_key}"]').get_attribute("textContent")
#                 user_list.append(get_name)
#             i = i + 5   # 设置每5次一个循环
#             print(i)
#         else:
#             # 如果当前循环下，尾条数据不存在，就进行向下滑动(每次向下滑动 当前浏览器的高度像素的四分之一)
#             quarter_of_the_height_n = quarter_of_the_height_n + quarter_of_the_height
#             js = f'document.getElementsByClassName("ag-body-viewport ag-layout-normal ag-row-no-animation")[0].scrollTop={quarter_of_the_height_n}'
#             driver.execute_script(js)
#             # 判断滑动后，尾条数据是否还能展示
#             print(i+4)
#             ele_list_3 = driver.find_elements_by_xpath(f'//div[@class="ag-center-cols-container"]/div[@row-index="{i+4}"]//div[@class="{search_key}"]')
#             # 滑动后，尾条数据不展示
#             if len(ele_list_3) != 1:
#                 # 判断尾条前一条数据是否展示
#                 print(i + 3)
#                 ele_list_3 = driver.find_elements_by_xpath(f'//div[@class="ag-center-cols-container"]/div[@row-index="{i+3}"]//div[@class="{search_key}"]')
#                 # 数据不展示，就打印下数据不展示
#                 if len(ele_list_3) != 1:
#                     print(f'{i+4}行元素不显示了')
#                 # 数据展示，就把最后一轮循环的数据添加到user_list中
#                 else:
#                     print(f'添加到{i+4}行数据')
#                     for j in range(i, i + 4):
#                         get_name = get_xpath_element(driver,f'//div[@class="ag-center-cols-container"]/div[@row-index="{j}"]//div[@class="{search_key}"]').get_attribute("textContent")
#                         # get_name = driver.find_element_by_xpath(f'//div[@class="ag-center-cols-container"]/div[@row-index="{j}"]//div[@class="{search_key}"]').get_attribute("textContent")
#                         user_list.append(get_name)
#                     break
#                 # 后面都是这个逻辑，往前推一个数据进行判断
#                 print(i + 2)
#                 ele_list_3 = driver.find_elements_by_xpath(f'//div[@class="ag-center-cols-container"]/div[@row-index="{i+2}"]//div[@class="{search_key}"]')
#                 if len(ele_list_3) != 1:
#                     print(f'{i+3}行元素不显示了')
#                 else:
#                     print(f'添加到{i+3}行数据')
#                     for j in range(i, i + 3):
#                         get_name = get_xpath_element(driver,f'//div[@class="ag-center-cols-container"]/div[@row-index="{j}"]//div[@class="{search_key}"]').get_attribute("textContent")
#                         # get_name = driver.find_element_by_xpath(f'//div[@class="ag-center-cols-container"]/div[@row-index="{j}"]//div[@class="{search_key}"]').get_attribute("textContent")
#                         user_list.append(get_name)
#                     break
#                 print(i + 1)
#                 ele_list_3 = driver.find_elements_by_xpath(f'//div[@class="ag-center-cols-container"]/div[@row-index="{i+1}"]//div[@class="{search_key}"]')
#                 if len(ele_list_3) != 1:
#                     print(f'{i+2}行元素不显示了')
#                 else:
#                     print(f'添加到{i+2}行数据')
#                     for j in range(i, i + 2):
#                         get_name = get_xpath_element(driver,f'//div[@class="ag-center-cols-container"]/div[@row-index="{j}"]//div[@class="{search_key}"]').get_attribute("textContent")
#                         # get_name = driver.find_element_by_xpath(f'//div[@class="ag-center-cols-container"]/div[@row-index="{j}"]//div[@class="{search_key}"]').get_attribute("textContent")
#                         user_list.append(get_name)
#                     break
#                 print(i)
#                 ele_list_3 = driver.find_elements_by_xpath(f'//div[@class="ag-center-cols-container"]/div[@row-index="{i}"]//div[@class="{search_key}"]')
#                 if len(ele_list_3) != 1:
#                     print(f'{i+1}行元素不显示了')
#                 else:
#                     print(f'添加到{i+1}行数据')
#                     get_name = get_xpath_element(driver,f'//div[@class="ag-center-cols-container"]/div[@row-index="{i}"]//div[@class="{search_key}"]').get_attribute("textContent")
#                     # get_name = driver.find_element_by_xpath(f'//div[@class="ag-center-cols-container"]/div[@row-index="{i}"]//div[@class="{search_key}"]').get_attribute("textContent")
#                     user_list.append(get_name)
#                     break
#                 print(i-1)
#                 ele_list_3 = driver.find_elements_by_xpath(f'//div[@class="ag-center-cols-container"]/div[@row-index="{i-1}"]//div[@class="{search_key}"]')
#                 if len(ele_list_3) != 1:
#                     print(f'{i}行元素不显示了')
#                     break
#                 else:
#                     print(f'只显示到{i}行元素')
#                     break
#     print(len(user_list))
#     return user_list

def remove_value_from_list(list,value):
    """
    从列中删除某个元素
    :param list:
    :param value:
    :return:
    """
    list.remove(value)
    print(len(list))
    return list

def contacts_page_send_email(driver,username):
    """
    在Favorites/Team/Personal/Directory页面点击Invite按钮
    :param driver:
    :param username:
    :return:
    """
    invite_xpath = f'//div[text()="{username}"]/../../../..//div[@class="button invite-btn-container"]'
    public_click_element(driver,invite_xpath,description='Invite按钮')
    for i in range(10):
        element_list = get_xpath_elements(driver,notification_content)
        if len(element_list) == 1:
            break
        elif i == 9:
            screen_shot_func(driver, '没有出现绿色的提示信息')
            raise Exception
        else:
            time.sleep(1)

def recents_page_check_call(driver,user_name,can_connect = 'can_not_connect',send_invite = 'send_invite'):
    """
    判断在Recents页面点击Call按钮能否打通这个Call
    :param driver:
    :param user_name: 想要点击的name
    :param can_connect: 是否可以打通；默认不能打通('can_not_connect'),can_connect为可以打通
    :param send_invite: 不能打通时，是否需要发送邀请
    :return:
    """
    # 鼠标悬停
    ellipsis_xpath = f'//div[text()="{user_name}"]/../../../..//div[@class="ellipsis-menu-div"]'
    ellipsis = get_xpath_element(driver, ellipsis_xpath, description='悬浮按钮')
    ActionChains(driver).move_to_element(ellipsis).perform()
    # 选择Audio
    audio_xpath = f'//div[text()="{user_name}"]/../../../..//span[text()="Audio+"]/..'
    public_click_element(driver, audio_xpath, description='启动Audio按钮')
    # 需要Accept Declaimer
    count = get_xpath_elements(driver, accept_disclaimer)
    if len(count) == 1:
        public_click_element(driver, accept_disclaimer, '点击accept_disclaimer失败')
    if can_connect == 'can_not_connect':
        for i in range(3):
            ele_list = get_xpath_elements(driver,send_invite_button)
            if len(ele_list) == 1:
                break
            else:
                time.sleep(int(IMPLICIT_WAIT))
            print(i)
            public_assert(driver,i , 2,condition='!=',action='没出现Send_Invite按钮')
    elif can_connect == 'can_connect':
        ele_list = get_xpath_elements(driver,end_call_before_connecting)
        public_assert(driver,len(ele_list) , 1,action='应该可以打通但没打通')
    if send_invite == 'send_invite':
        public_check_element(driver, send_invite_button, '点击Send_Invite按钮失败')
    elif send_invite == 'click_cancel':
        public_click_element(driver, '//div[@class="modal-content"]//button[text()="Cancel"]', description='点击Send_Invite按钮失败')

def anonymous_user_call_can_not_call_again(driver):
    """
    判断在Recents页面，匿名用户的通话记录没有Call按钮
    :param driver:
    :return:
    """
    ele_list = get_xpath_elements(driver,'//div[@title="Anonymous User"]/../../../..//button[@class="k-button callButton"]')
    public_assert(driver,len(ele_list) , 0,action='Anonymous_User有Call按钮')

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

def expand_which_setting(driver,which_setting):
    """
    EXPAND某个setting配置项
    :param driver:
    :param which_setting: 具体的某个配置项的全称
    :return:
    """
    public_check_element(driver, f'//h1[contains(.,"{which_setting}")]/../..//button[contains(.,"Expand")]', 'EXPAND某个setting失败')

def get_css_value(driver,witch_xpath,which_CSS):
    """
    获取CSS属性值
    :param driver:
    :param witch_xpath: 哪个xpath
    :param which_CSS: 想获取哪一个CSS
    :return:
    """
    ele = get_xpath_element(driver,witch_xpath,description = f'{witch_xpath}的css属性值')
    css_value = ele.value_of_css_property(which_CSS)
    print(css_value)
    return css_value

def check_contacts_list(driver,*args):
    """
    获取并检查Contacts下Team页面的name列表
    :param driver:
    :param args: 预期的name列表
    :return:
    """
    # try:
    ele_list = get_xpath_elements(driver,'//div[@id="user-tabs-pane-team"]//div[@class="ag-center-cols-container"]/div//div[@class="cardName"]')
    print(ele_list)
    if len(args) != 0:
        for i in range(len(ele_list)):
            user_name = ele_list[i].get_attribute('textContent')
            public_assert(driver,user_name , args[i],action='contacts列表name与预期不符')
    elif len(args) == 0:
        public_assert(driver, len(ele_list) , 0, action='contacts列表name与预期不符')

def reset_disclaimer(driver):
    """
    Reset_All_Accepted_Disclaimers
    :param driver:
    :return:
    """
    public_check_element(driver, "//button[contains(.,'Reset All Accepted Disclaimers')]", '点击重置Disclaimer按钮失败')
    public_check_element(driver, '//div[@role="dialog"]//button[text()="OK"]', '重置Disclaimer时点击OK按钮失败')
    ele_list = get_xpath_elements(driver,"//button[text()='Reset All Accepted Disclaimers']")
    public_assert(driver,len(ele_list) , 1,action='Reset_All_Accepted_Disclaimers未生效')
    public_check_element(driver, "//button[text()='Reset All Accepted Disclaimers']", 'Disclaimer提示信息未散去', if_click=None,if_show=None)

def refresh_browser_page(driver,close_tutorial = 'close_tutorial'):
    """
    刷新浏览器的某个页面
    :param driver:
    :param close_tutorial: 是否关闭导航页面；默认关闭
    :return:
    """
    driver.refresh()
    time.sleep(20)
    if close_tutorial == 'close_tutorial':
        ele_list = get_xpath_elements(driver,close_tutorial_button)
        if len(ele_list) == 1:
            public_click_element(driver, close_tutorial_button,description = 'close_tutorial按钮')   # 刷新页面后关闭教程
        # public_click_element(driver, close_tutorial_button, description='close_tutorial按钮')  # 刷新页面后关闭教程

def disclaimer_should_be_shown_up_or_not(driver,appear = 'appear',wait_time = IMPLICIT_WAIT):
    """
    # Disclaimer should be shown up or not
    :param driver:
    :param appear: 是否出现Disclaimer，默认为出现：appear；不出现：not_appear
    :return:
    """
    # try:
    driver.implicitly_wait(int(wait_time))
    ele_list = get_xpath_elements(driver,"//button[contains(.,'ACCEPT')]")
    if appear == 'appear':
        public_assert(driver,len(ele_list) , 1,action='disclaimer是否出现与预期不符合')
    elif appear == 'not_appear':
        public_assert(driver, len(ele_list), 0, action='disclaimer是否出现与预期不符合')
    driver.implicitly_wait(IMPLICIT_WAIT)

def user_decline_or_accept_disclaimer(driver,accept_or_decline = 'decline'):
    """
    DECLINE Disclaimer or ACCEPT Disclaimer
    :param driver:
    :param accept_or_decline: decline or accept，默认decline
    :return:
    """
    if accept_or_decline == 'decline':
        public_check_element(driver, decline_disclaimer, '没找到decline按钮')
    elif accept_or_decline == 'accept':
        public_check_element(driver, accept_disclaimer, '没找到accept按钮')

def open_debug_tools_in_settings(driver):
    """
    在Settings打开Debug Tools配置
    :param driver:
    :return:
    """
    ele_list = driver.find_elements_by_xpath(debug_tools_close_xpath)
    if len(ele_list) == 1:
        public_check_element(driver, debug_tools_close_xpath, '打开Debug_Tools配置失败')
        time.sleep(1)
    else:
        print('Debug Tools配置已经打开了')

def erase_my_account(driver):
    """
    两次点击Erase My Account按钮去确认删除账号
    :param driver:
    :return:
    """
    for i in range(2):
        public_check_element(driver, '//button[text()="Erase My Account"]', '两次点击Erase_My_Account失败')
        time.sleep(1)

def verify_username_in_recents_page(driver,*args):
    """
    在Recents页面校验参与Call的name是否正确
    :param driver:
    :param args: 需要校验的name列表
    :return:
    """
    count = len(args)
    for i in range(count):
        ele_list = get_xpath_elements(driver,f'//div[@row-index="{i}"]//div[@class="cardName"]')
        if len(ele_list) == 1:
            name = get_xpath_element(driver,f'//div[@row-index="{i}"]//div[@class="cardName"]',description = '参会者').get_attribute("textContent")
            public_assert(driver,name , args[i],action='recents页面预期name和实际不一致')
        else:
            public_click_element(driver,'//button[text()="Refresh"]',description='Refresh按钮')
            name = get_xpath_element(driver,f'//div[@row-index="{i}"]//div[@class="cardName"]',description = '参会者').get_attribute("textContent")
            public_assert(driver, name, args[i], action='recents页面预期name和实际不一致')

def close_last_window(driver):
    """
    关闭最后一个浏览器页面，前面的浏览器页面不会被关闭
    :param driver:
    :return:
    """
    switch_to_last_window(driver)  # 切换到最新页面
    driver.close()
    time.sleep(2)
    switch_to_last_window(driver)  # 切换到最新页面
    time.sleep(2)

def switch_first_window(driver):
    """
    进入第一个窗口
    :param driver:
    :return:
    """
    driver.switch_to.window(driver.window_handles[0])  # 切换到第一个tab页

def new_another_tab_and_go(driver,website):
    """
    新打开一个tab页面，网址是website
    :param driver:
    :param website:
    :return:
    """
    js = "window.open('{}','_blank');"
    driver.execute_script(js.format(website))
    switch_to_last_window(driver)  # 切换到最新页面

def get_ele_text(driver,ele_xpath):
    """
    获取元素的文本值
    :param driver:
    :param ele_xpath:
    :return:
    """
    get_text = get_xpath_element(driver,ele_xpath,description = '元素的文本值').get_attribute('textContent')
    return get_text

def get_ele_class_name(driver,ele_xpath,class_name):
    """
    获取元素的属性{class_name}值
    :param driver:
    :param ele_xpath: 元素的xpath
    :param class_name: 元素的具体属性
    :return:
    """
    get_class_value = get_xpath_element(driver, ele_xpath,description = '元素的属性值').get_attribute(f'{class_name}')
    print(f'{class_name}的value是:',get_class_value)
    return get_class_value

def open_html_create_call(login_user,password,call_user):
    """
    打开html页面进行call
    :param login_user: 通过html登录的user
    :param password: 密码
    :param call_user: 需要给他进行call的user
    :return:
    """
    driver = start_an_empty_window()
    html_abs_path = os.path.join(os.path.dirname(os.path.dirname(os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__)))))),'publicData','html_login.html')
    driver.get(html_abs_path)
    select = get_xpath_element(driver, '//select[@id="environment-select"]',description = '选择environment')
    Select(select).select_by_visible_text('stage-asia')
    time.sleep(1)
    email_input = get_xpath_element(driver,'//input[@id="email"]',description = 'email')
    email_input.send_keys(login_user)
    password_input =get_xpath_element(driver,'//input[@id="password"]',description = 'password')
    password_input.send_keys(password)
    public_click_element(driver, '//button[@id="login-btn"]',description = 'Login按钮')
    public_check_element(driver, search_by_email, 'search_by_enail输入框未出现', if_click=None, if_show=1)
    public_click_element(driver, search_by_email,description = '根据email查询框')
    get_xpath_element(driver, search_by_email,description = '根据email查询框').send_keys(call_user)
    public_click_element(driver, '//button[@id="call-btn"]',description = 'Call按钮')
    return driver

def check_a_contains_b(driver,a,b):
    """
    断言两个css属性值是否相同
    :param driver:
    :param a:
    :param b:
    :return:
    """
    public_assert(driver,b , a,condition='in',action='css属性值断言失败')

def two_option_is_equal(driver,option1,option2):
    """
    判断两个对象一致
    :param driver:
    :param option1:
    :param option2:
    :return:
    """
    public_assert(driver,option1,option2,action='两列表不一致')

if __name__ == '__main__':
    # print()
    # open_html_create_call('Huiming.shi.helplightning+8888888888@outlook.com','*IK<8ik,8ik,','Huiming.shi.helplightning+111222333@outlook.com')
    # User S belong to WS1 and WS2 log in
    # driver1 = driver_set_up_and_logIn('Huiming.shi.helplightning+9988776655@outlook.com','*IK<8ik,8ik,')
    # # Contact of WS1 log in
    # driver0 = driver_set_up_and_logIn('Huiming.shi.helplightning+99887766551@outlook.com','*IK<8ik,8ik,')
    driver = driver_set_up_and_logIn('big_admin','asdQWE123')
    # # get modify picture absolute path
    # modify_picture_path = r'E:\automation_add_pages\automation_add_pages\Citron\publicData\modify_picture.jpg'
    # # Make sure the name and avator is in its original state
    # my_account_change_name_and_avator(driver2,'Huiming.shi.helplightning+99887766551','change',modify_picture_path,'back_to_contact')
    # time.sleep(100000)
    # driver = driver_set_up_and_logIn('Huiming.shi.helplightning+EU1@outlook.com', '*IK<8ik,8ik,',check_toturial='check_toturial')
    # ele_text = get_ele_text(driver,'//span[@class="k-link k-header"]')
    # check_a_is_queal_b(driver,ele_text,'MY HELP LIGHTNING')
    # Premium User log in
    # driver = driver_set_up_and_logIn('Huiming.shi.helplightning+9988776655@outlook.com','*IK<8ik,8ik,')
    # Premium User Send meeting room link
    invite_url =  send_meeting_room_link(driver,'MHS')
    # # anonymous open meeting link with website
    # from Citron.scripts.Calls.call_test_case.call_python_Lib.call_public_lib import anonymous_open_meeting_link, user_anwser_call
    # driver1 = anonymous_open_meeting_link(invite_url)
    # # Premium User Aneser call
    # user_anwser_call(driver)