*** Settings ***
Library           Selenium2Library
Library           OperatingSystem
Resource          ../../../Lib/public.robot
Resource          ../../../Lib/calls_resource.robot
Resource          ../../../Lib/hodgepodge_resource.robot
Library           call_python_Lib/call_public_lib.py
Library           call_python_Lib/else_public_lib.py

*** Test Cases ***
#Small_range_149_151
#    [Documentation]    Guide First-Time use hints	newly installed app	   premium user call contact in F2F mode
#    [Tags]      small range 149+150+151 lines    Bug：hint dialog does not show， shttps://vipaar.atlassian.net/browse/CITRON-3353
#    # premium user log in
#    ${driver1}  driver_set_up_and_logIn   ${crunch_site_username}   ${crunch_site_password}
#    # Contact of premium user log in
#    ${driver2}  driver_set_up_and_logIn     ${big_admin_first_WS_username}   ${big_admin_first_WS_password}
#    # premium user call contact in F2F mode
#    make_calls_with_who   ${driver1}   ${driver2}   ${big_admin_first_WS_username}
#    # VP: hint dialog shows;
#    which_page_is_currently_on    ${driver1}    ${choose_give_receive_help_mode}
#    # Mute,Camera and End Call icon are at 50% opacity;
#    which_page_is_currently_on    ${driver1}    //*[@*="#mic_off"]
#    which_page_is_currently_on    ${driver1}    //*[@*="#phone_end_red"]
#    # Yellow star on F2F icon
#    which_page_is_currently_on    ${driver1}    //img[@class="starHint"]
#    # Click Mute/Camera/Hamburger
#    switch_to_other_tab    ${driver1}    //*[@*="#mic_off"]
#    sleep  1s
#    # VP: hint dialog still shows
#    which_page_is_currently_on    ${driver1}    ${choose_give_receive_help_mode}
#    # Click Give or receive help on dialog
#    enter_giver_mode     ${driver1}      none    none     2
#    # Back to F2F mode	VP: hint dialog disappear
#    which_page_is_currently_on    ${driver1}    ${choose_give_receive_help_mode}     not_currently_on
#    [Teardown]      run keywords    exit_call   ${driver2}   1
#    ...             AND             exit_driver   ${driver1}   ${driver2}

Small_range_152
    [Documentation]    2 users in face to face mode
    [Tags]      small range 152 line
    # user1 log in
    ${driver1}  driver_set_up_and_logIn     ${Expert_User1_username}   ${universal_password}
    # user2 log in
    ${driver2}  driver_set_up_and_logIn     ${Expert_User2_username}   ${universal_password}
    # user3 log in
    ${driver3}  driver_set_up_and_logIn     ${Expert_User3_username}   ${universal_password}
    # 2 users in face to face mode
    make_calls_with_who   ${driver1}   ${driver2}   ${Expert_User2_username}
    # VP: hint dialog shows;
    which_page_is_currently_on    ${driver1}    ${choose_give_receive_help_mode}
    # 3rd user join as 3pc call
    enter_contacts_search_user    ${driver1}   ${Expert_User3_name}
    click_user_in_contacts_call    ${driver1}     ${Expert_User3_name}
    user_anwser_call    ${driver3}
    sleep  10s
    # VP:hints dialog is closed on screen of 3pc call
    which_page_is_currently_on    ${driver1}    ${choose_give_receive_help_mode}     not_currently_on
    [Teardown]      run keywords    end_call_for_all   ${driver1}
    ...             AND             exit_driver    ${driver1}   ${driver2}   ${driver3}

Small_range_153_160
    [Documentation]    Enterprise user call contact in F2F mode
    [Tags]      small range 153-160 lines
    # Enterprise user log in
    ${driver1}  driver_set_up_and_logIn     ${enterprise_username}   ${enterprise_password}
    # contact of Enterprise user log in
    ${driver2}  driver_set_up_and_logIn     ${belong_enterprise_username}    ${universal_password}
    make_calls_with_who   ${driver1}   ${driver2}   ${belong_enterprise_username}
    # uncheck "Continue to show hints" checkbox
    switch_to_other_tab     ${driver1}     //div[@class="checkbox"]//input[@type="checkbox"]
    # End call, then make another call
    exit_call    ${driver1}
    close_call_ending_page    ${driver1}
    close_call_ending_page    ${driver2}
    make_calls_with_who   ${driver1}   ${driver2}   ${belong_enterprise_username}
    # VP: hint dialog does not shown
    which_page_is_currently_on    ${driver1}    ${choose_give_receive_help_mode}     not_currently_on
    # End call
    exit_call    ${driver1}
    close_call_ending_page    ${driver1}
    close_call_ending_page    ${driver2}
    # open "Show menu hints" setting from account
    enter_my_account_settings_page    ${driver1}
    # VP: "Show menu hints" is off
    which_page_is_currently_on    ${driver1}    ${open_Menu_Items}
    # Turn on "Show menu hints" setting
    switch_to_other_tab    ${driver1}    ${open_Menu_Items}
    # Kill/close app and relaunch
    exit_driver    ${driver1}
    ${driver1}   driver_set_up_and_logIn     ${enterprise_username}   ${enterprise_password}
    # VP: hints setting is on status
    enter_my_account_settings_page    ${driver1}
    which_page_is_currently_on     ${driver1}    //h1[text()="Menu Items"]/..//div[@class="react-toggle react-toggle--checked"]
    # call contact in F2F mode
    switch_to_diffrent_page   ${driver1}   ${py_contacts_page}     ${py_contacts_switch_success}    ${py_get_number_of_rows}
    make_calls_with_who   ${driver1}   ${driver2}   ${belong_enterprise_username}
    # VP: hint dialog shows
    which_page_is_currently_on    ${driver1}    ${choose_give_receive_help_mode}
    # click Close on hint dialog
    switch_to_other_tab    ${driver1}     //span[@class="close-button"]
    # VP: hints dialog is closed
    which_page_is_currently_on    ${driver1}    ${choose_give_receive_help_mode}     not_currently_on
    # Switch to giver or receiver
    enter_giver_mode    ${driver1}     none    none     2     has_no_dialog
    enter_face_to_face_mode     ${driver1}
    # VP: hint dialog is not shown
    which_page_is_currently_on    ${driver1}    ${choose_give_receive_help_mode}     not_currently_on
    [Teardown]      run keywords    exit_call   ${driver1}
    ...             AND             exit_driver    ${driver1}   ${driver2}

Small_range_161
    [Documentation]    WebApp specific
    [Tags]      small range 161 line
    # user1 log in
    ${driver1}  driver_set_up_and_logIn     ${Expert_User1_username}   ${universal_password}
    # user2 log in
    ${driver2}  driver_set_up_and_logIn     ${Expert_User2_username}   ${universal_password}
    # call contact in F2F mode
    make_calls_with_who   ${driver1}   ${driver2}   ${Expert_User2_username}
    # VP: hint dialog shows;
    which_page_is_currently_on    ${driver1}    ${choose_give_receive_help_mode}
    # Mute,Camera and End Call icon are at 50% opacity;
    which_page_is_currently_on    ${driver1}    //*[@*="#mic_on"]
    which_page_is_currently_on    ${driver1}    //*[@*="#phone_end_red"]
    # Yellow star on F2F icon
    which_page_is_currently_on    ${driver1}    //img[@class="starHint"]
    # VP: Have Switch Camera button
    enter_giver_mode    ${driver1}   none   none   2
    enter_FGD_mode   ${driver1}    Swap Camera
    [Teardown]      run keywords    exit_call   ${driver1}
    ...             AND             exit_driver    ${driver1}   ${driver2}

Join_call_162_167
    [Documentation]     Join call	MPC via dialer directly
    [Tags]     small range 612-617 lines
    [Setup]     run keywords      Login_premium_user                # log in with Site Admin
    ...         AND               switch_to_created_workspace       ${created_workspace}      # 进入Huiming.shi_Added_WS这个WS
    ...         AND               enter_workspace_settings_page     # 进入settings页面
    ...         AND               close_disable_external_users      # 设置Security: Disable External Users为close状态
    ...         AND               Close
    # EU1 登录
    ${driver1}   driver_set_up_and_logIn    ${Expert_User5_username}        ${call_oncall_user_password}
    # TU2 登录
    ${driver2}   driver_set_up_and_logIn    ${Team_User1_username}           ${personal_user_password}
    # EU1 calls TU2. TU2 answers call
    make_calls_with_who   ${driver1}   ${driver2}   ${Team_User1_username}
    # EU3 登录
    ${driver3}   driver_set_up_and_logIn    ${Expert_User4_username}        ${call_oncall_user_password}
    # PU4 登录
    ${driver4}   driver_set_up_and_logIn    ${ws_branding_A_user}        ${call_oncall_user_password}
    # DU5 登录
    ${driver5}   driver_set_up_and_logIn    ${ws_branding_B_user}        ${call_oncall_user_password}
    # EU1 sends 3pi link.
    ${invite_url}     send_invite_in_calling_page    ${driver1}
    # EU3, PU (personal user 4, DU (different enterprise user) 5, AU (anonymous user) 6 clicks on 3pi link in rapid sequence.
    user_make_call_via_meeting_link    ${driver3}    ${invite_url}
    user_make_call_via_meeting_link    ${driver4}    ${invite_url}
    user_make_call_via_meeting_link    ${driver5}    ${invite_url}
    ${driver6}    anonymous_open_meeting_link    ${invite_url}
    # EU3 joins call automatically.
    which_page_is_currently_on    ${driver3}    ${end_call_button}
    # EU1 gets accept/decline request from PU4.   EU1 accepts call.    PU4 joins call
    user_anwser_call    ${driver1}   no_direct
    which_page_is_currently_on    ${driver4}    ${end_call_button}
    # EU1 gets accept/decline request from DU5.   EU1 declines call.   DU5 doesn't join call
    user_decline_call    ${driver1}   in_calling
    which_page_is_currently_on    ${driver5}    ${your_call_was_declined}
    # EU1 gets accept/decline request from AU6.   EU1 accepts call	VP: AU6 joins call.
    user_anwser_call    ${driver1}   no_direct
    which_page_is_currently_on    ${driver6}    ${end_call_button}
    [Teardown]      run keywords    Close
    ...             AND             exit_driver    ${driver1}    ${driver2}  ${driver3}    ${driver4}    ${driver5}  ${driver6}

Join_call_168_178
    [Documentation]     Join call	MPC via on-call group.
    [Tags]     small range 168-178 lines
    [Setup]     run keywords      Login_premium_user                # log in with Site Admin
    ...         AND               switch_to_created_workspace       ${created_workspace}      # 进入Huiming.shi_Added_WS这个WS
    ...         AND               enter_workspace_settings_page     # 进入settings页面
    ...         AND               close_disable_external_users      # 设置Security: Disable External Users为close状态
    ...         AND               Close
    # EU1 登录
    ${driver1}   driver_set_up_and_logIn    ${Expert_User5_username}        ${call_oncall_user_password}
    # TU2 登录
    ${driver2}   driver_set_up_and_logIn    ${Team_User1_username}           ${personal_user_password}
    # EU1 calls TU2. TU2 answers call
    make_calls_with_who   ${driver1}   ${driver2}   ${Team_User1_username}
    # EU3 登录
    ${driver3}   driver_set_up_and_logIn    ${Expert_User4_username}        ${call_oncall_user_password}
    # PU4 登录
    ${driver4}   driver_set_up_and_logIn    ${ws_branding_A_user}        ${call_oncall_user_password}
    # DU5 登录
    ${driver5}   driver_set_up_and_logIn    ${ws_branding_B_user}        ${call_oncall_user_password}
    # EU1 sends 3pi link.
    ${invite_url}     send_invite_in_calling_page    ${driver1}
    # EU3, PU (personal user 4, DU (different enterprise user) 5, AU (anonymous user) 6 clicks on 3pi link in rapid sequence.
    user_make_call_via_meeting_link    ${driver3}    ${invite_url}
    user_make_call_via_meeting_link    ${driver4}    ${invite_url}
    user_make_call_via_meeting_link    ${driver5}    ${invite_url}
    ${driver6}    anonymous_open_meeting_link    ${invite_url}
    # EU3 joins call automatically.
    which_page_is_currently_on    ${driver3}    ${end_call_button}
    # EU1 gets accept/decline request from PU4.   EU1 accepts call.    PU4 joins call
    user_anwser_call    ${driver1}   no_direct
    which_page_is_currently_on    ${driver4}    ${end_call_button}
    # EU1 gets accept/decline request from DU5.   EU1 declines call.   DU5 doesn't join call
    user_decline_call    ${driver1}   in_calling
    which_page_is_currently_on    ${driver5}    ${your_call_was_declined}
    # EU1 gets accept/decline request from AU6.   EU1 accepts call	VP: AU6 joins call.
    user_anwser_call    ${driver1}   no_direct
    which_page_is_currently_on    ${driver6}    ${end_call_button}
    [Teardown]      run keywords    Close
    ...             AND             exit_driver    ${driver1}    ${driver2}  ${driver3}    ${driver4}    ${driver5}  ${driver6}

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