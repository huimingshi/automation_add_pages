# _*_ coding: utf-8 _*_ #
# @Time     :9/6/2022 2:31 PM
# @Author   :Huiming Shi
import time

from Citron.public_switch.pubLib import *
from Citron.scripts.Calls.call_test_case.call_python_Lib.else_public_lib import switch_to_last_window as STLW
from Citron.scripts.Calls.call_test_case.call_python_Lib.public_settings_and_variable import *


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
    """
    删除第一个tag
    :param driver:
    :return:
    """
    # 点击首行数据的Details按钮
    click_first_line_details(driver)
    # 删除第一个tag
    public_check_element(driver, '//ul[@role="listbox"]/li[1]/span[@aria-label="delete"]', '删除第一个tag失败')
    public_check_element(driver, '//div[@class="CallInfo container-box"]//button[@class="k-button k-primary pull-right"]', '点击保存按钮失败')
    close_details_page(driver)

def give_star_rating(driver,star):
    """
    # Give a star rating
    :param driver:
    :param star:   Value range：From 1 to 5
    :return:
    """
    public_check_element(driver, f'//div[@class="stars"]/span[{int(star)}]/i', '给出星级评价失败')

def make_sure_enter_call(driver):
    """
    确保进入通话状态中
    :param driver:
    :return:
    """
    driver.implicitly_wait(3)
    for i in range(40):
        ele_list_2 = get_xpath_elements(driver, please_wait)
        ele_list_1 = get_xpath_elements(driver,zhuanquanquan)
        ele_list = get_xpath_elements(driver, '//div[@id="connecting_call_label" and text()="Joining Call..."]')
        if len(ele_list) == 0 and len(ele_list_1) == 0 and len(ele_list_2) == 0:
            break
        elif i == 39:
            screen_shot_func(driver, '通话还未拨通成功')
            raise Exception('通话还未拨通成功')
        else:
            time.sleep(int(3))
    driver.implicitly_wait(IMPLICIT_WAIT)

def first_call_record_tag_and_comment(driver,expect_tag,*args):
    """
    检查首行call记录的tag和comment是否正确
    :param driver:
    :param expect_tag: 预期的tag名称
    :return:
    """
    # 获取首行call记录的tag
    print(expect_tag)
    for i in range(3):
        get_tag = get_xpath_element(driver,'//div[@class="ag-center-cols-container"]/div[@row-index="0"]/div[@col-id="tags"]',description = '首行call数据的tag').get_attribute('textContent')
        print(get_tag)
        if get_tag == expect_tag:
            break
        else:
            time.sleep(2)
        print(i)
        public_assert(driver, i, 2, condition='!=', action='tag与预期不一致')
    # 点击首行数据的Details按钮
    click_first_line_details(driver)
    # 获取首行call记录的comment列表
    comment_ele_list = get_xpath_elements(driver,'//div[@class="comment-text row"]')
    i = 0
    for ele in comment_ele_list:
        comment_text = ele.get_attribute('textContent')
        print(args[i], comment_text)
        public_assert(driver,args[i] , comment_text,action='comment与预期不一致')
        i = i + 1
    # 关闭Details页面
    close_details_page(driver)

def get_all_tag_after_call(driver):
    """
    在通话结束页面，获取所有的tags
    :param driver:
    :return:
    """
    tag_list = []
    public_click_element(driver,add_tag_input,description = '添加tag')  # 点击Add tags
    ele_list = get_xpath_elements(driver,f'//div[@class="k-list-scroller"]//li')
    for ele in ele_list:
        get_tag = ele.get_attribute("textContent")
        print(get_tag)
        tag_list.append(get_tag)
    return tag_list

def check_tag_and_com_switch_success(driver,has_tag = 0):
    """
    # 校验关闭Call tag and Comment配置项后，通话结束后没有tag和comment
    :param driver:
    :param has_tag:是否出现tag和comment，默认没出现;  0-不出现； 1-出现
    :return:
    """
    for i in range(3):
        count = get_xpath_elements(driver,five_star_high_praise)
        if len(count) == 1:
            break
        time.sleep(2)
    tag_count = get_xpath_elements(driver,'//span[@class="k-widget k-multiselect k-header"]')
    print(tag_count)
    public_assert(driver,len(tag_count),int(has_tag),action=f'tag输入框的个数应该为{int(has_tag)}')
    com_count = get_xpath_elements(driver,add_comment)
    print(len(com_count))
    public_assert(driver,len(com_count) , int(has_tag),action=f'comment输入框的个数应该为{int(has_tag)}')

def check_survey_switch_success(driver,status = '0',click_button = 'no_click'):
    """
    # 校验切换After Call: End of Call Survey配置项后，通话结束后有没有 a link to take a survey
    :param driver:
    :param status: ‘0’ or ‘1’；‘0’表示不出现，‘1’表示出现；默认为‘0’
    :param click_button:出现按钮后是否点击；默认不点击
    :return:
    """
    for i in range(3):
        count = get_xpath_elements(driver,five_star_high_praise)
        if len(count) == 1:
            break
        time.sleep(2)
    count = get_xpath_elements(driver,take_survey_after_call)
    if status == '0':
        public_assert(driver,len(count) , 0,'不该出现take_survey按钮的')
    elif status == '1':
        public_assert(driver,len(count) , 1,action='该出现take survey按钮的')
        if click_button == 'click':
            public_click_element(driver,take_survey_after_call,description = 'take_survery按钮')
            time.sleep(6)       # 等待Survey页面加载出来

def close_call_ending_page(driver):
    """
    # 关闭通话结束展示页面
    :param driver:
    :return:
    """
    STLW(driver)  # 切换到最新页面
    ele_list = get_xpath_elements(driver,'//div[@class="EndCallPageContent"]//span[@role="presentation"]')
    if len(ele_list) == 1:
        print('可以关闭通话结束页面')
        public_click_element(driver,'//div[@class="EndCallPageContent"]//span[@role="presentation"]',description='关闭通话结束页面')
    elif len(ele_list) == 0:
        print('没有通话结束页面')

def check_tutorial_screen_shows_up(driver):
    """
    # After ending call,	VP: The tutorial screen shows up.
    :param driver:
    :return:
    """
    # try:
    count = get_xpath_elements(driver,close_tutorial_button)
    public_assert(driver,len(count) , 1,action='该出现tutorial的')

def get_all_comments_in_call_end(driver,*args):
    """
    通话结束页面，获取所有的comments
    :param driver:
    :param args:
    :return:
    """
    # try:
    ele_list = get_xpath_elements(driver,'//div[@class="comment-text row"]')
    for i in range(len(ele_list)):
        get_comment = ele_list[i].get_attribute("textContent")   # 获取comment
        public_assert(driver,get_comment,args[i],action='获取的comments和预期不符')

def which_mode_shown_in_the_top(driver,which_mode = 'Audio+'):
    """
    顶部展示哪种模式
    :param driver:
    :param which_mode: 模式，默认为Audio+模式
    :return:
    """
    ele_list = get_xpath_elements(driver,which_mode_xpath.format(which_mode))
    public_assert(driver,len(ele_list),1,action=f'{which_mode}_mode展示在顶部')

def video_source_icon_is_red_and_off(*args):
    """
    video图标红色且关闭
    :param driver:
    :return:
    """
    sys_type = get_system_type()
    if sys_type == 'Windows':
        for i in range(len(args)):
            ele_list = get_xpath_elements(args[i], video_off_red)
            if len(ele_list) == 1:
                break
            elif i == len(args) - 1:
                public_assert(args[i], len(ele_list), 1, action='video图标红色且关闭')
    else:
        for driver in args:
            ele_list = get_xpath_elements(driver, video_off_red)
            public_assert(driver, len(ele_list), 1, action='video图标红色且关闭')

def which_mode_display_in_the_bottom(driver,which_mode = 'Audio+'):
    """
    底部展示哪种模式
    :param driver:
    :param which_mode: 模式，默认为Audio+模式
    :return:
    """
    ele_list = get_xpath_elements(driver, which_mode_bottom_xpath.format(which_mode))
    public_assert(driver, len(ele_list), 1, action=f'{which_mode}_mode展示在底部')

def show_which_mode_in_right(driver,which_mode = 'f2f_on'):
    """
    右侧展示哪种模式
    :param driver:
    :param which_mode: 模式，默认为f2f_on模式，也可以为“rh_on”，也可以为“gh_on”，也可以为“#ghop_on”
    :return:
    """
    ele_list = get_xpath_elements(driver, show_which_mode_xpath.format(which_mode))
    public_assert(driver, len(ele_list), 1, action=f'{which_mode}_mode展示在右侧')

def display_participants_avatar(driver):
    """
    展示通话参与者的avatar
    :param driver:
    :return:
    """
    ele_list = get_xpath_elements(driver, '//div[@class="Avatars"]')
    public_assert(driver, len(ele_list), 1, condition='>=',action='展示通话参与者的avatar')

def display_which_user_avatar(driver,username = 'Huiming.shi.helplightning+in_call_messageB'):
    """
    展示哪个user的avatar
    :param driver:
    :param username: 用户名
    :return:
    """
    get_xpath_element(driver,f'//h6[text()="{username}"]/../div[@class="Avatars"]',description=f'应该展示{username}的avatar')

def shown_a_special_dialog_prompting(driver,role = 'giver'):
    """
    下方显示三个按钮：Choose Existing Photo、Choose Document、Take New Photo
    :param driver:
    :param role:角色；分为giver、receiver和observer
    :return:
    """
    ele_list_CEP = get_xpath_elements(driver, Share_a_photo)
    ele_list_CD = get_xpath_elements(driver, Share_a_document)
    ele_list_TNP = get_xpath_elements(driver, Take_a_photo)
    if role == 'giver':
        public_assert(driver, len(ele_list_CEP), 1, action='展示Share_a_photo按钮')
        public_assert(driver, len(ele_list_CD), 1, action='展示Share_a_document按钮')
        public_assert(driver, len(ele_list_TNP), 1, action='展示Take_a_photo按钮')
    elif role == 'receiver':
        public_assert(driver, len(ele_list_CEP), 1, action='展示Share_a_photo按钮')
        public_assert(driver, len(ele_list_CD), 0, action='不展示Share_a_document按钮')
        public_assert(driver, len(ele_list_TNP), 0, action='不展示Take_a_photo按钮')
    elif role == 'observer':
        public_assert(driver, len(ele_list_CEP), 0, action='不展示Share_a_photo按钮')
        public_assert(driver, len(ele_list_CD), 0, action='不展示Share_a_document按钮')
        public_assert(driver, len(ele_list_TNP), 0, action='不展示Take_a_photo按钮')

def show_text_in_bottom(driver,which_role = 'receiver'):
    """
    下方展示的文本内容
    :param driver:
    :param which_role: 角色？receiver还是giver
    :return:
    """
    get_xpath_element(driver,'//b[text()="Audio+ Mode:"]',description='展示Audio+Mode:字段')
    if which_role == 'receiver':
        get_xpath_element(driver,'//span[text()="Select content to share."]',description='显示字段正确')
    elif which_role == 'giver':
        get_xpath_element(driver, '//span[text()="Ask others to Take a Photo or share content"]',description='展示文本正确')

def display_live_video_in_background(driver):
    """
    摄像展示
    :param driver:
    :return:
    """
    # sys_type = get_system_type()
    # if sys_type != 'Windows':
    get_xpath_element(driver,'//div[@class="VideoContainer"]//video[@id="camera_video"]',description='摄像展示')

def telestration_icon_is_or_not_visible(driver,is_visible = 'yes'):
    """
    是否展示telestration
    :param driver:
    :param is_visible: 是否展示：默认yes展示
    :return:
    """
    ele_list = get_xpath_elements(driver,PanZoomTools)
    if is_visible == 'yes':
        public_assert(driver,len(ele_list),1,action='应该展示telestration')
    else:
        public_assert(driver,len(ele_list),0,action='应该不展示telestration')

def Audio_SD_HD_should_be_shown(driver,useable = 'sure'):
    """
    判断(Audio+,SD,HD)是否可见可用
    :param driver:
    :param useable:是否可用？默认可用
    :return:
    """
    sys_type = get_system_type()
    if sys_type != 'Windows':
        get_xpath_element(driver,'//button[@id="audioPlusModeIndicator"]',description='Audio_SD_HD可见可用')
    elif sys_type == 'Windows' and useable != 'sure':
        get_xpath_element(driver, '//button[@disabled and @id="audioPlusModeIndicator"]', description='Audio_SD_HD可见但不可用')

def click_source_menu_in_action_bar(driver, *args):
    """
    点击VIEW SOURCE，查看有哪些操作图标，有photo、document等
    :param driver:
    :param args:
    :return:
    """
    # 展开VIEW SOURCE
    public_click_element(driver,video_off_red,description='点击红色的视频按钮')
    for one in args:
        get_xpath_element(driver,f'//span[text()="{one}"]',description=f'{one}图标展示')
    time.sleep(2)
    # 合上VIEW SOURCE
    public_click_element(driver, video_off_red, description='点击红色的视频按钮')

def take_new_photo(driver):
    """
    点击Take New Photo按钮
    :param driver:
    :return:
    """
    # 是否有Take New Photo按钮
    ele_list = get_xpath_elements(driver,Take_a_photo)
    if len(ele_list) == 1:
        # 点击Take New Photo按钮
        public_click_element(driver,Take_a_photo,description='点击Take_New_Photo按钮')
        # 弹出Take_Photo对话框
        get_xpath_element(driver,'//h4[text()="Take Photo"]',description='弹出Take_Photo对话框')
        time.sleep(15)   # 等待能捕捉到摄像头
        # 点击Capture按钮
        public_click_element(driver,'//button[text()="Capture"]',description='点击Capture按钮')
        # 出现Use和Retake按钮
        get_xpath_element(driver,use_photo_button,description='出现Use按钮')
        get_xpath_element(driver,'//button[text()="Retake"]',description='出现Retake按钮')
        # 点击use按钮
        public_click_element(driver,use_photo_button,description='点击Use按钮')
        return 'can_Take_a_photo'
    else:
        return 'can_not_Take_a_photo'

def show_sending_photo_progress(driver):
    """
    捕捉到的摄像图片上传时显示进度条
    :param driver:
    :return:
    """
    get_xpath_element(driver,'//div[@role="progressbar"]',description='进度条')

def return_button_display(driver,display = 'yes'):
    """
    底部的Return按钮是否展示
    :param driver:
    :param display: 默认’yes‘展示
    :return:
    """
    if display == 'yes':
        get_xpath_element(driver,clear_shared_content,description='clear_shared_content按钮应该展示')
    else:
        ele_list = get_xpath_elements(driver,clear_shared_content)
        public_assert(driver,len(ele_list),0,action='clear_shared_content按钮不应该展示')

def screen_capture_button_is_visible(driver,visible = 'yes'):
    """
    Screen_Capture按钮是否展示
    :param driver:
    :param visible:
    :return:
    """
    if visible == 'yes':
        get_xpath_element(driver,capture_button,description='Screen_Capture按钮应该展示')
    else:
        ele_list = get_xpath_elements(driver,capture_button)
        public_assert(driver,len(ele_list),0,action='Screen_Capture按钮不应该展示')

def show_you_can_now_draw(driver):
    """
    提示信息：You can now draw on the shared photo
    :param driver:
    :return:
    """
    get_xpath_element(driver,'//div[text()="You can now draw on the shared photo"]',description='提示信息出现')