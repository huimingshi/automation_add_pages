*** Settings ***
Library           Selenium2Library
Library           OperatingSystem
Resource          ../../../Lib/public.robot
Resource          ../../../Lib/calls_resource.robot
Resource          ../../../Lib/hodgepodge_resource.robot
Library           call_python_Lib/call_public_lib.py
Library           call_python_Lib/else_public_lib.py

*** Test Cases ***

#Call_Tag_Comment_592_595
#    [Documentation]    Call Tag/Comment   Pre-condition:Site has workspace WS1 ,WS2; User A,B,C in WS1; User C in WS2        A, B and C in a call
#    [Tags]     small range 592-595  lines  ，有bug：CITRON-3246，不能修改tag；https://vipaar.atlassian.net/browse/CITRON-3338，通话记录没有DETAILS按钮
#    [Setup]     run keywords      Login_premium_user   # log in with premium admin
#    ...         AND               make_sure_workspaces_setting_tagging_and_comments      open_feature     open_feature          # WS1 and WS2 both turn on tag feature
#    ...         AND               Close
#    # User A log in
#    ${driver1}   driver_set_up_and_logIn   ${big_admin_first_WS_username}    ${big_admin_first_WS_password}
#    # User B log in
#    ${driver2}   driver_set_up_and_logIn   ${big_admin_third_WS_username}    ${big_admin_third_WS_password}
#    # User C log in
#    ${driver3}   driver_set_up_and_logIn   ${switch_workspace_username}      ${switch_workspace_password}
#    # User C与User B进行Call
#    make_calls_with_who    ${driver3}   ${driver2}    ${big_admin_third_WS_username}
#    # User C 进入到邀请第三位用户进入call 的页面，并查询User A
#    enter_contacts_search_user   ${driver3}   ${big_admin_first_WS_name}
#    # 点击查询到的User A
#    click_user_in_contacts_call   ${driver3}   ${big_admin_first_WS_name}
#    # User A 接收打进来的Call
#    user_anwser_call   ${driver1}
#    # User A leave call
#    exit_call   ${driver1}
#    # User A have tags screen pop up	A choose and enter new tag name, fill comments
#    ${first_tag_text}   add_tags_and_comment    ${driver1}     1   good_experience_1
#    # User A 进入Recents页面
#    sleep  5s   # 等待最近一次通话记录加载
#    close_call_ending_page   ${driver1}
#    switch_to_diffrent_page   ${driver1}   ${py_recents_page}     ${py_recents_switch_success}    ${py_get_number_of_rows}
#    # A's recent should have tag and comments just entered
#    first_call_record_tag_and_comment   ${driver1}   ${first_tag_text}   good_experience_1
#    # Then B leave call after A added tags
#    exit_call   ${driver2}   1
#    # B and C add tags and comments
#    ${second_tag_text}   add_tags_and_comment     ${driver2}    2   good_experience_2
#    ${third_tag_text}    add_tags_and_comment     ${driver3}    3   good_experience_3
#    # 先关闭call结束页面
#    close_call_ending_page   ${driver2}
#    close_call_ending_page   ${driver3}
#    # View recents of this call	A and B and C should have same tags and comments，进入到Recents页面
#    # User A切换到Contacts页面，再切换到Recents页面，目的是为了使Recents页面得到刷新
#    switch_to_diffrent_page   ${driver1}   ${py_contacts_page}     ${py_contacts_switch_success}    ${py_get_number_of_rows}
#    switch_to_diffrent_page   ${driver1}   ${py_recents_page}     ${py_recents_switch_success}    ${py_get_number_of_rows}
#    # User B C切换到Recents页面
#    switch_to_diffrent_page   ${driver2}   ${py_recents_page}     ${py_recents_switch_success}    ${py_get_number_of_rows}
#    switch_to_diffrent_page   ${driver3}   ${py_recents_page}     ${py_recents_switch_success}    ${py_get_number_of_rows}
#    first_call_record_tag_and_comment   ${driver1}     ${first_tag_text}, ${second_tag_text}, ${third_tag_text}      good_experience_3    good_experience_2   good_experience_1
#    first_call_record_tag_and_comment   ${driver2}     ${first_tag_text}, ${second_tag_text}, ${third_tag_text}      good_experience_3    good_experience_2   good_experience_1
#    first_call_record_tag_and_comment   ${driver3}     ${first_tag_text}, ${second_tag_text}, ${third_tag_text}      good_experience_3    good_experience_2   good_experience_1
##    # Modify any tags for this call
##    del_tags_in_call_details   ${driver3}
##    # User A B C 切换到Contacts页面，再切换到Recents页面，目的是为了使Recents页面得到刷新
##    switch_to_diffrent_page   ${driver1}   ${py_contacts_page}     ${py_contacts_switch_success}    ${py_get_number_of_rows}
##    switch_to_diffrent_page   ${driver1}   ${py_recents_page}     ${py_recents_switch_success}    ${py_get_number_of_rows}
##    switch_to_diffrent_page   ${driver2}   ${py_contacts_page}     ${py_contacts_switch_success}    ${py_get_number_of_rows}
##    switch_to_diffrent_page   ${driver2}   ${py_recents_page}     ${py_recents_switch_success}    ${py_get_number_of_rows}
##    switch_to_diffrent_page   ${driver3}   ${py_contacts_page}     ${py_contacts_switch_success}    ${py_get_number_of_rows}
##    switch_to_diffrent_page   ${driver3}   ${py_recents_page}     ${py_recents_switch_success}    ${py_get_number_of_rows}
##    # Other participants tags must be updated,too;
##    first_call_record_tag_and_comment   ${driver1}     ${first_tag_text}, ${second_tag_text}      good_experience_3    good_experience_2   good_experience_1
##    first_call_record_tag_and_comment   ${driver2}     ${first_tag_text}, ${second_tag_text}      good_experience_3    good_experience_2   good_experience_1
##    first_call_record_tag_and_comment   ${driver3}     ${first_tag_text}, ${second_tag_text}      good_experience_3    good_experience_2   good_experience_1
#    [Teardown]      run keywords    Close
#    ...             AND             exit_driver   ${driver1}   ${driver2}  ${driver3}
#
#Call_Tag_Comment_596_599
#    [Documentation]    Call Tag/Comment   Pre-condition:Site has workspace WS1 ,WS2; User A,B,C in WS1; User C in WS2        A, B and C in a call
#    [Tags]     small range 596-599  lines     https://vipaar.atlassian.net/browse/CITRON-3338，通话记录没有DETAILS按钮
#    [Setup]     run keywords      Login_premium_user   # log in with premium admin
#    ...         AND               make_sure_workspaces_setting_tagging_and_comments      open_feature     open_feature          # WS1 and WS2 both turn on tag feature
#    ...         AND               Close
#    # User A log in
#    ${driver1}   driver_set_up_and_logIn   ${big_admin_first_WS_username}    ${big_admin_first_WS_password}
#    # User B log in
#    ${driver2}   driver_set_up_and_logIn   ${big_admin_third_WS_username}    ${big_admin_third_WS_password}
#    # User C log in
#    ${driver3}   driver_set_up_and_logIn   ${switch_workspace_username}      ${switch_workspace_password}
#    # User C与User B进行Call
#    make_calls_with_who    ${driver3}   ${driver2}    ${big_admin_third_WS_username}
#    # User C 进入到邀请第三位用户进入call 的页面，并查询User A
#    enter_contacts_search_user   ${driver3}   ${big_admin_first_WS_name}
#    # 点击查询到的User A
#    click_user_in_contacts_call   ${driver3}   ${big_admin_first_WS_name}
#    # User A 接收打进来的Call
#    user_anwser_call   ${driver1}
#    # User C End Call for All
#    end_call_for_all   ${driver3}
#    # 获取所有的tags列表
#    ${tags_list_C1}    get_all_tag_after_call    ${driver3}
#
#    # 先关闭call结束页面
#    close_call_ending_page   ${driver1}
#    close_call_ending_page   ${driver2}
#    close_call_ending_page   ${driver3}
#    # User C switch to WS2
#    user_switch_to_second_workspace     ${driver3}
#    # User A切换到Contacts页面
#    switch_to_diffrent_page   ${driver1}   ${py_contacts_page}     ${py_contacts_switch_success}    ${py_get_number_of_rows}
#    # A call B, invite C
#    make_calls_with_who    ${driver1}   ${driver2}    ${big_admin_third_WS_username}
#    enter_contacts_search_user    ${driver1}   ${switch_workspace_name}
#    # 点击查询到的User C
#    click_user_in_contacts_call   ${driver1}   ${switch_workspace_name}
#    user_anwser_call    ${driver3}
#    # A end call for all
#    end_call_for_all   ${driver1}
#    # C click tag fields
#    # 获取所有的tags列表
#    ${tags_list_C2}    get_all_tag_after_call    ${driver3}
#    # VP: Similar tag name of WS1 list out
#    lists should be equal     ${tags_list_C1}    ${tags_list_C2}
#    # A, B , C fill in tags and comments
#    ${first_tag_text}    add_tags_and_comment     ${driver1}    1   good_experience_4
#    ${second_tag_text}   add_tags_and_comment     ${driver2}    2   good_experience_5
#    ${third_tag_text}    add_tags_and_comment     ${driver3}    3   good_experience_6
#    # 先关闭call结束页面
#    close_call_ending_page   ${driver3}
#    # User C switch to WS1
#    user_switch_to_first_workspace   ${driver3}
#    # 切换到Recents页面
#    switch_to_diffrent_page   ${driver3}   ${py_recents_page}     ${py_recents_switch_success}    ${py_get_number_of_rows}
#    # User C should see all tags and comments from call recents
#    first_call_record_tag_and_comment   ${driver3}     ${first_tag_text}, ${second_tag_text}, ${third_tag_text}      good_experience_6    good_experience_5   good_experience_4
#    [Teardown]      run keywords    Close
#    ...             AND             exit_driver   ${driver1}   ${driver2}  ${driver3}
#
#Call_Tag_Comment_600_604
#    [Documentation]    Call Tag/Comment   Pre-condition:Site has workspace WS1 ,WS2; User A,B,C in WS1; User C in WS2        A, B and C in a call
#    [Tags]     small range 600-604  lines     https://vipaar.atlassian.net/browse/CITRON-3338，通话记录没有DETAILS按钮
#    [Setup]     run keywords      Login_premium_user   # log in with premium admin
#    ...         AND               make_sure_workspaces_setting_tagging_and_comments      open_feature     open_feature          # WS1 and WS2 both turn on tag feature
#    ...         AND               Close
#    # User A log in
#    ${driver1}   driver_set_up_and_logIn   ${big_admin_first_WS_username}    ${big_admin_first_WS_password}
#    # User B log in
#    ${driver2}   driver_set_up_and_logIn   ${big_admin_third_WS_username}    ${big_admin_third_WS_password}
#    # User C log in
#    ${driver3}   driver_set_up_and_logIn   ${switch_workspace_username}      ${switch_workspace_password}
#    # User C与User B进行Call
#    make_calls_with_who    ${driver3}   ${driver2}    ${big_admin_third_WS_username}
#    # User C 进入到邀请第三位用户进入call 的页面，并查询User A
#    enter_contacts_search_user   ${driver3}   ${big_admin_first_WS_name}
#    # 点击查询到的User A
#    click_user_in_contacts_call   ${driver3}   ${big_admin_first_WS_name}
#    # User A 接收打进来的Call
#    user_anwser_call   ${driver1}
#    # User C End Call for All
#    end_call_for_all   ${driver3}
#    # 获取所有的tags列表
#    ${tags_list_B1}    get_all_tag_after_call    ${driver2}
#    ${tags_list_A1}    get_all_tag_after_call    ${driver1}
#
#    # 先关闭call结束页面
#    close_call_ending_page   ${driver1}
#    close_call_ending_page   ${driver2}
#    close_call_ending_page   ${driver3}
#    # User C switch to WS2
#    user_switch_to_second_workspace     ${driver3}
#    # C send meeing link [link2]
#    ${invite_url}  send_meeting_room_link   ${driver3}  OTU
#    # A and B click [link2] to enter call
#    user_make_call_via_meeting_link   ${driver1}    ${invite_url}
#    user_anwser_call  ${driver3}
#    user_make_call_via_meeting_link   ${driver2}    ${invite_url}
#    user_anwser_call  ${driver3}    no_direct
#    # owner end call
#    end_call_for_all   ${driver3}
#    # B and A click tag，VP: Similar tag name of WS1 list out
#    ${tags_list_B2}    get_all_tag_after_call    ${driver2}
#    ${tags_list_A2}    get_all_tag_after_call    ${driver1}
#    lists should be equal   ${tags_list_B1}   ${tags_list_B2}
#    lists should be equal   ${tags_list_A1}   ${tags_list_A2}
#    # 添加tags和comment
#    ${first_tag_text}    add_tags_and_comment     ${driver1}    1   good_experience_7
#    ${second_tag_text}   add_tags_and_comment     ${driver2}    2   good_experience_8
#    # 先关闭call结束页面
#    close_last_window   ${driver1}    # 通过link进入Call的页面，不会有call结束页面的关闭按钮
#    close_last_window   ${driver2}    # 通过link进入Call的页面，不会有call结束页面的关闭按钮
#    # VP: for A and B, tag comment is saved to WS1's recents
#    switch_to_diffrent_page   ${driver2}   ${py_recents_page}     ${py_recents_switch_success}    ${py_get_number_of_rows}
#    switch_to_diffrent_page   ${driver1}   ${py_recents_page}     ${py_recents_switch_success}    ${py_get_number_of_rows}
#    first_call_record_tag_and_comment   ${driver1}     ${first_tag_text}, ${second_tag_text}       good_experience_8   good_experience_7
#    # 添加tag和comment
#    ${third_tag_text}    add_tags_and_comment     ${driver3}    3   good_experience_9    # 添加tag和comment
#    # VP: For C, tag comment is saved to recents of ws2
#    close_call_ending_page   ${driver3}    # 先关闭call结束页面
#    switch_to_diffrent_page   ${driver3}   ${py_recents_page}     ${py_recents_switch_success}    ${py_get_number_of_rows}     # 切换到Recents页面
#    first_call_record_tag_and_comment   ${driver3}     ${third_tag_text}     good_experience_9
#    # Anonymous click link2 to enter call
#    ${driver4}   anonymous_open_meeting_link   ${invite_url}
#    user_anwser_call   ${driver3}
#    # owner end call
#    exit_call   ${driver4}
#    # VP: Anonymous user does not have tag comment fields
#    check_tag_and_com_switch_success   ${driver4}
#    [Teardown]      run keywords    Close
#    ...             AND             exit_driver   ${driver1}   ${driver2}  ${driver3}   ${driver4}
#
#Call_Tag_Comment_605_606
#    [Documentation]    Call Tag/Comment   Pre-condition:Site has workspace WS1 ,WS2; User A,B,C in WS1; User C in WS2        A, B and C in a call
#    [Tags]     small range 605-606  lines     https://vipaar.atlassian.net/browse/CITRON-3338，通话记录没有DETAILS按钮
#    [Setup]     run keywords      Login_premium_user   # log in with premium admin
#    ...         AND               make_sure_workspaces_setting_tagging_and_comments      open_feature     open_feature          # WS1 and WS2 both turn on tag feature
#    ...         AND               Close
#    # 该脚本中使用的on-call-group是three_user_in_this_on_call_group，隶属于big_admin
#    # User A log in
#    ${driver1}   driver_set_up_and_logIn   ${big_admin_first_WS_username}    ${big_admin_first_WS_password}
#    # User C log in
#    ${driver3}   driver_set_up_and_logIn   ${switch_workspace_username}      ${switch_workspace_password}
#    # User C switch to WS2
#    user_switch_to_second_workspace     ${driver3}
#    # A Call on-call group from contact list
#    different_page_search_single_users    ${driver1}   ${py_contacts_page}    ${py_input_search}    ${py_get_number_of_rows}   ${big_admin_on_call_group}  # search on-call-group in Team page
#    make_call_to_onCall     ${driver1}   ${driver3}    ${big_admin_on_call_group}
#    # C accept call, then end call
#    exit_call     ${driver3}
#    # A and C fill in tag and comments
#    ${first_tag_text}     add_tags_and_comment     ${driver1}    1   good_experience_11
#    ${second_tag_text}    add_tags_and_comment     ${driver3}    2   good_experience_12
#    # VP: for A , tag comment is saved to WS1's recents
#    close_call_ending_page   ${driver1}
#    switch_to_diffrent_page   ${driver1}   ${py_recents_page}     ${py_recents_switch_success}    ${py_get_number_of_rows}
#    first_call_record_tag_and_comment   ${driver1}   ${first_tag_text}, ${second_tag_text}   good_experience_12    good_experience_11
#    # VP: For C, tag comment is saved to recents of ws1
#    close_call_ending_page   ${driver3}
#    user_switch_to_first_workspace   ${driver3}    # User C switch to WS1
#    switch_to_diffrent_page   ${driver3}   ${py_recents_page}     ${py_recents_switch_success}    ${py_get_number_of_rows}
#    first_call_record_tag_and_comment   ${driver3}   ${first_tag_text}, ${second_tag_text}   good_experience_12    good_experience_11
#    [Teardown]      run keywords    Close
#    ...             AND             exit_driver   ${driver1}  ${driver3}

Call_survey_608_610
    [Documentation]   Call survey(Tier of enterprise and above)   Customer call Experts group[all have survey & call tag permission]   Customer invite a enterprise user
    [Tags]     small range 608-610 lines
    [Setup]     run keywords      Login_workspaces_admin            # log in with WS admin
    ...         AND               enter_workspace_settings_page     # 进入settings页面
    ...         AND               set_survey_open                   # 设置After Call: End of Call Survey为open状态
    ...         AND               open_tagging_and_comments         # 设置After Call: Tagging and Comments为open状态
    ...         AND               Close
    # Customer 登录
    ${driver1}   driver_set_up_and_logIn    ${call_oncall_user_username}        ${call_oncall_user_password}
    # Experts group user登录
    ${driver2}   driver_set_up_and_logIn    ${oncall_user_username}             ${oncall_user_password}
    # enterprise user登录
    ${driver3}   driver_set_up_and_logIn    ${personal_user_username}           ${personal_user_password}
    # make call with on-call
    make_call_to_onCall   ${driver1}   ${driver2}
    # Customer invite a enterprise user
    enter_contacts_search_user   ${driver1}    ${personal_user_name}
    click_user_in_contacts_call    ${driver1}    ${personal_user_name}
    # enterprise user 接受call
    user_anwser_call   ${driver3}
    # Customer click End Call
    leave_call  ${driver1}
    # Customer enter call tag & comment
    ${first_tag_text}  add_tags_and_comment    ${driver1}     1   good_experience_13
    # And then click Take Survey button
    check_survey_switch_success   ${driver1}    1   click
    # return to the Tags/Comments page, but survey button disappear.
    close_last_window   ${driver1}
    check_survey_switch_success   ${driver1}    0
    # The entered call tag and comment should not disappeared.
    check_tag_and_com_switch_success   ${driver1}    1

    ###### 609 line
    # After customer save successfully call & comment, Expert click End Call button
    exit_call   ${driver2}   10
    # Expert enter call tag & comment, and then click Take Survey button
    ${second_tag_text}  add_tags_and_comment    ${driver2}     2   good_experience_14
    check_survey_switch_success   ${driver2}    1   click
    # return to the Tags/Comments page, but survey button disappear.
    close_last_window   ${driver2}
    check_survey_switch_success   ${driver2}    0
    # The entered call tag and comment should not disappeared.
    check_tag_and_com_switch_success   ${driver2}    1
    # The entered call tag and comment should not disappeared.
    get_all_comments_in_call_end    ${driver2}    good_experience_14   good_experience_13

    ###### 610 line
    #  Enterprise user enter call tag & comment, and then click Take Survey button
    ${third_tag_text}  add_tags_and_comment    ${driver3}     3   good_experience_15
    check_survey_switch_success   ${driver3}    1   click
    # return to the Tags/Comments page, but survey button disappear.
    close_last_window   ${driver3}
    check_survey_switch_success   ${driver3}    0
    # The entered call tag and comment should not disappeared.
    check_tag_and_com_switch_success   ${driver3}    1
    # The entered call tag and comment should not disappeared.
    get_all_comments_in_call_end    ${driver3}   good_experience_15    good_experience_14   good_experience_13

    # Customer navigate to Recent ->Call, to make sure the tags & comments should be saved successfully
    close_call_ending_page   ${driver1}
    switch_to_diffrent_page   ${driver1}   ${py_recents_page}     ${py_recents_switch_success}    ${py_get_number_of_rows}     # 切换到Recents页面
    first_call_record_tag_and_comment   ${driver1}     ${first_tag_text}, ${second_tag_text}, ${third_tag_text}     good_experience_15    good_experience_14   good_experience_13
    [Teardown]      run keywords    Close
    ...             AND             exit_driver    ${driver1}    ${driver2}  ${driver3}

Call_survey_611_615
    [Documentation]   Call survey(Tier of enterprise and above)   Pre-condition:(A & B not in the same company)    3PC call
    [Tags]     small range 611-615 lines
    [Setup]     run keywords      Login_premium_user                # log in with SITE admin
    ...         AND               enter_workspace_settings_page     # 进入settings页面
    ...         AND               set_survey_open                   # 设置After Call: End of Call Survey为open状态
    ...         AND               close_tagging_and_comments        # 设置After Call: Tagging and Comments为close状态
    ...         AND               Close
    ...         AND               Login_workspaces_admin            # log in with WS admin
    ...         AND               enter_workspace_settings_page     # 进入settings页面
    ...         AND               set_survey_open                   # 设置After Call: End of Call Survey为open状态
    ...         AND               open_tagging_and_comments         # 设置After Call: Tagging and Comments为open状态
    ...         AND               Close
    # User A 登录
    ${driver1}   driver_set_up_and_logIn    ${switch_workspace_username}        ${switch_workspace_password}
    # User B 登录
    ${driver2}   driver_set_up_and_logIn    ${call_oncall_user_username}        ${call_oncall_user_password}
    # User C 登录
    ${driver3}   driver_set_up_and_logIn    ${big_admin_first_WS_username}      ${big_admin_first_WS_password}
    # User A, B and C are in a MHS call. User B is owner.
    ${invite_url}  send_meeting_room_link   ${driver2}   MHS
    user_make_call_via_meeting_link   ${driver1}    ${invite_url}
    user_anwser_call  ${driver2}
    user_make_call_via_meeting_link   ${driver3}    ${invite_url}
    user_anwser_call  ${driver2}    no_direct
    # End call.
    end_call_for_all    ${driver2}
    #VP: A and C just has Survey page. B has tag/comment part and survey page.
    check_tag_and_com_switch_success   ${driver1}
    check_tag_and_com_switch_success   ${driver3}
    check_tag_and_com_switch_success   ${driver2}       1
    check_survey_switch_success     ${driver1}      1     no_click
    check_survey_switch_success     ${driver3}      1     click     # B clicks Survey button
    check_survey_switch_success     ${driver2}      1     click     # C clicks Survey button
    # A clicks Close button
    close_last_window   ${driver1}
    # User A return to the previous page before entering call.
    which_page_is_currently_on     ${driver1}     ${py_contacts_switch_success}
    # User B return to the previous page before entering call.
    close_last_window   ${driver2}
    close_call_ending_page   ${driver2}
    which_page_is_currently_on     ${driver2}     ${py_contacts_switch_success}

    ###### 614 line
    # C receives an incoming call from A
    close_last_window   ${driver3}
    close_last_window   ${driver3}
    refresh_browser_page    ${driver3}
    make_calls_with_who   ${driver1}   ${driver3}   ${big_admin_first_WS_username}   no_anwser    not_personal
    # Accept Call
    user_anwser_call    ${driver3}
    # Enter call view. And the tag screen or survey web view will be closed
    which_page_is_currently_on     ${driver3}    ${end_call_button}
    # end call
    exit_call   ${driver3}

    ###### 615 line
    # C receives an incoming call from A
    close_call_ending_page   ${driver1}
    refresh_browser_page    ${driver3}
    make_calls_with_who   ${driver1}   ${driver3}   ${big_admin_first_WS_username}   no_anwser    not_personal
    # Cancel
    user_decline_call   ${driver3}
    # return to the previous page before entering call.
    which_page_is_currently_on   ${driver3}   ${py_contacts_switch_success}
    [Teardown]      run keywords    Close
    ...             AND             exit_driver    ${driver1}    ${driver2}  ${driver3}

Call_survey_616_618
    [Documentation]   Call survey(Tier of enterprise and above)   Anonymous call Meeting Owner
    [Tags]     small range 616-618 lines
    [Setup]     run keywords      Login_workspaces_admin            # log in with WS admin
    ...         AND               enter_workspace_settings_page     # 进入settings页面
    ...         AND               set_survey_open                   # 设置After Call: End of Call Survey为open状态
    ...         AND               open_tagging_and_comments         # 设置After Call: Tagging and Comments为open状态
    ...         AND               Close
    # Meeting Owner 登录
    ${driver1}   driver_set_up_and_logIn    ${call_oncall_user_username}        ${call_oncall_user_password}
    # 3rd enterprise user 登录
    ${driver2}   driver_set_up_and_logIn    ${personal_user_username}           ${personal_user_password}
    # 获取meeting link
    ${invite_url}  send_meeting_room_link   ${driver1}   OTU
    # Anonymous call Meeting Owner
    ${driver3}   anonymous_open_meeting_link    ${invite_url}
    # Owner accept
    user_anwser_call  ${driver1}
    # the 3rd enterprise user who is in the same enterprise with owner join in it.
    user_make_call_via_meeting_link   ${driver2}    ${invite_url}
    # Owner accept
    user_anwser_call  ${driver1}    no_direct
    # Owner End call
    end_call_for_all   ${driver1}
    # Owner clicks Survey button
    check_survey_switch_success    ${driver1}     1    click
    # Owner return to the Tags/Comments page
    close_last_window   ${driver1}
    # Owner adds tags/comment
    ${first_tag_text}   add_tags_and_comment    ${driver1}    1    good_experience_16
    # Owner navigate to Recent tab to make sure these tags/comment should be saved successfully.
    close_call_ending_page    ${driver1}
    switch_to_diffrent_page   ${driver1}   ${py_recents_page}     ${py_recents_switch_success}    ${py_get_number_of_rows}

    ###### 617 line
    # Anonymous clicks Survey button
    check_survey_switch_success    ${driver3}     1    click
    # Anonymous clicks Done button to return to the previous page before entering call.[App: login page, Citron: Call End page]
    close_last_window   ${driver3}
    which_page_is_currently_on     ${driver3}     ${five_star_high_praise}

    ###### 618 line
    # VP: return to the previous page before entering call
    which_page_is_currently_on    ${driver2}    ${five_star_high_praise}
    [Teardown]      run keywords    Close
    ...             AND             exit_driver    ${driver1}    ${driver2}  ${driver3}