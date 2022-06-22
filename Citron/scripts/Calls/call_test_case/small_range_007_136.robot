*** Settings ***
Library           Selenium2Library
Library           OperatingSystem
Resource          ../../../Lib/public.robot
Resource          ../../../Lib/calls_resource.robot
Resource          ../../../Lib/hodgepodge_resource.robot
Library           call_python_Lib/call_public_lib.py
Library           call_python_Lib/else_public_lib.py
Force Tags        small_range

*** Test Cases ***
All_active_users_in_the_entire_enterprise_should_show
    [Documentation]    Open Directory view, All active users in the entire enterprise should show.
    [Tags]      small range 66 line       call_case
    [Setup]     run keywords      Login_premium_user   # log in with big_admin
    ...         AND               switch_to_second_workspace    # 切换到Canada这个WS
    ...         AND               enter_workspace_settings_page   # enter workspace settings page
    ...         AND               open_workspace_directory    # Switch "Workspace Directory" on
    ...         AND               Close    # close browser
    # log in with big_admin
    ${driver}   driver_set_up_and_logIn    ${crunch_site_username}    ${crunch_site_password}
    # 切换到Huiming.shi_Added_WS这个WS
    user_switch_to_second_workspace   ${driver}    ${Huiming_shi_Added_WS}
    # 进入Directory页面
    switch_to_diffrent_page   ${driver}   ${py_directory_page}     ${py_directory_switch_success}    ${py_get_number_of_rows}
    # 获取Directory页面的所有user，放到列表中
    ${directory_user_list}  get_all_data_on_the_page   ${driver}    ${py_directory_page}
    ${directory_user_list}    remove_blank_for_list_ele   ${directory_user_list}
    # 进入到WS下的Users页面
    switch_to_diffrent_page   ${driver}  ${py_users_page}    ${py_users_switch_success}    ${py_get_number_of_rows}    switch_tree   2
    # 获取Users页面的所有active user，放到列表中
    ${active_user_list}     get_all_data_on_the_page   ${driver}    ${py_users_page}
    ${active_user_list}    remove_blank_for_list_ele   ${active_user_list}
    ${active_user_list_final}     remove_value_from_list    ${active_user_list}   ${crunch_site_username}
    two_option_is_equal   ${driver}   ${directory_user_list}   ${active_user_list_final}
    [Teardown]      run keywords    Close
    ...             AND             exit_driver
#    ...             AND             exit_driver    ${driver}

Disable_External_Users_Pre_condition_In_a_site_meeting_link
    [Documentation]    Pre-condition: In a site,workspace WS1 has "Disable External Feature"=ON; workspace WS2 has "Disable External Feature"=OFF; User S belong to WS1 and WS2; User E2
    [Tags]    small range 103+104+105+107 line     有bug：https://vipaar.atlassian.net/browse/CITRON-3248   MHS link不应该打通     call_case
    [Setup]     run keywords      Login_premium_user   # log in with premium admin
    ...         AND               make_sure_workspaces_setting_external_feature      open_feature     close_feature          # workspace WS1 has "Disable External Feature"=ON; workspace WS2 has "Disable External Feature"=OFF;
    ...         AND               Close
    ...         AND               Login_workspaces_admin    # log in with workspace admin
    ...         AND               enter_workspace_settings_page   # enter workspace settings page
    ...         AND               close_disable_external_users    # Switch "Disable External Feature" off from citron for a specific workspace
    ...         AND               Close    # close browser
    # User S belong to WS1 and WS2 log in
    ${driver1}  driver_set_up_and_logIn   ${switch_workspace_username}   ${switch_workspace_password}
    # another site user E2 log in
    ${driver2}  driver_set_up_and_logIn   ${normal_username_for_calls}   ${normal_password_for_calls}
    # Send MHS link
    ${invite_url}   send_meeting_room_link    ${driver1}   MHS
    # switch to second workspace
    user_switch_to_second_workspace     ${driver1}
#    # Call can not reach to mhs owner
#    check_call_can_reach_to_or_not   ${driver1}  ${driver2}   ${invite_url}   0
    # Send OTU link
    ${invite_url}   send_meeting_room_link   ${driver1}   OTU
    # switch to first workspace
    user_switch_to_first_workspace     ${driver1}
    # VP: call establish successfully
    check_call_can_reach_to_or_not   ${driver1}  ${driver2}   ${invite_url}    1
    [Teardown]      run keywords     Close
    ...             AND              exit_driver
#    ...             AND              exit_driver   ${driver1}   ${driver2}

Disable_External_Users_Pre_condition_In_a_site_on_call_link
    [Documentation]    Pre-condition: In a site,workspace WS1 has "Disable External Feature"=ON; workspace WS2 has "Disable External Feature"=OFF; User S belong to WS1 and WS2; User E2
    [Tags]     small range 103+104+106+108 line    call_case
    [Setup]     run keywords      Login_premium_user   # log in with premium admin
    ...         AND               make_sure_workspaces_setting_external_feature      open_feature     close_feature          # workspace WS1 has "Disable External Feature"=ON; workspace WS2 has "Disable External Feature"=OFF;
    ...         AND               Close
    ...         AND               Login_workspaces_admin    # log in with workspace admin
    ...         AND               enter_workspace_settings_page   # enter workspace settings page
    ...         AND               close_disable_external_users    # Switch "Disable External Feature" off from citron for a specific workspace
    ...         AND               Close    # close browser
    # User S belong to WS1 and WS2 log in
    ${driver1}  driver_set_up_and_logIn   ${switch_workspace_username}   ${switch_workspace_password}
    # another site user E2 log in
    ${driver2}  driver_set_up_and_logIn   ${normal_username_for_calls}   ${normal_password_for_calls}
    # switch to second workspace
    user_switch_to_second_workspace     ${driver1}
    # Call can not reach to mhs owner
    check_call_can_reach_to_or_not   ${driver1}   ${driver2}    https://app-stage.helplightning.net.cn/help?enterprise_id=1204&group_id=10531&group_name=1o1o1o_on_call_group    0    # this is WS1 (1o1o1o_on_call_group) On-Call Group Url
    # switch to first workspace
    user_switch_to_first_workspace     ${driver1}
    # Call can reach to mhs owner
    check_call_can_reach_to_or_not   ${driver1}   ${driver2}    https://app-stage.helplightning.net.cn/help?enterprise_id=6106&group_id=10523&group_name=2o2o2o_on_call_group     1    # this is WS2 (2o2o2o_on_call_group) On-Call Group Url
    [Teardown]      run keywords     Close
    ...             AND              exit_driver
#    ...             AND              exit_driver   ${driver1}   ${driver2}

User_Directory_User_open_invite_3rd_participant_dialog
    [Documentation]    Pre-conditron: User belong to 2 workspaces WS1 and WS2   Enable Directory feature for WS1   Disable Directory feature for WS2
    [Tags]      small range 84 line     call_case
    [Setup]     run keywords      Login_premium_user   # log in with premium admin
    ...         AND               make_sure_workspaces_setting_workspace_directory      open_feature     close_feature          # workspace WS1 has "Disable External Feature"=ON; workspace WS2 has "Disable External Feature"=OFF;
    ...         AND               Close
    # User S belong to WS1 and WS2 log in
    ${driver1}  driver_set_up_and_logIn   ${switch_workspace_username}   ${switch_workspace_password}
    # Contact of WS1 log in
    ${driver2}  driver_set_up_and_logIn    ${big_admin_first_WS_username}   ${big_admin_first_WS_password}
    # Contact of WS1 call the user directly
    contacts_witch_page_make_call   ${driver2}   ${driver1}   ${py_team_page}    ${switch_workspace_name}
    # User open invite 3rd participant dialog
    open_invite_3rd_participant_dialog    ${driver1}   no_enter
    # User check on Directory	VP: All users of WS1 shows up
    check_user_show_up_or_not_when_invite_3rd   ${driver1}   1
    # end call
    exit_call   ${driver2}   1
    [Teardown]      run keywords    Close
    ...             AND             exit_driver
#    ...             AND             exit_driver   ${driver1}   ${driver2}

User_Directory_User_open_invite_3rd_participant_dialog_has_no_Directory_checkbox
    [Documentation]    Pre-conditron: User belong to 2 workspaces WS1 and WS2   Enable Directory feature for WS1   Disable Directory feature for WS2
    [Tags]      small range 85 line      call_case
    [Setup]     run keywords      Login_premium_user   # log in with premium admin
    ...         AND               make_sure_workspaces_setting_workspace_directory      open_feature     close_feature          # workspace WS1 has "Disable External Feature"=ON; workspace WS2 has "Disable External Feature"=OFF;
    ...         AND               Close
    # User S belong to WS1 and WS2 log in
    ${driver1}  driver_set_up_and_logIn   ${switch_workspace_username}   ${switch_workspace_password}
    # Contact of WS2 log in
    ${driver2}  driver_set_up_and_logIn    ${big_admin_second_WS_username}   ${big_admin_second_WS_password}
    # Contact of WS2 call the user directly
    contacts_witch_page_make_call   ${driver2}   ${driver1}    ${py_team_page}   ${switch_workspace_name}
    # User open invite 3rd participant dialog
    open_invite_3rd_participant_dialog    ${driver1}   no_enter
    # VP: user has no Directory checkbox
    check_user_show_up_or_not_when_invite_3rd   ${driver1}   0
    # end call
    exit_call   ${driver2}   1
    [Teardown]      run keywords    Close
    ...             AND             exit_driver
#    ...             AND             exit_driver   ${driver1}   ${driver2}

Disable_External_Users_check_case_1
    [Documentation]    in Citron-Admin-Calls, name of personal user and user from another site workspace should display as "External User" in call list and call details page
    [Tags]      small range 94 line      call_case
    [Setup]     run keywords      Login_workspaces_admin    # log in with workspace admin
    ...         AND               enter_workspace_settings_page   # enter workspace settings page
    ...         AND               close_disable_external_users    # Switch "Disable External Feature" off from citron for a specific workspace
    ...         AND               Close    # close browser
    ...         AND               Login_premium_user    # log in with premium admin
    ...         AND               enter_workspace_settings_page   # enter workspace settings page
    ...         AND               close_disable_external_users    # Switch "Disable External Feature" off from citron for a specific workspace
    ...         AND               Close    # close browser
    # Expert user log in
    ${driver1}  driver_set_up_and_logIn    ${an_expert_user_username}    ${an_expert_user_password}
    # user from another site log in
    ${driver2}  driver_set_up_and_logIn    ${other_site_user_1_username}   ${other_site_user_1_password}
    # Expert user call the user from another site
    switch_to_diffrent_page   ${driver1}   ${py_personal_page}   ${py_personal_switch_success}    ${py_get_number_of_rows}
    contacts_witch_page_make_call   ${driver1}   ${driver2}   ${py_personal_page}   ${other_site_user_1_name}
    # end call
    exit_call   ${driver2}

    # Switch "Disable External Feature" on from citron for a specific workspace
    Login_workspaces_admin
    enter_workspace_settings_page
    open_disable_external_users
    # enter Calls page
    enter_calls_menu
    # in Citron-Admin-Calls, name of personal user and user from another site workspace should display as "External User" in call list and call details page
    display_as_external_user_in_call_list
    [Teardown]      run keywords     Close
    ...             AND              exit_driver
#    ...             AND              exit_driver   ${driver1}   ${driver2}

Disable_External_Users_check_case_2
    [Documentation]    Personal user or user from another site workspace logs in,VP: they should not be able to call this site workspace user via meeting link
    [Tags]         small range 96+97+98+99 line   有bug：https://vipaar.atlassian.net/browse/CITRON-3248   MHS link不应该打通       call_case
    [Setup]     run keywords      Login_workspaces_admin    # log in with workspace admin
    ...         AND               enter_workspace_settings_page   # enter workspace settings page
    ...         AND               open_disable_external_users    # Switch "Disable External Feature" on from citron for a specific workspace
    ...         AND               Close    # close browser
    ...         AND               Login_site_admin    # log in with premium admin
    ...         AND               enter_workspace_settings_page   # enter workspace settings page
    ...         AND               open_disable_external_users    # Switch "Disable External Feature" off from citron for a specific workspace
    ...         AND               Close    # close browser
    # Expert user log in
    ${driver1}  driver_set_up_and_logIn    ${an_expert_user_username}    ${an_expert_user_password}
    ${time_started_1}   get_start_time_of_the_last_call   ${driver1}
    # user from another site log in
    ${driver2}  driver_set_up_and_logIn    ${other_site_user_1_username}   ${other_site_user_1_password}
    ${time_started_2}   get_start_time_of_the_last_call   ${driver2}
#    # VP: they should not be able to call this site workspace user via meeting link
#    check_call_can_reach_to_or_not   ${driver1}   ${driver2}   https://app-stage.helplightning.net.cn/meet/Huiming.shi.helplightning+an_expert_user1     0     # MHS link
#    # VP: this record should not appear in recent list for both participants
#    ${time_started_3}   record_should_not_appear_in_recent_list   ${driver1}
#    should be equal as strings    ${time_started_3}   ${time_started_1}
#    ${time_started_4}   record_should_not_appear_in_recent_list   ${driver2}
#    should be equal as strings    ${time_started_4}   ${time_started_2}
    # VP: they should not be able to call this site workspace user via on-call group link
    check_call_can_reach_to_or_not   ${driver1}  ${driver2}   https://app-stage.helplightning.net.cn/help?enterprise_id=2799&group_id=5562&group_name=on-call+group+2   0    # this is (on-call group 2) On-Call Group Url
    # exit driver
    exit_one_driver   ${driver2}
    # user from another site log in
    Login_new_added_user   ${other_site_user_1_username}
    # VP: they should not be able to direct Call this site workspace user any longer
    check_should_not_be_able_to_direct_call
    [Teardown]      run keywords     Close
    ...             AND              exit_driver    ${driver1}
#    ...             AND              exit_one_driver    ${driver1}

Disable_External_Users_check_case_3
    [Documentation]    Anonymous user  VP: he should be able to call this site workspace user via meeting link   VP: he should be able to call this site workspace via on-call group link
    [Tags]    small range 99+100 line         call_case
    [Setup]     run keywords      Login_workspaces_admin    # log in with workspace admin
    ...         AND               enter_workspace_settings_page   # enter workspace settings page
    ...         AND               open_disable_external_users    # Switch "Disable External Feature" off from citron for a specific workspace
    ...         AND               Close    # close browser
    # Expert user log in
    ${driver1}    driver_set_up_and_logIn    ${an_expert_user_username}    ${an_expert_user_password}
    ${time_started}   get_start_time_of_the_last_call   ${driver1}
    # 启动一个空的窗口
    ${driver2}  start_an_empty_window
    # Anonymous user   VP: he should be able to call this site workspace user via meeting link
    check_call_can_reach_to_or_not  ${driver1}   ${driver2}   https://app-stage.helplightning.net.cn/meet/Huiming.shi.helplightning+an_expert_user1    1    # MHS link
    # this record should not appear in recent list for this site user
    ${time_started_1}   get_start_time_of_the_last_call   ${driver1}
    should be equal as strings    ${time_started_1}   ${time_started}
    # 启动一个空的窗口
    ${driver3}  start_an_empty_window
    # Anonymous user   VP: he should be able to call this site workspace via on-call group link
    check_call_can_reach_to_or_not  ${driver1}   ${driver3}   https://app-stage.helplightning.net.cn/help?enterprise_id=2799&group_id=5562&group_name=on-call+group+2    1    # this is (on-call group 2) On-Call Group Url
    # this record should not appear in recent list for this site user
    ${time_started_2}   get_start_time_of_the_last_call   ${driver1}
    should be equal as strings    ${time_started_2}   ${time_started}
    [Teardown]      run keywords     Close
    ...             AND              exit_driver
#    ...             AND              exit_driver   ${driver1}   ${driver2}

In_calling_page_clicks_Invite_Send_Invitation_page
    [Documentation]    In calling page, clicks Invite -> Send Invitation page
    [Tags]      small range 51 line         call_case
    # User S belong to WS1 and WS2 log in
    ${driver1}  driver_set_up_and_logIn   ${switch_workspace_username}   ${switch_workspace_password}
    # Contact of WS1 log in
    ${driver2}  driver_set_up_and_logIn     ${big_admin_first_WS_username}   ${big_admin_first_WS_password}
    # Contact of WS1 call the user directly
    contacts_witch_page_make_call   ${driver1}   ${driver2}     ${py_team_page}     ${big_admin_first_WS_name}
    make_sure_enter_call      ${driver1}
    # In calling page, clicks Invite -> Send Invitation papge
    which_page_is_currently_on    ${driver1}    ${end_call_button}
    ${invite_url}  send_invite_in_calling_page   ${driver1}
    # 启动一个空的窗口
    ${driver3}  start_an_empty_window
    # anonymous user can accept the call successfully
    check_call_can_reach_to_or_not  ${driver1}   ${driver3}   ${invite_url}   1
    # 结束call
    exit_call   ${driver2}   2
    [Teardown]      run keywords    Close
    ...             AND             exit_driver
#    ...             AND             exit_driver   ${driver1}   ${driver2}   ${driver3}

User_1_receives_an_incoming_call_from_user_2
    [Documentation]    User 1 receives an incoming call from user 2	VP: User 1 should show User 2's Display Name & Avatar	End call	User 2 changes Display name & Avatar	User 1 receives an incoming call from user 2 again	VP: User 1 should show the new Display Name & Avatar
    [Tags]     small range 31 line       call_case
    # User S belong to WS1 and WS2 log in
    ${driver1}  driver_set_up_and_logIn   ${switch_workspace_username}   ${switch_workspace_password}
    # Contact of WS1 log in
    ${driver2}  driver_set_up_and_logIn     ${big_admin_first_WS_username}   ${big_admin_first_WS_password}
    # get modify picture absolute path
    ${modify_picture_path}  return_modify_pirture_path
    # Make sure the name and avator is in its original state
    my_account_change_name_and_avator   ${driver2}   ${big_admin_first_WS_name}   change   ${modify_picture_path}   back_to_contact
    # Contact of WS1 call the user directly
    contacts_witch_page_make_call   ${driver2}   ${driver1}     ${py_team_page}     ${switch_workspace_name}    no_anwser
    # VP: User 1 should show User 2's Display Name & Avatar   	End call
    show_incoming_call_name_avator   ${driver1}   ${driver2}   modify_picture    ${big_admin_first_WS_name}
    # User 2 changes Display name & Avatar
    ${random}   return_a_random
    my_account_change_name_and_avator   ${driver2}    ${random}   delete   ${modify_picture_path}   back_to_contact
    # User 1 receives an incoming call from user 2 again
    contacts_witch_page_make_call   ${driver2}   ${driver1}     ${py_team_page}     ${switch_workspace_name}    no_anwser
    # VP: User 1 should show the new Display Name & Avatar
    show_incoming_call_name_avator   ${driver1}   ${driver2}   original_default_avatar_url   ${random}
    [Teardown]      run keywords     my_account_change_name_and_avator   ${driver2}   ${big_admin_first_WS_name}   change   ${modify_picture_path}   # Make sure the name and avator is in its original state
    ...             AND              exit_driver
#    ...             AND              exit_driver   ${driver1}   ${driver2}

During_Call_open_invite_the_3rd_participant_page
    [Documentation]    During Call, open invite the 3rd participant page	Scrolls  the contact list 	VP: show a 'loading...' , and once stop, contact name should be shown up.	In Citron update the display name & Avatar of one member of contact list	Pull-down in Team tab to refresh	VP: the updated contact list should be shown up.
    [Tags]      small range 32+33 line          call_case
    # User S belong to WS1 and WS2 log in
    ${driver1}  driver_set_up_and_logIn   ${switch_workspace_username}   ${switch_workspace_password}
    # Contact of WS1 log in
    ${driver2}  driver_set_up_and_logIn     ${big_admin_first_WS_username}   ${big_admin_first_WS_password}
    # another Contact of WS1 log in
    ${driver3}  driver_set_up_and_logIn     ${big_admin_another_first_WS_username}   ${big_admin_another_first_WS_password}
    # get modify picture absolute path
    ${modify_picture_path}   return_modify_pirture_path
    # Make sure the name and avator is in its original state
    my_account_change_name_and_avator    ${driver3}   ${big_admin_another_first_WS_name}    change   ${modify_picture_path}
    # Contact of WS1 call the user directly
    contacts_witch_page_make_call   ${driver2}   ${driver1}     ${py_team_page}     ${switch_workspace_name}
    # VP: show a 'loading...' , and once stop, contact name should be shown up.
    which_page_is_currently_on    ${driver2}    ${end_call_button}
    enter_contacts_search_user   ${driver2}    ${big_admin_another_first_WS_name}
    display_name_avator_in_contact_list   ${driver2}    ${big_admin_another_first_WS_name}   modify_picture
    close_invite_3th_page   ${driver2}
    # another User changes Display name & Avatar
    ${random}   return_a_random
    my_account_change_name_and_avator   ${driver3}    ${random}   delete   ${modify_picture_path}
    # VP: the updated contact list should be shown up.
    enter_contacts_search_user   ${driver2}    ${random}
    display_name_avator_in_contact_list   ${driver2}    ${random}   original_default_avatar_url
    close_invite_3th_page   ${driver2}
    # 结束通话
    exit_call     ${driver1}    1
    [Teardown]      run keywords     my_account_change_name_and_avator    ${driver3}   ${big_admin_another_first_WS_name}    change   ${modify_picture_path}
    ...             AND              exit_driver
#    ...             AND              exit_driver   ${driver1}   ${driver2}   ${driver3}

User_A_opens_Directory_tab
    [Documentation]    Team user C exists in Directory tab.     User C has signed out of every instance of mobile app and web.
    [Tags]     small range 110 line        call_case
    [Setup]     run keywords      Login_premium_user              # log in with premium admin
    ...         AND               enter_workspace_settings_page   # enter workspace settings page
    ...         AND               open_workspace_directory    # Switch "Workspace Directory" on
    ...         AND               Close    # close browser
    # Expert user A signs in.
    ${driver1}  driver_set_up_and_logIn   ${switch_workspace_username}   ${switch_workspace_password}
    # team user logs in
    ${driver2}  driver_set_up_and_logIn     ${check_team_offline_username}   ${a_team_user_password}
    # logout from citron
    logout_citron  ${driver2}
    # switch to directory page
    switch_to_diffrent_page   ${driver1}   ${py_directory_page}     ${py_directory_switch_success}    ${py_get_number_of_rows}
    # search user in Directory page
    contacts_different_page_search_user   ${driver1}   ${py_directory_page}   ${check_team_offline_name}
    # VP: User C displays with greyed out pattern, including the icon, all text (name, title, location), but not including the favorite star.
    contacts_judge_reachable_or_not   ${driver1}    ${py_directory_page}   ${check_team_offline_name}
    [Teardown]      run keywords     Close
    ...             AND              exit_driver
#    ...             AND              exit_driver   ${driver1}   ${driver2}

User_A_opens_Personal_contact_tab
    [Documentation]    Personal users D and user E (from different site) exists in Personal contact tab.    User D and user E has signed out of every instance of mobile app and web.
    [Tags]     small range 111 line             call_case
    [Setup]     run keywords      Login_workspaces_admin          # log in with workspace admin
    ...         AND               enter_workspace_settings_page   # enter workspace settings page
    ...         AND               close_disable_external_users    # Switch "Disable External Feature" off from citron for a specific workspace
    ...         AND               Close    # close browser
    # Expert user A signs in.
    ${driver1}  driver_set_up_and_logIn   ${an_expert_user_username}   ${an_expert_user_password}
    # from different site user logs in
    ${driver2}  driver_set_up_and_logIn     ${personal_user1_username}   ${other_site_user_1_password}
    # logout from citron
    logout_citron  ${driver2}
    # enter personal page
    switch_to_diffrent_page   ${driver1}   ${py_personal_page}    ${py_personal_switch_success}    ${py_personal_search_result}
    # search user in Personal page
    contacts_different_page_search_user    ${driver1}    ${py_personal_page}    ${personal_user1_name}
    # VP: User D and user E displays with greyed out pattern, including the icon, all text (name, title, location), but not including the favorite star.
    contacts_judge_reachable_or_not  ${driver1}    ${py_personal_page}    ${personal_user1_name}
    [Teardown]      run keywords     Close
    ...             AND              exit_driver
#    ...             AND              exit_driver   ${driver1}   ${driver2}

User_B_displays_as_reachable
    [Documentation]    Expert user B exists in recent tab. contact list.    User B  signed out of every instance of mobile app and web.
    [Tags]     small range 112 line
    # Expert user A signs in.
    ${driver1}  driver_set_up_and_logIn   ${switch_workspace_username}   ${switch_workspace_password}
    # Expert user B logs in
    ${driver2}  driver_set_up_and_logIn     ${big_admin_first_WS_username}   ${big_admin_first_WS_password}
    # logout from citron
    logout_citron  ${driver2}
    # enter to personal page
    switch_to_diffrent_page    ${driver1}   ${py_recents_page}    ${py_recents_switch_success}    ${py_get_number_of_rows}
    # VP: User B displays as reachable.
    judge_reachable_in_recents   ${driver1}   ${big_admin_first_WS_name}
    [Teardown]      exit_driver
#    [Teardown]      exit_driver   ${driver1}   ${driver2}

#User_B_stays_logged_in_on_one_device_User_B_is_user_A_contact
#    [Documentation]    User A opens Team contact tab. User B stays logged in on one device. User B is user A’s contact. 	User B logouts.
#    [Tags]     small range 113 line  ，有bug：https://vipaar.atlassian.net/browse/CITRON-3274         call_case
#    [Setup]     run keywords      Login_premium_user              # log in with premium admin
#    ...         AND               enter_workspace_settings_page   # enter workspace settings page
#    ...         AND               close_disable_external_users    # Switch "Disable External Feature" off from citron for a specific workspace
#    ...         AND               Close    # close browser
#    # Expert user A signs in.
#    ${driver1}  driver_set_up_and_logIn   ${switch_workspace_username}   ${switch_workspace_password}
#    # Expert user B logs in
#    ${driver2}  driver_set_up_and_logIn     ${big_admin_first_WS_username}   ${big_admin_first_WS_password}
#    # search user in Team page
#    contacts_different_page_search_user    ${driver1}    ${py_team_page}    ${py_team_user_search}    ${py_team_search_result}    ${big_admin_first_WS_name}
#    # judge reachable
#    contacts_judge_reachable_or_not  ${driver1}   ${py_team_search_result}    reachable
#    # User B logouts from one device.
#    logout_citron  ${driver2}
#    sleep  45s
#    # judge unreachable
#    contacts_judge_reachable_or_not  ${driver1}   ${py_team_search_result}
#    # Expert user B re logs in
#    ${driver3}  driver_set_up_and_logIn     ${big_admin_first_WS_username}   ${big_admin_first_WS_password}
#    sleep  45s
#    # judge reachable
#    contacts_judge_reachable_or_not  ${driver1}   ${py_team_search_result}    reachable
#    [Teardown]      run keywords     Close
#    ...             AND              exit_driver
##    ...             AND              exit_driver   ${driver1}   ${driver2}

User_B_logouts_from_one_device
    [Documentation]    User A opens Team contact tab. User B stays logged in on two devices. User B is user A’s contact.
    [Tags]     small range 114 line     call_case
    [Setup]     run keywords      Login_premium_user              # log in with premium admin
    ...         AND               enter_workspace_settings_page   # enter workspace settings page
    ...         AND               close_disable_external_users    # Switch "Disable External Feature" off from citron for a specific workspace
    ...         AND               Close    # close browser
    # Expert user A signs in.
    ${driver1}  driver_set_up_and_logIn   ${switch_workspace_username}   ${switch_workspace_password}
    # Expert user B logs in
    ${driver2}  driver_set_up_and_logIn     ${a_team_user_username}   ${big_admin_first_WS_password}
    # Expert user B logs in in another web
    ${driver3}  driver_set_up_and_logIn     ${a_team_user_username}   ${big_admin_first_WS_password}
    # User B logouts from one device.
    logout_citron  ${driver2}
    # search user in Team page
    contacts_different_page_search_user    ${driver1}    ${py_team_page}     ${a_team_user_name}
    # VP: User B should keep active.
    contacts_judge_reachable_or_not  ${driver1}    ${py_team_page}     ${a_team_user_name}    reachable
    [Teardown]      run keywords     Close
    ...             AND              exit_driver
#    ...             AND              exit_driver   ${driver1}   ${driver2}   ${driver3}

unable_to_reach_user_message_displays
    [Documentation]    User A and user B are in 2PC.   Team user C exists in Directory tab.   User C has signed out of every instance of mobile app and web.	User A opens invite contact view.
    [Tags]     small range 115 line       call_case
    # Expert user A signs in.
    ${driver1}  driver_set_up_and_logIn   ${switch_workspace_username}   ${switch_workspace_password}
    # Expert user B logs in
    ${driver2}  driver_set_up_and_logIn     ${big_admin_first_WS_username}   ${big_admin_first_WS_password}
    # Contact of WS1 call the user directly
    contacts_witch_page_make_call   ${driver1}   ${driver2}    ${py_team_page}      ${big_admin_first_WS_name}
    # Team user C logs in
    ${driver3}  driver_set_up_and_logIn     ${a_team_user_username}   ${a_team_user_password}
    # User C has signed out of every instance of mobile app and web.
    logout_citron  ${driver3}
    # 进入Contacts界面，并查询user
    which_page_is_currently_on    ${driver1}    ${end_call_button}
    enter_contacts_search_user    ${driver1}   ${a_team_user_name}
    # 校验在通话中Contacts页面中未登录的user，点击后是否会弹出{username} is unreachable的提示信息
    click_user_in_contacts_call   ${driver1}   ${a_team_user_name}   can_not_reach
    # 结束call
    exit_call      ${driver1}    1
    [Teardown]      exit_driver
#    [Teardown]      exit_driver   ${driver1}   ${driver2}   ${driver3}

User_A_taps_unreachable_user_B_from_recents_tab_User_B_is_expert_user_User
    [Documentation]    User A taps unreachable user B from recents tab.  User B is expert user   Other user clicks on this OTU link  User B is anonymous user.
    [Tags]     small range 122+123+127+129+130 line        call_case
    # User A log in
    ${driver1}   driver_set_up_and_logIn   ${switch_workspace_username}    ${switch_workspace_password}
    # User B is expert user log in
    ${driver2}   driver_set_up_and_logIn   ${for_expert_call_username}    ${public_pass}
    # 进行一次call
    contacts_witch_page_make_call   ${driver1}    ${driver2}     ${py_team_page}      ${for_expert_call_name}
    # 结束通话
    exit_call     ${driver1}
    # 关闭通话结束展示页面并退出
    close_call_ending_page      ${driver2}
    logout_citron   ${driver2}
    # 关闭通话结束展示页面
    close_call_ending_page      ${driver1}
    # 进入Recents页面
    sleep  5s   # 等待最近一次通话记录加载
    switch_to_diffrent_page   ${driver1}   ${py_recents_page}     ${py_recents_switch_success}    ${py_get_number_of_rows}
    refresh_browser_page   ${driver1}
    # Click Cancel.	Nothing happens.     129 line
    recents_page_check_call    ${driver1}   ${for_expert_call_name}   can_not_connect   click_cancel
    # Send invitation dialog displays asking “Would you like to invite them into a call via email”，Click Send Invite button.
    recents_page_check_call    ${driver1}   ${for_expert_call_name}
    # 从邮箱获取刚发送的OTU邮件
    sleep  20s
    ${meeting_link}    obtain_meeting_link_from_email    check_otu
    # User B is expert user log in
    ${driver3}   driver_set_up_and_logIn   ${for_expert_call_username}    ${big_admin_first_WS_password}
    # VP: call establish successfully
    check_call_can_reach_to_or_not   ${driver1}  ${driver3}   ${meeting_link}    1
    # 切换到首个句柄
    switch_first_window   ${driver3}
    # User B logout
    logout_citron   ${driver3}

    # anonymous open meeting link with website
    ${driver4}   anonymous_open_meeting_link    ${meeting_link}
    # 确保call连接成功，但未接听
    make_sure_enter_call   ${driver4}
    # User A Aneser call
    user_anwser_call   ${driver1}
    # User A exit call
    exit_call  ${driver1}
    # 关闭通话结束展示页面
    close_call_ending_page      ${driver1}
    # 进入Recents页面
    sleep  5s   # 等待最近一次通话记录加载
    switch_to_diffrent_page   ${driver1}   ${py_recents_page}     ${py_recents_switch_success}    ${py_get_number_of_rows}     switch_tree    1
    # 判断在Recents页面，匿名用户的通话记录没有Call按钮
    anonymous_user_call_can_not_call_again   ${driver1}
    [Teardown]     exit_driver
#    [Teardown]     exit_driver   ${driver1}  ${driver3}  ${driver4}

User_A_taps_unreachable_user_B_from_recents_tab_User_B_is_team_user
    [Documentation]    User A taps unreachable user B from recents tab.  User B is team user   Other user clicks on this OTU link  User B is anonymous user.
    [Tags]     small range 122+124+128 line      call_case
    # User A log in
    ${driver1}   driver_set_up_and_logIn   ${switch_workspace_username}    ${switch_workspace_password}
    # User B is team user log in
    ${driver2}   driver_set_up_and_logIn   ${for_team_call_username}    ${public_pass}
    # 进行一次call
    contacts_witch_page_make_call   ${driver1}    ${driver2}     ${py_team_page}      ${for_team_call_name}
    # 结束通话
    exit_call     ${driver1}
    # 关闭通话结束展示页面
    close_call_ending_page      ${driver1}
    close_call_ending_page      ${driver2}
    # User B logout
    logout_citron   ${driver2}
    # 进入Recents页面
    sleep  5s   # 等待最近一次通话记录加载
    switch_to_diffrent_page   ${driver1}   ${py_recents_page}     ${py_recents_switch_success}    ${py_get_number_of_rows}
    refresh_browser_page   ${driver1}
    # Send invitation dialog displays asking “Would you like to invite them into a call via email”，Click Send Invite button.
    recents_page_check_call    ${driver1}   ${for_team_call_name}
    # 从邮箱获取刚发送的OTU邮件
    sleep  20s
    ${meeting_link}    obtain_meeting_link_from_email    check_otu
    # User B is team user log in
    ${driver3}   driver_set_up_and_logIn   ${for_team_call_username}    ${public_pass}
    # VP: call establish successfully
    check_call_can_reach_to_or_not   ${driver1}  ${driver3}   ${meeting_link}    1
    # 切换到首个句柄
    switch_first_window   ${driver3}
    # User B logout
    logout_citron   ${driver3}
    # 启动一个空的窗口
    ${driver4}   start_an_empty_window
    # VP: call establish successfully
    check_call_can_reach_to_or_not   ${driver1}  ${driver4}   ${meeting_link}    1
    [Teardown]     exit_driver
#    [Teardown]     exit_driver   ${driver1}   ${driver3}  ${driver4}

User_A_taps_unreachable_user_B_from_recents_tab_User_B_is_another_enterprise_user
    [Documentation]    User A taps unreachable user B from recents tab.  User B is another enterprise user
    [Tags]     small range 122+126 line       call_case
    [Setup]     run keywords      Login_workspaces_admin          # log in with workspace admin
    ...         AND               enter_workspace_settings_page   # enter workspace settings page
    ...         AND               close_disable_external_users    # Switch "Disable External Feature" off
    ...         AND               Close    # close browser
    # User A log in
    ${driver1}   driver_set_up_and_logIn   ${switch_workspace_username}    ${switch_workspace_password}
    # User B is  another enterprise user log in
    ${driver2}   driver_set_up_and_logIn   ${for_other_site_call_username}    ${public_pass}
    # 进行一次call
    switch_to_diffrent_page   ${driver1}   ${py_personal_page}   ${py_personal_switch_success}    ${py_get_number_of_rows}
    contacts_witch_page_make_call   ${driver1}    ${driver2}     ${py_personal_page}      ${for_other_site_call_name}
    # 结束通话
    exit_call     ${driver1}
    # 关闭通话结束展示页面
    close_call_ending_page      ${driver1}
    close_call_ending_page      ${driver2}
    # User B logout
    logout_citron   ${driver2}
    # 进入Recents页面
    sleep  5s   # 等待最近一次通话记录加载
    switch_to_diffrent_page   ${driver1}   ${py_recents_page}     ${py_recents_switch_success}    ${py_get_number_of_rows}
    refresh_browser_page   ${driver1}
    # Send invitation dialog displays asking “Would you like to invite them into a call via email”，Click Send Invite button.
    recents_page_check_call    ${driver1}   ${for_other_site_call_name}
    # 从邮箱获取刚发送的OTU邮件
    sleep  20s
    ${meeting_link}    obtain_meeting_link_from_email    check_otu
    # User B is another enterprise user log in
    ${driver3}   driver_set_up_and_logIn   ${for_other_site_call_username}    ${other_site_user_2_password}
    # VP: call establish successfully
    check_call_can_reach_to_or_not   ${driver1}   ${driver3}   ${meeting_link}    1
    # 切换到首个句柄
    switch_first_window   ${driver3}
    # User B logout
    logout_citron   ${driver3}
    [Teardown]      run keywords    Close
    ...             AND             exit_driver
#    ...             AND             exit_driver   ${driver1}   ${driver3}

Team_user_A_signs_in_User_B_is_expert_user
    [Documentation]    Team user A signs in. User A taps unreachable user B from contacts tab.  User B is expert user
    [Tags]     small range 131+132+133 line        call_case
    # Team user log in
    ${driver1}   driver_set_up_and_logIn   ${a_team_user_username}    ${a_team_user_password}
    # 在Contacts页面查询user
    contacts_different_page_search_user   ${driver1}    ${py_team_page}    ${for_expert_call_name}
    # Send invitation dialog displays asking “Would you like to invite them into a call via email”，Click Send Invite button.
    contacts_page_send_email    ${driver1}    ${for_expert_call_name}
    # 从邮箱获取刚发送的OTU邮件
    sleep  20s
    ${meeting_link}    obtain_meeting_link_from_email    check_otu
    # User B is expert user log in
    ${driver2}   driver_set_up_and_logIn   ${for_expert_call_username}    ${public_pass}
    check_call_can_reach_to_or_not    ${driver1}   ${driver2}   ${meeting_link}    1
    # 切换到首个句柄
    switch_first_window   ${driver2}
    # User B logout
    logout_citron   ${driver2}
    # 启动一个空的窗口
    ${driver3}   start_an_empty_window
    # User B is anonymous user clicks on this OTU link.
    check_call_can_reach_to_or_not    ${driver1}   ${driver3}   ${meeting_link}    1
    [Teardown]      exit_driver
#    [Teardown]      exit_driver   ${driver1}   ${driver2}   ${driver3}

check_personal_user_can_see_user_S_is_unreachable_status
    [Documentation]    Pre-condition: User S belong to workspace WS1 and WS2    User S switch to WS1   User S logout of all devices
    [Tags]     small range 135+136 line        call_case
#    [Setup]     run keywords      Login_premium_user              # log in with premium admin
#    ...         AND               enter_workspace_settings_page   # enter workspace settings page
#    ...         AND               close_disable_external_users    # Switch "Disable External Feature" off
#    ...         AND               switch_to_second_workspace      # 切换到第二个WS
#    ...         AND               enter_workspace_settings_page   # enter workspace settings page
#    ...         AND               close_disable_external_users    # Switch "Disable External Feature" off
#    ...         AND               Close                           # close browser
#    ...         AND               Login_workspaces_admin          # log in with workspace admin
#    ...         AND               enter_workspace_settings_page   # enter workspace settings page
#    ...         AND               close_disable_external_users    # Switch "Disable External Feature" off
#    ...         AND               Close                           # close browser
    # User S signs in.
    ${driver1}  driver_set_up_and_logIn   ${for_check_user_online_or_not}   ${public_pass}
    # Contact of WS1
    ${driver2}  driver_set_up_and_logIn     ${big_admin_first_WS_username}   ${big_admin_first_WS_password}
    # Contact of WS2  logs in
    ${driver3}  driver_set_up_and_logIn     ${big_admin_second_WS_username}   ${big_admin_second_WS_password}
    # Personal contact of WS2 logs in in another web
    ${driver4}  driver_set_up_and_logIn     ${other_site_user_3_username}   ${other_site_user_3_password}
    # VP: Contact of WS2 see User S is online status
    contacts_different_page_search_user    ${driver3}    ${py_team_page}   ${online_or_not_name}
    contacts_judge_reachable_or_not    ${driver3}     ${py_team_page}     ${online_or_not_name}    reachable
    # VP: Personal contact of WS2 see User S is online status
    switch_to_other_tab   ${driver4}    ${Personal_tab_xpath}
    contacts_different_page_search_user    ${driver4}    ${py_personal_page}     ${online_or_not_name}
    contacts_judge_reachable_or_not    ${driver4}    ${py_personal_page}    ${online_or_not_name}    reachable
    logout_citron    ${driver4}
    sleep  4
    # User S logout of all devices
    logout_citron    ${driver1}
    # VP: Contact of WS1 see user S is unreachable status
    contacts_different_page_search_user    ${driver2}    ${py_team_page}    ${online_or_not_name}
    contacts_judge_reachable_or_not    ${driver2}     ${py_team_page}     ${online_or_not_name}    unreachable
    logout_citron    ${driver2}
    # VP: contact of WS2 see user s is unreachable status
    contacts_different_page_search_user    ${driver3}    ${py_team_page}      ${online_or_not_name}
    sleep  4
    contacts_judge_reachable_or_not    ${driver3}     ${py_team_page}     ${online_or_not_name}    unreachable
    logout_citron    ${driver3}
    [Teardown]      run keywords     Close
    ...             AND              exit_driver
#    ...             AND              exit_driver   ${driver1}   ${driver2}   ${driver3}   ${driver4}