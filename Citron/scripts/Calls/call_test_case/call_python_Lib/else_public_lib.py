#----------------------------------------------------------------------------------------------------#
import time
import os,sys
import platform
from selenium import webdriver
from public_lib import screen_shot_func,get_system_type,public_check_element,kill_all_browser
from public_settings_and_variable import *
from selenium.webdriver.common.keys import Keys
from selenium.webdriver.common.action_chains import ActionChains

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
    driver = webdriver.Chrome(chrome_options=option)
    driver.implicitly_wait(int(15))
    driver.maximize_window()
    return driver

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
    try:    # enter email
        driver.find_element_by_xpath(username_input).click()
        driver.find_element_by_xpath(username_input).send_keys(username)
        username_value = driver.find_element_by_xpath(username_input).get_attribute('value')
        if username_value == username:
            time.sleep(1)
            driver.find_element_by_xpath(submit_button).click()
    except Exception as e:
        print('登陆时输入email失败',e)
        screen_shot_func(driver, '登陆时输入email失败')
        raise Exception
    else:
        print('登陆时输入email成功')
    try:    # enter password
        for i in range(3):
            ele_list =  driver.find_elements_by_xpath('//input[@style="display: block;"]')
            ele_list_psd = driver.find_elements_by_xpath(password_input)
            if len(ele_list) == 1 and len(ele_list_psd) == 1 :
                ele_list_psd[0].send_keys(password)
                driver.find_element_by_xpath(submit_button).click()
                break
            elif i == 2:
                print('password输入框未出现')
                print('再点击下NEXT按钮')
                driver.find_element_by_xpath(submit_button).click()
                for j in range(3):
                    ele_list = driver.find_elements_by_xpath('//input[@style="display: block;"]')
                    ele_list_psd = driver.find_elements_by_xpath(password_input)
                    if len(ele_list) == 1 and len(ele_list_psd) == 1:
                        ele_list_psd[0].send_keys(password)
                        driver.find_element_by_xpath(submit_button).click()
                        break
                    elif j == 2:
                        print('password输入框还是未出现')
                    else:
                        raise Exception('password输入框还是未出现')
            else:
                time.sleep(1)
    except Exception as e:
        print('登陆时输入password失败',e)
        screen_shot_func(driver, '登陆时输入password失败')
        raise Exception
    else:
        print('登陆时输入password成功')
    # 校验是否进入到主页
    for i in range(40):
        time.sleep(1)
        currentPageUrl = driver.current_url
        print("当前页面的url是：", currentPageUrl)
        if currentPageUrl == test_web:
            break
        elif i == 39:
            print('未进入到登录后的页面')
            public_check_element(driver, submit_button, '没找到登录按钮')
            for i in range(40):
                time.sleep(1)
                currentPageUrl = driver.current_url
                print("当前页面的url是：", currentPageUrl)
                if currentPageUrl == test_web:
                    break
                elif i == 39:
                    print('再次点击登录按钮未进入首页')
                    screen_shot_func(driver, '再次登陆失败')
                    raise Exception
    if accept == 'accept':
        count = driver.find_elements_by_xpath(accept_disclaimer)
        if len(count) == 1:  # close Disclaimer
            try:
                driver.find_element_by_xpath(accept_disclaimer).click()
                time.sleep(2)
                driver.implicitly_wait(int(2))
                count = driver.find_elements_by_xpath(accept_disclaimer)
                if len(count) == 1:  # close Disclaimer
                    try:
                        driver.find_element_by_xpath(accept_disclaimer).click()
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
            if check_toturial == 'check_toturial':
                ele_list = driver.find_elements_by_xpath('//h1[text()="Welcome to Help Lightning!"]')
                assert len(ele_list) == 1
            driver.find_element_by_xpath(close_tutorial_button).click()
        except AssertionError:
            screen_shot_func(driver, '展示的不是Welcome to Help Lightning!')
            raise AssertionError
        except Exception as e:
            print('登陆成功后关闭教程失败', e)
            screen_shot_func(driver, '登录成功后关闭教程失败')
            raise Exception
        else:
            print('登陆成功后关闭教程成功')
    if disturb == 'not_set_disturb':
        try:
            ele_list = driver.find_elements_by_xpath(not_disturb)
            if len(ele_list) == 0:
                driver.find_element_by_xpath(make_available_button).click()
        except Exception as e:
            print('取消免打扰模式失败',e)
            screen_shot_func(driver,'取消免打扰模式失败')
            raise Exception
    elif disturb == 'set_disturb':
        set_do_not_disturb(driver)
    driver.implicitly_wait(int(15))

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
    driver = webdriver.Chrome(chrome_options=option)
    driver.implicitly_wait(int(15))
    driver.get(test_web)
    driver.maximize_window()
    logIn_citron(driver, username, password, check_toturial, close_bounced, accept, disturb)
    return driver

def set_do_not_disturb(driver):
    """
    User设置比Do Not Disturb请勿打扰模式
    :param driver:
    :return:
    """
    try:
        ele_list = driver.find_elements_by_xpath(not_disturb)
        if len(ele_list) == 1:
            driver.find_element_by_xpath(not_disturb).click()
            textarea_ele = driver.find_element_by_xpath('//textarea[@placeholder="Status Message (optional)"]')
            textarea_ele.click()
            textarea_ele.send_keys('Please Do not disturb')
            driver.find_element_by_xpath('//button[@type="submit" and text()="Save"]').click()
            ele_list = driver.find_elements_by_xpath(make_available_button)
            assert len(ele_list) == 1
    except AssertionError:
        print('设置免打扰模式失败')
        screen_shot_func(driver, '设置免打扰模式失败')
        raise AssertionError
    except Exception as e:
        print('设置免打扰模式失败', e)
        screen_shot_func(driver, '设置免打扰模式失败')
        raise Exception
    try:
        textContent = driver.find_element_by_xpath('//div[@role="alert"]/div').get_attribute('textContent')
        print(textContent)
        assert textContent == 'Your status is currently set to Do Not Disturb.Make Available'
    except AssertionError:
        print('设置免打扰模式后文本信息不正确')
        screen_shot_func(driver, '设置免打扰模式后文本信息不正确')
        raise AssertionError
    except Exception as e:
        print('设置免打扰模式后文本信息不正确', e)
        screen_shot_func(driver, '设置免打扰模式后文本信息不正确')
        raise Exception

def do_not_disturb_become_available(driver):
    """
    Do Not Disturb后设置为可用
    :param driver:
    :return:
    """
    try:
        ele_list = driver.find_elements_by_xpath(make_available_button)
        if len(ele_list) == 1:
            ele_list[0].click()
            ele_list = driver.find_elements_by_xpath(not_disturb)
            assert len(ele_list) == 1
    except AssertionError:
        screen_shot_func(driver,'make_available按钮依然存在')
        raise AssertionError
    except Exception as e:
        print('make_available失败',e)
        screen_shot_func(driver, 'make_available失败')
        raise Exception

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
    # public_check_element(driver, current_account, '点击我的账号失败')
    # public_check_element(driver, '//div[@class="dropdown open btn-group btn-group-lg btn-group-link"]', '展开我的账号失败',if_click=None, if_show=1)
    public_check_element(driver, '//span[contains(.,"My Account")]','进入My_Account_Settings页面失败')
    # 判断是否需要更改name
    name_attribute = driver.find_element_by_xpath(my_account_name).get_attribute('value')
    if name_attribute != change_name:
        try:
            driver.find_element_by_xpath(my_account_name).clear()
            time.sleep(2)
            driver.find_element_by_xpath(my_account_name).send_keys(change_name)
        except Exception as e:
            print('更改name失败',e)
            screen_shot_func(driver, '更改name失败')
            raise Exception
        else:
            print('更改name成功')
    # 判断是否需要更改avator
    if change_avator == 'change':
        driver.find_element_by_xpath('//input[@type="file"]').send_keys(picture_path)
    elif change_avator == 'delete':
        # 获取alert对话框的按钮，点击按钮，弹出alert对话框
        driver.find_element_by_xpath('//button[contains(.,"Remove avatar")]').click()
        time.sleep(1)
        driver.find_element_by_xpath('//button[@class="k-button k-primary ml-4" and text()="Ok"]').click()
        time.sleep(1)
    public_check_element(driver, '//button[@type="submit" and contains(.,"Update")]', '点击Update失败')
    for i in range(10):
        element_list = driver.find_elements_by_xpath('//div[@class="k-notification-content"]')
        if len(element_list) == 0:
            break
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
    try:
        ele_list = driver.find_elements_by_xpath('//div[@class="comment-text row"]')
        for i in range(len(ele_list)):
            get_comment = ele_list[i].get_attribute("textContent")   # 获取comment
            assert get_comment == args[i]
    except AssertionError:
        screen_shot_func(driver,'获取的comments和预期不符')
        raise AssertionError

def hang_up_the_phone(driver):
    """
    点击红色的挂断电话按钮
    :param driver:
    :return:
    """
    public_check_element(driver, end_call_button, '找不到挂断按钮')

def leave_call(driver,select_co_host = 'no_need_select',username = 'Huiming.shi.helplightning+EU2',call_time=20):
    """
    # Leave call
    :param driver:
    :param call_time:通话持续时间
    :param select_co_host:是否需要选择另一个共同主持；默认no_need_select不需要；need_select为需要
    :param username:需要设置为另一个共同主持的user name
    :return:
    """
    # 维持通话20s
    time.sleep(int(call_time))
    for i in range(5):
        ele_list = driver.find_elements_by_xpath(count_of_call_user)
        if len(ele_list) > 3:
            break
        elif 1 == 4:
            screen_shot_func(driver, '当前参与通话的人数不到2人')
            raise Exception
        else:
            time.sleep(1)
    # 点击红色的挂断电话按钮
    hang_up_the_phone(driver)
    # User Leave call
    try:
        for i in range(5):
            ele_list = driver.find_elements_by_xpath(visibility_finishi_call)
            ele_list_leave_call = driver.find_elements_by_xpath(leave_call_button)
            if len(ele_list) == 1 and len(ele_list_leave_call) == 1:
                ele_list_leave_call[0].click()
                break
            elif i == 4:
                print('找不到Leave_call按钮')
                raise Exception('找不到Leave_call按钮')
    except Exception as e:
        print('点击Leave_call失败', e)
        screen_shot_func(driver, '点击Leave_call失败')
        raise Exception
    if select_co_host == 'need_select':
        try:
            driver.find_element_by_xpath(f'//strong[text()="{username}"]/../../../../..//div[@class="react-toggle-track"]').click()
            time.sleep(2)
            driver.find_element_by_xpath(leave_call_button).click()
            time.sleep(1)
            ele_list = driver.find_elements_by_xpath(leave_call_button)
            assert len(ele_list) == 0
        except AssertionError:
            screen_shot_func(driver, '未选择另一个共同主持')
            raise Exception('未选择另一个共同主持')
        except Exception as e:
            print('选择另一个共同主持后点击Leave_call失败', e)
            screen_shot_func(driver, '选择另一个共同主持后点击Leave_call失败')
            raise Exception('选择另一个共同主持后点击Leave_call失败')

def exit_call(driver,call_time=20):
    """
    # 结束call
    :param driver:
    :return:
    """
    # 维持通话20s
    time.sleep(int(call_time))
    for i in range(5):
        ele_list = driver.find_elements_by_xpath(count_of_call_user)
        if len(ele_list) > 3:
            break
        elif 1 == 4:
            screen_shot_func(driver, '当前参与通话的人数不到2人')
            raise Exception
        else:
            time.sleep(1)
    # 点击红色的挂断电话按钮
    hang_up_the_phone(driver)
    # User exit call
    try:
        for i in range(5):
            ele_list = driver.find_elements_by_xpath(visibility_finishi_call)
            ele_list_yes = driver.find_elements_by_xpath(exit_call_yes)
            if len(ele_list_yes) == 1 and len(ele_list) == 1:
                ele_list_yes[0].click()    # 可能会报错Message: stale element reference: element is not attached to the page document，参考：https://blog.csdn.net/zhangvalue/article/details/102921631
                break
            elif i == 4:
                print('找不到Yes按钮')
                raise Exception('找不到Yes按钮')
            else:
                time.sleep(1)
    except Exception as e:
        print('点击Yes失败', e)
        screen_shot_func(driver, '点击Yes失败')
        raise Exception
    else:
        print('点击Yes成功')

def end_call_for_all(driver,call_time=30):
    """
    End Call for All
    :param driver:
    :return:
    """
    # 维持通话20s
    time.sleep(int(call_time))
    for i in range(5):
        ele_list = driver.find_elements_by_xpath(count_of_call_user)
        if len(ele_list) > 3:
            break
        elif 1 == 4:
            screen_shot_func(driver, '当前参与通话的人数不到3人')
            raise Exception
        else:
            time.sleep(1)
    # 点击红色的挂断电话按钮
    hang_up_the_phone(driver)
    # 点击End_Call_for_All
    try:
        for i in range(5):
            ele_list = driver.find_elements_by_xpath(visibility_finishi_call)
            ele_list_end_call = driver.find_elements_by_xpath(end_call_for_all_button)
            if len(ele_list) == 1 and len(ele_list_end_call) == 1:
                ele_list_end_call[0].click()
                break
            elif i == 4:
                print('找不到End_Call_for_All按钮')
                raise Exception('找不到End_Call_for_All按钮')
            else:
                time.sleep(15)
    except Exception as e:
        print('点击End Call for All失败', e)
        screen_shot_func(driver, '点击End_Call_for_All失败')
        raise Exception
    else:
        print('点击End Call for All成功')
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
        public_check_element(driver, page_tag_xpath, '当前页面与预期页面不一致', if_click=None, if_show=1)
    elif currently_on == 'not_currently_on':
        ele_list = driver.find_elements_by_xpath(page_tag_xpath)
        print(ele_list)
        try:
            assert len(ele_list) == 0
        except AssertionError:
            screen_shot_func(driver,'当前页面与预期页面不一致')
            raise AssertionError('当前页面与预期页面不一致')

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
    try:
        ele_list = driver.find_elements_by_xpath(tag_xpath)
        if len(ele_list) == 1:
            ele_tag = driver.find_element_by_xpath(tag_xpath)
            first_tag_text = ele_tag.get_attribute("textContent")
            print(first_tag_text)
            ele_tag.click()
        else:
            driver.find_element_by_xpath(add_tag_input).click()
            ele_tag = driver.find_element_by_xpath(tag_xpath)
            first_tag_text = ele_tag.get_attribute("textContent")
            print(first_tag_text)
            ele_tag.click()
    except Exception as e:
        print('添加tag失败',e)
        screen_shot_func(driver, '添加tag失败')
        raise Exception
    try:
        driver.find_element_by_xpath(add_comment).click()
        driver.find_element_by_xpath(add_comment).send_keys(which_comment)
        driver.find_element_by_xpath('//div[@class="call-info-form-group form-group"]//button[contains(.,"Save")]').click()
    except Exception as e:
        print('添加comment失败',e)
        screen_shot_func(driver, '添加comment失败')
        raise Exception
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
            driver.quit()
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
    count = driver.find_elements_by_xpath(accept_disclaimer)
    if len(count) == 1:  # close Disclaimer
        public_check_element(driver, accept_disclaimer, '接受免责声明失败')

def check_tag_and_com_switch_success(driver,has_tag = 0):
    """
    # 校验关闭Call tag and Comment配置项后，通话结束后没有tag和comment
    :param driver:
    :param has_tag:是否出现tag和comment，默认没出现;  0-不出现； 1-出现
    :return:
    """
    for i in range(3):
        count = driver.find_elements_by_xpath(five_star_high_praise)
        if len(count) == 1:
            break
        time.sleep(2)
    try:
        tag_count = driver.find_elements_by_xpath('//span[@class="k-widget k-multiselect k-header"]')
        print(tag_count)
        assert len(tag_count) == int(has_tag)
    except AssertionError:
        print(f'tag输入框的个数应该为{int(has_tag)}')
        screen_shot_func(driver, f'tag输入框的个数应该为{int(has_tag)}')
        raise AssertionError
    com_count = driver.find_elements_by_xpath(add_comment)
    print(len(com_count))
    try:
        assert len(com_count) == int(has_tag)
    except AssertionError:
        print(f'comment输入框的个数应该为{int(has_tag)}')
        screen_shot_func(driver, f'comment输入框的个数应该为{int(has_tag)}')
        raise AssertionError

def check_survey_switch_success(driver,status = '0',click_button = 'no_click'):
    """
    # 校验切换After Call: End of Call Survey配置项后，通话结束后有没有 a link to take a survey
    :param driver:
    :param status: ‘0’ or ‘1’；‘0’表示不出现，‘1’表示出现；默认为‘0’
    :param click_button:出现按钮后是否点击；默认不点击
    :return:
    """
    for i in range(3):
        count = driver.find_elements_by_xpath(five_star_high_praise)
        if len(count) == 1:
            break
        time.sleep(2)
    count = driver.find_elements_by_xpath(take_survey_after_call)
    if status == '0':
        try:
            assert len(count) == 0
        except AssertionError:
            print('不该出现take survey按钮的')
            screen_shot_func(driver, '不该出现take_survey按钮的')
            raise AssertionError
    elif status == '1':
        try:
            assert len(count) == 1
            if click_button == 'click':
                driver.find_element_by_xpath(take_survey_after_call).click()
                time.sleep(6)       # 等待Survey页面加载出来
        except AssertionError:
            print('该出现take survey按钮的')
            screen_shot_func(driver, '该出现take_survey按钮的')
            raise AssertionError
        except Exception as e:
            print('点击take_survey按钮失败',e)
            screen_shot_func(driver, '点击take_survey按钮失败')
            raise Exception

def close_call_ending_page(driver):
    """
    # 关闭通话结束展示页面
    :param driver:
    :return:
    """
    switch_to_last_window(driver)  # 切换到最新页面
    try:
        ele_list = driver.find_elements_by_xpath('//div[@class="EndCallPageContent"]//span[@role="presentation"]')
        if len(ele_list) == 1:
            print('可以关闭通话结束页面')
            ele_list[0].click()
        elif len(ele_list) == 0:
            print('没有通话结束页面')
    except Exception as e:
        print('关闭通话结束页面失败',e)
        screen_shot_func(driver, '关闭通话结束页面失败')
        raise Exception

def check_tutorial_screen_shows_up(driver):
    """
    # After ending call,	VP: The tutorial screen shows up.
    :param driver:
    :return:
    """
    try:
        count = driver.find_elements_by_xpath(close_tutorial_button)
        assert len(count) == 1
    except AssertionError:
        print('该出现tutorial的')
        screen_shot_func(driver, '该出现tutorial的')
        raise AssertionError

def paste_on_a_non_windows_system(driver,paste_xpath):
    """
    非windows系统上粘贴
    :param driver:
    :param paste_xpath:需要进行粘贴的元素的xpath
    :return:
    """
    try:
        ele = driver.find_element_by_xpath(paste_xpath)
        actions = ActionChains(driver)
        actions.move_to_element(ele)
        actions.click(ele)  # select the element where to paste text
        actions.key_down(Keys.META)
        actions.send_keys('v')
        actions.key_up(Keys.META)
        actions.perform()
    except Exception as e:
        print('非Windows操作系统粘贴失败',e)
        screen_shot_func(driver, '非Windows操作系统粘贴失败')
        raise Exception
    else:
        print('非Windows操作系统粘贴成功')

def send_meeting_room_link(driver,which_meeting,if_send = 'no_send'):
    """
    # User发起MHS或者OTU会议，并且检查link的复制粘贴功能是否OK
    :param driver:
    :param which_meeting: MHS或者OTU
    :param if_send: 是否发送，‘send’表示发送，‘no_send’表示不发送，默认为no_send
    :return: MHS或者OTU会议的link
    """
    public_check_element(driver, send_my_help_space_invitation, '打开Send_My_Help_Space_Invitation窗口失败')
    try:
        if which_meeting == 'MHS':
            # 去勾选
            text_value = driver.find_element_by_xpath(checkbox_xpath).get_attribute('value')
            if text_value == 'true':
                driver.find_element_by_xpath(checkbox_xpath).click()
                time.sleep(2)
        elif which_meeting == 'OTU':
            # 勾选
            text_value = driver.find_element_by_xpath(checkbox_xpath).get_attribute('value')
            if text_value == 'false':
                driver.find_element_by_xpath(checkbox_xpath).click()
                time.sleep(2)
    except Exception as e:
        print(f'选择{which_meeting}_link失败', e)
        screen_shot_func(driver, f'选择{which_meeting}_link失败')
        raise Exception
    # 复制
    for i in range(5):
        text = driver.find_element_by_xpath('//div[@class="invite-link"]').get_attribute("textContent")
        print(text)
        if text.startswith(r'https://'):
            break
        elif i == 4:
            screen_shot_func(driver,'url信息未出现')
            raise Exception
        else:
            time.sleep(10)
    public_check_element(driver, '//i[@class="far fa-copy "]', '复制按钮未出现')
    sys_type = get_system_type()
    try:
        if sys_type == 'Windows':
            try:
                ele = driver.find_element_by_xpath(my_help_space_message)
                ele.click()
                ele.send_keys(Keys.CONTROL, 'v')
            except Exception as e:
                print('Windows操作系统粘贴失败',e)
                screen_shot_func(driver, 'Windows操作系统粘贴失败')
                raise Exception
            else:
                print('Windows操作系统粘贴成功')
        else:
            paste_on_a_non_windows_system(driver, my_help_space_message)
    except Exception as e:
        print('粘贴失败', e)
        screen_shot_func(driver, '粘贴失败')
        raise Exception
    # 验证复制后粘贴结果正确
    invite_url = driver.find_element_by_xpath(get_invite_link).get_attribute("textContent")  # Get the invitation link
    print('复制的link为:',invite_url)
    attribute = driver.find_element_by_xpath(my_help_space_message).get_attribute('value')
    print('粘贴的link为:',attribute)
    try:
        assert attribute == invite_url     # 验证复制后粘贴结果正确
    except AssertionError:
        print('复制和粘贴内容不一致')
        screen_shot_func(driver, '复制和粘贴内容不一致')
        raise AssertionError
    # Send Invite
    if if_send == 'send':
        try:
            # 输入email
            email_ele = driver.find_element_by_xpath(send_link_email_input)
            email_ele.click()
            email_ele.send_keys('Huiming.shi.helplightning+123456789@outlook.com')
            # 点击Send Invite按钮
            driver.find_element_by_xpath(send_link_send_invite).click()
        except Exception as e:
            print('点击Send Invite按钮失败',e)
            screen_shot_func(driver, '点击Send_Invite按钮失败')
            raise Exception
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
        driver.find_element_by_xpath(contacts_page).click()      # 进入Contacts页面
        time.sleep(2)
        driver.find_element_by_xpath(recents_page).click()      # 进入Recents页面
        time.sleep(5)
    except Exception as e:
        print('切换页面失败',e)
        screen_shot_func(driver, '切换页面失败')
        raise Exception
    time_started = 'there is no call record'
    count = driver.find_elements_by_xpath(first_time_call_started)
    if len(count) != 0:
        try:
            time_started = driver.find_element_by_xpath(first_time_call_started).get_attribute("textContent")
        except Exception as e:
            print('获取最近一次通话开始时间失败',e)
            screen_shot_func(driver, '获取最近一次通话开始时间失败')
            raise Exception
    return time_started

def get_recents_page_records_occurred_time(driver,rows = '2'):
    """
    获取Recents页面前n行数据的Occurred time列表
    :param driver:
    :param rows: 前多少行；默认为前两行；
    :return:前n行数据的Occurred time列表
    """
    occurred_time_list = []
    try:
        for i in range(int(rows)):
            ele_list = driver.find_elements_by_xpath(f'//div[@row-index="{i}"]/div[@col-id="timeCallStarted"]')
            if len(ele_list) >= 1:
                occurred_time = driver.find_element_by_xpath(f'//div[@row-index="{i}"]/div[@col-id="timeCallStarted"]').get_attribute("textContent")
                occurred_time_list.append(occurred_time)
            else:
                driver.find_element_by_xpath('//button[text()="Refresh"]').click()
                occurred_time = driver.find_element_by_xpath(f'//div[@row-index="{i}"]/div[@col-id="timeCallStarted"]').get_attribute("textContent")
                occurred_time_list.append(occurred_time)
    except Exception as e:
        screen_shot_func(driver,f'获取Recents页面前{int(rows)}行数据的Occurred_time失败')
        raise (f'获取Recents页面前{int(rows)}行数据的Occurred_time失败',e)
    return occurred_time_list

def two_list_has_one_same_element(driver,list1,list2):
    """
    获取Recents页面前n行数据的Occurred time列表，判断是否新增了数据
    :param driver:
    :param list1:
    :param list2:
    :return:
    """
    try:
        assert list1[0] == list2[-1]
    except AssertionError:
        screen_shot_func(driver,'两组数据没有重复的记录')
        raise AssertionError

def click_switch_ws_button(driver):
    """
    点击切换workspace按钮
    :param driver:
    :return:
    """
    public_check_element(driver, '//span[@role="listbox"]//i', '点击切换workspace按钮失败')
    time.sleep(2)

def user_switch_to_first_workspace(driver):
    """
    # switch to first workspace
    :param driver:
    :return:
    """
    # 点击切换WS按钮
    click_switch_ws_button(driver)
    public_check_element(driver, '//div[@class="k-list-scroller"]//li[1]', '切换到第一个workspace失败')
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
    public_check_element(driver, f'//div[@class="k-list-scroller"]//li[contains(.,"{which_ws}")]', f'切换到{which_ws}失败')
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

def different_page_search_single_users(driver,which_page,search_input_xpath,data_count_xpath,search_user):
    """
    在不同的页面进行user查询
    :param driver:
    :param which_page: 哪个页面
    :param search_input_xpath: 查询框的xpath
    :param data_count_xpath: 展示的data数对应的xpath
    :param search_user: 要查询的用户
    :return:
    """
    try:
        ele = driver.find_element_by_xpath(search_input_xpath)
        ele.clear()
        time.sleep(1)
        ele.click()
        ele.send_keys(search_user)
        for i in range(2):
            element_list = driver.find_elements_by_xpath(data_count_xpath)
            if len(element_list) == 1:
                break
            else:
                time.sleep(1)
    except Exception as e:
        screen_shot_func(driver, f'在{which_page}页面查询用户失败')
        raise Exception(f'在{which_page}页面查询用户失败',e)
    else:
        print(f'在{which_page}页面查询用户成功')

def judge_reachable_or_not(driver,data_count_xpath,unreachable = 'unreachable'):
    """
    判断用户是否reachable
    :param driver:
    :param data_count_xpath: 数据对应的xpath
    :param unreachable: 是否unreachable，默认为unreachable
    :return:
    """
    attr_xpath = data_count_xpath + '/div[@col-id="name"]'
    # 等待数据出现
    public_check_element(driver, attr_xpath, '数据未出现', if_click = None)
    class_attr = driver.find_element_by_xpath(attr_xpath).get_attribute('class')
    print(class_attr)
    if unreachable == 'unreachable':
        try:
            assert 'unreachableText' in class_attr
        except AssertionError:
            screen_shot_func(driver, '本该置灰user却没置灰')
            raise AssertionError('本该置灰展示user的，但没置灰展示')
    elif unreachable == 'reachable':
        try:
            assert 'unreachableText' not in class_attr
        except AssertionError:
            screen_shot_func(driver, '不该置灰user却置灰了')
            raise AssertionError('本不该置灰展示user的，但置灰展示了')

def judge_reachable_in_recents(driver,username):
    """
    判断在Recents页面，用户展示reachable
    :param driver:
    :param username: 需要校验的user的username
    :return:
    """
    try:
        class_attr = driver.find_element_by_xpath(f'//div[@class="cardName" and contains(.,"{username}")]/../../../..').get_attribute('class')
        print(class_attr)
        assert 'unreachable' not in class_attr
    except AssertionError:
        print('本不该置灰展示user的，但置灰展示了')
        screen_shot_func(driver, '不该置灰user却置灰了')
        raise AssertionError

def logout_citron(driver):
    """
    logout from citron
    :param driver:
    :return:
    """
    public_check_element(driver, current_account, '点击我的账号失败')
    public_check_element(driver, log_out_button, '点击退出按钮失败')
    try:
        element_list = driver.find_elements_by_xpath(username_input)
        assert len(element_list) == 1
    except AssertionError:
        screen_shot_func(driver, '退出登录后不是登录页面')
        raise AssertionError

def re_login_citron(driver,username,password='*IK<8ik,8ik,'):
    try:  # enter email
        driver.find_element_by_xpath(username_input).click()
        driver.find_element_by_xpath(username_input).send_keys(username)
        driver.find_element_by_xpath(submit_button).click()
    except Exception as e:
        print('登陆时输入email失败', e)
        screen_shot_func(driver, '登陆时输入email失败')
        raise Exception
    try:  # enter password
        driver.find_element_by_xpath(password_input).click()
        driver.find_element_by_xpath(password_input).send_keys(password)
        driver.find_element_by_xpath(submit_button).click()
    except Exception as e:
        print('登陆时输入password失败', e)
        screen_shot_func(driver, '登陆时输入password失败')
        raise Exception
    try: # 获取登陆失败的提示信息
        ele_list = driver.find_elements_by_xpath('//span[text()="Authentication Failed"]')
        assert len(ele_list) == 1
    except AssertionError:
        print('没出现登陆失败的提示信息Authentication Failed')
        raise AssertionError

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
    try:
        if whitch_setting == 'Workspace Settings':
            ele_list = driver.find_elements_by_xpath('//h1[text()="Workspace Settings"]')
            assert len(ele_list) == 1
        elif whitch_setting == 'Settings':
            ele_list = driver.find_elements_by_xpath('//h1[text()="Debug Tools"]')
            assert len(ele_list) == 1
    except AssertionError:
        screen_shot_func(driver,f'未进入{whitch_setting}页面')
        raise AssertionError

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
        driver.find_element_by_xpath(f'//div[@role="tree"]/div[{int(which_tree)}]').click()
    try:
        driver.find_element_by_xpath(f'//span[contains(.,"{switch_page}")]').click()
        for i in range(5):
            element_list = driver.find_elements_by_xpath(switch_success_tag)
            if len(element_list) == 1:
                time.sleep(2)
                element_list_data = driver.find_elements_by_xpath(data_show)
                if len(element_list_data) > 0:
                    break
                elif i == 4:
                    print(f'切换到{switch_page}页面后数据未加载出')
                    if switch_page == 'Recents':
                        driver.find_element_by_xpath('//button[text()="Refresh"]').click()
                        public_check_element(driver, data_show, f'刷新{switch_page}页面后数据仍然未加载出', if_click=0, if_show=1)
                else:
                    time.sleep(1)
            elif i == 4:
                print(f'未切换到{switch_page}页面')
                raise Exception(f'未切换到{switch_page}页面')
            else:
                time.sleep(1)
    except Exception as e:
        print(f'切换到{switch_page}页面失败',e)
        screen_shot_func(driver, f'切换到{switch_page}页面失败')
        raise Exception(f'切换到{switch_page}页面失败')
    else:
        print(f'切换到{switch_page}页面成功')

def get_all_data_on_the_page(driver,search_key = 'cardName'):
    """
    获取当前页面的所有user数据
    :param driver:
    :param search_key:xpath中的关键值，普通页面（Directory或者Users页面）和通话中邀请第三位用户的页面的user对应的xpath不同
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
        ele_list_1 = driver.find_elements_by_xpath(f'//div[@class="ag-center-cols-container"]/div[@row-index="{i}"]//div[@class="{search_key}"]')   # 取每次循环的第一行数据（每5条数据一次循环）
        ele_list_2 = driver.find_elements_by_xpath(f'//div[@class="ag-center-cols-container"]/div[@row-index="{i+4}"]//div[@class="{search_key}"]')   # 取每次循环的最后一行数据（每5条数据一次循环）
        if len(ele_list_1) == 1 and len(ele_list_2) == 1:  # 如果当前循环下，首条和尾条数据都存在，就获取name放到user_list中
            for j in range(i,i+5):  # 获取5条数据的name放到user_list中
                get_name = driver.find_element_by_xpath(f'//div[@class="ag-center-cols-container"]/div[@row-index="{j}"]//div[@class="{search_key}"]').get_attribute("textContent")
                user_list.append(get_name)
            i = i + 5   # 设置每5次一个循环
            print(i)
        else:
            # 如果当前循环下，尾条数据不存在，就进行向下滑动(每次向下滑动 当前浏览器的高度像素的四分之一)
            quarter_of_the_height_n = quarter_of_the_height_n + quarter_of_the_height
            js = f'document.getElementsByClassName("ag-body-viewport ag-layout-normal ag-row-no-animation")[0].scrollTop={quarter_of_the_height_n}'
            driver.execute_script(js)
            # 判断滑动后，尾条数据是否还能展示
            print(i+4)
            ele_list_3 = driver.find_elements_by_xpath(f'//div[@class="ag-center-cols-container"]/div[@row-index="{i+4}"]//div[@class="{search_key}"]')
            # 滑动后，尾条数据不展示
            if len(ele_list_3) != 1:
                # 判断尾条前一条数据是否展示
                print(i + 3)
                ele_list_3 = driver.find_elements_by_xpath(f'//div[@class="ag-center-cols-container"]/div[@row-index="{i+3}"]//div[@class="{search_key}"]')
                # 数据不展示，就打印下数据不展示
                if len(ele_list_3) != 1:
                    print(f'{i+4}行元素不显示了')
                # 数据展示，就把最后一轮循环的数据添加到user_list中
                else:
                    print(f'添加到{i+4}行数据')
                    for j in range(i, i + 4):
                        get_name = driver.find_element_by_xpath(f'//div[@class="ag-center-cols-container"]/div[@row-index="{j}"]//div[@class="{search_key}"]').get_attribute("textContent")
                        user_list.append(get_name)
                    break
                # 后面都是这个逻辑，往前推一个数据进行判断
                print(i + 2)
                ele_list_3 = driver.find_elements_by_xpath(f'//div[@class="ag-center-cols-container"]/div[@row-index="{i+2}"]//div[@class="{search_key}"]')
                if len(ele_list_3) != 1:
                    print(f'{i+3}行元素不显示了')
                else:
                    print(f'添加到{i+3}行数据')
                    for j in range(i, i + 3):
                        get_name = driver.find_element_by_xpath(f'//div[@class="ag-center-cols-container"]/div[@row-index="{j}"]//div[@class="{search_key}"]').get_attribute("textContent")
                        user_list.append(get_name)
                    break
                print(i + 1)
                ele_list_3 = driver.find_elements_by_xpath(f'//div[@class="ag-center-cols-container"]/div[@row-index="{i+1}"]//div[@class="{search_key}"]')
                if len(ele_list_3) != 1:
                    print(f'{i+2}行元素不显示了')
                else:
                    print(f'添加到{i+2}行数据')
                    for j in range(i, i + 2):
                        get_name = driver.find_element_by_xpath(f'//div[@class="ag-center-cols-container"]/div[@row-index="{j}"]//div[@class="{search_key}"]').get_attribute("textContent")
                        user_list.append(get_name)
                    break
                print(i)
                ele_list_3 = driver.find_elements_by_xpath(f'//div[@class="ag-center-cols-container"]/div[@row-index="{i}"]//div[@class="{search_key}"]')
                if len(ele_list_3) != 1:
                    print(f'{i+1}行元素不显示了')
                else:
                    print(f'添加到{i+1}行数据')
                    get_name = driver.find_element_by_xpath(f'//div[@class="ag-center-cols-container"]/div[@row-index="{i}"]//div[@class="{search_key}"]').get_attribute("textContent")
                    user_list.append(get_name)
                    break
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

def can_connect_call_or_not(driver,user_name,can_connect = 'can_not_connect',send_invite = 'send_invite'):
    """
    判断在Recents页面点击Call按钮能否打通这个Call
    :param driver:
    :param user_name: 想要点击的name
    :param can_connect: 是否可以打通；默认不能打通('can_not_connect'),can_connect为可以打通
    :param send_invite: 不能打通时，是否需要发送邀请
    :return:
    """
    try:
        driver.find_element_by_xpath(f'//div[@class="cardName" and contains(.,"{user_name}")]/../../../..//button[contains(.,"Call")]').click()
    except Exception as e:
        print('点击call按钮失败', e)
        screen_shot_func(driver,'点击call按钮失败')
        raise Exception
    if can_connect == 'can_not_connect':
        for i in range(2):
            ele_list = driver.find_elements_by_xpath(send_invite_button)
            if len(ele_list) == 1:
                break
            else:
                time.sleep(1)
            try:
                print(i)
                assert i != 2
            except AssertionError:
                screen_shot_func(driver, '没出现Send_Invite按钮')
                raise AssertionError('应该不可以启动电话的，但现在没出现Send Invite按钮')
    elif can_connect == 'can_connect':
        try:
            ele_list = driver.find_elements_by_xpath(end_call_before_connecting)
            assert len(ele_list) == 1
        except AssertionError:
            screen_shot_func(driver, '应该可以打通但没打通')
            raise AssertionError('应该可以打通但没打通')
    if send_invite == 'send_invite':
        public_check_element(driver, send_invite_button, '点击Send_Invite按钮失败')

def anonymous_user_call_can_not_call_again(driver):
    """
    判断在Recents页面，匿名用户的通话记录没有Call按钮
    :param driver:
    :return:
    """
    ele_list = driver.find_elements_by_xpath('//div[@title="Anonymous User"]/../../../..//button[@class="k-button callButton"]')
    try:
        assert len(ele_list) == 0
    except AssertionError:
        print('Anonymous User有Call按钮', e)
        screen_shot_func(driver, 'Anonymous_User有Call按钮')
        raise AssertionError

def first_call_record_tag_and_comment(driver,expect_tag,*args):
    """
    检查首行call记录的tag和comment是否正确
    :param driver:
    :param expect_tag: 预期的tag名称
    :return:
    """
    # 获取首行call记录的tag
    print(expect_tag)
    try:
        for i in range(3):
            get_tag = driver.find_element_by_xpath('//div[@class="ag-center-cols-container"]/div[@row-index="0"]/div[@col-id="tags"]').get_attribute('textContent')
            print(get_tag)
            if get_tag == expect_tag:
                break
            else:
                time.sleep(2)
            if i == 2:
                print('tag与预期不一致')
                raise AssertionError
    except AssertionError:
        screen_shot_func(driver,'tag与预期不一致')
        raise AssertionError('tag与预期不一致')
    except Exception as e:
        print('获取首行call记录的tag失败',e)
        screen_shot_func(driver,'获取首行call记录的tag失败')
        raise Exception('获取首行call记录的tag失败')
    # 点击首行数据的Details按钮
    click_first_line_details(driver)
    # 获取首行call记录的comment列表
    comment_ele_list = driver.find_elements_by_xpath('//div[@class="comment-text row"]')
    i = 0
    for ele in comment_ele_list:
        comment_text = ele.get_attribute('textContent')
        try:
            print(args[i],comment_text)
            assert args[i] == comment_text
            i = i + 1
        except AssertionError:
            screen_shot_func(driver,'comment与预期不一致')
            raise AssertionError('comment与预期不一致')
    # 关闭Details页面
    close_details_page(driver)

def get_all_tag_after_call(driver):
    """
    在通话结束页面，获取所有的tags
    :param driver:
    :return:
    """
    tag_list = []
    try:
        driver.find_element_by_xpath(add_tag_input).click()    # 点击Add tags
        ele_list = driver.find_elements_by_xpath(f'//div[@class="k-list-scroller"]//li')
        for ele in ele_list:
            get_tag = ele.get_attribute("textContent")
            print(get_tag)
            tag_list.append(get_tag)
    except Exception as e:
        print('获取所有的tags失败',e)
        screen_shot_func(driver,'获取所有的tags失败')
        raise Exception
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
    try:
        ele = driver.find_element_by_xpath(witch_xpath)
        css_value = ele.value_of_css_property(which_CSS)
        print(css_value)
        return css_value
    except Exception as e:
        print('获取css属性值失败',e)
        screen_shot_func(driver,'获取css属性值失败')
        raise Exception

def check_contacts_list(driver,*args):
    """
    获取并检查Contacts页面的name列表
    :param driver:
    :param args: 预期的name列表
    :return:
    """
    try:
        ele_list = driver.find_elements_by_xpath('//div[@class="ag-center-cols-container"]/div//div[@class="cardName"]')
        print(ele_list)
        if len(args) != 0:
            for i in range(len(ele_list)):
                user_name = ele_list[i].get_attribute('textContent')
                assert user_name == args[i]
        elif len(args) == 0:
            assert len(ele_list) == 0
    except AssertionError:
        screen_shot_func(driver,'contacts列表name与预期不符')
        raise AssertionError
    except Exception as e:
        print('获取contacts列表的name出错',e)
        screen_shot_func(driver, '获取contacts列表的name出错')
        raise Exception

def reset_disclaimer(driver):
    """
    Reset_All_Accepted_Disclaimers
    :param driver:
    :return:
    """
    public_check_element(driver, "//button[contains(.,'Reset All Accepted Disclaimers')]", '点击重置Disclaimer按钮失败')
    public_check_element(driver, '//div[@role="dialog"]//button[text()="OK"]', '重置Disclaimer时点击OK按钮失败')
    try:
        ele_list = driver.find_elements_by_xpath("//button[text()='Reset All Accepted Disclaimers']")
        assert len(ele_list) == 1
    except AssertionError:
        screen_shot_func(driver, 'Reset_All_Accepted_Disclaimers未生效')
        raise AssertionError
    public_check_element(driver, "//button[text()='Reset All Accepted Disclaimers']", 'Disclaimer提示信息未散去', if_click=None,if_show=None)

def refresh_browser_page(driver,close_tutorial = 'close_tutorial'):
    """
    刷新浏览器的某个页面
    :param driver:
    :param close_tutorial: 是否关闭导航页面；默认关闭
    :return:
    """
    try:
        driver.refresh()
    except Exception as e:
        print('refresh_fail',e)
        screen_shot_func(driver,'refresh_fail')
        raise Exception('refresh_fail')
    time.sleep(5)
    if close_tutorial == 'close_tutorial':
        ele_list = driver.find_elements_by_xpath(close_tutorial_button)
        if len(ele_list) == 1:
            try:  # close Tutorial
                ele_list[0].click()
            except Exception as e:
                print('关闭教程失败', e)
                screen_shot_func(driver, '关闭教程失败')
                raise Exception
            else:
                print('关闭教程成功')

def disclaimer_should_be_shown_up_or_not(driver,appear = 'appear'):
    """
    # Disclaimer should be shown up or not
    :param driver:
    :param appear: 是否出现Disclaimer，默认为出现：appear；不出现：not_appear
    :return:
    """
    try:
        ele_list = driver.find_elements_by_xpath("//button[contains(.,'ACCEPT')]")
        if appear == 'appear':
            assert len(ele_list) == 1
        elif appear == 'not_appear':
            assert len(ele_list) == 0
    except AssertionError:
        screen_shot_func(driver,'disclaimer是否出现与预期不符合')
        raise AssertionError

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
        # driver.find_element_by_xpath(debug_tools_close_xpath).click()
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
    try:
        for i in range(count):
            ele_list = driver.find_elements_by_xpath(f'//div[@row-index="{i}"]//div[@class="cardName"]')
            if len(ele_list) == 1:
                name = driver.find_element_by_xpath(f'//div[@row-index="{i}"]//div[@class="cardName"]').get_attribute("textContent")
                assert name == args[i]
            else:
                driver.find_element_by_xpath('//button[text()="Refresh"]').click()
                name = driver.find_element_by_xpath(f'//div[@row-index="{i}"]//div[@class="cardName"]').get_attribute("textContent")
                assert name == args[i]
    except AssertionError:
        print('recents页面预期name和实际不一致')
        screen_shot_func(driver,'recents页面预期name和实际不一致')
        raise AssertionError
    except Exception as e:
        print('recents页面没有这一行数据',e)
        screen_shot_func(driver, 'recents页面没有这一行数据')
        raise Exception

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
    try:
        get_text = driver.find_element_by_xpath(ele_xpath).get_attribute('textContent')
        return get_text
    except  Exception:
        screen_shot_func(driver, f'获取元素的文本值失败')
        raise  Exception

def get_ele_class_name(driver,ele_xpath,class_name):
    """
    获取元素的属性{class_name}值
    :param driver:
    :param ele_xpath: 元素的xpath
    :param class_name: 元素的具体属性
    :return:
    """
    try:
        get_class_value = driver.find_element_by_xpath(ele_xpath).get_attribute(f'{class_name}')
        print(f'{class_name}的value是:',get_class_value)
        return get_class_value
    except Exception:
        screen_shot_func(driver,f'获取元素的属性{class_name}值失败')
        raise Exception

def get_picture_path(picture_name = 'avatar1.jpg'):
    """
    # 获取avatar1.jpg绝对路径
    :return: avatar1.jpg绝对路径
    """
    dir_path = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
    print('当前目录绝对路径:',dir_path)
    system_type = get_system_type()
    if system_type == 'Windows':
        dir_list = dir_path.split('\\')
        print(dir_list)
        del dir_list[-1]
        del dir_list[-1]
        dir_list[-1] = 'publicData'
        join_str = '\\\\'
        final_path = join_str.join(dir_list)
        # modify_picture_path = final_path + '\\\\modify_picture.jpg'
        modify_picture_path = final_path + f'\\\\{picture_name}'
        return  modify_picture_path
    else:
        dir_list = dir_path.split('/')
        print(dir_list)
        del dir_list[-1]
        del dir_list[-1]
        dir_list[-1] = 'publicData'
        join_str = '//'
        final_path = join_str.join(dir_list)
        print(final_path)
        # modify_picture_path = final_path + '//modify_picture.jpg'
        modify_picture_path = final_path + f'//{picture_name}'
        print(modify_picture_path)
        return modify_picture_path

if __name__ == '__main__':
    print()