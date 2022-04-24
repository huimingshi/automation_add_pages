#----------------------------------------------------------------------------------------------------#
# set up
import time
import os
import platform
from selenium import webdriver
from selenium.webdriver.chrome.options import Options
from selenium.webdriver.support.wait import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC

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
password = '*IK<8ik,8ik,'
test_web = 'https://app-stage.helplightning.net.cn/'
username_input = '//input[@autocomplete="username"]'
password_input = '//input[@autocomplete="current-password"]'
next_button = '//button[text()="Next"]'
login_button = '//button[text()="Log In"]'
submint_button = '//button[@type="submit"]'
search_input = "filter-text-box"
tip_close = '//span[@class="close-button" and contains(.,"Close")]'
add_comment = '//textarea[@placeholder="Add a comment..."]'
accept_disclaimer = '//button[contains(.,"ACCEPT")]'
close_tutorial_button = '//div[@class="modal-header"]//button[@class="close"]'

#----------------------------------------------------------------------------------------------------#
# define python Library
def get_xpath_element(driver,xpath,ec = None):
    """
    通过xpath寻找元素，driver.find_element_by_xpath(xpath)
    :param driver: 浏览器驱动
    :param xpath: 元素的xpath
    :return:
    """
    if not ec:
        return WebDriverWait(driver, 20, 0.5).until(EC.visibility_of_element_located(('xpath',xpath)))
    else:
        return driver.find_element('xpath', xpath)

def get_xpath_elements(driver,xpath):
    """
    通过xpath寻找元素，driver.find_element_by_xpath(xpath)
    :param driver: 浏览器驱动
    :param xpath: 元素的xpath
    :return:
    """
    elements_list = driver.find_elements('xpath', xpath)
    return elements_list

def driver_set_up_and_logIn(username,implicitly_time,close_bounced='close_bounced',accept = 'accept'):
    """
    # Browser Front-loading
    :param driver:
    :param implicitly_time:
    :return:
    """
    driver = webdriver.Chrome(chrome_options=option)
    driver.implicitly_wait(int(implicitly_time))
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

    # # enter email
    # try:
    #     driver.find_element_by_xpath(username_input).click()
    #     driver.find_element_by_xpath(username_input).send_keys(username)
    #     driver.find_element_by_xpath(submint_button).click()
    # except Exception as e:
    #     print('登陆时输入email失败',e)
    #     screen_shot_func(driver, '登陆时输入email失败')
    #     raise Exception
    # else:
    #     print('登陆时输入email成功')
    # time.sleep(1)
    # # enter password
    # try:
    #     driver.find_element_by_xpath(password_input).click()
    #     driver.find_element_by_xpath(password_input).send_keys(password)
    #     driver.find_element_by_xpath(submint_button).click()
    # except Exception as e:
    #     print('登陆时输入password失败',e)
    #     screen_shot_func(driver, '登陆时输入password失败')
    #     raise Exception
    # else:
    #     print('登陆时输入password成功')
    # # close Disclaimer
    # count = driver.find_elements_by_xpath(close_disclaimer)
    # if len(count) == 1:
    #     try:
    #         driver.find_element_by_xpath(close_disclaimer).click()
    #     except Exception as e:
    #         print('登陆成功后接受免责声明失败', e)
    #         screen_shot_func(driver, '登陆成功后接受免责声明失败')
    #         raise Exception
    #     else:
    #         print('登陆成功后接受免责声明成功')
    # # close Tutorial
    # try:
    #     driver.find_element_by_xpath('//div[@class="modal-header"]//button[@class="close"]').click()
    # except Exception as e:
    #     print('登陆成功后关闭教程失败', e)
    #     screen_shot_func(driver, '登陆成功后关闭教程失败')
    #     raise Exception
    # else:
    #     print('登陆成功后关闭教程成功')
    # return driver

# def make_calls_with_who(username1,username2,call_time):
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
        driver1.find_element_by_id(search_input).click()
        driver1.find_element_by_id(search_input).send_keys(who)
    except Exception as e:
        print('查询用户失败',e)
        screen_shot_func(driver1, '查询用户失败')
        raise Exception
    time.sleep(3)
    try:
        driver1.find_element_by_xpath('//button[@class="k-button callButton"]').click()
    except Exception as e:
        print('点击call失败',e)
        screen_shot_func(driver1, '点击call失败')
        raise Exception
    else:
        print('点击call成功')
    time.sleep(5)
    # anwser calls
    try:
        driver2.find_element_by_xpath('//button[contains(.,"ANSWER")]').click()
    except Exception as e:
        print('点击ANWSER按钮失败',e)
        screen_shot_func(driver2, '点击ANWSER按钮失败')
        raise Exception
    # call on hold
    time.sleep(int(call_time))
    # screenshots
    try:
        driver1.find_element_by_xpath('//div[@class="menu roleMenu"]/div[@class="menu withsub  "]').click()
        driver1.find_element_by_xpath('//div[@class="submenu-container"]').click()
        for i in range(4):
            driver1.find_element_by_xpath('//input[@class="capture_button"]').click()
            time.sleep(3)
    except Exception as e:
        print('截图4次失败', e)
        screen_shot_func(driver1, '截图4次失败')
        raise Exception
    else:
        print('截图4次成功')
    # quit call
    try:
        driver1.find_element_by_xpath("//div[@class='InCall']//div[@class='menu']//*[@*='#phone_end_red']").click()
    except Exception as e:
        print('驱动1尝试点击挂断按钮失败', e)
        screen_shot_func(driver1, '点击挂断按钮失败失败')
        raise Exception
    else:
        print('驱动1尝试点击挂断按钮成功')
    try:
        driver1.find_element_by_xpath('//button[@class="promptButton submenu-seperator" and contains(.,"Yes")]').click()
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
    # kill所有的chromedriver进程
    os.system('taskkill /F /im chromedriver.exe')
    # 退出所有的浏览器
    os.system('taskkill /f /t /im chrome.exe')

def get_system_type():
    """
    # get current system type
    # Windows or Mac
    :return: system type
    """
    system_type = platform.system()
    print(system_type)
    return system_type

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