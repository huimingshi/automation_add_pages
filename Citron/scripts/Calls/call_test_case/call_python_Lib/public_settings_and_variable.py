#----------------------------------------------------------------------------------------------------#
# Chrome set up
from selenium import webdriver
from Citron.public_switch.public_switch_py import SMALL_RANGE_BROWSER_TYPE
if SMALL_RANGE_BROWSER_TYPE == 'Chrome':
    from selenium.webdriver.chrome.options import Options
    optionc = Options()
    optionc.add_argument("--disable-infobars")
    optionc.add_argument("start-maximized")
    optionc.add_argument("--disable-extensions")

    # Pass the argument 1 to allow and 2 to block
    optionc.add_experimental_option("prefs", {
        "profile.default_content_setting_values.notifications": 1,   # chrome开启通知
        "profile.default_content_setting_values.media_stream_mic": 1 ,   # chrome开启麦克风
        "profile.default_content_setting_values.media_stream_camera": 1    # chrome开启摄像头
    })
    # 忽略证书错误，不需要手动点高级选项
    optionc.add_argument('--ignore-certificate-errors')

elif SMALL_RANGE_BROWSER_TYPE == 'Firefox':
    from selenium.webdriver.firefox.options import Options

    optionf = Options()
    optionf.add_argument("--disable-infobars")
    optionf.add_argument("start-maximized")
    optionf.add_argument("--disable-extensions")

    # Pass the argument 1 to allow and 2 to block
    optionf.set_capability("prefs", {
        "profile.default_content_setting_values.notifications": 1,
        "profile.default_content_setting_values.media_stream_mic": 1
    })
    # 忽略证书错误，不需要手动点高级选项
    optionf.add_argument('--ignore-certificate-errors')
    profile = webdriver.FirefoxProfile()
    profile.set_preference('intl.accept_languages', 'en-US, en')
    profile.set_preference("permissions.default.microphone", 1)
    profile.set_preference("webdriver_accept_untrusted_certs", True)
    profile.set_preference("browser.link.open_newwindow", 3)
    profile.set_preference("browser.link.open_newwindow.restriction", 2)
    profile.set_preference("browser.tabs.remote.autostart", False)
    profile.set_preference("browser.tabs.remote.autostart.1", False)
    profile.set_preference("browser.tabs.remote.autostart.2", False)
# ----------------------------------------------------------------------------------------------------#
# variable
# test_web = 'https://app-stage.helplightning.net.cn/'
username_input = '//input[@autocomplete="username"]'
password_input = '//input[@autocomplete="current-password"]'
submit_button = '//button[@type="submit"]'
next_button = '//button[text()="Next"]'
login_button = '//button[text()="Log In"]'
search_input = '//input[@id="filter-text-box"]'
contacts_search_input = '//div[@id="user-tabs-pane-{}"]//input[@id="filter-text-box"]'
add_comment = '//textarea[@placeholder="Add a comment..."]'
accept_disclaimer = '//button[@class="pull-right btn btn-primary"]'     # ACCEPT Disclaimer when call或者就只是ACCEPT Disclaimer
close_tutorial_button = '//div[@class="modal-header"]//button[@class="close"]'
count_of_list = '//div[@class="ag-center-cols-container"]/div'
click_call_button = '//button[@class="k-button callButton"]'
anwser_call_button = '//button[@class="k-button success-btn big-btn" and text()="ANSWER"]'
external_join_call_anwser_button = '//button[contains(.,"Answer")]'
five_star_high_praise = '//span[@class="star"]/div[contains(.,"Excellent")]'
end_call_button = "//div[@class='InCall']//div[@class='menu']//*[@*='#phone_end_red']"    # 结束Call的红色按钮
add_tag_input = '//input[@placeholder="Add tags to filter calls..."]'       # call结束后的add tag
add_tag_input_after = '//span[@class="k-searchbar"]/input[@type="text"]'    # call结束后已经添加tag后，再添加tag
end_call_before_connecting = '//button[@class="btn btn-lg btn-danger"]'
invite_user_div = "//div[@class='InCall']//*[@*='#options_menu']/.."   # 通话中界面右上角的三个横岗
enter_invite_user_page = '//div[@class="submenu-icons"]//span[text()="Invite"]/..'
enter_debug_page = '//span[text()="Debug"]/..'
close_bounced_after_call_end = '//button[@class="k-button k-button-icon closeButton"]'
checkbox_xpath = '//input[@name="oneTime" and @type="checkbox"]'
first_time_call_started = '//div[@row-index="0"]/div[@col-id="timeCallStarted"]'
send_my_help_space_invitation = '//button[contains(.,"Send My Help Space Invitation")]'
get_invite_link = '//div[@class="invite-link"]'
my_help_space_message = '//input[@name="message"]'
send_invite_in_calling = '//a[@id="inviteDialog-tab-2"]'
contacts_list_in_calling = '//a[@id="inviteDialog-tab-1"]'
current_account = '//button[@id="currentAccount"]'
my_account_name = '//input[@placeholder="Name"]'
first_tree_menu = '//div[@role="tree"]/div[1]'
contacts_page = '//span[contains(.,"Contacts")]'
recents_page = "//span[contains(.,'Calls')]"
personal_page = '//span[contains(.,"Personal")]'
log_out_button = '//span[contains(.,"Logout")]'
send_invite_button = '//button[contains(.,"Send Invite")]'
send_link_email_input = '//input[@placeholder="Participant email"]'    # 发送link时的email输入框xpath
send_link_send_invite = '//button[contains(.,"Send Invite")]'          # 发送link时的Send Invite按钮
contacts_in_call_search_result = '//div[@id="inviteDialog-pane-1"]//div[@class="ag-center-cols-container"]/div'
close_invite_3th_page_xpath = '//div[@class="modal-dialog"]//span[@aria-hidden="true" and contains(.,"×")]'
first_line_details_button = '//div[@class="ag-center-cols-container"]/div[@row-index="0"]//button[@class="k-button detailsButton"]'   # 首行数据的Details按钮
close_details_xpath = '//div[@class="modal-content"]//span[contains(.,"×")]'   # Details页面的x按钮
not_disturb = '//button[@class="dnd-btn available-btn"]'   # 不是免打扰模式
make_available_button = '//button[text()="Make Available"]'    # 取消免打扰模式
decline_disclaimer = '//div[@class="modal-content"]//button[text()="DECLINE"]'    # DECLINE Disclaimer make call或者就只是DECLINE Disclaimer
decline_call = '//div[@class="modal-content"]//button[text()="Decline"]'     # 在通话界面上Decline Call
take_survey_after_call = '//button[contains(.,"Take Survey")]'   # call结束后的Take Survey按钮
end_call_for_all_button = '//button[contains(.,"End Call for All")]'    # End Call for All
leave_call_button = '//button[contains(.,"Leave Call")]'    # Leave Call
visibility_finishi_call = '//span[@style="visibility: visible;"]'    # 校验可以挂断电话的按钮是否出现
exit_call_yes = '//button[@class="promptButton submenu-seperator"]'   # 结束通话的Yes按钮
debug_tools_close_xpath = '//h1[text()="Debug Tools"]/..//div[@class="react-toggle"]'     # 打开Debug Tools设置
recording_settings = '//button[@id="recording-settings"]'                   # REC设置
record_this_session = '//a[text()="Record this session"]/../..'
do_not_record = '//a[text()="Do not record"]/../..'
webglCameraOff = "//canvas[@id='webglCameraOff']"
webglCameraOn = "//canvas[@id='webglCameraOn']"
video_on_button = '//div[@class="InCall"]//div[@class="menus false"]/div[@class="menu withsub  "]'
return_vidoe_on = '//div[@class="submenu-icons"]//span[contains(.,"amera")]/..'
pdf_on_button = "//div[@class='InCall']//*[@*='#pdf_on']"
ghop_on_button = "//div[@class='InCall']//*[@*='#ghop_on']/../.."
upload_file = '//input[@name="upload-file"]'
f2f_on_mode = "//div[@class='InCall']//*[@*='#f2f_on']"
which_mode_help = '//div[@class="user-base"]/strong[text()="{}"]'    # 选择GIVE HELP或者选择RECEIVE HELP
count_of_call_user = '//div[@class="F2FVideos ShowOpenTokVideos"]/div'
inviteDialog_search_user_input = '//div[@id="inviteDialog"]//input[@id="quick-search-text-box"]'
message_chat_icon = '//*[@*="#message_chat"]/../..'                                                                                # 通话过程中的Message图标
left_ChatDrawer = '//div[@class="ChatDrawer "]'                                                                              # message对话框至于通话界面左侧
in_call_lastMessages_text = '//p[text()="{}"]'                                                                               # 会话中最后一句文本
in_call_lastMessages_attach = '//div[@class="attachmentName" and text()="{}"]'                                                # 会话中最后一个附件
AttachmentOptionsMenu = '//div[text()="{}"]/../div[@class="AttachmentOptionsMenu plus attachment_template"]'                # 附件的三个点
AttachmentOptionsMenu_selecting_button = '//div[@class="selecting_button"]/span[text()="{}"]'                            # Share或者Download
PanZoomTools = '//div[@class="PanZoomTools show"]'
search_by_email = '//input[@id="user-search-email"]'
select_your_role = '//div[@class="menu roleMenu"]/div[@class="menu withsub  "]'
capture_button = '//input[@class="capture_button"]'
please_wait = '//div[@class="InvalidLinkView"]/h2[text()="Please wait."]'
zhuanquanquan = '//div[@id="whiteboard_progress_bar_container"]'
notification_content = '//div[@class="k-notification-content"]'      # 底下抛出的绿色的提示信息，比如修改成功，发送成功
updated_settings_successfully = '//div[@class="k-notification-content"]/span[text()="Updated settings sucessfully"]'      # 底下抛出的绿色的提示信息，Updated settings sucessfully
call_top_message = '//div[@class="AlertContainer"]//div[@class="message"]'    # 通话过程中最上方的提示信息，比如Checking Network Quality或者No camera detected
share_button = '//div[@class="DocToolBar show"]/button[text()="Share"]'      # 通话过程中左下角的Share按钮
enable_recording_call = '//div[@class="message" and contains(.,"{} has enabled recording for this call.")]'
turn_off_recording_call = '//div[@class="message" and contains(.,"{} has turned off recording for this call.")]'
Audio_Only_button = '//div[@class="message" and text()="Audio Only"]'
# Messages页面
message_textarea = '//textarea[@class="k-input"]'                         # 聊天输入框
message_toolbarButton = '//div[@class="toolbarButton"]'     # 点击这个按钮出现不同的文件类型
chatSessionList_lastMessages_text = '//div[@class="ChatSessionList_lastMessages"]/p[text()="{}"]'    # 会话中最后一句文本
chatSessionList_lastMessages_url = '//div[@class="ChatSessionList_lastMessages"]//a[@href="{}"]'    # 会话中最后一句url
chatSessionList_lastMessages_attach = '//div[@class="ChatSessionList_lastMessages"]//img[@alt="{}"]'    # 会话中最后一个附件
input_type_file = '//input[@type="file"]'                                                       # 上传文件的xpath
send_message_button = '//button[@class="k-button k-flat k-button-icon k-button-send"]'          # message发送按钮
unread_message_count = '//div[@class="ChatSessionList"]//div[@class="Badge"]/div'               # 未读消息数
show_unread_message_count = '//span[@class="k-badge k-badge-md k-badge-solid k-badge-error k-badge-circle k-badge-border-cutout k-badge-edge k-top-end"]/span'
button_message = '//div[@class="button message"]'                                               # contacts页面的message按钮发起新的message
message_page_info = '//div[@class="user_chat_buttons"]//span[text()="Info"]'                    # 聊天中查看Info
message_dialog_text = '//div[@class="k-bubble false"]//p'                                       # message会话框中的文本内容
message_members = '//div[@class="ChatInfo_grid_name"]'                                          # 聊天成员
message_page_back = '//div[@class="user_chat_buttons"]//span[text()="Back"]'                    # 点击Info后变成back按钮
message_delete_button = '//button[@class="btn btn-danger" and text()="Delete"]'                 # 删除message
message_delete_confirm_button = '//button[@class="btn btn-default" and text()="Delete"]'        # 确认删除message
message_delete_cancel_button = '//button[@class="btn btn-default" and text()="Cancel"]'         # 取消删除message
send_a_new_message_button = '//button[text()="SEND A NEW MESSAGE"]'                             # SEND A NEW MESSAGE按钮
search_messages_box = '//input[@id="quick-search-text-box"]'                                    # 创建messages时查询user的查询框
create_message_button = '//button[@class="create_button k-button k-primary"]'                   # 创建message的Create按钮
back_message_button = '//div[@class="returns_button"]'                                          # 创建message的Back按钮
attachmentName = '//div[@class="attachmentName"]'                                               # message会话框中的附件名称
message_dialog_div = '//div[@class="k-message-group k-alt"]/div'                                # History loaded smoothly
delete_message_info = '//div[@class="modal-body" and text()="This permanently deletes this message thread for all participants. Are you Sure?"]'
all_message_thread = '//div[@class="ChatSessionList_grid"]//div[@class="ag-center-cols-container"]/div'
witch_message_thread = '//div[text()="{}"]'                                                     # 哪一个用户的message
message_page_start_audio = '//div[@class="user_chat_buttons"]//span[text()="Audio+"]'           # 聊天中启动Audio+
message_page_start_video = '//div[@class="user_chat_buttons"]//span[text()="Video"]'            # 聊天中启动Video
invitation_dialog_cancel = '//button[@class="k-button" and text()="Cancel"]'                    # Cancel按钮
search_messages = '//div[@class="SearchMessages"]//input[@id="quick-search-text-box"]'          # Search Messages查询框
attach_particial_xpath = '//div[@class="attachmentName" and text()="{}"]/..//*[@*="#file"]'     # 会话中的附件xpath
# Calls页面
preview_container = '//div[@class="preview-container"]//img'                                    # 预览图
thumbnail_container = '//div[@class="attachment selectable "]/img'                              # 缩略图
play_video_button = '//span[text()="Play Video"]/..'                                            # 播放Video按钮