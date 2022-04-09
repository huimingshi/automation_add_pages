*** Settings ***
Library           Selenium2Library
Library           OperatingSystem
Resource          ../../Lib/small_range_resource.robot
Resource          ../../Lib/public.robot
Force Tags        small_range


*** Test Cases ***
Small_range_624
    [Documentation]     admin removes on-call group from citron	on-call group disappears  from team and favorite tab
    [Tags]    small range 624 line
    # Login_premium_user
    Login_premium_user
    switch_to_created_workspace    ${created_workspace}
    enter_workspace_groups_page
    # 创建一个新的on_call group
    ${group_name}    admin_add_on_call_group
    # 在Group页面搜索group
    page_search    professional_on_call_group     1
    # 专业的on_call_group  添加On-Call Group Visibility   为刚创建的on-call group
    modify_group_on_call_group_visibility    ${group_name}
    # close browser
    Close

    # professional_on_call_group  中的User  Huiming.shi.helplightning+random_2  登录
    Login_new_added_user    ${random_2_username}
    # 在Contacts页面，搜索刚创建的on-call group
    page_search   ${group_name}   1
    # 把刚创建的on-call group添加到favorite
    add_to_favorite_from_all_page
    # 进入Favorites页面
    enter_favorites_page
    page_search   ${group_name}   1
    # close browser
    Close

    # Login_premium_user
    Login_premium_user
    switch_to_created_workspace     ${created_workspace}
    enter_workspace_groups_page
    # 在Contacts页面，搜索刚创建的on-call group
    page_search   ${group_name}   1
    # admin removes on-call group from citron
    delete_someone_group
    # close browser
    Close

    # professional_on_call_group  中的User  Huiming.shi.helplightning+random_2  登录
    Login_new_added_user    ${random_2_username}
    # 在Contacts页面，搜索刚创建的on-call group
    page_search   ${group_name}   0
    # 进入Favorites页面
    enter_favorites_page
    page_search   ${group_name}   0
    [Teardown]  Close

Set_Declaimer_delete_user_is_selected_User_clicks_Decline_button
    [Documentation]     Set Declaimer ->'delete user' is selected    User clicks Decline button
    [Tags]    small range 789-798 lines
    [Setup]     run keywords    Login_workspaces_admin
    ...         AND             enter_workspace_settings_page       # 进入settings页面
    ...         AND             expand_option_delete_user           # EXPAND delete user 选项
    ...         AND             set_disclaimer_is_on                # 设置Disclaimer为open状态
    ...         AND             set_delete_user_open                # 设置delete user为open状态
    # 进入users页面
    enter_workspace_users_page
    # 新建一个normal user
    ${random}   get_random_number
    ${email}   add_normal_user   ${random}
    # 根据邮件打开链接并设置密码
    fill_password_mailbox
    # Close driver
    Close

    ######  797 line
    # Login App with Enterprise/Premium user who doesn't accept the disclaimer
    user_login_citron_without_accept_disclaimer    ${email}
    # Disclaimer window should be shown up
    check_appear_disclaimer
    # User clicks Decline button
    click_decline_disclaimer
    # Click 'Cancel' button
    cancel_erase_my_account
    # Return to the disclaimer window
    check_appear_disclaimer

    ###### 789,790,794 lines
    # User clicks Decline button
    click_decline_disclaimer
    # Delete alert confirm 1 pops up
    alert_appear_after_click_decline_disclaimer
    # Click 'Erase' button
    confirm_erase_my_account
    # Delete Alert confirm 2 pops up
    alert_appear_after_click_erase_my_account
    # Click 'Cancel' button
    cancel_erase_my_account
    # Return to the disclaimer window
    check_appear_disclaimer

    ###### 790,791lines
    # click_decline_disclaimer
    click_decline_disclaimer
    # Click 'Erase' button
    confirm_erase_my_account
    # Click 'Erase' button again
    confirm_erase_my_account
    # Returns to login page without user's info
    login_page_without_user_info
    # User A relogs in, VP: Alert hasn't User A account
    erased_user_re_login   ${email}
    # Close driver
    Close

    ###### 792 line
    # Login crunch
    Login_crunch
    # 进入crunch的Audit Logs页面
    enter_enterprises_audit_log
    # In Crunch to check this audit log should be recorded.
    ${LogList}    get_all_logs_in_audit_logs
    log_in_crunch_is_correct    User ${random}    ${LogList}
    log_in_crunch_is_correct    was deleted after declining the disclaimer.     ${LogList}
    log_in_crunch_is_correct    has declined the Disclaimer text.     ${LogList}
    log_in_crunch_is_correct    property 'disclaimer_accepted' to 'false'.    ${LogList}
    # Close driver
    Close

    ###### 793 line
    # In Citron -> Admin -> Users, to check this user is not in Active User & Deactive User & Invitation User List.
    Login_workspaces_admin
    # 进入users页面
    enter_workspace_users_page
    # Active User 中查询 不存在
    page_search   ${random}   0
    # Deactive User 中查询 不存在
    enter_users_deactive_user
    page_search   ${random}   0
    # Invitation User 中查询 不存在
    enter_users_invitations
    page_search   ${random}   0
    [Teardown]  Close

Set_Declaimer_delete_user_is_selected_User_clicks_Accept_button
    [Documentation]     Set Declaimer ->'delete user' is selected    User clicks Accept button.
    [Tags]    small range 799 line
    [Setup]     run keywords    Login_workspaces_admin
    ...         AND             enter_workspace_settings_page       # 进入settings页面
    ...         AND             expand_option_delete_user           # EXPAND delete user 选项
    ...         AND             set_disclaimer_is_on                # 设置Disclaimer为open状态
    ...         AND             set_delete_user_open                # 设置delete user为open状态
    # 进入users页面
    enter_workspace_users_page
    # 新建一个normal user
    ${random}   get_random_number
    ${email}   add_normal_user   ${random}
    # 根据邮件打开链接并设置密码
    fill_password_mailbox
    # Close driver
    Close

    ######  799 line
    # Login App with Enterprise/Premium user who doesn't accept the disclaimer
    user_login_citron_without_accept_disclaimer    ${email}
    # Disclaimer window should be shown up
    check_appear_disclaimer
    # User clicks Accept button.
    click_accept_disclaimer
    # VP: User should successfully log in App.
    users_successfully_login

    # User kill App, and then re-open App
    Close
    user_login_citron_without_accept_disclaimer    ${email}
    # User auto-logs in App without Disclaimer window.
    user_login_without_disclaimer
    [Teardown]  Close

Set_Declaimer_delete_user_is_not_selected_User_clicks_Decline_button
    [Documentation]     Set Declaimer ->'delete user' is NOT selected    User clicks Decline button
    [Tags]    small range 803 line
    [Setup]     run keywords    Login_workspaces_admin
    ...         AND             enter_workspace_settings_page       # 进入settings页面
    ...         AND             expand_option_delete_user           # EXPAND delete user 选项
    ...         AND             set_disclaimer_is_on                # 设置Disclaimer为open状态
    ...         AND             set_delete_user_close               # 设置delete user为close状态
    ...         AND             reset_all_accepted_disclaimers      # Reset All Accepted Disclaimers
    ...         AND             Close                               # close browser
    # Login App with Enterprise/Premium user who doesn't accept the disclaimer
    user_login_citron_without_accept_disclaimer      Huiming.shi.helplightning+test_disclaimer@outlook.com
    # Disclaimer window should be shown up
    check_appear_disclaimer
    # User clicks Decline button.
    click_decline_disclaimer
    # VP: User should be navigate to Login Page.
    login_page_without_user_info
    [Teardown]  Close

Set_Declaimer_delete_user_is_not_selected_User_clicks_Accept_button
    [Documentation]     Set Declaimer ->'delete user' is NOT selected    User clicks Accept button
    [Tags]    small range 804 line
    [Setup]     run keywords    Login_workspaces_admin
    ...         AND             enter_workspace_settings_page       # 进入settings页面
    ...         AND             expand_option_delete_user           # EXPAND delete user 选项
    ...         AND             set_disclaimer_is_on                # 设置Disclaimer为open状态
    ...         AND             set_delete_user_close               # 设置delete user为close状态
    ...         AND             reset_all_accepted_disclaimers      # Reset All Accepted Disclaimers
    ...         AND             Close                               # close browser
    # Login App with Enterprise/Premium user who doesn't accept the disclaimer
    user_login_citron_without_accept_disclaimer      Huiming.shi.helplightning+test_disclaimer@outlook.com
    # Disclaimer window should be shown up
    check_appear_disclaimer
    # User clicks Accept button.
    click_accept_disclaimer
    # VP: User should successfully log in App.
    users_successfully_login
    [Teardown]  Close

Set_Declaimer_delete_user_is_not_selected_user_S_belong_to_Workspace_WS1_WS2_and_WS3
    [Documentation]     user S belong to Workspace WS1, WS2, and WS3;  Each workspace has its own disclaimer content;
    [Tags]    small range 812-816 line
    [Setup]     run keywords    Login_premium_user
    ...         AND             enter_workspace_settings_page       # 进入settings页面
    ...         AND             expand_option_delete_user           # EXPAND delete user 选项
    ...         AND             set_disclaimer_is_on                # 设置Disclaimer为open状态
    ...         AND             set_delete_user_close               # 设置delete user为close状态
    ...         AND             switch_to_second_workspace          # 切换到第二个workspace-Canada
    ...         AND             expand_option_delete_user           # EXPAND delete user 选项
    ...         AND             set_disclaimer_is_on                # 设置Disclaimer为open状态
    ...         AND             set_delete_user_close               # 设置delete user为close状态
    ...         AND             switch_to_third_workspace           # 切换到第三个workspace-Slytherin 🐍
    ...         AND             expand_option_delete_user           # EXPAND delete user 选项
    ...         AND             set_disclaimer_is_on                # 设置Disclaimer为open状态
    ...         AND             set_delete_user_close               # 设置delete user为close状态
    # 进入users页面
    enter_workspace_users_page
    # 新建一个normal user
    ${random}   get_random_number
    ${email}   add_normal_user   ${random}
    # 进入Site Administration目录树中的Users页面
    enter_site_users_page
    # 在这个页面查询刚添加的user
    page_search   ${email}   1
    # 点击Details按钮
    click_Users_user_details
    # 使得这个user处于三个WS中，目前已处于第三个WS
    make_user_belong_to_three_WS    Canada    BigAdmin Premium
    # 根据邮件打开链接并设置密码
    fill_password_mailbox
    # Close driver
    Close

    ###### 813,814,816 lines
    # User S login，进入第一个WS
    user_login_citron_without_accept_disclaimer    ${email}
    # User S decline disclaimer of WS1
    check_appear_disclaimer
    click_decline_disclaimer
    # VP: User S switch to WS2
    # User S decline disclaimer of WS2
    check_appear_disclaimer
    click_decline_disclaimer
    # User S decline disclaimer of WS3
    check_appear_disclaimer
    click_decline_disclaimer
    # VP: User S is force logout
    login_page_without_user_info
    # close driver
    Close

    ###### 815 line
    user_login_citron_without_accept_disclaimer    ${email}
    # User S decline disclaimer of WS1
    check_appear_disclaimer
    click_decline_disclaimer
    # VP: User S switch to WS2
    # User S decline disclaimer of WS2
    check_appear_disclaimer
    click_decline_disclaimer
    # User S decline disclaimer of WS3
    check_appear_disclaimer
    click_accept_disclaimer
    # 关闭导航页面
    close_tutorial
    # User S click workspace list	VP: WS1, WS2 and WS3 still show in the option list, even disclaimer is declined
    ${WSList}   all_WS_show_in_option_list    3
    string_in_list_object    BigAdmin Premium   ${WSList}
    string_in_list_object    Canada   ${WSList}
    string_in_list_object    Slytherin   ${WSList}
    [Teardown]  Close

#Set_Declaimer_delete_user_is_selected_user_S_belong_to_Workspace_WS1_WS2_and_WS3
#    [Documentation]     Site Admin set "delete user" for disclaimer of WS1    user S belong to Workspace WS1, WS2, and WS3
#    [Tags]    small range 817-819 line  ，有bug：https://vipaar.atlassian.net/browse/CITRON-3278
#    [Setup]     run keywords    Login_premium_user
#    ...         AND             enter_workspace_settings_page       # 进入settings页面
#    ...         AND             expand_option_delete_user           # EXPAND delete user 选项
#    ...         AND             set_disclaimer_is_on                # 设置Disclaimer为open状态
#    ...         AND             set_delete_user_open                # 设置delete user为open状态
#    ...         AND             switch_to_second_workspace          # 切换到第二个workspace-Canada
#    ...         AND             expand_option_delete_user           # EXPAND delete user 选项
#    ...         AND             set_disclaimer_is_on                # 设置Disclaimer为open状态
#    ...         AND             set_delete_user_close               # 设置delete user为close状态
#    ...         AND             switch_to_third_workspace           # 切换到第三个workspace-Slytherin 🐍
#    ...         AND             expand_option_delete_user           # EXPAND delete user 选项
#    ...         AND             set_disclaimer_is_on                # 设置Disclaimer为open状态
#    ...         AND             set_delete_user_close               # 设置delete user为close状态
#    # 进入users页面
#    enter_workspace_users_page
#    # 新建一个normal user
#    ${random}   get_random_number
#    ${email}   add_normal_user   ${random}
#    # 进入Site Administration目录树中的Users页面
#    enter_site_users_page
#    # 在这个页面查询刚添加的user
#    page_search   ${email}   1
#    # 点击Details按钮
#    click_Users_user_details
#    # 使得这个user处于三个WS中，目前已处于第三个WS
#    make_user_belong_to_three_WS    Canada    BigAdmin Premium
#    # 根据邮件打开链接并设置密码
#    fill_password_mailbox
#    # Close driver
#    Close
#
#    # User S login，进入第一个WS
#    user_login_citron_without_accept_disclaimer    ${email}
#    # User S decline disclaimer of WS1, and confirm delete user
#    check_appear_disclaimer         # 检查是否有Disclaimer
#    click_decline_disclaimer        # 点击decline
#    confirm_erase_my_account        # 点击erase_my_account
#    confirm_erase_my_account        # 再次点击erase_my_account
#    # VP: user s is switch to WS2
#    check_appear_disclaimer         # 检查是否有Disclaimer
#    # # uses S logout and login again
#    Close
#
#    # User S login，进入第二个WS
#    user_login_citron_without_accept_disclaimer    ${email}
#    # VP: disclaimer of WS 2 is shown
#    check_appear_disclaimer         # 检查是否有Disclaimer
#    # 点击accept
#    click_accept_disclaimer
#    # VP: WS1 is no long exist in Workspace option list.
#    ${WSList}   all_WS_show_in_option_list    2
#    string_in_list_object    Canada   ${WSList}
#    string_in_list_object    Slytherin   ${WSList}
#    [Teardown]  Close
