#----------------------------------------------------------------------------------------------------#
# Chrome set up
from selenium import webdriver
from Citron.public_switch.public_switch_py import BROWSER_TYPE
if BROWSER_TYPE == 'Chrome':
    from selenium.webdriver.chrome.options import Options
    option = Options()
    option.add_argument("--disable-infobars")
    option.add_argument("start-maximized")
    option.add_argument("--disable-extensions")

    # Pass the argument 1 to allow and 2 to block
    option.add_experimental_option("prefs", {
        "profile.default_content_setting_values.notifications": 1,   # chrome开启通知
        "profile.default_content_setting_values.media_stream_mic": 1 ,   # chrome开启麦克风
        "profile.default_content_setting_values.media_stream_camera": 1    # chrome开启摄像头
    })
    # 忽略证书错误，不需要手动点高级选项
    option.add_argument('--ignore-certificate-errors')

elif BROWSER_TYPE == 'Firefox':
    from selenium.webdriver.firefox.options import Options

    option = Options()
    option.add_argument("--disable-infobars")
    option.add_argument("start-maximized")
    option.add_argument("--disable-extensions")

    # Pass the argument 1 to allow and 2 to block
    option.set_capability("prefs", {
        "profile.default_content_setting_values.notifications": 1,
        "profile.default_content_setting_values.media_stream_mic": 1
    })
    # 忽略证书错误，不需要手动点高级选项
    option.add_argument('--ignore-certificate-errors')
    profile = webdriver.FirefoxProfile()
    profile.set_preference('intl.accept_languages', 'en-US, en')
    profile.set_preference("permissions.default.microphone", 1)
    profile.set_preference("webdriver_accept_untrusted_certs", True)
# ----------------------------------------------------------------------------------------------------#
# variable
test_web = 'https://app-stage.helplightning.net.cn/'
username_input = '//input[@autocomplete="username"]'
password_input = '//input[@autocomplete="current-password"]'
submit_button = '//button[@type="submit"]'
next_button = '//button[text()="Next"]'
login_button = '//button[text()="Log In"]'
search_input = '//input[@id="filter-text-box"]'
add_comment = '//textarea[@placeholder="Add a comment..."]'
accept_disclaimer = '//button[@class="pull-right btn btn-primary"]'     # ACCEPT Disclaimer when call或者就只是ACCEPT Disclaimer
close_tutorial_button = '//div[@class="modal-header"]//button[@class="close"]'
count_of_list = '//div[@class="ag-center-cols-container"]/div'
click_call_button = '//button[@class="k-button callButton"]'
anwser_call_button = '//button[@class="k-button success-btn big-btn"]'
external_join_call_anwser_button = '//button[contains(.,"Answer")]'
five_star_high_praise = '//span[@class="star"]/div[contains(.,"Excellent")]'
end_call_button = "//div[@class='InCall']//div[@class='menu']//*[@*='#phone_end_red']"    # 结束Call的红色按钮
add_tag_input = '//input[@placeholder="Add tags to filter calls..."]'       # call结束后的add tag
add_tag_input_after = '//span[@class="k-searchbar"]/input[@type="text"]'    # call结束后已经添加tag后，再添加tag
end_call_before_connecting = '//button[@class="btn btn-lg btn-danger"]'
invite_user_div = "//div[@class='InCall']//*[@*='#options_menu']/.."   # 通话中界面右上角的三个横岗
enter_invite_user_page = '//span[contains(.,"Invite")]/../../div[@class="submenu-container"][1]'
enter_debug_page = '//span[contains(.,"Invite")]/../../div[@class="submenu-container"][2]'
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
recents_page = "//span[contains(.,'Recents')]"
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
video_on_button = "//div[@class='InCall']//*[@*='#video_on']"
return_vidoe_on = '//div[@class="submenu-icons"]//span[contains(.,"amera")]/..'
f2f_on_mode = "//div[@class='InCall']//*[@*='#f2f_on']"
count_of_call_user = '//div[@class="F2FVideo ShowOpenTokVideos"]/div'
search_by_email = '//input[@id="user-search-email"]'
select_your_role = '//div[@class="menu roleMenu"]/div[@class="menu withsub  "]'