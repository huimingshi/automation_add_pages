# _*_ coding: utf-8 _*_ #
# @Time     :9/6/2022 2:28 PM
# @Author   :Huiming Shi

from selenium.webdriver.common.keys import Keys
from Citron.public_switch.pubLib import *
from Citron.scripts.Calls.call_test_case.call_python_Lib.else_public_lib import paste_on_a_non_windows_system as POANWS
from Citron.scripts.Calls.call_test_case.call_python_Lib.public_settings_and_variable_copy import \
    send_my_help_space_invitation, checkbox_xpath, my_help_space_message, get_invite_link, send_link_email_input, \
    send_link_send_invite


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
            public_assert(driver,args[i] , user_name, condition='in',action='contacts列表name与预期不符')
    elif len(args) == 0:
        public_assert(driver, len(ele_list) , 0, action='contacts列表name与预期不符')

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
        POANWS(driver, my_help_space_message)
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