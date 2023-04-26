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

    optionc1 = Options()
    optionc1.add_argument("--disable-infobars")
    optionc1.add_argument("start-maximized")
    optionc1.add_argument("--disable-extensions")

    # Pass the argument 1 to allow and 2 to block
    optionc1.add_experimental_option("prefs", {
        "profile.default_content_setting_values.notifications": 1,   # chrome开启通知
        "profile.default_content_setting_values.media_stream_mic": 1 ,   # chrome开启麦克风
        "profile.default_content_setting_values.media_stream_camera": 2    # chrome关闭摄像头
    })
    # 忽略证书错误，不需要手动点高级选项
    optionc1.add_argument('--ignore-certificate-errors')

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
participants_div = "//*[@*='#participants']/.."    # 通话中界面左侧的邀请user进入call的入口按钮
show_participants_button = "//div[@class='InCall']//*[@*='#participants']/.."   # 通话中界面右下角的参与者图标
every_participant_name = "//div[@class='ag-center-cols-container']//strong"     # 通话中界面右下角的每个参与者
enter_add_user_page = '//span[text()="Add People"]'    #Add People按钮
enter_debug_page = '//span[text()="Debug"]/..'
close_bounced_after_call_end = '//button[@class="k-button k-button-icon closeButton"]'
checkbox_xpath = '//input[@name="oneTime" and @type="checkbox"]'
first_time_call_started = '//div[@row-index="0"]/div[@col-id="timeCallStarted"]'
send_my_help_space_invitation = '//button[contains(.,"Send My Help Space Invitation")]'
get_invite_link = '//div[@class="invite-link"]'
my_help_space_message = '//input[@name="message"]'
new_invite_in_calling = '//a[@id="inviteDialog-tab-invitation"]'     # New Invitation标签页
contacts_list_in_calling = '//a[@id="inviteDialog-tab-contacts" and @aria-selected="true"]'     # in-call中的Contacts标签页被选中
directory_list_in_calling = '//a[@id="inviteDialog-tab-directory" and @aria-selected="true"]'     # in-call中的directory标签页被选中
directory_checkbox = '//a[@id="inviteDialog-tab-directory" and @aria-selected="false"]'     # in-call中的directory标签
invitation_list_in_calling = '//a[@id="inviteDialog-tab-invitation" and @aria-selected="true"]'     # in-call中的invitation标签页被选中
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
new_invitation_send = '//button[text()="Send"]'    # New Invitation标签页中的Send按钮
contacts_in_call_search_result = '//div[@id="inviteDialog-pane-1"]//div[@class="ag-center-cols-container"]/div'
close_participants_page_xpath = '//div[@class="selected-border"]/..//*[@*="#participants"]/..'    # 关闭Participants入口页面
first_line_details_button = '//div[@class="ag-center-cols-container"]/div[@row-index="0"]//button[@class="k-button detailsButton"]'   # 首行数据的Details按钮
close_details_xpath = '//div[@class="modal-content"]//span[contains(.,"×")]'   # Details页面的x按钮
not_disturb = '//button[@class="dnd-btn available-btn"]'   # 不是免打扰模式
make_available_button = '//button[text()="Make Available"]'    # 取消免打扰模式
close_end_call_page_button = '//div[@class="EndCallPageContent"]//span[@role="presentation"]'       # 关闭通话结束的按钮
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
video_on_button = '//*[@*="#video_on"]/..'
stop_video_button = '//span[text()="Stop Video"]'
start_video_button = '//span[text()="Start Video"]'
camera_icon = '//div[@class="menu NewCameraMenu"]'      # call页面左侧的摄像头图标按钮
off_on_camera = '//div[@class="menu NewCameraMenu"]//*[@*="#camera_front_{}"]/../../..'    # call页面左侧的打开、关闭摄像头图标按钮
return_vidoe_on = '//div[@class="submenu-icons"]//span[contains(.,"amera")]/..'
pdf_on_button = "//div[@class='InCall']//*[@*='#pdf_on']"
ghop_on_button = "//div[@class='InCall']//*[@*='#ghop_on']/../.."
upload_file = '//input[@name="upload-file"]'
which_mode_help = '//div[@class="user-base"]/strong[text()="{}"]'    # 选择GIVE HELP或者选择RECEIVE HELP
count_of_call_user = '//div[@class="F2FVideos ShowOpenTokVideos"]/div'
inviteDialog_search_user_input = '//div[@id="inviteDialog"]//input[@id="quick-search-text-box"]'     # in call页面的Contacts列表中查询框
message_chat_icon = '//*[@*="#message_chat"]/../..'                                                   # 通话过程中的Message图标
left_ChatDrawer = '//div[@class="ChatDrawer "]'                                                        # message对话框至于通话界面左侧
in_call_lastMessages_text = '//p[text()="{}"]'                                                         # 会话中最后一句文本
in_call_lastMessages_attach = '//div[@class="attachmentName" and text()="{}"]'                          # 会话中最后一个附件
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
which_mode_xpath = '//div[@class="top Alert"]/div[contains(.,"{} Mode")]'                                     # 会话顶部的模式
which_mode_bottom_xpath = '//button[@id="audioPlusModeIndicator"]//h2[text()="{}"]'                            # 会话底部的模式
show_which_mode_xpath = '//div[@class="menu withsub  "]//*[@*="#{}"]'                                          # 会话右侧展示的模式
Share_a_photo = '//button[text()="Share a Photo"]'
Share_a_document = '//button[text()="Share a Document"]'
Take_a_photo = '//button[text()="Take a Photo"]'
video_off_red = '//*[@*="#video_off_red"]'
use_photo_button = '//button[text()="Use"]'
clear_shared_content = '//div[@class="RetakeButton"]'
open_freeze = '//*[@*="#freeze_on"]/..'     # 打开左侧的freeze设置的按钮
attachment_selectable = '//div[@class="attachment selectable "]'        # Calls的Details页面的附件
# right_share_button = '//*[@*="#share"]/..'    # 右侧的SHARE按钮
TPPW_share = '//span[text()="{}"]'      # 四种模式：“Take a New Photo”，“Photo from library“，”PDF Document“，”Whiteboard“
stop_sharing_button = '//button[text()="Stop Sharing"]'   # Stop Sharing按钮
my_camera_button = '//span[text()="My Camera"]'    # My Camera按钮
retry_video_connection = '//button[text()="Retry Video Connection"]'           # Retry Video Connection按钮
return_to_ultra_low_bandwidth = '//button[text()="Return to Ultra-Low Bandwidth"]'  # Return to Ultra-Low Bandwidth按钮
merge_on_button = '//*[@*="#merge_off"]/..'      # 进行Merge的按钮#
merge_off_button = '//*[@*="#merge_on"]/..'      # 取消Merge的按钮
preview_merge_button = '//button[text()="Merge"]'    # Merge Preview中的Merge按钮
right_share_button = '//div[@class="menu shareMenu"]'    # 右侧的SHARE按钮
share_live_video_button = '//button[@class="k-button share-video-button btn-primary"]/div'    # 下方的Share live video from 按钮
live_video_from_sb = '//div[@class="submenu-live-video-from"]//span[contains(.,"{}")]'     # 右侧的share live video from，选择somebody
live_video_visible = '//div[@class="submenu-live-video-from"]/div[@class="submenu-userinfo"]/span[contains(.,"{}")]'     # 右侧的share live video from，选择somebody
freeze_on_action = '//*[@*="#freeze_on"]/..'   # 进行freeze的操作
freeze_off_action = '//*[@*="#freeze_off"]/..'   # 进行取消freeze的操作
task_field_is_frozen = '//div[text()="The task field is frozen"]'   # The task field is frozen的提示信息
task_field_is_unfrozen = '//div[text()="The task field is unfrozen"]'   # The task field is unfrozen的提示信息
choose_document = '//div[@class="submenu-content"]//span[text()="Document"]/..'            # 选择document
Clear_Shared_Content = '//button[text()="Clear Shared Content"]'              # Clear Shared Content按钮
cancel_send_photo = '//div[@class="ProgressInfo"]/button[text()="Cancel"]'     # 取消send图片
zoom_in_photo = '//*[@*="#zoom_in"]/..'    # 分享图片或者whiteboard时，底部展示的放大按钮
zoom_in_pdf = '//button[@id="zoomIn"]'    # 分享PDF时，上方展示的放大按钮
share_page_button = '//button[text()="Share Page"]'        # 分享PDF时，左下角展示的Share Page按钮
return_page_button = '//button[text()="Return"]'        # 分享PDF时，左下角展示的Return按钮
option_menu = '//div[@class="OptionMenu"]'      # 展开右上角的三个横杠
ultra_low_bandwidth = '//p[text()="Ultra-Low Bandwidth > "]'     # 点击右上角的三个横杠后，展示的Ultra-Low Bandwidth >
close_option_menu = '//div[@class="selected-border"]/../..'         # 关闭右上角的三个横杠
call_quality_span = '//span[text()="Call Quality"]'      # 点击右上角的三个横杠后，展示的Call Quality
participants_avatar = '//div[@class="Avatars"]'     # participant's avatar displays
AudioPlusModeShareDialog = '//div[@class="AudioPlusModeShareDialog"]'    # 下方的Audio+ Mode对话框
capture_and_share = '//button[text()="Capture and Share"]'    # Capture and Share按钮
# call通话过程中预期出现的提示信息
expect_text_1 = '//div[text()="Entering document sharing mode."]'
expect_text_2 = '//div[text()="You can now draw on the shared document"]'
expect_text_3 = '//div[text()="Exiting document sharing mode."]'
expect_text_4 = '//div[text()="You can now draw on the shared photo"]'
expect_text_5 = '//div[text()="Exiting Photo Mode"]'
expect_text_6 = '//div[text()="{}  has joined the call as an observer."]'
expect_text_7 = '//div[text()="{} left the call"]'
expect_text_8 = '//div[text()="Your invite to {} was sent successfully."]'
expect_text_9 = '//div[text()="Your call has been accepted."]'
expect_text_10 = '//div[text()="{} has turned off recording for this call."]'
expect_text_11 = '//div[text()="{} has enabled recording for this call."]'
expect_text_12 = '//div[text()="Now Receiving Help"]'
expect_text_13 = '//div[text()="Now Giving Help"]'
expect_text_14 = '//div[text()="The task field is frozen"]'
expect_text_15 = '//div[text()="The task field is unfrozen"]'
expect_text_16 = '//div[text()="{} has joined the call."]'
expect_text_17 = '//div[text()="{} (Receiver) left the call"]'
expect_text_18 = '//div[@class="subMessage" and contains(.,"Switched back to Face to Face mode.")]'
expect_text_19 = '//div[@class="subMessage" and contains(.,"Point at a task area")]'
expect_text_20 = '//div[@class="subMessage" and contains(.,"Point at a white background")]'
expect_text_21 = '//div[text()="Now Observing"]'
expect_text_22 = '//div[text()="PDF file is loading..."]'
expect_text_23 = '//div[text()="Tap the Share button to share the document"]'
expect_text_24 = '//div[text()="Receiving document from {}"]'
expect_text_25 = '//div[text()="Receiving photo from {}"]'
expect_text_26 = '//div[text()="Sending photo…"]'
expect_text_27 = '//div[text()="The upload of resource has been cancelled"]'
expect_text_28 = '//div[text()="Checking Network Quality"]'
expect_text_29 = '//div[text()="Ultra-Low Bandwidth Mode"]'
expect_text_30 = '//div[text()="Your camera is off. Start Video or share content."]'
expect_text_31 = '//div[text()="{} has joined the call."]'
expect_text_32 = '//div[text()="{} left the call"]'
expect_text_33 = '//div[text()="Switched back to Face to Face mode."]'
expect_text_34 = '//div[text()="The task field is frozen"]'
expect_text_35 = '//div[text()="Exiting document sharing mode."]'
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
witch_message_thread = '//div[text()="{}"]/..'                                                     # 哪一个用户的message
message_page_start_audio = '//div[@class="user_chat_buttons"]//span[text()="Audio+"]'           # 聊天中启动Audio+
message_page_start_video = '//div[@class="user_chat_buttons"]//span[text()="Video"]'            # 聊天中启动Video
invitation_dialog_cancel = '//button[@class="k-button" and text()="Cancel"]'                    # Cancel按钮
search_messages = '//div[@class="SearchMessages"]//input[@id="quick-search-text-box"]'          # Search Messages查询框
attach_particial_xpath = '//div[@class="attachmentName" and text()="{}"]/..//*[@*="#file"]'     # 会话中的附件xpath
# Calls页面
preview_container = '//div[@class="preview-container"]//img'                                    # 预览图
thumbnail_container = '//div[@class="attachment selectable "]/img'                              # 缩略图
play_video_button = '//span[text()="Play Video"]/..'                                            # 播放Video按钮
nav_left = "//*[@*='#nav_left']/.."                                                             # 左移按钮
nav_solid = "//*[@*='#nav_solid']/.."                                                           # 固定按钮
nav_hollow = "//*[@*='#nav_hollow']/.."                                                         # 空心按钮
nav_right = "//*[@*='#nav_right']/.."                                                           # 右移按钮
current_participant_div = "//div[@class='videoViews_4_{}  ']"                                   # 通话页面上展示的每个入会者
participants_title = "//div[@class='WebCall show']//span[@ref='eText']"                         # 通话页面上participants下的4个标题
co_host_right_button = '//span[text()="{}"]/../../../../..//*[@*="#angle_right"]/../..'            # Co-host旁边的>按钮
co_host_on = "//div[@class='ag-center-cols-container']//strong[text()='{}']/../../../../..//div[@class='react-toggle react-toggle--checked']"    # Co-Host状态为on
co_host_off = "//div[@class='ag-center-cols-container']//strong[text()='{}']/../../../../..//div[@class='react-toggle']"   # Co-Host状态为off
can_not_turn_off = "//div[@class='ag-center-cols-container']//strong[text()='{}']/../../../../..//div[@class='react-toggle react-toggle--checked react-toggle--disabled']"   #Co-Host状态不能改成off
can_not_remove = "//strong[text()='{}']/../../../../..//span[@class='disableRemove']"   #入会者不能被移除
turns_on_mic = "//*[@*='#mic_off']/.."   # 取消麦克风静音状态
mic_is_on = "//*[@*='#mic_on']/.."   # 麦克风开启状态
participant_mic_is_off = "//strong[text()='{}']/../../../../..//*[@*='#mic_off']/.."   # 入会者的麦克风状态是静音
every_role = "//div[@class='user-list']//strong"   # 点击切换role的图标后，展示的所有user
specific_which_user = "//div[@class='user-list']//strong[text()='{}']"   # 点击切换role的图标后，展示的具体的某个user
back_button_in_bottom = "//div[@class='user-footer']/span[text()='< Back']"   # MODE底部的Back按钮
continue_button_in_bottom = "//div[@class='user-footer']/button[text()='Continue']"      # MODE底部的Continue按钮
giver_help_mode = "//*[@*='#gh_on']"
receiver_help_mode = "//*[@*='#rh_on']"
observer_mode = "//*[@*='#ob_on']"
mute_which_participant = '//span[text()="{}"]/../../../../..//*[@*="#mic_on"]/../../..'   # co-host静音某个user
unmute_which_participant = '//span[text()="{}"]/../../../../..//*[@*="#mic_off"]/../../..'  # co-host尝试取消静音某个user
turn_on_co_host_button = '//div[@class="react-toggle"]/../..//div[@class="HLToggle"]'            # 开启co-host按钮
turn_off_co_host_button = '//div[@class="react-toggle react-toggle--checked"]/../..//div[@class="HLToggle"]'           # 关闭co-host按钮
co_host_button_unusable = '//div[@class="react-toggle react-toggle--checked react-toggle--disabled"]'     # 整个Participant置灰，无法选中
co_host_button_gray = '//div[@class="react-toggle react-toggle--disabled"]'     # 不可开启或者关闭co-host
PPECFA_button = '//div[@class="submenu-content"]//a[text()="End Call for All"]'    # participants页面的end_call_for_all按钮
ECFA_YES_button = '//button[@variant="secondary" and contains(.,"Yes")]'    # end call for all时的Yes按钮
collaboration_mode_flag = '//canvas[@id="webgl"]'                # Collaboration mode的标志
good_experience = 'good_experience'