# _*_ coding: utf-8 _*_ #
# @Time     :9/6/2022 2:17 PM
# @Author   :Huiming Shi

import random
import string
from Citron.Lib.python_Lib.ui_keywords import get_modify_picture_path as GMPP, check_zipFile_exists as CZE
from Citron.public_switch.pubLib import *
from Citron.scripts.Calls.call_test_case.call_python_Lib.else_public_lib import suspension_of_the_mouse as SOTM, \
    scroll_into_view as SIV, refresh_browser_page as RBP
from public_settings_and_variable import *
from selenium.webdriver.common.action_chains import ActionChains
from selenium.webdriver.common.keys import Keys


def start_new_chat(driver,username):
    """
    发起新的chat，并校验是否发起成功（根据username校验）
    :param driver:
    :param username: 用户名
    :return:
    """
    # 鼠标悬浮
    SOTM(driver, username)
    public_click_element(driver,button_message,description='发起new_chat')
    # 校验是否进入到message会话列表
    ele_list = get_xpath_elements(driver, f'//div[@class="ChatSessionList_name" and text()="{username}"]')
    public_assert(driver,1,len(ele_list),action='发起chat成功')

def check_last_message_content(driver,test_data,data_type='text'):
    """
    # 检查最新的消息是什么
    :param driver:
    :param test_data:
    :param data_type:
    :return:
    """
    if data_type == 'text':
        ele_list = get_xpath_elements(driver,chatSessionList_lastMessages_text.format(test_data))
        public_assert(driver, len(ele_list), 1, action=f'{test_data}未成功发送')
    elif data_type == 'url':
        ele_list = get_xpath_elements(driver,chatSessionList_lastMessages_url.format(test_data))
        public_assert(driver, len(ele_list), 1, action=f'{test_data}未成功发送')

def get_random_str():
    """
    获取随机字符串
    :return:
    """
    random_str = ''.join(random.choice(string.ascii_letters + string.digits) for _ in range(20))
    return random_str

def send_message_by_keyboard(driver,keyboard = 'enter'):
    """
    # 通过键盘发送messages
    :param driver:
    :param keyboard: 操作键盘类型
    :return: 返回随机字符串，用于后面的校验
    """
    random_str = get_random_str()
    print(random_str)
    message_input = get_xpath_element(driver, message_textarea, description='message输入框')
    message_input.send_keys(random_str)
    sys_type = get_system_type()
    if sys_type == 'Windows':
        if keyboard == 'enter':
            message_input.send_keys(Keys.ENTER)
        elif keyboard == 'shift_enter':
            ActionChains(driver).key_down(Keys.SHIFT).key_down(Keys.ENTER).perform()
            message_input.send_keys('anotherline')
            public_click_element(driver, send_message_button, description='聊天内容发送按钮')
    elif sys_type != 'Windows':
        if keyboard == 'enter':
            message_input.send_keys(Keys.ENTER)
        elif keyboard == 'shift_enter':
            ActionChains(driver).key_down(Keys.SHIFT).key_down(Keys.ENTER).perform()
            message_input.send_keys('anotherline')
            public_click_element(driver, send_message_button, description='聊天内容发送按钮')
    return random_str

def send_message_by_different_data(driver,test_data,data_type='text',send = 'send'):
    """
    测试用不同的数据类型发送message
    :param driver:
    :param test_data:
    :param data_type:是哪种数据类型，分为text和url
    :return:
    """
    message_input = get_xpath_element(driver, message_textarea, description='message输入框')
    message_input.click()
    message_input.send_keys(test_data)
    time.sleep(2)
    if send == 'send':
        public_click_element(driver,send_message_button,description='聊天内容发送按钮')
        check_last_message_content(driver, test_data, data_type)
        if data_type == 'text':
            ele_list = get_xpath_elements(driver,chatSessionList_lastMessages_text.format(test_data))
            public_assert(driver, len(ele_list), 1, condition=">=", action=f'{test_data}未成功发送')
        elif data_type == 'url':
            ele_list = get_xpath_elements(driver,chatSessionList_lastMessages_url.format(test_data))
            public_assert(driver, len(ele_list), 1, condition=">=", action=f'{test_data}未成功发送')

def send_message_by_different_file(driver,file_name,in_call='not_in_call'):
    """
    测试用不同的文件类型发送message
    :param driver:
    :param file_name: 文件名
    :param in_call: 是否在通话中上传文件;默认是不在通话中
    :return:
    """
    file_path = GMPP(picture_name = file_name)
    public_click_element(driver,message_toolbarButton,description='message_tool')
    get_xpath_element(driver, input_type_file, ec='ec').send_keys(file_path)
    time.sleep(3)
    if in_call == 'not_in_call':
        public_click_element(driver, send_message_button, description='message发送按钮')
        ele_list = get_xpath_elements(driver, chatSessionList_lastMessages_attach.format(file_name))
        print(len(ele_list))
        public_assert(driver, len(ele_list), 1, action=f'{file_name}未成功发送')
    elif in_call == 'in_call':
        public_click_element(driver, send_message_button, description='message发送按钮')
        ele_list = get_xpath_elements(driver, in_call_lastMessages_attach.format(file_name))
        print(len(ele_list))
        public_assert(driver, len(ele_list), 1, action=f'{file_name}未成功发送')

def get_unread_message_count(driver,message_count = '1'):
    """
    获取未读消息数
    :param driver:
    :param message_count: 预期消息数
    :return:
    """
    if message_count == '0':
        # message会话页面
        ele_list = get_xpath_elements(driver,unread_message_count)
        public_assert(driver,0,len(ele_list),action='应该没有未读消息')
        # Messages菜单
        ele_list = get_xpath_elements(driver, show_unread_message_count)
        public_assert(driver, 0, len(ele_list), action='Messages应该没有未读消息')
    else:
        # message会话页面
        textContent = get_xpath_element(driver,unread_message_count,description='message会话页面未读消息数').get_attribute("textContent")
        print('textContent:',textContent)
        public_assert(driver,int(textContent),int(message_count),action='message会话页面获取未读消息数')
        # Messages菜单
        textContent = get_xpath_element(driver, show_unread_message_count, description='Messages菜单页面未读消息数').get_attribute("textContent")
        print('textContent:',textContent)
        public_assert(driver, int(textContent), int(message_count), action='Messages菜单页面获取未读消息数')

def click_which_message(driver,*args):
    """
    打开对应的message会话
    :param driver:
    :param username: 用户名s
    :return:
    """
    time.sleep(2)
    if len(args) > 1:
        user_list = [args[i] for i in range(len(args))]
        final_name_str = ', '.join(user_list)
    else:
        final_name_str = args[0]
    for i in range(3):
        ele_list = get_xpath_elements(driver,witch_message_thread.format(final_name_str))
        if len(ele_list) != 0:
            public_click_element(driver,witch_message_thread.format(final_name_str),description=f'点击{final_name_str}的message')
            break
        elif i == 2:
            public_click_element(driver, witch_message_thread.format(final_name_str),description=f'等待后点击{final_name_str}的message')
        else:
            time.sleep(1)

def get_message_dialog_text(driver,has_text = '1'):
    """
    获取message对话框的消息文本
    :param driver:
    :param has_text: 是否有文本内容；默认有‘1’，没有‘0’
    :return:
    """
    if has_text == '1':
        div_list = get_xpath_elements(driver, message_dialog_text)
        all_text = []
        for i in range(len(div_list)):
            all_text.append(div_list[i].get_attribute("textContent"))
        print(all_text)
        return all_text
    else:
        div_list = get_xpath_elements(driver, message_dialog_text)
        public_assert(driver,0,len(div_list),action='空白的消息会话')

def get_message_dialog_attach(driver):
    """
    获取message对话框的附件名称
    :param driver1:
    :param driver2:
    :return:
    """
    div_list = get_xpath_elements(driver, attachmentName)
    all_attach = []
    for i in range(len(div_list)):
        all_attach.append(div_list[i].get_attribute("textContent"))
    print(all_attach)
    return all_attach

def see_last_content_on_message_dialog(driver, text):
    """
    判断message对话框中最后一条消息内容
    :param driver:
    :param text:
    :return:
    """
    time.sleep(5)
    all_text = get_message_dialog_text(driver)
    public_assert(driver,text,all_text[-2],action='message对话框最后一条消息内容')

def see_last_attachName_on_message_dialog(driver, attach_name):
    """
    判断message对话框中最后一条消息内容
    :param driver:
    :param attcah_name:
    :return:
    """
    time.sleep(5)
    all_attach = get_message_dialog_attach(driver)
    public_assert(driver,attach_name,all_attach[-1],action='message对话框最后一条附件名称')

def click_url_on_message_dialog(driver):
    """
    点击message对话框中的url
    :param driver:
    :return:
    """
    time.sleep(5)
    div_list = get_xpath_elements(driver, message_dialog_text)
    try:
        div_list[-2].click()
    except Exception as e:
        print('元素不可点击', e)
        msg = traceback.format_exc()
        print(msg)
        screen_shot_func(driver, f'url不可点击')
        raise Exception

def check_goto_baidu(driver):
    """
    校验是否进入百度首页
    :param driver:
    :return:
    """
    ele_list = get_xpath_elements(driver,'//input[@id="kw"]')
    public_assert(driver, 1, len(ele_list), action='进入到百度页面')
    time.sleep(3)

def click_message_info(driver):
    """
    点击Info按钮
    :param driver:
    :return:
    """
    public_click_element(driver, message_page_info, description='点击Info按钮')
    time.sleep(3)

def click_delete_message(driver):
    """
    点击删除按钮
    :param driver:
    :return:
    """
    public_click_element(driver, message_delete_button, description='点击Delete按钮')

def click_message_back(driver):
    """
    # 点击Back按钮
    :param driver:
    :return:
    """
    public_click_element(driver, message_page_back, description='点击Back按钮')

def check_delete_message_confirmation_dialog(driver):
    """
    检验删除message时的提示信息和按钮展示
    :param driver:
    :return:
    """
    # 点击Info按钮
    click_message_info(driver)
    # 点击删除按钮
    click_delete_message(driver)
    # 检查删除的提示信息
    ele_list = get_xpath_elements(driver,delete_message_info)
    public_assert(driver,1,len(ele_list),action='判断提示信息')
    ele_list = get_xpath_elements(driver, message_delete_confirm_button)
    public_assert(driver, 1, len(ele_list), action='判断删除按钮')
    ele_list = get_xpath_elements(driver, message_delete_cancel_button)
    public_assert(driver, 1, len(ele_list), action='判断取消按钮')
    # 取消删除
    public_click_element(driver, message_delete_cancel_button, description='确认删除message')
    # 点击Back按钮
    click_message_back(driver)

def click_message_info_check(driver,*args):
    """
    点击message的Info校验会话成员
    :param driver:
    :param args:
    :return:
    """
    # 点击Info按钮
    click_message_info(driver)
    # 校验会话成员
    ele_list = get_xpath_elements(driver,message_members)
    for i in range(len(args)):
        print(ele_list[i].get_attribute("textContent"))
        public_assert(driver, args[i], ele_list[i].get_attribute("textContent"), action='校验message会话成员')
    # 点击Back按钮
    click_message_back(driver)

def delete_first_message_thread(driver):
    """
    删除首条message
    :param driver:
    :return:
    """
    time.sleep(2)
    public_click_element(driver,'//div[@class="ChatSessionList_grid"]//div[@ref="eCenterContainer"]//div[@row-id="0"]',description='第一条message')
    time.sleep(2)
    # 点击Info按钮
    click_message_info(driver)
    # 点击删除按钮
    click_delete_message(driver)
    # 确认删除
    public_click_element(driver, message_delete_confirm_button, description='确认删除message')
    time.sleep(2)

def delete_all_message_thread(driver):
    """
    删除所有的message
    :param driver:
    :return:
    """
    # 获取message线程数
    ele_list = get_xpath_elements(driver, all_message_thread)
    for _ in range(len(ele_list)):
        delete_first_message_thread(driver)

def delete_message_chat(driver,if_delete = '1'):
    """
    删除当前的message会话
    :param driver:
    :return:
    """
    # 点击Info按钮
    click_message_info(driver)
    # 点击删除按钮
    click_delete_message(driver)
    if if_delete == '1':
        # 确认删除
        public_click_element(driver, message_delete_confirm_button, description='确认删除message')
        time.sleep(3)
    else:
        # 取消删除
        public_click_element(driver, message_delete_cancel_button, description='确认删除message')
        # 点击Back按钮
        click_message_back(driver)

def check_message_delete_success(driver,username,is_deleted = '1'):
    """
    校验message是否删除成功
    :param driver:
    :param username:
    :param is_deleted:是否删除，默认‘1’删除
    :return:
    """
    ele_list = get_xpath_elements(driver,witch_message_thread.format(username))
    if is_deleted == '1':
        public_assert(driver, 0, len(ele_list), action='message删除成功')
    else:
        public_assert(driver, 1, len(ele_list), action='message应未被删除')

def send_a_new_message_action(driver):
    """
    点击SEND A NEW MESSAGE按钮
    :param driver:
    :return:
    """
    public_click_element(driver, send_a_new_message_button, description='创建新的message')

def check_create_message_back(driver):
    """
    检查创建message时可以取消创建
    :param driver:
    :return:
    """
    send_a_new_message_action(driver)
    # 检查是否有Back按钮
    ele_list = get_xpath_elements(driver, back_message_button)
    public_assert(driver, 1, len(ele_list), action='back按钮')
    public_click_element(driver, back_message_button, description='取消创建新的message')

def create_a_new_message(driver,search = 'search',*args):
    """
    在Messages页面发起新的会话
    :param driver:
    :param message_user:
    :return:
    """
    send_a_new_message_action(driver)
    for i in range(4):
        ele_list = get_xpath_elements(driver,'//div[@class="ContactsGrid"]//div[@ref="eCenterContainer"]/div[@row-id="0"]')
        if len(ele_list) == 1:
            break
        elif i == 1:
            RBP(driver)
            send_a_new_message_action(driver)
        elif i == 3:
            public_assert(driver,1,len(ele_list),action='判断创建message时用户数据是否加载出来')
    if search == 'search':
        search_ele = get_xpath_element(driver,search_messages_box,description='创建新的message的搜索框')
        search_ele.click()
    # 所有user都逐个点击选中
    print(args)
    print(len(args))
    for i in range(len(args)):
        if search == 'search':
            search_ele.clear()
            search_ele.send_keys(args[i])
            time.sleep(1)
        else:
            time.sleep(2)
        # 点击user选中
        public_click_element(driver, f'//div[@class="contact-name" and contains(.,"{args[i]}")]', description=f'选择{args[i]}')
        # 检查是否选中
        ele_list = get_xpath_elements(driver,f'//span[@class="items-name " and contains(.,"{args[i]}")]')
        public_assert(driver,1,len(ele_list),action='user是否被点击选中')

def de_select_one_user(driver,username):
    """
    创建message去勾选某个user
    :param driver:
    :param username:
    :return:
    """
    public_click_element(driver,f'//span[@class="items-name " and contains(.,"{username}")]/..//*[@*="#xmark"]/../..',description=f'去勾选{username}')

def confirm_create_message(driver):
    """
    点击Create按钮确认创建新的message
    :param driver:
    :return:
    """
    # 点击Create按钮
    public_click_element(driver, create_message_button, description='Create按钮')

def download_attach_on_message_dialog(driver,attach_name,extension='original'):
    """
    点击附件进行下载
    :param driver:
    :param attach_name: 附件名
    :param extension: 下载的文件的扩展名
    :return:
    """
    # ele_xpath = f'//div[@class="attachmentName" and text()="{attach_name}"]/..//*[@*="#file"]'
    ele_xpath = attach_particial_xpath.format(attach_name)
    SIV(driver,ele_xpath)
    # 如果不加这个等待时间的话，下面的click会报错，目前不知道啥原因导致的
    time.sleep(3)
    public_click_element(driver, message_textarea, description='message输入框')
    public_click_element(driver,ele_xpath,description='点击附件进行下载')
    time.sleep(10)
    result = CZE(extension)
    public_assert(driver,1,result[1],action='点击附件下载')

def click_audio_video_button(driver,type = 'Audio',check = '1'):
    """
    启动Audio+或者Video
    :param driver:
    :param type: 启动类型：Audio+或者Video
    :param check: 是否做检查，检查是否弹出提示信息
    :return:
    """
    if type == 'Audio':
        public_click_element(driver,message_page_start_audio,description='点击Audio+')
    else:
        public_click_element(driver, message_page_start_video, description='点击Video')
    if check == 1:
        ele_list_1 = get_xpath_elements(driver,'//div[@class="alert-1" and text()="The contact you selected"]')
        public_assert(driver,1,len(ele_list_1),action='提示信息第一行')
        ele_list_2 = get_xpath_elements(driver, '//div[@class="alert-2" and text()="is not currently signed in to the system."]')
        public_assert(driver, 1, len(ele_list_2), action='提示信息第二行')
        ele_list_3 = get_xpath_elements(driver, '//div[@class="alert-confirm" and text()="Would you like to invite them into a call via email?"]')
        public_assert(driver, 1, len(ele_list_3), action='提示信息第三行')
        ele_list_cancel = get_xpath_elements(driver,invitation_dialog_cancel)
        public_assert(driver, 1, len(ele_list_cancel), action='Cancel按钮')
        ele_list_send = get_xpath_elements(driver, '//button[@class="k-button k-primary" and text()="Send Invite"]')
        public_assert(driver, 1, len(ele_list_send), action='Send_Invite按钮')
    ele_list_cancel = get_xpath_elements(driver, invitation_dialog_cancel)
    if len(ele_list_cancel) == 1:
        public_click_element(driver,invitation_dialog_cancel,description='点击Cancel按钮')

def check_outgoing_call_names(driver,*args):
    """
    校验outgoing_call_names
    :param driver:
    :param args:预期的用户names
    :return:
    """
    if len(args) != 1:
        user_list = []
        for i in range(len(args)):
            user_list.append(args[i])
        final_name_str = ', '.join(user_list)
    else:
        final_name_str = args[0]
    actual_names = get_xpath_element(driver,'//div[@id="connecting_caller_name"]',description='获取outgoing_call_names').get_attribute("textContent")
    public_assert(driver,final_name_str,actual_names,action='校验outgoing_call_names')

def search_messages_by_keyword(driver,input_keyword):
    """
    根据关键字查询messages列表
    :param driver:
    :param input_keyword: 需要根据该关键字进行搜索
    :return:
    """
    search_message_ele = get_xpath_element(driver,search_messages,description='Search_Messages查询框')
    search_message_ele.clear()
    search_message_ele.send_keys(input_keyword)
    time.sleep(3)


if __name__ == '__main__':
    send_message_by_keyboard(1)