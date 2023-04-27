*** Settings ***
Library           Selenium2Library
Library           OperatingSystem
Resource          ../../Lib/small_range_resource.robot
Resource          ../../Lib/public.robot
Force Tags        small_range


*** Test Cases ***
User_without_a_workspace_try_to_login
    [Documentation]    User without a workspace try to login
    [Tags]    small range 7 line
    # User without a workspace try to login
    Login_without_check   ${without_WS_user}
    # VP: msg like "You have not been assign to a workspace in your organization, please contact your administrator"
    your_count_has_been_deactived
    [Teardown]    Close

#Register_personal
#    [Documentation]    Tutorial
#    [Tags]    small range 12-18 lines,新版本导致登录后没有tutorial，脚本不适用
#    # User logs in App firstly
#    user_login_citron_without_close_tutorial   ${normal_username_for_calls}
#    # No click 'Let's go!' button, kill App, then reopen App	VP: Show tutorial screen
#    refresh_browser_tutorial
#    # click 'Let's go!' button	 Show next page of tutorial page	  Clicks 'Next' button	 Show next page of tutorial page   Clicks 'Next' button until the last page
#    click_next_until_last_page
#    # kill App, then reopen App	   VP: Show the first page of tutorial screen
#    refresh_browser_tutorial
#    # Last page	Clicks 'Get Started' button	  VP: Tutorial page disappeared
#    last_page_click_get_started
#    # Clear cache  Another user logs in App firstly	  VP: tutorial page should show up.
#    user_login_citron_without_close_tutorial   ${normal_username_for_calls_B}
#    # In last page of tutorial, clicks 'Close' button    Tutorial page disappeared
#    last_page_click_get_started
#    # User re-login App	VP: No Tutorial screen
#    log_out_from_citron
#    re_log_in_citron_no_tutorial   ${normal_username_for_calls_B}
#    # kill App, then reopen App	VP: No tutorial screen
#    log_out_from_citron
#    re_log_in_citron_no_tutorial   ${personal_user_username}
#    [Teardown]    Close

Reset_Password
    [Documentation]    Reset Password
    [Tags]    small range 21 line
    # open citron without password
    open_citron_without_password   ${normal_username_for_calls}
    # send reset password email
    send_reset_password_email
    # Enter a wrong password
    enter_a_wrong_password
    [Teardown]    Close

Allow_Users_to_Enter_their_Mobile_Number
    [Documentation]    Allow Users to Enter their Mobile Number
    [Tags]    small range 41-44 lines
    # log in with normal user
    Login_new_added_user   ${a_normal_test_username}
    # enter My account page
    enter_my_account_page
    # Tab should move sequentially from Username to Name to Title   Phone is behind Location.
    check_my_account_elements_location
    # User update the others fields without Phone, And then clicks Update button
    ${random}   update_my_account_fields
    # Enter the wrong phone number with correct country code	VP: there is an alert message to pop up.
    enter_phone_with_country_code   8612345678911    1    cancel
    # Enter the correct phone number with wrong country code	VP: there is an alert message to pop up.
    enter_phone_with_country_code   1115951747996    1    cancel
    # Enter the valid phone number with country code
    enter_phone_with_country_code   8615951747997    0    confirm
    # Enter the valid phone number with country code
    enter_phone_with_country_code   8615951747996    0    confirm
    # the Phone number should be successfully saved
    my_account_fields_saved_successfully   ${random}
    # log in with crunch site admin
    Login_crunch
    # enter crunch Audit Logs page
    enter_enterprises_audit_log
    # verify_option_delete_user_recorded_in_audit_log
    ${LogList}   get_all_logs_in_audit_logs
    log_in_crunch_is_correct     property 'phone' to '+8615951747996'     ${LogList}
    [Teardown]    Close

Turn_on_User_Directory_case
    [Documentation]    Turn on User Directory
    [Tags]    small range 61 lines
    # log in citron with site admin
    Login_site_admin
    # enter Workspace Settings page
    enter_workspace_settings_page
    # Turn on User Directory
    turn_on_user_directory
    # log in citron with workspace admin
    Login_workspaces_admin
    # All clients will show the Directory tab on the dock
    show_the_directory_tab_on_the_dock   1
    [Teardown]    Close

Turn_off_User_Directory_case
    [Documentation]    Turn off User Directory
    [Tags]    small range 62 lines
    # log in citron with site admin
    Login_site_admin
    # enter Workspace Settings page
    enter_workspace_settings_page
    # Turn off User Directory
    turn_off_user_directory
    # log in citron with workspace admin
    Login_workspaces_admin
    # All clients will not show the Directory tab on the dock
    show_the_directory_tab_on_the_dock   0
    [Teardown]    Close

User_Directory_open_five_view
    [Documentation]    User Directory  Open Directory view   Open Team contact view   Open Personal contact view   Open Favorite view   Open Recent view
    [Tags]    small range 66-78 lines
    [Setup]     run keywords    Login_workspaces_admin   # log in citron with workspaces user
    ...         AND             enter_workspace_settings_page   # enter workspace settings page
    ...         AND             close_disable_external_users    # Switch "Disable External Feature" off
    ...         AND             turn_on_user_directory        # Switch "Workspace Directory" on
    # enter Directory page
    enter_contacts_page
    enter_directory_page
    # Search with name   Search with title   Search with location
    directory_search_with_name_title_location
    # Unfavorite the contact in favorite tab
    Unfavorite_the_contact_in_favorite_tab
    # Unfavorite the contact in Directory view
    Unfavorite_the_contact_in_Directory_view
    # enter Contacts Team page
    enter_contacts_page
    # Search with name   Search with title   Search with location
    team_search_with_name_title_location
    # Search with name   Search with title   Search with location
    personal_search_with_name_title_location
    # enter Favorite page
    enter_favorites_page
    # Search with name   Search with title   Search with location
    favorite_search_with_name_title_location
    # enter Recents page
    enter_recents_page
    # Title and location should show under user's name if contact has title or location.
    check_three_field_position
    [Teardown]    Close

Contact_Pre_condition_user_belongs_to_workspace_WS1_and_WS2
    [Documentation]    Contact   Pre-condition: user belongs to workspace WS1 and WS2
    [Tags]    small range 34-38 lines
    [Setup]     run keywords    Login_premium_user   # log in citron with premiun user
    ...         AND             make_sure_workspaces_disable_external_feature   close_feature   close_feature   #  # workspace WS1 has "Disable External Feature"=ON; workspace WS2 has "Disable External Feature"=ON;
    # VP: App show first workspace name of workspace options
    show_first_workspace_name
    # enter contact page
    enter_contacts_page
    # User currently is on WS1	User open Team	User switch to WS2	VP: Team contact list is update to WS2
    switch_workspace_check_user   ${first_team_username}
    # enter Personal contact page
    enter_personal_contact_page
    # User open Personal contact 	User switch to WS2	VP: Personal contact is updated to WS2
    switch_workspace_check_user   ${first_personal_username}
    # enter favorite page
    enter_favorites_page
    # User open Favorites	User switch to WS2	VP: Favorites list is update to WS2
    switch_workspace_check_user   ${first_line_username}
    # enter recents page
    enter_recents_page
    # User open Recents	User switch to WS2	VP: Recents list is update to WS2
    switch_workspace_check_recents_list
    [Teardown]    Close

User_Directory_Pre_conditron_User_belong_to_2_workspaces_WS1_and_WS2
    [Documentation]    User Directory   Pre-condition: user belongs to workspace WS1 and WS2
    [Tags]    small range 79-83 lines
    [Setup]     run keywords    Login_premium_user      # log in citron with premiun user
    ...         AND             enter_workspace_settings_page        # enter workspace settings page
    ...         AND             turn_on_user_directory          # Enable Directory feature for WS1
    ...         AND             switch_to_second_workspace          # switch to second workspace
    ...         AND             enter_workspace_settings_page           # enter second workspace workspace settings page
    ...         AND             turn_on_user_directory          # Enable Directory feature for WS2
    ...         AND             switch_to_first_workspace         # switch to first workspace
    # User is currently on WS1
    back_to_directory_page
    # User open Directory tab	User switch to WS2	VP: Directory it updated to WS2;
    switch_workspace_check_directory
    # Disable Directory feature for WS2  	User is currently on WS1
    enter_workspace_settings_page  # enter workspace settings page
    turn_off_user_directory  # Disable Directory feature for WS2
    switch_to_first_workspace  # switch to first workspace
    back_to_directory_page    # User is currently on WS1
    # User open Directory tab	User switch to WS2	VP: Hide directory tab after switched to WS2
    switch_to_second_workspace   # switch to second workspace
    show_the_directory_tab_on_the_dock   0  # Hide directory tab after switched to WS2
    [Teardown]    Close

Disable_External_Users_Switch_Disable_External_Feature_on_from_citron_for_a_specific_workspace
    [Documentation]    Disable External Users   Switch "Disable External Feature" on from citron for a specific workspace
    [Tags]    small range 91，92，101 lines
    [Setup]     run keywords    Login_premium_user   # log in citron with workspaces user
    ...         AND             switch_to_first_workspace       # 切换到第一个WS
    ...         AND             enter_workspace_settings_page   # enter workspace settings page
    ...         AND             open_disable_external_users    # Switch "Disable External Feature" on from citron for a specific workspace
    ...         AND             Close    # close browser
    # log in citron with an expert user
    Login_new_added_user    ${switch_workspace_username}
    # 切换到第一个WS
    switch_to_first_workspace
    # enter Favorotes page
    enter_favorites_page
    # this site workspace user should not see personal user and user from another site workspace in Recent/Favorites tab
    external_user_is_invisible
    # enter Recents page
    enter_recents_page
    # this site workspace user should not see personal user and user from another site workspace in Recent/Favorites tab
    external_call_record_is_invisible
    # close browser
    Close

    # Switch "Disable External Feature" off from citron
    Login_premium_user
    # 切换到第一个WS
    switch_to_first_workspace
    enter_workspace_settings_page
    close_disable_external_users
    Close

    # log in citron with an expert user
    Login_new_added_user    ${switch_workspace_username}
    # 切换到第一个WS
    switch_to_first_workspace
    # Personal contact tab is back.
    enter_personal_contact_page
    [Teardown]    Close

In_Citron_update_the_members_of_groups_and_update_the_display_name_Avatar_of_one_member_of_group
    [Documentation]    In Citron update the members of groups    In Citron update the display name & Avatar of one member of group
    [Tags]    small range 29-30 lines
    [Setup]     run keywords    Login_workspaces_admin   # log in citron with workspaces user
    ...         AND             enter_workspace_settings_page   # enter workspace settings page
    ...         AND             close_disable_external_users    # Switch "Disable External Feature" off from citron for a specific workspace
    # get random number
    ${random}   get_random_number
    # enter contact page
    enter_contacts_page
    refresh_web_page
    # search contact in team
    team_page_search   ${random}   0
    # enter User page
    enter_workspace_users_page
    # add a normal user
    ${email}  add_normal_user   ${random}
    # enter contact page
    enter_contacts_page
    # In Citron update the members of groups
    team_page_search   ${random}   1
    # get user info before modified
    get_user_info     ${random}     data:image/png;base64
    # get random number
    ${random_new}   get_random_number
    # enter User page
    enter_workspace_users_page
    # search contact in Users
    page_search  ${random}  1
    # modify user name & Avatar
    modify_user_name_avator   ${random_new}
    # enter contact page
    enter_contacts_page
    # In Citron update the members of groups
    team_page_search   ${random_new}   1
    # get user info before modified
    get_user_info   ${random_new}    https://s3.cn-north-1
    [Teardown]   Close

User_A_opens_Team_contact_tab
    [Documentation]    Show unreachable users	Show unreachable user status	Expert user A signs in.	Expert user B exists in team contact tab. User B never signed into HL.
    [Tags]    small range  109  line
    [Setup]     run keywords    Login_premium_user   # big_admin log in
    ...         AND             enter_workspace_settings_page   # enter workspace setting page
    ...         AND             close_disable_external_users    # set setting 'Disable External Users button' off in WS1
    ...         AND             Close  # close browser
    # log in citron with site admin
    Login_new_added_user    ${switch_workspace_username}
    # 切换到第一个WS
    switch_to_first_workspace
    # search user in contacts page
    team_page_search   ${never_log_in_name}   1
    # VP: User B displays with greyed out pattern, including the icon, all text (name, title, location), but not including the favorite star.
    check_one_user_unreachable_in_team      unreachable
    [Teardown]    Close

Favorite_unreachable_users
    [Documentation]    User A favorite the unreachable user B from team contact tab.
    [Tags]    small range  116+117  line
    [Setup]     run keywords    Login_premium_user   # big_admin log in
    ...         AND             enter_workspace_settings_page   # enter workspace setting page
    ...         AND             close_disable_external_users    # set setting 'Disable External Users button' off in WS1
    ...         AND             Close  # close browser
    # log in citron with site admin
    Login_new_added_user    ${switch_workspace_username}
    # 切换到第一个WS
    switch_to_first_workspace
    # 在 Team page查询user
    team_page_search    ${never_log_in_name}   1
    # 把userB添加到favorite中
    add_to_favorite_from_all_page
    # 进入Favorites页面
    enter_favorites_page
    # 在Favorite页面进行查询user
    favorites_page_search    ${never_log_in_name}   1
    # VP: User B displays with greyed out pattern, including the icon, all text (name, title, location), but not including the favorite star.
    check_one_user_unreachable     unreachable
    # User A unfavorite user B from Favorite tab.
    unfavorite_user_from_all_pages
    # 在Favorite页面进行查询user
    favorites_page_search    ${never_log_in_name}   0
    # 返回Team tab页面
    enter_contacts_page
    # 在 Team page查询user
    team_page_search    ${never_log_in_name}   1
    # 把userB添加到favorite中
    add_to_favorite_from_all_page
    # User A unfavorite user B from Team contact tab.
    unfavorite_user_from_team_page
    # 进入Favorites页面
    enter_favorites_page
    # 在Favorite页面进行查询user
    favorites_page_search    ${never_log_in_name}   0
    [Teardown]    Close

User_A_taps_unreachable_user_B_from_team_contacts_tab
    [Documentation]    User A taps unreachable user B from team contacts tab.
    [Tags]    small range  118  line
    [Setup]     run keywords    Login_premium_user   # big_admin log in
    ...         AND             enter_workspace_settings_page   # enter workspace setting page
    ...         AND             close_disable_external_users    # set setting 'Disable External Users button' off in WS1
    ...         AND             Close  # close browser
    # log in citron with site admin
    Login_new_added_user    ${switch_workspace_username}
    # 切换到第一个WS
    switch_to_first_workspace
    # seacrh user B in team page
    team_page_search   ${never_log_in_username}   1
    # 点击Send Invite按钮
    click_send_invite_button    send_invite
    sleep  25s
    # 检查邮箱
    ${email_link_2}  get_send_invite_email
    [Teardown]    Close

User_A_taps_unreachable_user_B_from_personal_contacts_tab
    [Documentation]    User A taps unreachable user B from personal contacts tab.
    [Tags]    small range  119  line
    [Setup]     run keywords    Login_premium_user   # big_admin log in
    ...         AND             enter_workspace_settings_page   # enter workspace setting page
    ...         AND             close_disable_external_users    # set setting 'Disable External Users button' off in WS1
    ...         AND             Close  # close browser
    # log in citron with site admin
    Login_new_added_user    ${switch_workspace_username}
    # 切换到第一个WS
    switch_to_first_workspace
    # 进入personal页面
    enter_personal_contact_page
    # seacrh user B in personal page，这个用户属于Huiming.shi
    personal_page_search   Huiming.shi.helplightning+never_login_personal   1
    # 点击Send Invite按钮
    click_send_invite_button    send_invite
    sleep  25s
    # 检查邮箱
    ${email_link_2}  get_send_invite_email
    [Teardown]    Close

User_A_taps_unreachable_user_B_from_directory_tab
    [Documentation]    User A taps unreachable user B from director tab.
    [Tags]    small range  120  line
    [Setup]     run keywords    Login_premium_user    # Site Admin log in
    ...         AND             enter_workspace_settings_page   # enter workspace setting page
    ...         AND             turn_on_user_directory   # set setting 'Workspace Directory' on in WS1
    ...         AND             Close  # close browser
    # log in citron with site admin
    Login_new_added_user    ${switch_workspace_username}
    # 切换到第一个WS
    switch_to_first_workspace
    # 进入 directory 页面
    enter_directory_page
    # seacrh user B in directory page
    directory_page_search   ${never_log_in_name}   1
    # 点击Send Invite按钮
    click_send_invite_button    send_invite
    sleep  25s
    # 检查邮箱
    ${email_link_2}  get_send_invite_email
    [Teardown]    Close

User_A_taps_unreachable_user_B_from_favorites_tab
    [Documentation]    User A taps unreachable user B from favorites tab.
    [Tags]    small range  121  line
    [Setup]     run keywords    Login_premium_user   # big_admin log in
    ...         AND             enter_workspace_settings_page   # enter workspace setting page
    ...         AND             close_disable_external_users    # set setting 'Disable External Users button' off in WS1
    ...         AND             Close  # close browser
    # log in citron with site admin
    Login_new_added_user    ${switch_workspace_username}
    # 切换到第一个WS
    switch_to_first_workspace
    # seacrh user B in team page
    team_page_search   ${never_log_in_username}   1
    # 添加user到favorites
    add_to_favorite_from_all_page
    # 进入到Favorites页面
    enter_favorites_page
    # seacrh user B in Favorites page
    favorites_page_search   ${never_log_in_username}   1
    # 点击Send Invite按钮
    click_send_invite_button    send_invite
    sleep  25s
    # 检查邮箱
    ${email_link_2}  get_send_invite_email
    [Teardown]    Close