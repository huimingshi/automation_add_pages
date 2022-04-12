#----------------------------------------------------------------------------------------------------#
# set up
import time
import os
import platform
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
password = '*IK<8ik,8ik,'
test_web = 'https://app-stage.helplightning.net.cn/'
username_input = '//input[@autocomplete="username"]'
password_input = '//input[@autocomplete="current-password"]'
submint_button = '//button[@type="submit"]'
search_input = "filter-text-box"
tip_close = '//span[@class="close-button" and contains(.,"Close")]'
add_comment = '//textarea[@placeholder="Add a comment..."]'
close_disclaimer = '//button[contains(.,"ACCEPT")]'

#----------------------------------------------------------------------------------------------------#
# define python Library
def driver_set_up_and_logIn(username,implicitly_time):
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
    # enter email
    try:
        driver.find_element_by_xpath(username_input).click()
        driver.find_element_by_xpath(username_input).send_keys(username)
        driver.find_element_by_xpath(submint_button).click()
    except Exception as e:
        print('登陆时输入email失败',e)
        screen_shot_func(driver, '登陆时输入email失败')
        raise Exception
    else:
        print('登陆时输入email成功')
    time.sleep(1)
    # enter password
    try:
        driver.find_element_by_xpath(password_input).click()
        driver.find_element_by_xpath(password_input).send_keys(password)
        driver.find_element_by_xpath(submint_button).click()
    except Exception as e:
        print('登陆时输入password失败',e)
        screen_shot_func(driver, '登陆时输入password失败')
        raise Exception
    else:
        print('登陆时输入password成功')
    # close Disclaimer
    count = driver.find_elements_by_xpath(close_disclaimer)
    if len(count) == 1:
        try:
            driver.find_element_by_xpath(close_disclaimer).click()
        except Exception as e:
            print('登陆成功后接受免责声明失败', e)
            screen_shot_func(driver, '登陆成功后接受免责声明失败')
            raise Exception
        else:
            print('登陆成功后接受免责声明成功')
    # close Tutorial
    try:
        driver.find_element_by_xpath('//div[@class="modal-header"]//button[@class="close"]').click()
    except Exception as e:
        print('登陆成功后关闭教程失败', e)
        screen_shot_func(driver, '登陆成功后关闭教程失败')
        raise Exception
    else:
        print('登陆成功后关闭教程成功')
    return driver

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