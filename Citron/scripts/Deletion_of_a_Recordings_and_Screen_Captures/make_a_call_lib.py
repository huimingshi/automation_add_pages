#----------------------------------------------------------------------------------------------------#
# set up
import time
from selenium import webdriver
from Citron.public_switch.pubLib import *
from Citron.public_switch.public_switch_py import SMALL_RANGE_BROWSER_TYPE, IMPLICIT_WAIT
from selenium.webdriver import ActionChains

if SMALL_RANGE_BROWSER_TYPE == 'Chrome':
    from selenium.webdriver.chrome.options import Options
    option = Options()
    option.add_argument("--disable-infobars")
    option.add_argument("start-maximized")
    option.add_argument("--disable-extensions")

    # Pass the argument 1 to allow and 2 to block
    option.add_experimental_option("prefs", {
        "profile.default_content_setting_values.notifications": 1,   # chrome开启通知
        "profile.default_content_setting_values.media_stream_mic": 1,   # chrome开启麦克风
        "profile.default_content_setting_values.media_stream_camera": 1  # chrome开启摄像头
    })
    # 忽略证书错误，不需要手动点高级选项
    option.add_argument('--ignore-certificate-errors')

elif SMALL_RANGE_BROWSER_TYPE == 'Firefox':
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
    # 忽略证书错误，不需要手动点高级选项
    option.add_argument('--ignore-certificate-errors')
    profile = webdriver.FirefoxProfile()
    profile.set_preference('intl.accept_languages', 'en-US, en')
    profile.set_preference("permissions.default.microphone", 1)
    profile.set_preference("webdriver_accept_untrusted_certs", True)
#----------------------------------------------------------------------------------------------------#
# variable
password = '*IK<8ik,8ik,'
test_web = 'https://app-stage.helplightning.net.cn/'
username_input = '//input[@autocomplete="username"]'
password_input = '//input[@autocomplete="current-password"]'
next_button = '//button[text()="Next"]'
login_button = '//button[text()="Log In"]'
submint_button = '//button[@type="submit"]'
search_input = '//input[@id="filter-text-box"]'
tip_close = '//span[@class="close-button" and contains(.,"Close")]'
add_comment = '//textarea[@placeholder="Add a comment..."]'
accept_disclaimer = '//button[contains(.,"ACCEPT")]'
close_tutorial_button = '//div[@class="modal-header"]//button[@class="close"]'
click_call_button = '//button[@class="k-button callButton"]'
anwser_call_button = '//button[@class="k-button success-btn big-btn"]'
end_call_button = "//div[@class='InCall']//div[@class='menu']//*[@*='#phone_end_red']"    # 结束Call的红色按钮
visibility_finishi_call = '//span[@style="visibility: visible;"]'    # 校验可以挂断电话的按钮是否出现
exit_call_yes = '//button[@class="promptButton submenu-seperator"]'   # 结束通话的Yes按钮
contacts_search_input = '//div[@id="user-tabs-pane-{}"]//input[@id="filter-text-box"]'
decline_disclaimer = '//div[@class="modal-content"]//button[text()="DECLINE"]'    # DECLINE Disclaimer make call或者就只是DECLINE Disclaimer
video_on_button = '//div[@class="InCall"]//div[@class="menus false"]/div[@class="menu withsub  "]'
upload_file = '//input[@name="upload-file"]'
please_wait = '//div[@class="InvalidLinkView"]/h2[text()="Please wait."]'
zhuanquanquan = '//div[@id="whiteboard_progress_bar_container"]'
webglCameraOff = "//canvas[@id='webglCameraOff']"

#----------------------------------------------------------------------------------------------------#
# define python Library

def driver_set_up_and_logIn(username,close_bounced='close_bounced',accept = 'accept'):
    """
    # Browser Front-loading
    :param driver:
    :return:
    """
    if SMALL_RANGE_BROWSER_TYPE == 'Chrome':
        driver = webdriver.Chrome(options=option)
    elif SMALL_RANGE_BROWSER_TYPE == 'Firefox':
        driver = webdriver.Firefox(options=option,firefox_profile=profile)
    driver.implicitly_wait(int(IMPLICIT_WAIT))
    driver.get(test_web)
    driver.maximize_window()
    # enter email
    public_click_element(driver,username_input,description='username输入框')
    get_xpath_element(driver,username_input,description='username输入框').send_keys(username)
    username_value = get_xpath_element(driver,username_input,description='用户名输入框').get_attribute('value')
    if username_value == username:
        time.sleep(1)
        public_check_element(driver,next_button,description='NEXT按钮')
    # 输入密码
    driver.implicitly_wait(0.1)
    for i in range(100):
        time.sleep(1)
        ele_list = get_xpath_elements(driver, '//input[@style="display: block;"]')
        ele_list_next = get_xpath_elements(driver, next_button)
        if len(ele_list) == 1:
            get_xpath_element(driver, password_input,description='密码输入框').send_keys(password)
            public_click_element(driver, login_button,description='LOGIN按钮')
            time.sleep(1)
            break
        elif len(ele_list_next) == 1:
            public_click_element(driver, next_button,description='NEXT按钮')
        elif i == 99:
            print('password输入框还是未出现')
            screen_shot_func(driver, '登陆时输入password失败')
            raise Exception('password输入框还是未出现')
    # 校验是否进入到主页
    for i in range(200):
        time.sleep(1)
        currentPageUrl = driver.current_url
        print("当前页面的url是：", currentPageUrl)
        if currentPageUrl == test_web:
            break
        ele_list_login = get_xpath_elements(driver, login_button)
        if len(ele_list_login) == 1:
            public_click_element(driver, login_button,description='LOGIN按钮')
        elif i == 199:
            print('再次点击登录按钮未进入首页')
            raise Exception
    driver.implicitly_wait(15)
    # close Disclaimer
    if accept == 'accept':
        count = get_xpath_elements(driver,accept_disclaimer)
        if len(count) == 1:  # close Disclaimer
            public_click_element(driver,accept_disclaimer,description = '接受Disclaimer按钮')
    driver.implicitly_wait(int(8))
    # close Tutorial
    if close_bounced == 'close_bounced':
        ele_list = get_xpath_elements(driver, close_tutorial_button)
        if len(ele_list) == 1:
            public_click_element(driver, close_tutorial_button, description='关闭tutorial按钮')
    driver.implicitly_wait(int(15))
    return driver

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

def proceed_with_camera_off(driver):
    """
    Proceed with my camera Off
    关闭摄像头阴暗时的提示信息
    :param driver:
    :return:
    """
    ele_list = get_xpath_elements(driver,webglCameraOff)
    if len(ele_list) == 1:
        public_click_element(driver,webglCameraOff,description='proceed_with_camera_off按钮')

def contacts_witch_page_make_call(driver1,driver2,witch_page,who = 'on-call group 1',accept='accept'):
    """
    Contacts页面进行call操作
    :param driver1:
    :param driver2:
    :param witch_page: 哪个page? Favorites/Team/Personal/Directory四个页面
    :param who: 与谁进行call? on-call group或者是某个user
    :param accept:对端是否accept此次call
    :return:
    """
    contacts_search_input_format = contacts_search_input.format(witch_page.lower())    # 目前只做了Contacts页面的make call
    # 查询on-call group或者是某个user
    element = get_xpath_element(driver1, contacts_search_input_format, description='查询框')
    element.clear()
    time.sleep(1)
    public_click_element(driver1, contacts_search_input_format, description='查询框')
    element.send_keys(who)
    time.sleep(5)
    contacts_search_result = f'//div[@id="user-tabs-pane-{witch_page.lower()}"]//div[text()="{who}"]'
    ele_ment = get_xpath_elements(driver1, contacts_search_result)
    print(f'{witch_page}输入框个数', len(ele_ment))
    if len(ele_ment) < 1:
        refresh_browser_page(driver1)
        element = get_xpath_element(driver1, contacts_search_input_format, description='搜索框')
        public_click_element(driver1, contacts_search_input_format, description='搜索框')
        element.send_keys(who)
        time.sleep(5)
    public_check_element(driver1, contacts_search_result,f'{who}未加载出', if_click=None, if_show=1)
    # 鼠标悬停
    ellipsis_xpath = f'//div[text()="{who}"]/../../../..//div[@class="ellipsis-menu-div"]'
    ellipsis = get_xpath_element(driver1,ellipsis_xpath,description='悬浮按钮')
    ActionChains(driver1).move_to_element(ellipsis).perform()
    # 选择Audio
    audio_xpath = f'//div[text()="{who}"]/../../../..//span[text()="Video"]/..'
    public_click_element(driver1,audio_xpath,description='启动Audio按钮')
    # 需要Accept Declaimer
    driver1.implicitly_wait(5)
    count = get_xpath_elements(driver1, accept_disclaimer)
    if len(count) == 1:
        public_click_element(driver1, accept_disclaimer, '点击accept_disclaimer失败')
    driver1.implicitly_wait(IMPLICIT_WAIT)
    # 确保进入call
    driver1.implicitly_wait(3)
    for i in range(40):
        ele_list_2 = get_xpath_elements(driver1, please_wait)
        ele_list_1 = get_xpath_elements(driver1, zhuanquanquan)
        ele_list = get_xpath_elements(driver1, '//div[@id="connecting_call_label" and text()="Joining Call..."]')
        if len(ele_list) == 0 and len(ele_list_1) == 0 and len(ele_list_2) == 0:
            break
        elif i == 39:
            screen_shot_func(driver1, '通话还未拨通成功')
            raise Exception('通话还未拨通成功')
        else:
            time.sleep(int(3))
    driver1.implicitly_wait(IMPLICIT_WAIT)
    # 另一端ACCEPT OR DECLINE
    if accept == 'accept':
        public_check_element(driver2, anwser_call_button, '点击ANWSER按钮失败')
    elif accept == 'no_accept':
        public_check_element(driver2, decline_disclaimer, '点击DECLINE按钮失败')
    # call on hold
    time.sleep(int(20))
    # 进入giver mode
    public_click_element(driver1, '//span[text()="I will give help"]', description='选择I_will_give_help失败')
    # 上传photo
    public_click_element(driver1, video_on_button, ec='ec', description='点击video按钮')
    # time.sleep(2)
    proceed_with_camera_off(driver1)
    public_click_element(driver1, '//div[@class="submenu-content"]//span[text()="Photo"]/..', ec='ec',description='选择Photo')
    get_xpath_element(driver1, upload_file, ec='ec', description='上传jpg文件').send_keys(get_picture_path())
    # 截图4次
    for i in range(4):
        public_click_element(driver1, '//input[@class="capture_button"]', description='圆形截图按钮')
        time.sleep(3)
    # quit call
    for i in range(5):
        hang_up_the_phone(driver1)  # 点击红色的挂断电话按钮
        ele_list = get_xpath_elements(driver1, visibility_finishi_call)
        ele_list_yes = get_xpath_elements(driver1, exit_call_yes)
        if len(ele_list_yes) == 1 and len(ele_list) == 1:
            public_click_element(driver1, exit_call_yes, description='Yes按钮')
            break
        elif i == 4:
            print('找不到Yes按钮')
            screen_shot_func(driver1, '找不到Yes按钮')
            raise Exception('找不到Yes按钮')
        else:
            time.sleep(5)
            hang_up_the_phone(driver1)  # 点击红色的挂断电话按钮
            time.sleep(5)

def make_calls_with_who(driver1, driver2, who, call_time):
    """
    # Make calls
    :param driver1:
    :param driver2:
    :param call_time:
    :return:
    """
    element = get_xpath_element(driver1, search_input,description = '搜索框')
    element.clear()
    time.sleep(2)
    public_click_element(driver1, search_input,description = '搜索框')
    element.send_keys(who)
    time.sleep(5)
    user_name = who.split('@')[0]
    ele_ment = get_xpath_elements(driver1,f'//div[@class="card"]/div[text()="{user_name}"]')
    print('0000000000000000000000000000000000',len(ele_ment))
    if len(ele_ment) < 1:
        refresh_browser_page(driver1)
        element = get_xpath_element(driver1,search_input,description = '搜索框')
        public_click_element(driver1,search_input,description = '搜索框')
        element.send_keys(who)
        time.sleep(5)
    public_check_element(driver1, f'//div[@class="card"]/div[text()="{user_name}"]', f'{user_name}未加载出',if_click = None,if_show = 1)
    public_check_element(driver1, click_call_button, '点击Call按钮失败')
    # user anwser calls
    ele_list = get_xpath_elements(driver2,anwser_call_button)
    if len(ele_list) == 1:
        public_click_element(driver2,anwser_call_button,description='ANWSER_CALL按钮')
    else:
        ele_list = get_xpath_elements(driver2,anwser_call_button)
        if len(ele_list) == 1:
            public_click_element(driver2,anwser_call_button,description='ANWSER_CALL按钮')
        else:
            screen_shot_func(driver1,'点击ANSWER按钮失败')
            raise Exception('点击ANSWER按钮失败')
    # call on hold
    time.sleep(int(call_time))
    # screenshots
    public_click_element(driver1,'//div[@class="menu roleMenu"]/div[@class="menu withsub  "]',description='截图前的第一个按钮')
    public_click_element(driver1,'//div[@class="submenu-container"]',description='截图前的第二个按钮')
    for i in range(4):
        public_click_element(driver1,'//input[@class="capture_button"]',description='截图按钮')
        time.sleep(3)
    # quit call
    for i in range(5):
        hang_up_the_phone(driver1)  # 点击红色的挂断电话按钮
        ele_list = get_xpath_elements(driver1, visibility_finishi_call)
        ele_list_yes = get_xpath_elements(driver1, exit_call_yes)
        if len(ele_list_yes) == 1 and len(ele_list) == 1:
            public_click_element(driver1, exit_call_yes, description='Yes按钮')
            # ele_list_yes[0].click()    # 可能会报错Message: stale element reference: element is not attached to the page document，参考：https://blog.csdn.net/zhangvalue/article/details/102921631
            break
        elif i == 4:
            print('找不到Yes按钮')
            screen_shot_func(driver1, '找不到Yes按钮')
            raise Exception('找不到Yes按钮')
        else:
            time.sleep(5)
            hang_up_the_phone(driver1)  # 点击红色的挂断电话按钮
            time.sleep(5)

def hang_up_the_phone(driver):
    """
    点击红色的挂断电话按钮
    :param driver:
    :return:
    """
    public_check_element(driver, end_call_button, '找不到挂断按钮')

def exit_drivers(*args):
    """
    # exit drivers
    :param driver1:
    :param driver2:
    :return:
    """
    kill_all_browser()

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

#----------------------------------------------------------------------------------------------------#
if __name__ == '__main__':
    pass