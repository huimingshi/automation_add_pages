# _*_ coding: utf-8 _*_ #
# @Time     :9/6/2022 2:17 PM
# @Author   :Huiming Shi

import random
import string
from Citron.Lib.python_Lib.ui_keywords import get_modify_picture_path as GMPP, check_zipFile_exists as CZE
from Citron.public_switch.pubLib import *
from Citron.scripts.Calls.call_test_case.call_python_Lib.else_public_lib import suspension_of_the_mouse as SOTM,scroll_into_view as SIV
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
            public_click_element(driver, message_send_button, description='聊天内容发送按钮')
    elif sys_type != 'Windows':
        if keyboard == 'enter':
            message_input.send_keys(Keys.ENTER)
        elif keyboard == 'shift_enter':
            ActionChains(driver).key_down(Keys.SHIFT).key_down(Keys.ENTER).perform()
            message_input.send_keys('anotherline')
            public_click_element(driver, message_send_button, description='聊天内容发送按钮')
    return random_str

def send_message_by_different_data(driver,test_data,data_type='text'):
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
    public_click_element(driver,message_send_button,description='聊天内容发送按钮')
    check_last_message_content(driver, test_data, data_type)
    if data_type == 'text':
        ele_list = get_xpath_elements(driver,chatSessionList_lastMessages_text.format(test_data))
        public_assert(driver, len(ele_list), 1, action=f'{test_data}未成功发送')
    elif data_type == 'url':
        ele_list = get_xpath_elements(driver,chatSessionList_lastMessages_url.format(test_data))
        public_assert(driver, len(ele_list), 1, action=f'{test_data}未成功发送')

def send_message_by_different_file(driver,file_name,file_type = 'img'):
    """
    测试用不同的文件类型发送message
    :param driver:
    :param file_name: 文件名
    :param file_type: 文件类型
    :return:
    """
    file_path = GMPP(picture_name = file_name)
    public_click_element(driver,message_toolbarButton,description='message_tool')
    get_xpath_element(driver, input_type_file, ec='ec').send_keys(file_path)
    time.sleep(3)
    public_click_element(driver,send_message_button,description='message发送按钮')
    if file_type == 'img':
        ele_list = get_xpath_elements(driver, chatSessionList_lastMessages_alt.format(file_name))
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
        textContent = get_xpath_element(driver,unread_message_count,description='未读消息数').get_attribute("textContent")
        public_assert(driver,int(textContent),int(message_count),action='获取未读消息数')
        # Messages菜单
        textContent = get_xpath_element(driver, show_unread_message_count, description='未读消息数').get_attribute("textContent")
        public_assert(driver, int(textContent), int(message_count), action='Messages获取未读消息数')

def click_which_message(driver,username):
    """
    打开对应的message会话
    :param driver:
    :param username: 用户名
    :return:
    """
    public_click_element(driver,f'//div[text()="{username}"]',description=f'点击{username}的message')

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

def click_message_info_check(driver,*args):
    """
    点击message的Info校验会话成员
    :param driver:
    :param args:
    :return:
    """
    public_click_element(driver,message_page_info,description='点击Info按钮')
    time.sleep(3)
    ele_list = get_xpath_elements(driver,message_members)
    for i in range(len(args)):
        print(ele_list[i].get_attribute("textContent"))
        public_assert(driver, args[i], ele_list[i].get_attribute("textContent"), action='校验message会话成员')
    # 点击Back按钮
    public_click_element(driver, message_page_back, description='点击Back按钮')

def delete_message_chat(driver):
    """
    删除当前的message会话
    :param driver:
    :return:
    """
    public_click_element(driver, message_page_info, description='点击Info按钮')
    public_click_element(driver,message_delete_button,description='点击Delete按钮')
    public_click_element(driver,message_delete_confirm_button,description='确认删除message')

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
    ele_list = get_xpath_elements(driver,'//div[@class="ContactsGrid"]//div[@ref="eCenterContainer"]/div[@row-id="0"]')
    public_assert(driver,1,len(ele_list),action='判断创建message时用户数据是否加载出来')
    if search == 'search':
        search_ele = get_xpath_element(driver,search_messages_box,description='创建新的message的搜索框')
    # 所有user都逐个点击选中
    for i in range (len(args)):
        if search == 'search':
            search_ele.clear()
            search_ele.send_keys(args[i])
        # 点击user选中
        public_click_element(driver, f'//div[@class="contact-name" and contains(.,"{args[i]}")]', description=f'选择{args[i]}')
        # 检查是否选中
        ele_list = get_xpath_elements(driver,f'//span[@class="items-name" and contains(.,"{args[i]}")]')
        public_assert(driver,1,len(ele_list),action='user是否被点击选中')

def de_select_one_user(driver,username):
    """
    创建message去勾选某个user
    :param driver:
    :param username:
    :return:
    """
    public_click_element(driver,f'//span[@class="items-name" and contains(.,"{username}")]/..//*[@*="#xmark"]/../..',description=f'去勾选{username}')

def confirm_create_message(driver):
    """
    点击Create按钮确认创建新的message
    :param driver:
    :return:
    """
    # 点击Create按钮
    public_click_element(driver, create_message_button, description='Create按钮')

def download_attach_on_message_dialog(driver,attach_name):
    """
    点击附件进行下载
    :param driver:
    :param attach_name: 附件名
    :return:
    """
    ele_xpath = f'//div[@class="attachmentName" and text()="{attach_name}"]/..//*[@*="#file"]'
    SIV(driver,ele_xpath)
    # 如果不加这个等待时间的话，下面的click会报错，目前不知道啥原因导致的
    time.sleep(3)
    public_click_element(driver, message_textarea, description='message输入框')
    public_click_element(driver,ele_xpath,description='点击附件进行下载')
    time.sleep(10)
    result = CZE('original')
    public_assert(driver,1,result[1],action='点击附件下载')



if __name__ == '__main__':
    send_message_by_keyboard(1)