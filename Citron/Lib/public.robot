*** Settings ***
Library           Selenium2Library
Library           DateTime
Library           String
Library           python_Lib/ui_keywords.py
Resource          ../publicData/public_data.robot
Resource          ../public_switch/public_switch_rf.robot


*** Variables ***
# register
${register_website}                 ${citron_website}register/personal                                  # register personal website
${register_account}                 xpath=//button[contains(.,'Create My Help Lightning Account')]      # Create My Help Lightning Account
# log in
${login_citron_success_1}           ${citron_website}admin/workspace/users
${login_citron_success_2}           ${citron_website}admin/workspaces
${login_citron_messages}            ${citron_website}messages
${login_crunch_success}             ${crunch_website}users                                              # login crunch success
${loginname_input}                  xpath=//input[@autocomplete="username"]                             # 用户名输入框
${next_button}                      xpath=//button[text()="Next"]                                       # NEXT按钮
${loginpsd_display}                 xpath=//input[@style="display: block;"]                             # 密码输入框出现
${loginpsd_input}                   xpath=//input[@autocomplete="current-password"]                     # 密码输入框
${login_button}                     xpath=//button[text()="Log In"]                                     # LOG IN按钮
${crunch_login_button}              xpath=//button[text()="Login"]                                      # LOGIN按钮
${accept_button}                    xpath=//button[contains(.,'ACCEPT')]                                # ACCEPT button
${button_of_popup}                  xpath=//div[@class="modal-header"]//button[@class="close"]          # Popover close button
${public_pass}                      *IK<8ik,8ik,                                                        # public password
${log_in_success_tag}               Welcome to                                                          # Sign of successful landing
${currentAccount_button}            xpath=//button[@id="currentAccount"]                                # 当前账号按钮
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
${enter_recents}                    xpath=//span[contains(.,'Calls')]                                   # normal Recents menu
${enter_contacts_page}              xpath=//span[contains(.,'Contacts')]                                # Contacts menu
${enter_primary_contacts}           xpath=//span[contains(.,'Primary Contact')]                         # Primary Contact page
${enter_personal_page}              xpath=//span[contains(.,'Personal')]                                # Personal page
${enter_favorites_page}             xpath=//span[contains(.,'Favorites')]                               # Favorites page
${enter_directory_page}             xpath=//span[contains(.,'Directory')]                               # Directory page
${enter_messages_page}              xpath=//span[contains(.,'Messages')]                                # Messgaes page
# 填写在发送邀请邮件中的内容
${small_horse}                      You and I are dark horses
${big_horse}                        You And I Are Dark Horses
${I_am_horse}                       I Am Dark Horse
${jarvan_fourth}                    德玛西亚皇子+[]()
${jarvan_fourth_1}                  德玛西亚皇子+[]-()
${demacia}                          德玛西亚+[]-()
# 发送邀请邮件的类型
${MHS_link_email}                   MHS
${OTU_link_email}                   OTU
# 是否在当前页面
${not_currently_on}                 not_currently_on
# 特殊的user
${user_13857584759}                 Huiming.shi.helplightning+13857584759
${hlnauto_p1}                       hlnauto+p1


*** Keywords ***
Login
    [Arguments]    ${username}    ${password}
    Open Browser    ${citron_website}     ${BROWSER_TYPE}
    Sleep    1s
    Maximize Browser Window
    # 输入账号
    wait until element is visible   ${loginname_input}    20s
    Input Text    ${loginname_input}    ${username}
    # 点击NEXT
    wait until element is visible   ${next_button}     10s
    Click Button    ${next_button}
    FOR   ${i}    IN RANGE   0    90
        sleep   2s
        ${count_pwd}   get element count   ${loginpsd_display}
        Exit For Loop If    '${count_pwd}'=='1'
        ${count_next}   get element count   ${next_button}
        Run Keyword If      '${count_next}'=='1'    Click Button    ${next_button}
        Exit For Loop If    '${i}'=='89'
    END
    # 输入密码
    wait until element is visible   ${loginpsd_input}
    Input Password    ${loginpsd_input}    ${password}
    # 点击LOG IN
    wait until element is visible   ${login_button}    10s
    Click Button    ${login_button}
    FOR   ${i}    IN RANGE   0    89
        sleep  2
        ${url}=   Get Location
        Exit For Loop If    '${url}'=='${citron_website}'
        Exit For Loop If    '${url}'=='${login_citron_success_1}'
        Exit For Loop If    '${url}'=='${login_citron_success_2}'
        ${count_login}   get element count   ${login_button}
        Run Keyword If      '${count_login}'=='1'    Click Button    ${login_button}
        Exit For Loop If    '${i}'=='89'
    END

click_login_crunch_again
    Click Button    ${crunch_login_button}
    FOR   ${i}    IN RANGE   0    30
        ${url}=   Get Location
        Exit For Loop If    '${url}'=='${login_crunch_success}'
        Run Keyword If      '${url}'!='${login_crunch_success}'    sleep   2s
        Exit For Loop If    '${i}'=='29'
    END

Login_crunch
    Open Browser    ${crunch_website}     ${BROWSER_TYPE}
    Sleep    1s
    Maximize Browser Window
    Sleep    1s
    # 输入账号
    wait until element is visible    ${loginname_input}    10s
    Input Text    ${loginname_input}    ${crunch_site_username}
    # 点击NEXT
    wait until element is visible     ${next_button}    10s
    Click Button    ${next_button}
    FOR   ${i}    IN RANGE   0    90
        sleep   2s
        ${count_pwd}   get element count   ${loginpsd_display}
        Exit For Loop If    '${count_pwd}'=='1'
        ${count_next}   get element count   ${next_button}
        Run Keyword If      '${count_next}'=='1'    Click Button    ${next_button}
        Exit For Loop If    '${i}'=='89'
    END
    # 输入密码
    wait until element is visible     ${loginpsd_input}    20s
    Input Password    ${loginpsd_input}    ${crunch_site_password}
    # 点击LOG IN
    wait until element is visible     ${crunch_login_button}    10s
    Click Button    ${crunch_login_button}
    FOR   ${i}    IN RANGE   0    30
        ${url}=   Get Location
        Exit For Loop If    '${url}'=='${login_crunch_success}'
        Run Keyword If      '${url}'!='${login_crunch_success}'    sleep   2s
        Run Keyword If      '${i}'=='29'    click_login_crunch_again
    END
    Sleep    2s
    wait until element is visible    xpath=//h3[text()="Users"]     10s

Open_register_personal_website
    # Open register personal website
    Open Browser    ${register_website}    ${BROWSER_TYPE}
    Sleep    1s
    # Maximize Browser Window
    Maximize Browser Window
    wait until element is visible   ${register_account}

check_disclaimer
    FOR   ${i}    IN RANGE   0    8
        ${count}   get element count   ${accept_button}
        Run Keyword If    '${count}'=='1'    click element   ${accept_button}
        Exit For Loop If    '${count}'=='1'
        Run Keyword If   '${count}'=='0'    sleep   1s
    END
    sleep    1s
    ${count_again}   get element count   ${accept_button}
    Run Keyword If    '${count_again}'=='1'    click element   ${accept_button}

check_tutorial_again
    # close 弹框
    FOR   ${i}    IN RANGE   0    15
        ${count}   get element count   ${button_of_popup}
        Run Keyword If    '${count}'=='1'    click element   ${button_of_popup}
        Exit For Loop If    '${count}'=='1'
        Run Keyword If   '${count}'=='0'    sleep   1s
    END
    sleep    1s
    # 检查还有没有弹框
    ${count}   get element count    ${button_of_popup}
    Run Keyword If   '${count}'=='1'    click element   ${button_of_popup}

Login_site_admin
    # 登录系统
    Login    ${site_admin_username}    ${public_pass}
    # 检查是否有Disclaimer
    check_disclaimer
#    # 关闭tutorial
#    check_tutorial_again

Login_premium_user
    # 登录系统
    Login    ${crunch_site_username}    ${crunch_site_password}
    # 检查是否有Disclaimer
    check_disclaimer
#    # 关闭tutorial
#    check_tutorial_again

Login_workspaces_admin
    # 登录系统
    Login    ${workspace_admin_username}     ${public_pass}
    # 检查是否有Disclaimer
    check_disclaimer
#    # 关闭tutorial
#    check_tutorial_again

Login_another_workspaces_admin
    # 登录系统
    Login    ${another_workspace_admin_username}     ${public_pass}
    # 检查是否有Disclaimer
    check_disclaimer
#    # 关闭tutorial
#    check_tutorial_again

Login_another_group_admin
    # 登录系统
    Login    ${another_group_admin_username}     ${public_pass}
    # 检查是否有Disclaimer
    check_disclaimer
#    # 关闭tutorial
#    check_tutorial_again

Login_workspaces_admin_one
    # 登录系统
    Login    ${workspace_admin_username_one}     ${public_pass}
    # 检查是否有Disclaimer
    check_disclaimer
#    # 关闭tutorial
#    check_tutorial_again

Login_group_admin
    # 登录系统
    Login    ${group_admin_username}    ${public_pass}
    # 检查是否有Disclaimer
    check_disclaimer
#    # 关闭tutorial
#    check_tutorial_again

Login_new_added_user
    [Arguments]    ${user_username}
    # 登录系统
    Login    ${user_username}    ${public_pass}
    # 检查是否有Disclaimer
    check_disclaimer
#    # 关闭tutorial
#    check_tutorial_again

Login_new_added_user_whitout_workspaces
    [Arguments]    ${user_username}
    # 登录系统
    Open Browser    ${citron_website}     ${BROWSER_TYPE}
    Sleep    1s
    Maximize Browser Window
    # 输入账号
    wait until element is visible   ${loginname_input}    10s
    Input Text    ${loginname_input}    ${user_username}
    # 点击NEXT
    wait until element is visible   ${next_button}     10s
    Click Button    ${next_button}
    FOR   ${i}    IN RANGE   0    90
        sleep   2s
        ${count_pwd}   get element count   ${loginpsd_display}
        Exit For Loop If    '${count_pwd}'=='1'
        ${count_next}   get element count   ${next_button}
        Run Keyword If      '${count_next}'=='1'    Click Button    ${next_button}
        Exit For Loop If    '${i}'=='89'
    END
    # 输入密码
    wait until element is visible   ${loginpsd_input}
    Input Password    ${loginpsd_input}    ${public_pass}
    # 点击LOG IN
    wait until element is visible   ${login_button}    10s
    Click Button    ${login_button}
    # 出现提示信息
#    wait until element is visible    xpath=//span[contains(.,'You have not been assigned to a Workspace in your Organization. Please contact your administrator.')]
    wait until element is visible    xpath=//span[contains(.,'Your account has been deactivated. Please contact your administrator.')]
    sleep  3s
    element should be visible    xpath=//a[contains(.,'Forgot Password?')]

Login_normal_for_calls
    # 登录系统
    Login    ${normal_username_for_calls}     ${public_pass}
    # 检查是否有Disclaimer
    check_disclaimer
#    # 关闭tutorial
#    check_tutorial_again

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
    sleep   10s
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