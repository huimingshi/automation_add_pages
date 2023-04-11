# _*_ coding: utf-8 _*_ #
# @Time     :11/4/2022 2:15 PM
# @Author   :Huiming Shi
from Citron.public_switch.pubLib import *
from Citron.scripts.Calls.call_test_case.call_python_Lib.public_lib import change_driver_implicit_wait, \
    modify_implicit_wait
from public_settings_and_variable_copy import *

@change_driver_implicit_wait
def now_which_help(driver,expect_mode = 'receiving'):
    """
    Now Giving Help.或者Now Receiving Help.提示信息出现
    :param driver:
    :param expect_mode:预期出现的提示信息
    :return:
    """
    if expect_mode == 'receiving':
        ele_list12 = get_xpath_elements(driver, expect_text_12)
        public_assert(driver, len(ele_list12), 1, action='未出现提示Receiving')
    else:
        ele_list13 = get_xpath_elements(driver, expect_text_13)
        public_assert(driver, len(ele_list13), 1, action='未出现提示Giving')

@change_driver_implicit_wait
def giver_share_a_document(driver,fileName,click_share = 'click_share',check_info = 'check_info'):
    """
    Share a Document，只有giver才会看到Share a Document按钮
    :param driver:
    :param fileName: 文件名
    :param click_share:
    :param check_info:
    :return:
    """
    public_click_element(driver,Share_a_document,description='点击Share_a_Document按钮')
    picture_path = get_picture_path(fileName)
    get_xpath_element(driver, input_type_file, ec='ec').send_keys(picture_path)
    if click_share == 'click_share':
        public_click_element(driver,'//button[text()="Share"]',description='点击Share按钮')
        if check_info == 'check_info':
            ele_list1 = get_xpath_elements(driver, expect_text_1)
            ele_list2 = get_xpath_elements(driver, expect_text_2)
            public_assert(driver,len(ele_list1),1,action='未出现提示1')
            public_assert(driver, len(ele_list2), 1, action='未出现提示2')
    else:
        if check_info == 'check_info':
            ele_list22 = get_xpath_elements(driver, expect_text_22)
            public_assert(driver, len(ele_list22), 1, action='未出现提示22')

@change_driver_implicit_wait
def helper_load_document(driver,fileName,click_share = 'click_share',check_info = 'check_info'):
    """
    Load document，非fiver需要点击右侧的video红色按钮才能上传document
    :param driver:
    :param fileName: 文件名
    :param click_share:
    :param check_info:
    :return:
    """
    public_click_element(driver,video_off_red,description='点击右侧的Video红色按钮')
    time.sleep(2)
    public_click_element(driver,choose_document,description='选择document')
    picture_path = get_picture_path(fileName)
    get_xpath_element(driver, input_type_file, ec='ec').send_keys(picture_path)
    if click_share == 'click_share':
        public_click_element(driver,'//button[text()="Share"]',description='点击Share按钮')
        if check_info == 'check_info':
            ele_list1 = get_xpath_elements(driver, expect_text_1)
            ele_list2 = get_xpath_elements(driver, expect_text_2)
            public_assert(driver,len(ele_list1),1,action='未出现提示1')
            public_assert(driver, len(ele_list2), 1, action='未出现提示2')
    else:
        if check_info == 'check_info':
            ele_list22 = get_xpath_elements(driver, expect_text_22)
            public_assert(driver, len(ele_list22), 1, action='未出现提示22')

@change_driver_implicit_wait
def you_can_draw_shared_photo(driver):
    """
    You can now draw on the shared photo提示信息出现
    :param driver:
    :return:
    """
    ele_list4 = get_xpath_elements(driver, expect_text_4)
    public_assert(driver, len(ele_list4), 1, action='未出现提示4')

@change_driver_implicit_wait
def click_clear_shared_content(driver,which_mode = 'document',check_info='check_info'):
    """
    点击Clear Shared Content按钮
    :param driver:
    :param which_mode: 退出哪种模式？默认document模式。photo模式
    :param check_info:
    :return:
    """
    public_click_element(driver,Clear_Shared_Content,description='点击Clear_Shared_Content按钮')
    if check_info == 'check_info' and which_mode == 'document':
        ele_list3 = get_xpath_elements(driver, expect_text_3)
        public_assert(driver, len(ele_list3), 1, action='未出现提示3')
    elif check_info == 'check_info' and which_mode == 'photo':
        ele_list5 = get_xpath_elements(driver, expect_text_5)
        public_assert(driver, len(ele_list5), 1, action='未出现提示5')

@change_driver_implicit_wait
def exiting_photo_mode_show(driver):
    """
    Exiting Photo Mode提示信息出现
    :param driver:
    :return:
    """
    ele_list5 = get_xpath_elements(driver, expect_text_5)
    public_assert(driver, len(ele_list5), 1, action='未出现提示5')

@change_driver_implicit_wait
def has_joined_as_observer(driver,who):
    """
    %1$s has joined as obeserver提示信息出现
    :param driver:
    :param who:
    :return:
    """
    ele_list6 = get_xpath_elements(driver, expect_text_6.format(who))
    public_assert(driver, len(ele_list6), 1, action='未出现提示6')

@modify_implicit_wait(5)
def has_left_the_session(driver,who):
    """
    %1$s left the call提示信息出现
    :param driver:
    :param who:
    :return:
    """
    ele_list7 = get_xpath_elements(driver, expect_text_7.format(who))
    public_assert(driver, len(ele_list7), 1, action='未出现提示7')

@change_driver_implicit_wait
def your_invite_to_was_sent_successfully(driver,who):
    """
    Your invite to %1$s was sent successfully提示信息出现
    :param driver:
    :param who:
    :return:
    """
    ele_list8 = get_xpath_elements(driver, expect_text_8.format(who))
    public_assert(driver, len(ele_list8), 1, action='未出现提示8')

@change_driver_implicit_wait
def has_accepted_your_call(driver,user):
    """
    %1$s has accepted your call提示信息出现
    :param driver:
    :return:
    """
    ele_list9 = get_xpath_elements(driver, expect_text_9)
    public_assert(driver, len(ele_list9), 1, action='未出现提示9')
    ele_list31 = get_xpath_elements(driver,expect_text_31.format(user))
    public_assert(driver,len(ele_list31),1,action="未出现提示31")

@change_driver_implicit_wait
def click_do_not_record(driver,who,check='check'):
    """
    点击Do not record按钮
    :param driver:
    :param who:
    :param check:
    :return:
    """
    public_click_element(driver, recording_settings, description='recording_setting')
    public_click_element(driver,do_not_record,description = 'do_not_record')
    if check == 'check':
        ele_list10 = get_xpath_elements(driver, expect_text_10.format(who))
        public_assert(driver, len(ele_list10), 1, action='未出现提示10')

@change_driver_implicit_wait
def click_record_this_session(driver,who,check='check'):
    """
    点击Record this session按钮
    :param driver:
    :param who:
    :param check:
    :return:
    """
    public_click_element(driver, recording_settings, description='recording_setting')
    public_click_element(driver, record_this_session,description = 'record_this_session')
    if check == 'check':
        ele_list11 = get_xpath_elements(driver, expect_text_11.format(who))
        public_assert(driver, len(ele_list11), 1, action='未出现提示11')

@change_driver_implicit_wait
def the_task_field_is_frozen(driver):
    """
    The task field is frozen提示信息出现
    :param driver:
    :return:
    """
    ele_list14 = get_xpath_elements(driver, expect_text_14)
    public_assert(driver, len(ele_list14), 1, action='未出现提示14')

@change_driver_implicit_wait
def the_task_field_is_unfrozen(driver):
    """
    The task field is unfrozen提示信息出现
    :param driver:
    :return:
    """
    ele_list15 = get_xpath_elements(driver, expect_text_15)
    public_assert(driver, len(ele_list15), 1, action='未出现提示15')

@change_driver_implicit_wait
def has_joined_the_call(driver,who):
    """
    %1$s has joined the call提示信息出现
    :param driver:
    :param who:
    :return:
    """
    ele_list16 = get_xpath_elements(driver, expect_text_16.format(who))
    public_assert(driver, len(ele_list16), 1, action='未出现提示16')

@modify_implicit_wait(5)
def left_call_switch_f2f_mode(driver,who):
    """
    %1$s (%2$s) left the call. Switched back to Face to Face mode.提示信息出现
    :param driver:
    :param who:
    :return:
    """
    ele_list17 = get_xpath_elements(driver, expect_text_17.format(who))
    public_assert(driver, len(ele_list17), 1, action='未出现提示17')
    ele_list18 = get_xpath_elements(driver, expect_text_18)
    public_assert(driver, len(ele_list18), 1, action='未出现提示18')

@change_driver_implicit_wait
def point_at_a_task_area(driver):
    """
    Now Receiving Help. Point at a task area提示信息出现
    :param driver:
    :return:
    """
    ele_list12 = get_xpath_elements(driver, expect_text_12)
    public_assert(driver, len(ele_list12), 1, action='未出现提示12')
    ele_list19 = get_xpath_elements(driver, expect_text_19)
    public_assert(driver, len(ele_list19), 1, action='未出现提示19')

@change_driver_implicit_wait
def point_at_a_white_background(driver):
    """
    Now Giving Help. Pont at a white background提示信息出现
    :param driver:
    :return:
    """
    ele_list13 = get_xpath_elements(driver, expect_text_13)
    public_assert(driver, len(ele_list13), 1, action='未出现提示13')
    ele_list20 = get_xpath_elements(driver, expect_text_20)
    public_assert(driver, len(ele_list20), 1, action='未出现提示20')

@change_driver_implicit_wait
def now_observing_mode(driver):
    """
    Now Observing mode提示信息出现
    :param driver:
    :return:
    """
    ele_list21 = get_xpath_elements(driver, expect_text_21)
    public_assert(driver, len(ele_list21), 1, action='未出现提示21')

@change_driver_implicit_wait
def pending_document_sharing(driver):
    """
    PDF file is loading...提示信息出现
    :param driver:
    :return:
    """
    ele_list22 = get_xpath_elements(driver, expect_text_22)
    public_assert(driver, len(ele_list22), 1, action='未出现提示22')

@change_driver_implicit_wait
def tap_share_button_to_share(driver):
    """
    Tap the Share button to share the document提示信息出现
    :param driver:
    :return:
    """
    ele_list23 = get_xpath_elements(driver, expect_text_23)
    public_assert(driver, len(ele_list23), 1, action='未出现提示23')

@change_driver_implicit_wait
def receiving_file_from_anybody(driver,who,file_type='document'):
    """
    Receiving document from %1$s (Receiver)或者Receiving photo from %1$s (Receiver)提示信息出现
    :param driver:
    :param who:
    :return:
    """
    if file_type == 'document':
        ele_list24 = get_xpath_elements(driver, expect_text_24.format(who))
        public_assert(driver, len(ele_list24), 1, action='未出现提示24')
    else:
        ele_list25 = get_xpath_elements(driver, expect_text_25.format(who))
        public_assert(driver, len(ele_list25), 1, action='未出现提示25')

@change_driver_implicit_wait
def sending_photo_info(driver):
    """
    Sending photo...提示信息出现
    :param driver:
    :return:
    """
    ele_list26 = get_xpath_elements(driver, expect_text_26)
    public_assert(driver, len(ele_list26), 1, action='未出现提示26')

@change_driver_implicit_wait
def upload_resource_has_cancelled(driver):
    """
    The upload of resource has been cancelled提示信息出现
    :param driver:
    :return:
    """
    ele_list27 = get_xpath_elements(driver, expect_text_27)
    public_assert(driver, len(ele_list27), 1, action='未出现提示27')

@change_driver_implicit_wait
def checking_network_quality(driver):
    """
    Checking Network Quality提示信息出现
    :param driver:
    :return:
    """
    ele_list28 = get_xpath_elements(driver, expect_text_28)
    public_assert(driver, len(ele_list28), 1, action='未出现提示28')

@change_driver_implicit_wait
def audio_only_alert(driver):
    """
    Audio Only提示信息出现
    :param driver:
    :return:
    """
    ele_list29 = get_xpath_elements(driver, expect_text_29)
    public_assert(driver, len(ele_list29), 1, action='未出现提示29')

@change_driver_implicit_wait
def your_camera_is_off(driver):
    """
    Your camera is off. Start Video or share content.提示信息出现
    :param driver:
    :return:
    """
    ele_list30 = get_xpath_elements(driver, expect_text_30)
    public_assert(driver, len(ele_list30), 1, action='未出现提示30')

@modify_implicit_wait(5)
def left_call_back_f2f_mode(driver,username):
    """
    UserName left the call. Switched back to Face to Face mode.
    :param driver:
    :param username:
    :return:
    """
    ele_list32 = get_xpath_elements(driver, expect_text_32.format(username))
    public_assert(driver, len(ele_list32), 1, action='未出现提示32')
    ele_list33 = get_xpath_elements(driver, expect_text_33)
    public_assert(driver, len(ele_list33), 1, action='未出现提示33')

@change_driver_implicit_wait
def exiting_document_sharing_mode(driver):
    """
    Exiting document sharing mode.提示信息出现
    :param driver:
    :return:
    """
    ele_list35 = get_xpath_elements(driver, expect_text_35)
    public_assert(driver, len(ele_list35), 1, condition=">=", action='未出现提示32')