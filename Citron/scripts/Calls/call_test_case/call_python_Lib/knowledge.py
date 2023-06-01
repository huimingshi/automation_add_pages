# _*_ coding: utf-8 _*_ #
# @Time     :5/24/2023 1:58 PM
# @Author   :Huiming Shi

#----------------------------------------------------------------------------------------------------#
import time
from Citron.public_switch.pubLib import *
from Citron.public_switch.public_switch_py import *
from Citron.scripts.Calls.call_test_case.call_python_Lib.else_public_lib import scroll_into_view as SIV
from Citron.scripts.Calls.call_test_case.call_python_Lib.public_lib import py_get_random, modify_implicit_wait, switch_to_default_content
from Citron.scripts.Calls.call_test_case.call_python_Lib.public_settings_and_variable_copy import *
from selenium.webdriver.common.keys import Keys
from selenium.webdriver.common.action_chains import ActionChains
from selenium.webdriver.support.select import Select
from Citron.scripts.Calls.call_test_case.call_python_Lib.login_lib import start_an_empty_window as SAEW

#----------------------------------------------------------------------------------------------------#
# define python Library
def save_folder(driver):
    """
    点击保存按钮，保存folder
    :param driver:
    :return:
    """
    # 点击保存
    public_click_element(driver, folder_save_button, description="save按钮")
    time.sleep(3)

@modify_implicit_wait(3)
def add_knowledge_folder(driver,sharing_options=None,select_location = None):
    """
    新增一条knowledge数据
    :param driver:
    :param sharing_options: 选择Share options策略: None？only？all
    :param select_location: 选择一个folder的location名称
    :return:创建的folder的名称
    """
    # 点击新增folder按钮
    public_click_element(driver,add_folder_button,description="add_folder按钮")
    random_int = py_get_random()
    # 输入folder的名称
    ele = get_xpath_element(driver,folder_name_input,description="name输入框")
    folder_name = f'folder{random_int}'
    ele.send_keys(folder_name)
    if sharing_options:
        public_click_element(driver,choose_sharing_options,description="sharing_options下拉框")
        public_click_element(driver,share_with_all_users,description="勾选share_with_all_users")
        if sharing_options.upper() == "ALL":
            public_click_element(driver,'//div[@class="k-form-field"]//span[@class="k-select"]',description="Editable_by下拉框")
            time.sleep(1)
            public_click_element(driver,'//li[text()="All users and admins"]',description="选择all")
    if select_location:
        pass
    # 点击保存
    save_folder(driver)
    # 校验新增成功
    ele_list = get_xpath_elements(driver,folder_single_div.format(folder_name))
    public_assert(driver,len(ele_list),1,action="新增folder")
    return folder_name

def click_which_folder(driver,folder_name):
    """
    点击某个folder
    :param driver:
    :param procedure_name:
    :return:
    """
    public_click_element(driver,folder_single_div.format(folder_name),description=f"{folder_name}这个folder")
    time.sleep(2)

def right_click_folder(driver,folder_name):
    """
    右击某个folder或者file或者procedure
    :param driver:
    :param folder_name: folder的名称
    :return:
    """
    action = ActionChains(driver)
    username = get_xpath_element(driver,folder_single_div.format(folder_name),description=f"{folder_name}这个folder")
    action.context_click(username).perform()

def click_folder_settings(driver,folder_name):
    """
    点击某个folder的settings
    :param driver:
    :param folder_name: folder的名称
    :return:
    """
    # 右击某个folder
    right_click_folder(driver, folder_name)
    # 点击Settings
    public_click_element(driver,folder_settings.format(folder_name),description=f"{folder_name}这个folder的settings")

@modify_implicit_wait(3)
def delete_which_folder(driver,folder_name):
    """
    删除某个folder
    :param driver:
    :param folder_name: folder的名称
    :return:
    """
    # 右击某个folder
    right_click_folder(driver, folder_name)
    # 点击Delete
    public_click_element(driver, folder_delete.format(folder_name), description=f"{folder_name}这个folder的delete")
    time.sleep(3)
    # 检验删除成功
    ele_list = get_xpath_elements(driver, folder_delete.format(folder_name))
    public_assert(driver, len(ele_list), 0, action="删除folder")

def choose_folder_location(driver,folder_name,private = None):
    """
    选择一个folder location
    :param driver:
    :param folder_name: 目的folder
    :param private: 目的folder是否是private类型的folder
    :return:
    """
    # 选择对应的folder
    public_click_element(driver, select_a_folder_location, description="select_a_folder_location按钮")
    time.sleep(3)
    SIV(driver, choose_which_folder.format(folder_name))
    if not private:
        public_click_element(driver, choose_which_folder.format(folder_name), description=f"{folder_name}这个folder")
    else:
        get_xpath_element(driver,f'//span[text()="{folder_name}"]/..//i[@class="k-icon k-i-lock"]',description="private类型的folder无法选中")

def save_settings(driver):
    """
    保存settings
    :param driver:
    :return:
    """
    # 点击SAVE
    public_click_element(driver, add_file_save, description="SAVE按钮")
    time.sleep(3)

def add_file_procedure_to_folder(driver,folder_name,file_name = "avatar1.jpg"):
    """
    添加file或者procedure到folder中
    :param driver:
    :param folder_name: folder的名称
    :param file_name: 文件名称，默认为“avatar1.jpg”不填
    :return:  procedure_name
    """
    # 点击Add Knowledge按钮
    public_click_element(driver,add_knowledge,description="add_knowledge按钮")
    # # 预先设置随机数
    # random_int = py_get_random()
    # procedure_name = f'procedure{random_int}'
    if "." in file_name:   # 保证file_name传的是一个文件名
        # 上传文件
        file = get_picture_path(file_name)
        public_click_element(driver,add_file_to_knowledge,description="添加file按钮")
        get_xpath_element(driver,add_file_input, ec='ec',description="上传文件按钮").send_keys(file)
        # 验证文件上传成功
        get_xpath_element(driver,delete_knowledge_file,description="文件删除按钮")
    else:
        # 预先设置随机数
        random_int = py_get_random()
        procedure_name = f'procedure{random_int}'
        public_click_element(driver,add_procedure_to_knowledge,description="添加procedure按钮")
        # 输入Procedure的name
        get_xpath_element(driver,procedure_name_input, ec='ec',description="新建Procedure时的name输入框").send_keys(procedure_name)
    # 选择对应的folder
    choose_folder_location(driver,folder_name)
    # # 输入Description
    # get_xpath_element(driver, description_input, description="description_input输入框").send_keys(procedure_name)
    # 点击SAVE
    save_settings(driver)
    if "." not in file_name:
        return  procedure_name

@modify_implicit_wait(3)
def back_to_main(driver):
    """
    回到Main节点
    :param driver:
    :return:
    """
    # 切回主html文档
    switch_to_default_content(driver)
    # 回到main节点
    ele_list = get_xpath_elements(driver,master_node)
    if len(ele_list) == 1:
        public_click_element(driver,master_node,description="主节点按钮")
        time.sleep(2)

@modify_implicit_wait(3)
def click_procedure_settings(driver,procedure_name,can_setting = "yes"):
    """
    点击某个procedure或者file的settings
    :param driver:
    :param procedure_name: procedure的名称
    :param can_setting: 是否可以进行settings：默认可以
    :return:
    """
    # 右击某个procedure或者file
    right_click_folder(driver, procedure_name)
    if can_setting != "yes":
        ele_list = get_xpath_elements(driver,procedure_settings.format(procedure_name))
        public_assert(driver,len(ele_list),0,action="应该不可点击settings")
    else:
        # 点击Settings
        public_click_element(driver,procedure_settings.format(procedure_name),description=f"{procedure_name}这个folder的settings")

def click_which_procedure(driver,procedure_name):
    """
    点击某个procedure或者file
    :param driver:
    :param procedure_name:
    :return:
    """
    public_click_element(driver,procedure_single_div.format(procedure_name),description=f"{procedure_name}这个procedure")

def update_procedure_step(driver):
    """
    更新procedure的step
    :param driver:
    :return:
    """
    # 预先设置随机数
    random_int = py_get_random()
    step_title = f'step_title{random_int}'
    ele = get_xpath_element(driver,step_title_input,description="step_title输入框")
    ele.send_keys(step_title)
    # 点击第一个procedure
    click_first_procedure(driver)

def switch_iframe(driver):
    """
    切换到iframe中
    :param driver:
    :return:
    """
    # 进入frame中
    driver.switch_to.frame(get_xpath_element(driver, '//iframe[@class="k-iframe"]', description="切换iframe"))

def add_text_to_procedure(driver):
    """
    给procedure添加文本描述信息
    :param driver:
    :return: text_item
    """
    # 预先设置随机数
    random_int = py_get_random()
    text_item = f'text_item{random_int}'
    # 输入文本信息
    public_click_element(driver,add_procedure_step_text,description="T按钮")
    # 进入frame中
    switch_iframe(driver)
    # 输入文本
    ele = get_xpath_element(driver, '//div[@class="k-content ProseMirror"]', description="添加文本的输入框")
    ele.send_keys(text_item)
    # 切回主html文档
    switch_to_default_content(driver)
    return text_item

def check_all_character_strings(driver,strings):
    """
    全选输入的字符串
    :param driver:
    :param strings: 字符串
    :return:
    """
    ele = get_xpath_element(driver, f'//p[text()="{strings}"]', description='非Windows操作系统粘贴')
    actions = ActionChains(driver)
    actions.move_to_element(ele)
    actions.click(ele)  # select the element where to paste text
    actions.key_down(Keys.META)
    actions.send_keys('a')
    # actions.key_up(Keys.META)
    # actions.perform()

def click_nike_button(driver):
    """
    点击对钩按钮
    :param driver:
    :return:
    """
    public_click_element(driver, '//span[@class="k-button-icon k-icon k-i-check-circle"]', description="点击对钩按钮")
    time.sleep(2)

def change_text_item_size(driver,strings):
    """
    改变字体大小
    :param driver:
    :param strings:
    :return:
    """
    # 进入frame中
    switch_iframe(driver)
    # 全选输入的字符串
    check_all_character_strings(driver, strings)
    # 切回主html文档
    switch_to_default_content(driver)
    public_click_element(driver,'//span[text()="Font Size"]',description="选择字体大小按钮")
    time.sleep(1)
    public_click_element(driver,'//li[text()="6 (24pt)"]',description="选择14pt的大小")
    # 点击第一个procedure
    click_first_procedure(driver)

def add_question(driver,index = 4):
    """
    添加Question
    :param driver:
    :param index:需要删除的Question的序号
    :return:
    """
    # 点击对钩按钮
    click_nike_button(driver)
    # 预先设置随机数
    random_int = py_get_random()
    question = f'question{random_int}'
    # 输入Question信息
    get_xpath_element(driver,question_input,description="Question输入框").send_keys(question)
    # 点击第一个procedure
    click_first_procedure(driver)

def click_first_procedure(driver):
    """
    点击第一个procedure
    :param driver:
    :return:
    """
    # 点击第一个procedure
    time.sleep(1)
    public_click_element(driver, '//div[@class="row p-2 align-middle list-item"][last()]//div[@class="list-item-content"]', description=f"第一个procedure")
    time.sleep(1)

def add_single_or_multiple_choices(driver,options = 'add_option',single = 'single'):
    """
    添加Single or multiple choices
    :param driver:
    :param options: 是否需要添加options
    :param single: single还是multiple
    :return:
    """
    # 点击添加Single or multiple choices按钮
    public_click_element(driver,'//span[@class="k-button-icon k-icon k-i-list-bulleted"]',description="add_single_or_multiple_choices按钮")
    time.sleep(1)
    # 预先设置随机数
    random_int = py_get_random()
    question = f'question{random_int}'
    # 输入Question信息
    get_xpath_element(driver, question_input, description="Question输入框").send_keys(question)
    time.sleep(1)
    # single还是multiple
    if single != 'single':
        public_click_element(driver,f'{last_procedure_container}//span[text()="Single choice"]',description="SINGLE_CHOICE按钮")
        public_click_element(driver,'//span[text()="Multiple choice"]',description="选择Multiple_choice")
    # 是否Options
    if options == 'add_option':
        # 点击第一个procedure
        click_first_procedure(driver)
        # 添加Option
        public_click_element(driver,options_button,description="OPTIONS按钮")
        public_click_element(driver,'//span[text()="Add option"]',description="ADD_OPTION按钮")
        get_xpath_element(driver,option_name_input,description="Option_name输入框").send_keys(question)
        time.sleep(1)
        public_click_element(driver,add_option_dialog_close,description="窗口关闭按钮")
        # 校验option添加成功
        value = get_xpath_element(driver,option_show,description="添加的option").get_attribute("textContent")
        public_assert(driver,value,question,action="option添加成功")
        return question
    return

def edit_options(driver,option_value):
    """
    修改options
    :param driver:
    :param option_value: option的内容
    :return:
    """
    # 修改options
    public_click_element(driver, options_button, description="OPTIONS按钮")
    get_xpath_element(driver, option_name_input, description="Option_name输入框").send_keys('1')
    time.sleep(1)
    public_click_element(driver, add_option_dialog_close, description="窗口关闭按钮")
    # 校验option修改成功
    value = get_xpath_element(driver, option_show, description="添加的option").get_attribute("textContent")
    public_assert(driver, value, option_value+"1", action="option添加失败")

def add_file_to_procedure(driver,file_name = "avatar1.jpg"):
    """
    上传文件到procedure中
    :param driver:
    :param file_name:
    :return:
    """
    # 上传文件
    file = get_picture_path(file_name)
    print(file)
    get_xpath_element(driver, add_file_to_procedure_input, ec='ec', description="上传文件按钮").send_keys(file)
    time.sleep(5)
    # 验证文件上传成功
    if '.jpg' in file_name:
        get_xpath_element(driver,f'{last_procedure_container}//img',description="picture上传成功")
    elif '.mp3' in file_name:
        pass
    elif '.mp4' in file_name:
        get_xpath_element(driver,f'{last_procedure_container}//i[@class="far  fa-file-video"]',description="video上传成功")
    elif '.pdf' in file_name:
        get_xpath_element(driver, f'{last_procedure_container}//i[@class="far  fa-file-pdf"]',description="pdf上传成功")
    else:
        raise Exception("请上传正确的文件")

def add_image_video(driver,type = 'image'):
    """
    添加image或者video到procedure
    :param driver:
    :param type:  image或者video
    :return:
    """
    if type == 'image':
        SIV(driver,image_button)
        public_click_element(driver,image_button,description="相机按钮")
    elif type == 'video':
        SIV(driver,video_button)
        public_click_element(driver,video_button,description="摄像按钮")
    else:
        raise Exception("请输入正确的类型")
    time.sleep(1)
    get_xpath_element(driver, f'{last_procedure_container}//input[@placeholder="Add {type} description*"]',description=f"add_{type}_desc输入框").send_keys(f"add {type}")
    # 点击第一个procedure
    click_first_procedure(driver)

def add_QR_code(driver):
    """
    添加二维码到procedure
    :param driver:
    :return:
    """
    public_click_element(driver,'//span[@class="k-button-icon far fa-qrcode"]',description="二维码按钮")
    get_xpath_element(driver,f'{last_procedure_container}//input[@placeholder="Add QR code description*"]',description="add_QR输入框").send_keys("二维码")
    # 点击第一个procedure
    click_first_procedure(driver)

def add_signature(driver):
    """
    添加signature到procedure
    :param driver:
    :return:
    """
    public_click_element(driver,'//span[@class="k-button-icon far fa-signature"]',description="signature按钮")
    get_xpath_element(driver,f'{last_procedure_container}//input[@placeholder="Add your signature*"]',description="add_signature输入框").send_keys("德玛西亚皇子")
    # 点击第一个procedure
    click_first_procedure(driver)

def fill_conditional_step_desc(driver,back = None):
    """
    填充Add conditional step description
    :param driver:
    :param back: 是否需要点击第一个procedure
    :return:
    """
    get_xpath_element(driver,f'{last_procedure_container}//input[@placeholder="Add conditional step description*"]',description="add_conditional输入框").send_keys("熔岩巨兽")
    if back:
        # 点击第一个procedure
        click_first_procedure(driver)

def add_condition_item(driver,condition = "add",count = 2):
    """
    添加condition到procedure
    :param driver:
    :param condition: 是否添加Condition；默认添加
    :param count: 添加condition的个数；默认2个
    :return:
    """
    # 点击add condition图标
    public_click_element(driver,'//div[@class="k-widget k-toolbar"]/span[last()]//button[1]',description="add_condition图标")
    # 填充Add conditional step description
    fill_conditional_step_desc(driver)
    if condition == "add":
        # 点击CONDITIONS按钮
        public_click_element(driver,Conditions_button,description="CONDITIONS按钮")
        for i in range(int(count)):
            # 点击ADD CONDITION按钮
            public_click_element(driver,Add_condition_button,description="ADD_CONDITION按钮")
            # 输入描述信息
            get_xpath_element(driver,condition_input,description="Condition输入框").send_keys(f"condition{i + 1}")
        # 关闭dialog
        public_click_element(driver,add_option_dialog_close,description="窗口关闭按钮")
    # 点击第一个procedure
    click_first_procedure(driver)

def change_step_index(driver,index = 2):
    """
    改变condition的step的次序
    :param driver:
    :param index: 想更改step为几
    :return:
    """
    # 点击CONDITIONS按钮
    public_click_element(driver, Conditions_button, description="CONDITIONS按钮")
    # 点击第一个步骤的STEP1
    public_click_element(driver,'//div[@class="choice-option"][1]//span[@class="k-button-text"]',description="STEP1")
    time.sleep(1)
    # 改为Step 2
    public_click_element(driver,choose_which_step.format(int(index)),description="选择Step_2")
    time.sleep(1)
    # 关闭dialog
    public_click_element(driver, add_option_dialog_close, description="窗口关闭按钮")
    # 校验修改成功
    get_xpath_element(driver,'//span[text()="condition1 >> 2"]',description="校验修改成功")

def add_more_condition(driver,count = 1):
    """
    添加额外的condition
    :param driver:
    :param count:
    :return:
    """
    # 点击CONDITIONS按钮
    public_click_element(driver, Conditions_button, description="CONDITIONS按钮")
    for i in range(int(count)):
        # 点击ADD CONDITION按钮
        public_click_element(driver, Add_condition_button, description="ADD_CONDITION按钮")
        # 输入描述信息
        get_xpath_element(driver, condition_input,description="Condition输入框").send_keys(f"more_condition{i + 1}")
    # 关闭dialog
    public_click_element(driver, add_option_dialog_close, description="窗口关闭按钮")

def delete_one_condition_option(driver):
    """
    删除一条condition中的option
    :param driver:
    :return:
    """
    # 点击CONDITIONS按钮
    public_click_element(driver, Conditions_button, description="CONDITIONS按钮")
    # 删除第一个step
    public_click_element(driver,'//div[@class="choice-option"][1]//span[@class="k-button-icon k-icon k-i-delete"]/..',description="删除第一个Step")
    # 关闭dialog
    public_click_element(driver, add_option_dialog_close, description="窗口关闭按钮")
    # 校验删除成功
    get_xpath_element(driver, '//span[text()="condition2 >> 1"]', description="校验删除成功1")
    get_xpath_element(driver, '//span[text()="more_condition1 >> 1"]', description="校验删除成功2")

def enter_which_step(driver,step = 2):
    """
    进入到第几个STEP中
    :param driver:
    :param step: 默认为第二个STEP
    :return:
    """
    # 点击右上角的选择STEP按钮
    public_click_element(driver,'//button[@title="Select step"]',description="右上角的选择STEP按钮")
    time.sleep(1)
    # 选择STEP 2
    public_click_element(driver,choose_which_step.format(int(step)),description="选择Step_2")

def add_enter_data(driver):
    """
    添加enter data到procedure中
    :param driver:
    :return:
    """
    # 点击enter data按钮
    public_click_element(driver,'//span[@class="k-button-icon far fa-pencil-ruler"]',description="enter_data按钮")
    time.sleep(1)
    # 输Add data description
    get_xpath_element(driver,f'{last_procedure_container}//input[@placeholder="Add data description*"]',description="add_data_desc输入框").send_keys("扭曲树精")
    # 点击第一个procedure
    click_first_procedure(driver)

def delete_procedure_item(driver):
    """
    删除最后一个procedure的item
    :param driver:
    :return:
    """
    # 删除前查看item的数量
    ele_list = get_xpath_elements(driver,procedure_container)
    print(len(ele_list))
    # 鼠标悬停
    ellipsis_xpath = f'{last_procedure_container}//div[@class="procedure-item-actions"]'
    ellipsis = get_xpath_element(driver, ellipsis_xpath, description='鼠标悬浮')
    ActionChains(driver).move_to_element(ellipsis).perform()
    time.sleep(3)
    public_click_element(driver,f'{last_procedure_container}//span[@class="k-button-icon k-icon k-i-delete"]',description="删除按钮")
    time.sleep(3)
    # 删除后查看item的数量
    ele_list_after = get_xpath_elements(driver,procedure_container)
    print(len(ele_list_after))
    public_assert(driver,len(ele_list),len(ele_list_after) + 1,action="item删除成功")

def publish_procedure(driver):
    """
    Publish Procedure
    :param driver:
    :return:
    """
    # 点击publish按钮
    public_click_element(driver,'//span[text()="Publish"]',description="publish按钮")
    time.sleep(1)
    # 输入Version comments
    get_xpath_element(driver,'//input[@name="comments"]',description="Version_comments输入框").send_keys('1')
    time.sleep(1)
    # 点击OK
    public_click_element(driver,procedure_publish_ok,description="OK按钮")

def check_published_status(driver):
    """
    校验处于published状态
    :param driver:
    :return:
    """
    # 检查Publish成功，按钮文本改变
    get_xpath_element(driver,'//div[text()="PUBLISHED" and @class="primary-badge"]',description="PUBLISHED状态")
    get_xpath_element(driver,'//span[text()="Update"]',description="右上角的UPDATE按钮")
    # 检查版本号
    version = get_xpath_element(driver, version_num, description="Version").get_attribute("textContent")
    print(version)
    public_assert(driver, version, 'Version:  1', action="Version正确")
    # 检查Description
    description = get_xpath_element(driver, description_str, description="Version").get_attribute("textContent")
    print(description)
    public_assert(driver, description, 'Description:  1', action="Description正确")

def update_procedure(driver):
    """
    更新procedure
    :param driver:
    :return:
    """
    # 点击UPDATE按钮
    public_click_element(driver, '//span[text()="Update"]', description="Update按钮")
    time.sleep(1)
    # 输入Version comments
    get_xpath_element(driver, '//input[@name="comments"]', description="Version_comments输入框").send_keys('.1')
    time.sleep(1)
    # 点击OK
    public_click_element(driver, procedure_publish_ok,description="OK按钮")

@modify_implicit_wait(3)
def check_updated_success(driver):
    """
    校验处于update成功
    :param driver:
    :return:
    """
    # 当Procedure updated的提示信息消失
    for i in range(10):
        ele = get_xpath_elements(driver,'//div[text()="Procedure updated"]')
        if len(ele) == 1:
            time.sleep(1)
        else:
            break
    # 检查版本号
    version = get_xpath_element(driver,version_num,description="Version").get_attribute("textContent")
    public_assert(driver,version,'Version:  2',action="Version正确")
    # 检查Description
    description = get_xpath_element(driver,description_str,description="Version").get_attribute("textContent")
    public_assert(driver,description,'Description:  1.1',action="Description正确")

@modify_implicit_wait(3)
def delete_which_procedure(driver,procedure_name,can_delete = "yes"):
    """
    删除某个procedure或者file
    :param driver:
    :param procedure_name:
    :param can_not_delete: 是否可以删除：默认可以删除
    :return:
    """
    # 右击某个procedure或者file
    right_click_folder(driver, procedure_name)
    if can_delete != "yes":
        ele_list = get_xpath_elements(driver, procedure_delete.format(procedure_name))
        public_assert(driver,len(ele_list),0,action="没有delete按钮")
    else:
        # 点击delete
        public_click_element(driver, procedure_delete.format(procedure_name),description=f"{procedure_name}这个folder的delete")
        time.sleep(2)
        # 断言删除成功
        ele_list = get_xpath_elements(driver,procedure_single_div.format(procedure_name))
        public_assert(driver,len(ele_list),0,action="删除procedure")

@modify_implicit_wait(3)
def update_folder_name_desc(driver,original_folder_name):
    """
    更新folder的name和description
    :param driver:
    :param original_folder_name: 原先的folder的名称
    :return: new_folder_name
    """
    # 右击folder，点击settings
    click_folder_settings(driver,original_folder_name)
    # 清空Name
    ele = get_xpath_element(driver,folder_name_input,description="folder的name输入框")
    ele.click()
    # 预先设置随机数
    # random_int = py_get_random()
    # new_folder_name = f'new_folder_name{random_int}'
    new_folder_name = "new"
    # 填入Name
    ele.send_keys(new_folder_name)
    new_folder_name = original_folder_name + new_folder_name
    # 清空description
    ele = get_xpath_element(driver, description_input, description="folder的description输入框")
    ele.clear()
    time.sleep(1)
    # 填入description
    ele.send_keys(new_folder_name)
    # 点击保存
    save_folder(driver)
    # # 断言update成功
    # ele_list = get_xpath_elements(driver, folder_single_div.format(new_folder_name))
    # public_assert(driver, len(ele_list), 1, action="更新folder")
    return new_folder_name

def change_location_to_public_folder(driver,folder_name,public_folder,private = None):
    """
    更改location到一个public folder下
    :param driver:
    :param folder_name: 需要移动的folder
    :param public_folder: 目的folder
    :param private: 目的folder是否是private类型的folder
    :return:
    """
    # 右击folder，点击settings
    click_folder_settings(driver, folder_name)
    # 选择对应的folder
    choose_folder_location(driver,public_folder,private)
    # 点击保存
    save_folder(driver)
    # # 断言update成功
    # for i in range(5):
    #     ele_list = get_xpath_elements(driver, folder_single_div.format(folder_name))
    #     if len(ele_list) == 0:
    #         break
    #     elif i < 4:
    #         time.sleep(2)
    #     else:
    #         public_assert(driver, len(ele_list), 0, action="更改folder的location成功")

def add_description_to_file(driver,file_name):
    """
    给file或者procedure添加description描述信息
    :param driver:
    :param file_name:
    :return:
    """
    # 右击
    right_click_folder(driver,file_name)
    # 点击settings选项
    click_procedure_settings(driver,file_name)
    # 填入description描述信息
    get_xpath_element(driver,description_input,description="描述输入框").send_keys(file_name)
    # 点击SAVE保存
    save_settings(driver)
    # 右击
    right_click_folder(driver, file_name)
    # 点击settings选项
    click_procedure_settings(driver, file_name)
    # 校验修改成功
    value = get_xpath_element(driver, description_input, description="描述输入框").get_attribute("value")
    public_assert(driver,value,file_name,action="update_success")
    # 点击Cancel
    public_click_element(driver,'//span[text()="Cancel"]',description="Cancel按钮")
    time.sleep(2)

def image_is_opened(driver,image_name):
    """
    图片展示在主窗口页面
    :param driver:
    :param image_name:
    :return:
    """
    get_xpath_element(driver,f'//img[@alt="{image_name}"]',description="图片展示")
    public_click_element(driver,'//span[@class="k-button-icon k-icon k-i-x"]',description="关闭按钮")
    time.sleep(2)

def get_current_folders(driver):
    """
    获取当前页面的folder的名称列表
    :param driver:
    :return:  folder_name_list
    """
    folder_name_list = []
    # 获取所有的folder的名称
    ele_list = get_xpath_elements(driver,'//div[@class="knowledge-folder"]/div/div')
    public_assert(driver,len(ele_list),0,condition="!=",action="folder数量不为0")
    for i in range(len(ele_list)):
        folder_name = ele_list[i].get_attribute("textContent")
        folder_name_list.append(folder_name)
    return folder_name_list

def folder_sort_by(driver,by = "name"):
    """
    根据name进行排序
    :param driver:
    :param by:根据什么来排序？  按name或者Last Updated排序
    :return:
    """
    # 点击排序按钮
    public_click_element(driver, folder_sort_button, description="排序按钮")
    if by == "name":
        public_click_element(driver,sort_by_name_button,description="根据name排序按钮")
    else:
        public_click_element(driver, sort_by_last_updated_button, description="根据last_updated排序按钮")
    time.sleep(1)

def search_knowledge(driver,value):
    """
    根据关键字查询Knowledge
    :param driver:
    :param value: 查询的关键字
    :return:
    """
    get_xpath_element(driver,'//input[@class="k-input k-input-md k-rounded-md k-input-solid"]',description="查询输入框").send_keys(value)
    time.sleep(3)
    ele_list = get_xpath_elements(driver,f'//div[text()="{value}"]')
    public_assert(driver,len(ele_list),1,action=f"根据{value}查询结果正确")

def add_step(driver):
    """
    添加一个step
    :param driver:
    :return:
    """
    public_click_element(driver,step_action,description="STEP_ACTIONS按钮")
    public_click_element(driver,'//span[text()="Add Step"]',description="Add_Step按钮")
    time.sleep(3)

def delete_step(driver):
    """
    删除某个step
    :param driver:
    :return:
    """
    public_click_element(driver, step_action, description="STEP_ACTIONS按钮")
    public_click_element(driver,'//span[text()="Delete Step"]',description="delete_step按钮")
    time.sleep(3)



if __name__ == '__main__':
    import time
    print(int(time.time() * 1000000))