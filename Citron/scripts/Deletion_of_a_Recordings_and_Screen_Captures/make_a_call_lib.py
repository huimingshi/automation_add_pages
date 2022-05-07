#----------------------------------------------------------------------------------------------------#
# set up
import time
from selenium import webdriver
from Citron.public_switch.pubLib import get_system_type, kill_all_browser, get_xpath_element, get_xpath_elements
from Citron.public_switch.public_switch_py import BROWSER_TYPE, IMPLICIT_WAIT

if BROWSER_TYPE == 'Chrome':
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

elif BROWSER_TYPE == 'Firefox':
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

#----------------------------------------------------------------------------------------------------#
# define python Library

def driver_set_up_and_logIn(username,close_bounced='close_bounced',accept = 'accept'):
    """
    # Browser Front-loading
    :param driver:
    :return:
    """
    if BROWSER_TYPE == 'Chrome':
        driver = webdriver.Chrome(options=option)
    elif BROWSER_TYPE == 'Firefox':
        driver = webdriver.Firefox(options=option,firefox_profile=profile)
    driver.implicitly_wait(int(IMPLICIT_WAIT))
    driver.get(test_web)
    driver.maximize_window()
    try:    # enter email
        get_xpath_element(driver,username_input).click()
        get_xpath_element(driver,username_input).send_keys(username)
        username_value = get_xpath_element(driver,username_input).get_attribute('value')
        if username_value == username:
            time.sleep(1)
            get_xpath_element(driver,next_button).click()
    except Exception as e:
        print('登陆时输入email失败',e)
        screen_shot_func(driver, '登陆时输入email失败')
        raise Exception
    else:
        print('登陆时输入email成功')
    # 输入密码
    driver.implicitly_wait(0.1)
    try:
        for i in range(100):
            time.sleep(1)
            ele_list = get_xpath_elements(driver, '//input[@style="display: block;"]')
            ele_list_next = get_xpath_elements(driver, next_button)
            if len(ele_list) == 1:
                get_xpath_element(driver, password_input).send_keys(password)
                get_xpath_element(driver, login_button).click()
                time.sleep(1)
                break
            elif len(ele_list_next) == 1:
                get_xpath_element(driver, next_button).click()
            elif i == 99:
                print('password输入框还是未出现')
                raise Exception
    except Exception:
        print('登陆时输入password失败')
        screen_shot_func(driver, '登陆时输入password失败')
        raise Exception
    else:
        print('登陆时输入password成功')
    # 校验是否进入到主页
    try:
        for i in range(100):
            time.sleep(1)
            currentPageUrl = driver.current_url
            print("当前页面的url是：", currentPageUrl)
            if currentPageUrl == test_web:
                break
            ele_list_login = get_xpath_elements(driver, login_button)
            if len(ele_list_login) == 1:
                get_xpath_element(driver, login_button).click()
            elif i == 99:
                print('再次点击登录按钮未进入首页')
                raise Exception
    except Exception:
        screen_shot_func(driver, '再次登陆失败')
        raise Exception
    else:
        print('进入首页')
    driver.implicitly_wait(15)
    if accept == 'accept':
        count = get_xpath_elements(driver,accept_disclaimer)
        if len(count) == 1:  # close Disclaimer
            try:
                get_xpath_element(driver,accept_disclaimer).click()
                time.sleep(2)
                driver.implicitly_wait(int(2))
                count = get_xpath_elements(driver,accept_disclaimer)
                if len(count) == 1:  # close Disclaimer
                    try:
                        get_xpath_element(driver,accept_disclaimer).click()
                    except Exception as e:
                        print('登陆成功后再次接受免责声明失败', e)
                        screen_shot_func(driver, '登录成功后再次接受免责声明失败')
                        raise Exception
                    else:
                        print('登陆成功后再次接受免责声明成功')
            except Exception as e:
                print('登陆成功后接受免责声明失败', e)
                screen_shot_func(driver, '登录后接受免责声明失败')
                raise Exception
            else:
                print('登陆成功后接受免责声明成功')
    driver.implicitly_wait(int(8))
    if close_bounced == 'close_bounced':
        try:  # close Tutorial
            get_xpath_element(driver,close_tutorial_button).click()
        except AssertionError:
            screen_shot_func(driver, '展示的不是Welcome to Help Lightning!')
            raise AssertionError
        except Exception as e:
            print('登陆成功后关闭教程失败', e)
            screen_shot_func(driver, '登录成功后关闭教程失败')
            raise Exception
        else:
            print('登陆成功后关闭教程成功')
    driver.implicitly_wait(int(15))
    return driver

def make_calls_with_who(driver1, driver2, who, call_time):
    """
    # Make calls
    :param driver1:
    :param driver2:
    :param call_time:
    :return:
    """
    # make calls with who
    try:
        get_xpath_element(driver1,search_input).click()
        # driver1.find_element_by_id(search_input).click()
        get_xpath_element(driver1,search_input).send_keys(who)
        # driver1.find_element_by_id(search_input).send_keys(who)
    except Exception as e:
        print('查询用户失败',e)
        screen_shot_func(driver1, '查询用户失败')
        raise Exception
    time.sleep(3)
    try:
        get_xpath_element(driver1,'//button[@class="k-button callButton"]').click()
        # driver1.find_element_by_xpath('//button[@class="k-button callButton"]').click()
    except Exception as e:
        print('点击call失败',e)
        screen_shot_func(driver1, '点击call失败')
        raise Exception
    else:
        print('点击call成功')
    time.sleep(5)
    # anwser calls
    try:
        get_xpath_element(driver2,'//button[contains(.,"ANSWER")]').click()
        # driver2.find_element_by_xpath('//button[contains(.,"ANSWER")]').click()
    except Exception as e:
        print('点击ANWSER按钮失败',e)
        screen_shot_func(driver2, '点击ANWSER按钮失败')
        raise Exception
    # call on hold
    time.sleep(int(call_time))
    # screenshots
    try:
        get_xpath_element(driver1,'//div[@class="menu roleMenu"]/div[@class="menu withsub  "]').click()
        # driver1.find_element_by_xpath('//div[@class="menu roleMenu"]/div[@class="menu withsub  "]').click()
        get_xpath_element(driver1,'//div[@class="submenu-container"]').click()
        # driver1.find_element_by_xpath('//div[@class="submenu-container"]').click()
        for i in range(4):
            get_xpath_element(driver1,'//input[@class="capture_button"]').click()
            # driver1.find_element_by_xpath('//input[@class="capture_button"]').click()
            time.sleep(3)
    except Exception as e:
        print('截图4次失败', e)
        screen_shot_func(driver1, '截图4次失败')
        raise Exception
    else:
        print('截图4次成功')
    # quit call
    try:
        get_xpath_element(driver1,"//div[@class='InCall']//div[@class='menu']//*[@*='#phone_end_red']").click()
        # driver1.find_element_by_xpath("//div[@class='InCall']//div[@class='menu']//*[@*='#phone_end_red']").click()
    except Exception as e:
        print('驱动1尝试点击挂断按钮失败', e)
        screen_shot_func(driver1, '点击挂断按钮失败失败')
        raise Exception
    else:
        print('驱动1尝试点击挂断按钮成功')
    try:
        get_xpath_element(driver1,'//button[@class="promptButton submenu-seperator" and contains(.,"Yes")]').click()
        # driver1.find_element_by_xpath('//button[@class="promptButton submenu-seperator" and contains(.,"Yes")]').click()
    except Exception as e:
        print('点击Yes按钮失败',e)
        screen_shot_func(driver1, '点击yes按钮失败')
        raise Exception

def exit_drivers(*args):
    """
    # exit drivers
    :param driver1:
    :param driver2:
    :return:
    """
    kill_all_browser()

def screen_shot_func(driver,screen_name):
    current_time = time.strftime("%Y-%m-%d-%H-%M-%S", time.localtime(time.time()))
    sys_type = get_system_type()
    if sys_type == 'Windows':
        driver.save_screenshot('.\\' + current_time + screen_name + 'screenshot.png')
    else:
        driver.save_screenshot('./' + current_time + screen_name + 'screenshot.png')

#----------------------------------------------------------------------------------------------------#
if __name__ == '__main__':
    pass