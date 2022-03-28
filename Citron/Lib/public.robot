*** Settings ***
Library           Selenium2Library
Library           DateTime
Library           String
Library           python_Lib/ui_keywords.py
Resource          ../publicData/public_data.robot


*** Variables ***
# Browser Type
${browser_type}                     Chrome                                                              # Browser Type
# register
${register_website}                 https://app-stage.helplightning.net.cn/register/personal            # register personal website
${register_account}                 xpath=//button[contains(.,'Create My Help Lightning Account')]      # Create My Help Lightning Account
# log in
${citron_website}                   https://app-stage.helplightning.net.cn/                             # citron website
${crunch_website}                   https://crunch-stage.helplightning.net.cn/                          # crunch website
${loginname_input}                  xpath=//input[@autocomplete="username"]                             # 用户名输入框
${next_button}                      xpath=//button[@type="submit"]                                      # NEXT按钮
${loginpsd_input}                   xpath=//input[@autocomplete="current-password"]                     # 密码输入框
${login_button}                     xpath=//button[@type="submit"]                                      # LOG IN按钮
${accept_button}                    xpath=//button[contains(.,'ACCEPT')]                                # ACCEPT button
${button_of_popup}                  xpath=//div[@class="modal-header"]//button[@class="close"]          # Popover close button
${public_pass}                      *IK<8ik,8ik,                                                        # public password
${log_in_success_tag}               Welcome to                                                          # Sign of successful landing
# enter first menu tree
${enter_first_menu_tree}            xpath=//div[@role="tree"]/div[1]                                    # enter first menu tree
# enter workspace administration page
${enter_workspace_menu}             xpath=//div[@role="tree"]/div[2]                                    # workspace ADMINISTRATION Page menu
# enter group administration page
${enter_group_menu}                 xpath=//div[@role="tree"]/div[2]                                    # workspace ADMINISTRATION Page menu
# enter site administration page
${enter_site_menu}                  xpath=//div[@role="tree"]/div[3]                                    # site ADMINISTRATION Page menu
# Each small menu page
${enter_users}                      xpath=//span[contains(.,"Users")]                                   # Users Page menu
${enter_groups}                     xpath=//span[contains(.,'Groups')]                                  # Groups Page menu
${enter_analytics}                  xpath=//span[contains(.,'Analytics')]                               # Analytics page menu
${enter_calls}                      xpath=//span[contains(.,'Calls')]                                   # Calls page menu
${enter_workspaces}                 xpath=//span[contains(.,'Workspaces')]                              # Workspaces page menu
${enter_Workspace_settings}         xpath=//span[contains(.,'Workspace Settings')]                      # Workspace Settings menu
${enter_Site_settings}              xpath=//span[contains(.,'Site Settings')]                           # Site Settings menu
${enter_recents}                    xpath=//span[contains(.,'Recents')]                                 # normal Recents menu
${enter_contacts_page}              xpath=//span[contains(.,'Contacts')]                                # Contacts menu
${enter_primary_contacts}           xpath=//span[contains(.,'Primary Contact')]                         # Primary Contact page
${enter_personal_page}              xpath=//span[contains(.,'Personal')]                                # Personal page
${enter_favorites_page}             xpath=//span[contains(.,'Favorites')]                               # Favorites page
${enter_directory_page}             xpath=//span[contains(.,'Directory')]                               # Directory page


*** Keywords ***
Login
    [Arguments]    ${username}    ${password}
    Open Browser    ${citron_website}     ${browser_type}
    Sleep    1s
    Maximize Browser Window
    # 输入账号
    wait until element is visible   ${loginname_input}    10s
    Input Text    ${loginname_input}    ${username}
    # 点击NEXT
    wait until element is visible   ${next_button}     10s
    Click Button    ${next_button}
    # 输入密码
    wait until element is visible  ${loginpsd_input}      10s
    Input Password    ${loginpsd_input}    ${password}
    # 点击LOG IN
    wait until element is visible   ${login_button}    10s
    Click Button    ${login_button}
    Sleep    3s

Login_crunch
    Open Browser    ${crunch_website}     ${browser_type}
    Sleep    1s
    Maximize Browser Window
    Sleep    1s
    # 输入账号
    wait until element is visible    ${loginname_input}    10s
    Input Text    ${loginname_input}    ${crunch_site_username}
    # 点击NEXT
    wait until element is visible     ${next_button}    10s
    Click Button    ${next_button}
    # 输入密码
    wait until element is visible     ${loginpsd_input}    10s
    Input Password    ${loginpsd_input}    ${crunch_site_password}
    # 点击LOG IN
    wait until element is visible     ${login_button}    10s
    Click Button    ${login_button}
    Sleep    2s

Open_register_personal_website
    # Open register personal website
    Open Browser    ${register_website}    ${browser_type}
    Sleep    1s
    # Maximize Browser Window
    Maximize Browser Window
    wait until element is visible   ${register_account}

Login_site_admin
    # 登录系统
    Login    ${site_admin_username}    ${site_admin_password}
    sleep    3s
    ${count}  get element count  ${accept_button}
    Run Keyword If   '${count}'=='1'    click element   ${accept_button}
    sleep  1s
    Comment    弹框包含"Welcome to Help Lightning!"
    Wait Until Page Contains    ${log_in_success_tag}  20s
    sleep  1s
    # close 弹框
    wait until element is visible    ${button_of_popup}
    Click Button    ${button_of_popup}
    sleep    1s

Login_premium_user
    # 登录系统
    Login    ${crunch_site_username}    ${crunch_site_password}
    sleep    3s
    ${count}  get element count  ${accept_button}
    Run Keyword If   '${count}'=='1'    click element   ${accept_button}
    sleep  1s
    Comment    弹框包含"Welcome to"
    Wait Until Page Contains    ${log_in_success_tag}  20s
    sleep  1s
    # close 弹框
    wait until element is visible    ${button_of_popup}
    Click Button    ${button_of_popup}
    sleep    1s

Login_workspaces_admin
    # 登录系统
    Login    ${workspace_admin_username}     ${workspace_admin_password}
    sleep    3s
    ${count}  get element count  ${accept_button}
    Run Keyword If   '${count}'=='1'    click element   ${accept_button}
    sleep  1s
    Comment    弹框包含"Welcome to Help Lightning!"
    Wait Until Page Contains    ${log_in_success_tag}    20s
    sleep  1s
    # close 弹框
    wait until element is visible    ${button_of_popup}
    Click Button    ${button_of_popup}
    sleep    1s

Login_another_workspaces_admin
    # 登录系统
    Login    ${another_workspace_admin_username}     ${another_workspace_admin_password}
    sleep    3s
    ${count}  get element count  ${accept_button}
    Run Keyword If   '${count}'=='1'    click element   ${accept_button}
    sleep  1s
    Comment    弹框包含"Welcome to Help Lightning!"
    Wait Until Page Contains    ${log_in_success_tag}   20s
    sleep  1s
    # close 弹框
    wait until element is visible    ${button_of_popup}
    Click Button    ${button_of_popup}
    sleep    1s

Login_another_group_admin
    # 登录系统
    Login    ${another_group_admin_username}     ${another_group_admin_password}
    sleep    3s
    ${count}  get element count  ${accept_button}
    Run Keyword If   '${count}'=='1'    click element   ${accept_button}
    sleep  1s
    Comment    弹框包含"Welcome to Help Lightning!"
    Wait Until Page Contains    ${log_in_success_tag}   20s
    sleep  1s
    # close 弹框
    wait until element is visible    ${button_of_popup}
    Click Button    ${button_of_popup}
    sleep    1s

Login_workspaces_admin_one
    # 登录系统
    Login    ${workspace_admin_username_one}     ${workspace_admin_password_one}
    sleep    3s
    ${count}  get element count  ${accept_button}
    Run Keyword If   '${count}'=='1'    click element   ${accept_button}
    sleep  1s
    Comment    弹框包含"Welcome to Help Lightning!"
    Wait Until Page Contains    ${log_in_success_tag}   20s
    sleep  1s
    # close 弹框
    wait until element is visible    ${button_of_popup}
    Click Button    ${button_of_popup}
    sleep    1s

Login_group_admin
    # 登录系统
    Login    ${group_admin_username}    ${group_admin_password}
    sleep    3s
    ${count}  get element count  ${accept_button}
    Run Keyword If   '${count}'=='1'    click element   ${accept_button}
    sleep  1s
    Comment    弹框包含"Welcome to Help Lightning!"
    Wait Until Page Contains    ${log_in_success_tag}   20s
    sleep  1s
    # close 弹框
    wait until element is visible    ${button_of_popup}
    Click Button    ${button_of_popup}
    sleep    1s

Login_new_added_user
    [Arguments]    ${user_username}
    # 登录系统
    Login    ${user_username}    ${public_pass}
    sleep    3s
    ${count}  get element count  ${accept_button}
    Run Keyword If   '${count}'=='1'    click element   ${accept_button}
    sleep  1s
    Comment    弹框包含"Welcome to"
    Wait Until Page Contains    ${log_in_success_tag}   20s
    sleep  1s
    # close 弹框
    wait until element is visible    ${button_of_popup}
    Click Button    ${button_of_popup}
    sleep    1s

Login_new_added_user_whitout_workspaces
    [Arguments]    ${user_username}
    # 登录系统
    Login    ${user_username}    ${public_pass}
    wait until element is visible    xpath=//span[contains(.,'You have not been assigned to a Workspace in your Organization. Please contact your administrator.')]
    sleep  3s
    element should be visible    xpath=//a[contains(.,'Forgot Password?')]

Login_normal_for_calls
    # 登录系统
    Login    ${normal_username_for_calls}     ${normal_password_for_calls}
    sleep    3s
    ${count}  get element count  ${accept_button}
    Run Keyword If   '${count}'=='1'    click element   ${accept_button}
    sleep  1s
    Comment    弹框包含"Welcome to Help Lightning!"
    Wait Until Page Contains    ${log_in_success_tag}   20s
    sleep  1s
    # close 弹框
    wait until element is visible    ${button_of_popup}
    Click Button    ${button_of_popup}
    sleep    1s

Login_new_added_register_personal
    [Arguments]    ${user_username}
    # 登录系统
    Login    ${user_username}    ${public_pass}
    sleep    1s
    Comment    无法登录
    wait until page does not contain   ${log_in_success_tag}   20s

refresh_web_page
    # 刷新页面
    Execute JavaScript    window.location.reload()
    sleep   3s
    ${ele_count}   get element count    ${button_of_popup}
    Run Keyword If   '${ele_count}'=='1'    click element     ${button_of_popup}    # 关闭导航弹窗
    sleep   1s

swipe_browser_to_bottom
    # 滑动
    Execute Javascript     window.scrollTo(0,5000000)    #滑动到最底部

switch_window_to_first
    ${window}    Get Window Handles
    Switch Window    ${window}[0]

switch_window_to_second
    ${window}    Get Window Handles
    Switch Window    ${window}[1]

switch_window_to_third
    ${window}    Get Window Handles
    Switch Window    ${window}[2]

switch_window_to_fourth
    ${window}    Get Window Handles
    Switch Window    ${window}[3]

Close
    Close All Browsers