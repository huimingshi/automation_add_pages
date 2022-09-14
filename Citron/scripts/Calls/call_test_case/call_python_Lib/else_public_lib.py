#----------------------------------------------------------------------------------------------------#
import time
from Citron.public_switch.pubLib import *
from Citron.public_switch.public_switch_py import *
from public_settings_and_variable import *
from selenium.webdriver.common.keys import Keys
from selenium.webdriver.common.action_chains import ActionChains
from selenium.webdriver.support.select import Select
from Citron.scripts.Calls.call_test_case.call_python_Lib.login_lib import start_an_empty_window as SAEW

#----------------------------------------------------------------------------------------------------#
# define python Library
def switch_to_last_window(driver):
    """
    # 切换到最新页面
    :param driver:
    :return:
    """
    driver.switch_to.window(driver.window_handles[-1])  # 切换到最新页面

def suspension_of_the_mouse(driver,username):
    """
    # 鼠标悬浮
    :param driver:
    :param username: 用户名
    :return:
    """
    ellipsis_xpath = f'//div[@title="{username}"]/../../../..//div[@class="ellipsis-menu-div"]'
    ellipsis = get_xpath_element(driver, ellipsis_xpath, description='悬浮按钮')
    ActionChains(driver).move_to_element(ellipsis).perform()

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

def scroll_into_view(driver,ele_xpath):
    """
    根据xpath滑动到元素可见
    :param driver:
    :param ele_xpath:
    :return:
    """
    element = driver.find_element_by_xpath(ele_xpath)
    driver.execute_script('arguments[0].scrollIntoView();', element)

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
    退出多有的浏览器驱动
    :param args:
    :return:
    """
    # exit driver
    kill_all_browser()

def exit_one_driver(*args):
    """
    退出单个浏览器驱动
    :param args:
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
        user_xpath = f'//div[@id="user-tabs-pane-{which_page.lower()}"]//div[@title="{search_user}"]'
        element_list = get_xpath_elements(driver,user_xpath)
        print(len(element_list))
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
    user_xpath = f'//div[@id="user-tabs-pane-{which_page.lower()}"]//div[@title="{which_user}"]/../../..'
    # 等待数据出现
    public_check_element(driver, user_xpath, '数据未出现', if_click = None)
    class_attr = get_xpath_element(driver,user_xpath,ec='ec').get_attribute('class')
    print(class_attr)
    if unreachable == 'unreachable':
        public_assert(driver,'unreachableText',class_attr,condition='in',action='本该置灰user却没置灰')
    elif unreachable == 'reachable':
        public_assert(driver, 'unreachableText', class_attr, condition='not in', action='不该置灰user却置灰了')

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
    """
    重新登录
    :param driver:
    :param username: 用户名
    :param password: 密码，默认*IK<8ik,8ik,
    :return:
    """
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
        if witch_page == 'Directory' or witch_page == 'Team':
            ele_list_1 = driver.find_elements_by_xpath(f'//div[@id="user-tabs-pane-{witch_page.lower()}"]//div[@class="ag-center-cols-container"]/div[@row-index="{i}"]//div[@class="{search_key}"]')  # 取每次循环的第一行数据（每4条数据一次循环）
            ele_list_2 = driver.find_elements_by_xpath(f'//div[@id="user-tabs-pane-{witch_page.lower()}"]//div[@class="ag-center-cols-container"]/div[@row-index="{i + 3}"]//div[@class="{search_key}"]')  # 取每次循环的最后一行数据（每4条数据一次循环）
        else:
            ele_list_1 = driver.find_elements_by_xpath(f'//div[@class="ag-center-cols-container"]/div[@row-index="{i}"]//div[@class="{search_key}"]')   # 取每次循环的第一行数据（每4条数据一次循环）
            ele_list_2 = driver.find_elements_by_xpath(f'//div[@class="ag-center-cols-container"]/div[@row-index="{i+3}"]//div[@class="{search_key}"]')   # 取每次循环的最后一行数据（每4条数据一次循环）
        if len(ele_list_1) == 1 and len(ele_list_2) == 1:  # 如果当前循环下，首条和尾条数据都存在，就获取name放到user_list中
            print('获取一轮4条数据')
            if witch_page == 'Directory' or witch_page == 'Team':
                for j in range(i,i+4):  # 获取4条数据的name放到user_list中
                    get_name = get_xpath_element(driver,f'//div[@id="user-tabs-pane-{witch_page.lower()}"]//div[@class="ag-center-cols-container"]/div[@row-index="{j}"]//div[@class="{search_key}"]').get_attribute("textContent")
                    get_name = get_name.split(' ')[0]
                    user_list.append(get_name)
            else:
                for j in range(i, i + 4):  # 获取4条数据的name放到user_list中
                    get_name = get_xpath_element(driver,f'//div[@class="ag-center-cols-container"]/div[@row-index="{j}"]//div[@class="{search_key}"]').get_attribute("textContent")
                    get_name = get_name.split(' ')[0]
                    user_list.append(get_name)
            # user_list.append(get_name)
            i = i + 4   # 设置每4次一个循环
            print(i)
        else:
            # 如果当前循环下，尾条数据不存在，就进行向下滑动(每次向下滑动 当前浏览器的高度像素的四分之一)
            quarter_of_the_height_n = quarter_of_the_height_n + quarter_of_the_height
            if witch_page == 'Directory' or witch_page == 'Team':
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
                        get_name = get_name.split(' ')[0]
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
                        get_name = get_name.split(' ')[0]
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
                        get_name = get_name.split(' ')[0]
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

def contacts_page_send_email(driver,username):
    """
    在Favorites/Team/Personal/Directory页面点击Invite按钮
    :param driver:
    :param username:
    :return:
    """
    # 鼠标悬浮
    suspension_of_the_mouse(driver, username)
    # 选择Invite
    invite_xpath = f'//div[@title="{username}"]/../../../..//div[@class="button invite-btn-container"]'
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
    # 鼠标悬浮
    suspension_of_the_mouse(driver, user_name)
    # 选择Audio
    audio_xpath = f'//div[contains(.,"{user_name}")]/../../../..//span[text()="Audio+"]/..'
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
        public_click_element(driver, '//div[@class="modal-content"]//button[text()="Cancel"]', description='点击取消Send_Invite按钮失败')

def get_css_value(driver,witch_xpath,which_CSS):
    """
    获取CSS属性值
    :param driver:
    :param witch_xpath: 哪个xpath
    :param which_CSS: 想获取哪一个CSS
    :return:
    """
    ele = get_xpath_element(driver,witch_xpath,description = f'{witch_xpath}的css属性值',ec='ec')
    css_value = ele.value_of_css_property(which_CSS)
    print(css_value)
    return css_value

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

def close_tutorial_action(driver):
    """
    关闭导航页面
    :param driver:
    :return:
    """
    ele_list = get_xpath_elements(driver, close_tutorial_button)
    if len(ele_list) == 1:
        public_click_element(driver, close_tutorial_button, description='close_tutorial按钮')  # 刷新页面后关闭教程

def refresh_browser_page(driver,close_tutorial = 'close_tutorial'):
    """
    刷新浏览器的某个页面
    :param driver:
    :param close_tutorial: 是否关闭导航页面；默认关闭
    :return:
    """
    driver.refresh()
    time.sleep(10)
    if close_tutorial == 'close_tutorial':
        close_tutorial_action(driver)

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

def erase_my_account(driver):
    """
    两次点击Erase My Account按钮去确认删除账号
    :param driver:
    :return:
    """
    for i in range(2):
        public_check_element(driver, '//button[text()="Erase My Account"]', '两次点击Erase_My_Account失败')
        time.sleep(1)

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
    driver = SAEW()
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
    public_check_element(driver, search_by_email, 'search_by_enail输入框未出现')
    public_click_element(driver, search_by_email,description = '根据email查询框')
    email_input = get_xpath_element(driver, search_by_email,description = '根据email查询框')
    email_input.send_keys(call_user)
    call_button = get_xpath_element(driver, '//button[@id="call-btn"]',description = 'Call按钮')
    for i in range(3):
        driver.execute_script('arguments[0].removeAttribute("disabled")', call_button)
        time.sleep(4)
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

def remove_blank_for_list_ele(list):
    """
    获取users或者directory列表时，会出现Huiming.shi.helplightning+Expert_BbB  (Not Signed In)的这种情况，所以去除掉中间的两个空格，返回新的列表
    :param list:
    :return:
    """
    remove_blank_list = []
    for one in list:
        if '  ' in one:
            one= one.split('  ')[0]
        remove_blank_list.append(one)
    return remove_blank_list

if __name__ == '__main__':
    print()