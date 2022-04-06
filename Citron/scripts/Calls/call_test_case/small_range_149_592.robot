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
#    [Teardown]      run keywords    end_call_for_all   ${driver1}
#    ...             AND             exit_driver    ${driver1}   ${driver2}   ${driver3}
    [Teardown]       exit_driver    ${driver1}   ${driver2}   ${driver3}

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
    exit_one_driver    ${driver1}
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
#    [Teardown]      run keywords    exit_call   ${driver1}
#    ...             AND             exit_driver    ${driver1}   ${driver2}
    [Teardown]       exit_driver    ${driver1}   ${driver2}

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
#    [Teardown]       exit_driver    ${driver1}   ${driver2}

Join_call_162_167
    [Documentation]     Join call	MPC via dialer directly
    [Tags]     small range 162-167 lines
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
    [Setup]     run keywords      Login_site_admin                  # log in with Site Admin
    ...         AND               switch_to_created_workspace       ${created_workspace_branding_3}      # 进入WS_branding_setting_WS3这个WS
    ...         AND               enter_workspace_settings_page     # 进入settings页面
    ...         AND               close_disable_external_users      # 设置Security: Disable External Users为close状态
    ...         AND               Close
    # TU2 登录
    ${driver1}   driver_set_up_and_logIn    ${test_WS3_TU1_user}        ${call_oncall_user_password}
    # EU1 登录
    ${driver2}   driver_set_up_and_logIn    ${test_WS3_EU1_user}        ${call_oncall_user_password}
    # TU2 clicks on on-call group 1 call. EU1 in on-call group 1 answers call.
    make_call_to_onCall     ${driver1}    ${driver2}    ${On_call_group_001}
    ${invite_url}    send_invite_in_calling_page    ${driver2}
    close_invite_3th_page    ${driver2}
    # Anonymous user 3 clicks on 3pi link. EU1 answers call.
    ${driver3}    anonymous_open_meeting_link    ${invite_url}
    user_anwser_call    ${driver2}   no_direct
    # VP: AU3 joins call.
    which_page_is_currently_on    ${driver3}    ${end_call_button}
    # TU2 invites TU4.   TU4 declines call.
    ${driver4}   driver_set_up_and_logIn    ${test_WS3_TU2_user}       ${call_oncall_user_password}
    enter_contacts_search_user     ${driver1}    ${test_WS3_TU2_user_name}
    click_user_in_contacts_call     ${driver1}    ${test_WS3_TU2_user_name}
    user_decline_call    ${driver4}
    # VP: Team user 4 doesn’t join call
    which_page_is_currently_on    ${driver4}    ${py_contacts_switch_success}
    # TU2 invites TU4.   TU4 accepts call.
    enter_contacts_search_user     ${driver1}    ${test_WS3_TU2_user_name}
    click_user_in_contacts_call     ${driver1}    ${test_WS3_TU2_user_name}
    user_anwser_call    ${driver4}
    # VP: Team user 4 joins call.
    which_page_is_currently_on    ${driver4}    ${end_call_button}
    # TU2 invites on-call group 1   VP: experts in on-call group 1 receives rollover call.    EU5 answers call.
    ${driver5}   driver_set_up_and_logIn    ${test_WS3_EU3_user}        ${call_oncall_user_password}
    enter_contacts_search_user     ${driver1}    ${On_call_group_001}
    click_user_in_contacts_call     ${driver1}    ${On_call_group_001}
    user_anwser_call    ${driver5}
    # TU2 invites on-call group 2   VP: other experts in on-call group 2 receives rollover call. Display message “No experts are available to take your call” if no experts login.
    ${driver6}   driver_set_up_and_logIn    ${test_WS3_EU2_user}        ${call_oncall_user_password}
    enter_contacts_search_user     ${driver1}    ${On_call_group_002}
    click_user_in_contacts_call     ${driver1}    ${On_call_group_002}
    # All experts in on-call group 2 declines call.   Display message “No experts are available to take your call”.
    user_decline_call    ${driver6}
    which_page_is_currently_on    ${driver1}    ${no_experts_are_available}
    # TU2 invites on-call group 2
    enter_contacts_search_user     ${driver1}    ${On_call_group_002}
    click_user_in_contacts_call     ${driver1}    ${On_call_group_002}
    # EU6 in on-call group2 answers call.	VP: expert user 6 joins call
    user_anwser_call    ${driver6}
    which_page_is_currently_on    ${driver6}    ${end_call_button}
    [Teardown]      run keywords    Close
    ...             AND             exit_driver    ${driver1}    ${driver2}  ${driver3}    ${driver4}    ${driver5}  ${driver6}

Join_call_179_187
    [Documentation]     Join call	MPC via MHS link.
    [Tags]     small range 179-187 lines
    [Setup]     run keywords      Login_premium_user                # log in with Site Admin
    ...         AND               switch_to_created_workspace       ${created_workspace}      # 进入Huiming.shi_Added_WS这个WS
    ...         AND               enter_workspace_settings_page     # 进入settings页面
    ...         AND               close_disable_external_users      # 设置Security: Disable External Users为close状态
    ...         AND               Close
    # EU1 登录
    ${driver1}   driver_set_up_and_logIn    ${Expert_User5_username}        ${call_oncall_user_password}
    # TU2 登录
    ${driver2}   driver_set_up_and_logIn    ${Team_User1_username}           ${personal_user_password}
    # TU2 clicks on EU1’s MHS link. EU1 answers call.
    ${invite_mhs_url}   send_meeting_room_link    ${driver1}   MHS
    user_make_call_via_meeting_link    ${driver2}    ${invite_mhs_url}
    user_anwser_call    ${driver1}
    # TU3 登录
    ${driver3}   driver_set_up_and_logIn    ${Team_User2_username}        ${call_oncall_user_password}
    # EU4 登录
    ${driver4}   driver_set_up_and_logIn    ${Expert_User4_username}        ${call_oncall_user_password}
    # PU5 登录
    ${driver5}   driver_set_up_and_logIn    ${ws_branding_A_user}        ${call_oncall_user_password}
    # EU1 sends 3pi link.
    ${invite_url}     send_invite_in_calling_page    ${driver1}
    # Following participants try to join call in rapid sequence: TU3 via MHS link. EU4 via MHS link.personal user 5 via MHS link.
    user_make_call_via_meeting_link    ${driver3}    ${invite_mhs_url}
    user_make_call_via_meeting_link    ${driver4}    ${invite_mhs_url}
    user_make_call_via_meeting_link    ${driver5}    ${invite_mhs_url}
    # VP: EU1 gets accept/decline request from TU3.   EU1 declines call.   TU3 doesn’t  join call.
    user_decline_call    ${driver1}    in_calling
    which_page_is_currently_on    ${driver3}    ${your_call_was_declined}
    # EU1 gets accept/decline request from EU4    EU1 declines call.   VP: EU4 doesn’t  join call.
    user_decline_call    ${driver1}    in_calling
    which_page_is_currently_on    ${driver4}    ${your_call_was_declined}
    # EU1 gets accept/decline request from PU5.   EU1 accepts call.	   VP: PU5 joins call.
    user_anwser_call    ${driver1}   no_direct
    which_page_is_currently_on    ${driver5}    ${end_call_button}

    # DU6 登录
    ${driver6}   driver_set_up_and_logIn    ${ws_branding_B_user}        ${call_oncall_user_password}
    # Following participants try to join call in rapid sequence: different enterprise user 6 via 3pi link. anonymous user 7 via 3pi link.anonymous user 8 via MHS link.
    user_make_call_via_meeting_link    ${driver6}    ${invite_url}
    ${driver7}    anonymous_open_meeting_link    ${invite_url}
    ${driver8}    anonymous_open_meeting_link    ${invite_url}
    # VP: EU1 gets accept/decline request from DU6."   EU1 accepts call.   VP: DU6 joins call.
    user_anwser_call    ${driver1}   no_direct
    which_page_is_currently_on    ${driver6}    ${end_call_button}
    # EU1 gets accept/decline request from AU7."    EU1 declines call.    VP: AU7 doesn’t join call.
    user_decline_call    ${driver1}    in_calling
    which_page_is_currently_on    ${driver7}    ${your_call_was_declined}
    # EU1 gets accept/decline request from AU8."    EU1 accepts call.	VP: AU8 joins call.
    user_anwser_call    ${driver1}   no_direct
    which_page_is_currently_on    ${driver8}    ${end_call_button}
    [Teardown]      run keywords    Close
    ...             AND             exit_driver    ${driver1}    ${driver2}   ${driver3}    ${driver4}    ${driver5}    ${driver6}    ${driver7}    ${driver8}

Join_call_188_195
    [Documentation]     Join call	MPC via OTU link.
    [Tags]     small range 188-195 lines
    [Setup]     run keywords      Login_premium_user                # log in with Site Admin
    ...         AND               switch_to_created_workspace       ${created_workspace}      # 进入Huiming.shi_Added_WS这个WS
    ...         AND               enter_workspace_settings_page     # 进入settings页面
    ...         AND               close_disable_external_users      # 设置Security: Disable External Users为close状态
    ...         AND               Close
    # EU1 登录
    ${driver1}   driver_set_up_and_logIn    ${Expert_User5_username}        ${call_oncall_user_password}
    # Anonymous user 2 clicks on EU1’s OTU link. EU1 answers call.
    ${invite_otu_url}   send_meeting_room_link    ${driver1}   OTU
    ${driver2}    anonymous_open_meeting_link    ${invite_otu_url}
    user_anwser_call    ${driver1}
    # TU3 登录
    ${driver3}   driver_set_up_and_logIn    ${Team_User2_username}        ${call_oncall_user_password}
    # EU4 登录
    ${driver4}   driver_set_up_and_logIn    ${Expert_User4_username}        ${call_oncall_user_password}
    # PU5 登录
    ${driver5}   driver_set_up_and_logIn    ${ws_branding_A_user}        ${call_oncall_user_password}
    # EU1 sends 3pi link.
    ${invite_url}     send_invite_in_calling_page    ${driver1}
    # Following participants try to join call in rapid sequence: TU3 via MHS link. EU4 via MHS link.personal user 5 via MHS link.
    user_make_call_via_meeting_link    ${driver3}    ${invite_otu_url}
    user_make_call_via_meeting_link    ${driver4}    ${invite_otu_url}
    user_make_call_via_meeting_link    ${driver5}    ${invite_otu_url}
    # VP: EU1 gets accept/decline request from TU3.   EU1 accepts call.   VP: TU3 joins call.
    user_anwser_call    ${driver1}    no_direct
    which_page_is_currently_on    ${driver3}    ${end_call_button}
    # EU1 gets accept/decline request from EU4    EU1 declines call.   VP: EU4 doesn’t  join call.
    user_decline_call    ${driver1}    in_calling
    which_page_is_currently_on    ${driver4}    ${your_call_was_declined}
    # EU1 gets accept/decline request from PU5.   EU1 accepts call.	   VP: PU5 joins call.
    user_anwser_call    ${driver1}   no_direct
    which_page_is_currently_on    ${driver5}    ${end_call_button}
    # DU6 登录
    ${driver6}   driver_set_up_and_logIn    ${ws_branding_B_user}        ${call_oncall_user_password}
    # Following participants try to join call in rapid sequence: different enterprise user 6 via 3pi link. anonymous user 7 via 3pi link.anonymous user 8 via MHS link.
    user_make_call_via_meeting_link    ${driver6}    ${invite_url}
    ${driver7}    anonymous_open_meeting_link    ${invite_url}
    # VP: EU1 gets accept/decline request from DU6."   EU1 accepts call.   VP: DU6 joins call.
    user_anwser_call    ${driver1}   no_direct
    which_page_is_currently_on    ${driver6}    ${end_call_button}
    # EU1 gets accept/decline request from AU7."    EU1 declines call.    VP: AU7 doesn’t join call.
    user_decline_call    ${driver1}    in_calling
    which_page_is_currently_on    ${driver7}    ${your_call_was_declined}
    [Teardown]      run keywords    Close
    ...             AND             exit_driver    ${driver1}    ${driver2}   ${driver3}    ${driver4}    ${driver5}    ${driver6}    ${driver7}

Join_call_196_200
    [Documentation]     In call	  2PC
    [Tags]     small range 196-200 lines
    # EU1 登录
    ${driver1}   driver_set_up_and_logIn    ${Expert_User1_username}        ${call_oncall_user_password}
    # EU2 登录
    ${driver2}   driver_set_up_and_logIn    ${Expert_User2_username}        ${call_oncall_user_password}
    # EU1 calls EU2. EU2 answers call,
    make_calls_with_who     ${driver1}     ${driver2}     ${Expert_User2_username}
    # VP: participant menu is not visible. Exit call submenu is Yes/No. Change role submenu is same as before.
    sleep   10s
    hang_up_the_phone     ${driver1}
    which_page_is_currently_on     ${driver1}     ${exit_call_yes_button}
    which_page_is_currently_on     ${driver1}     ${exit_call_no_button}
    hang_up_the_phone     ${driver1}
    hang_up_the_phone     ${driver2}
    which_page_is_currently_on     ${driver2}     ${exit_call_yes_button}
    which_page_is_currently_on     ${driver2}     ${exit_call_no_button}
    hang_up_the_phone     ${driver2}
    # EU1 switches to Giver.
    enter_giver_mode     ${driver1}     no_one     no_one     2
    # EU1 invites TU3. TU3 answers call.
    ${driver3}   driver_set_up_and_logIn    ${Team_User1_username}        ${call_oncall_user_password}
    enter_contacts_search_user     ${driver1}    ${Team_User1_name}
    click_user_in_contacts_call     ${driver1}    ${Team_User1_name}
    user_anwser_call     ${driver3}
    # VP: participants icon is visible for EU1 and EU2, but invisible for TU3.
    which_page_is_currently_on     ${driver1}     //div[@class='InCall']//div[@class='menu roleMenu']//*[@*="#gh_on"]
    which_page_is_currently_on     ${driver2}     //div[@class='InCall']//div[@class='menu roleMenu']//*[@*="#rh_on"]
    which_page_is_currently_on     ${driver3}     //div[@class='InCall']//div[@class='menu roleMenu']//*[@*="#gh_on"]     not_currently_on
    which_page_is_currently_on     ${driver3}     //div[@class='InCall']//div[@class='menu roleMenu']//*[@*="#rh_on"]     not_currently_on
    # TU3 leaves call.
    exit_call     ${driver3}    5
    # VP: participant menu is not visible. Exit call submenu is Yes/No. Change role submenu is same as before.
    hang_up_the_phone     ${driver1}
    which_page_is_currently_on     ${driver1}     ${exit_call_yes_button}
    which_page_is_currently_on     ${driver1}     ${exit_call_no_button}
    hang_up_the_phone     ${driver1}
    hang_up_the_phone     ${driver2}
    which_page_is_currently_on     ${driver2}     ${exit_call_yes_button}
    which_page_is_currently_on     ${driver2}     ${exit_call_no_button}
    hang_up_the_phone     ${driver2}
#    # End call.
#    exit_call     ${driver1}
    [Teardown]    exit_driver     ${driver1}     ${driver2}     ${driver3}

Join_call_201_205
    [Documentation]     In call	  2PC
    [Tags]     small range 201-205 lines
    [Setup]     run keywords      Login_premium_user                # log in with Site Admin
    ...         AND               switch_to_created_workspace       ${created_workspace}      # 进入Huiming.shi_Added_WS这个WS
    ...         AND               enter_workspace_settings_page     # 进入settings页面
    ...         AND               close_disable_external_users      # 设置Security: Disable External Users为close状态
    ...         AND               Close
    # EU1 登录
    ${driver1}   driver_set_up_and_logIn    ${Expert_User1_username}        ${call_oncall_user_password}
    # Anonymous user 1 clicks on EU1’s MHS or OTU link. EU1 answers call.
    ${invite_url}    send_meeting_room_link    ${driver1}    OTU
    ${driver2}   anonymous_open_meeting_link     ${invite_url}
    user_anwser_call     ${driver1}
    # VP: participant menu is not visible. Exit call submenu is Yes/No. Change role submenu is same as before.
    sleep   10s
    hang_up_the_phone     ${driver1}
    which_page_is_currently_on     ${driver1}     ${exit_call_yes_button}
    which_page_is_currently_on     ${driver1}     ${exit_call_no_button}
    hang_up_the_phone     ${driver1}
    hang_up_the_phone     ${driver2}
    which_page_is_currently_on     ${driver2}     ${exit_call_yes_button}
    which_page_is_currently_on     ${driver2}     ${exit_call_no_button}
    hang_up_the_phone     ${driver2}
    # EU1 switches to receiver, enters freezing, photo or pdf mode.
    enter_giver_mode    ${driver1}   no_one    no_one    2    has_dialog    receive
    enter_FGD_mode    ${driver1}      Document
    # Anonymous user 2 clicks on the same link. EU1 answers call.
    ${driver3}   anonymous_open_meeting_link     ${invite_url}
    user_anwser_call     ${driver1}    no_direct
    # Anonymous user 1 leaves call.
    exit_call     ${driver3}
    # VP: participant menu is not visible. Exit call submenu is Yes/No. Change role submenu is same as before.
    sleep   10s
    hang_up_the_phone     ${driver1}
    which_page_is_currently_on     ${driver1}     ${exit_call_yes_button}
    which_page_is_currently_on     ${driver1}     ${exit_call_no_button}
    hang_up_the_phone     ${driver1}
    hang_up_the_phone     ${driver2}
    which_page_is_currently_on     ${driver2}     ${exit_call_yes_button}
    which_page_is_currently_on     ${driver2}     ${exit_call_no_button}
    hang_up_the_phone     ${driver2}
    [Teardown]    exit_driver     ${driver1}     ${driver2}     ${driver3}

Small_range_560_580
    [Documentation]     3PI - Direct call     EU1 call EU2 from contact list
    [Tags]    small range 560-580 lines
    [Setup]     run keywords      Login_premium_user                # log in with Site Admin
    ...         AND               switch_to_created_workspace       ${created_workspace}      # 进入Huiming.shi_Added_WS这个WS
    ...         AND               enter_workspace_settings_page     # 进入settings页面
    ...         AND               close_disable_external_users      # 设置Security: Disable External Users为close状态
    ...         AND               Close
    # EU1 登录
    ${driver1}    driver_set_up_and_logIn    ${Expert_User1_username}     ${universal_password}
    # EU2 登录
    ${driver2}    driver_set_up_and_logIn    ${Expert_User2_username}     ${universal_password}
    # EU1 call EU2 from contact list
    make_calls_with_who     ${driver1}    ${driver2}    ${Expert_User2_username}
    # VP: Invite contact tab is default for EU1 and EU2;Send 3PI link is available;
    open_invite_3rd_participant_dialog     ${driver1}    no_enter
    close_invite_3th_page     ${driver1}
    open_invite_3rd_participant_dialog     ${driver1}
    close_invite_3th_page     ${driver1}
    open_invite_3rd_participant_dialog     ${driver2}    no_enter
    close_invite_3th_page     ${driver2}
    open_invite_3rd_participant_dialog     ${driver2}
    close_invite_3th_page     ${driver2}
    # EU1 invite EU3 from Team contact
    ${driver3}    driver_set_up_and_logIn    ${Expert_User3_username}     ${universal_password}
    enter_contacts_search_user     ${driver1}    ${Expert_User3_name}
    click_user_in_contacts_call     ${driver1}    ${Expert_User3_name}
    user_anwser_call    ${driver3}
    # EU1 leave call
    leave_call    ${driver1}
    exit_one_driver    ${driver1}
    # EU2 invite EU4 from Directory
    ${driver4}    driver_set_up_and_logIn    ${Expert_User4_username}     ${universal_password}
    enter_contacts_search_user     ${driver2}    ${Expert_User4_name}
    click_user_in_contacts_call     ${driver2}    ${Expert_User4_name}
    user_anwser_call    ${driver4}
    # EU4 leave call
    exit_call    ${driver4}
    exit_one_driver    ${driver4}
    # EU3 invite TU1
    ${driver5}    driver_set_up_and_logIn    ${Team_User1_username}     ${universal_password}
    enter_contacts_search_user     ${driver3}    ${Team_User1_name}
    click_user_in_contacts_call     ${driver3}    ${Team_User1_name}
    user_anwser_call    ${driver5}
    # EU2 leave call
    leave_call    ${driver2}
    exit_one_driver    ${driver2}
    # VP: TU1 can invite
    enter_contacts_search_user     ${driver5}    ${Team_User2_name}
    # VP: TU1 can not send 3PI link
    which_page_is_currently_on     ${driver5}    ${invite_send_invite_tab}    not_currently_on
    close_invite_3th_page     ${driver5}
    # EU3 send 3PI link to eMail
    ${invite_url}     send_invite_in_calling_page    ${driver3}
    close_invite_3th_page    ${driver3}
    log to console   ${invite_url}
    # EU5 click 3PI link to join    VP: directly joint automatically, do not need anyone's accept
    ${driver6}    driver_set_up_and_logIn    ${Expert_User5_username}     ${universal_password}
    user_make_call_via_meeting_link    ${driver6}    ${invite_url}
    which_page_is_currently_on    ${driver6}    ${end_call_button}
    # EU5 leave call
    exit_call    ${driver6}
    exit_one_driver    ${driver6}
    # TU2 click 3PI link to join    VP: directly joint automatically, do not need anyone's accept
    ${driver7}    driver_set_up_and_logIn    ${Team_User2_username}     ${universal_password}
    user_make_call_via_meeting_link    ${driver7}    ${invite_url}
    which_page_is_currently_on    ${driver7}    ${end_call_button}
    # TU2 leave call
    exit_call    ${driver7}
    exit_one_driver    ${driver7}
    # Anonymous user click 3PI to join
    ${driver8}    anonymous_open_meeting_link    ${invite_url}
    # VP: EU3 get Accept dialog     EU3 accept
    user_anwser_call    ${driver3}   no_direct
    # EU3 leave call
    leave_call    ${driver3}
    exit_one_driver    ${driver3}
    sleep   80s
    # Expert user from different enterprise click 3PI link
    ${driver9}    driver_set_up_and_logIn    ${ws3_branding_C_user}     ${universal_password}
    user_make_call_via_meeting_link    ${driver9}    ${invite_url}
    # VP:TU1 get Accept dialog	TU1 accept
    user_anwser_call    ${driver5}   no_direct
    # End 3PC call
    end_call_for_all    ${driver5}
    sleep   30s
    # Login user click previous 3PI link       VP: Get msg "This meeting is over. Please contact the host to invite you to another meeting."
    user_make_call_via_meeting_link    ${driver9}    ${invite_url}
    which_page_is_currently_on    ${driver9}    ${this_call_is_over}
    # Anonymous user click 3PI         VP: Get msg "This meeting is over. Please contact the host to invite you to another meeting."
    user_make_call_via_meeting_link    ${driver8}    ${invite_url}
    which_page_is_currently_on    ${driver8}    ${this_call_is_over}
    [Teardown]      run keywords    Close
    ...             AND             exit_driver     ${driver1}    ${driver2}   ${driver3}    ${driver4}    ${driver5}    ${driver6}    ${driver7}    ${driver8}    ${driver9}

Small_range_581_582
    [Documentation]     3PI - Direct call     EU1 call EU2 from contact list
    [Tags]    small range 581-582 lines
    # EU1 登录
    ${driver1}    driver_set_up_and_logIn    ${Expert_User1_username}     ${universal_password}
    # EU2 登录
    ${driver2}    driver_set_up_and_logIn    ${Expert_User2_username}     ${universal_password}
    # EU1 call EU2 from contact list
    make_calls_with_who     ${driver1}    ${driver2}    ${Expert_User2_username}
    # Expert 登录
    ${driver3}    driver_set_up_and_logIn    ${Expert_AaA_username}     ${universal_password}
    # EU1 invte on-call group
    enter_contacts_search_user     ${driver1}    ${AaA_on_call_group_name}
    click_user_in_contacts_call     ${driver1}    ${AaA_on_call_group_name}
    # VP: on-call group members can get rollover call    ExpetA answer rollover call	VP: rollover call stops
    user_anwser_call    ${driver3}
    which_page_is_currently_on    ${driver3}    ${end_call_button}
    [Teardown]      run keywords    Close
    ...             AND             exit_driver     ${driver1}    ${driver2}   ${driver3}

Small_range_583_585
    [Documentation]     3PI - Direct call     EU1 call EU2 from contact list
    [Tags]    small range 583-585 lines
    # EU1 登录
    ${driver1}    driver_set_up_and_logIn    ${Expert_User1_username}     ${universal_password}
    # EU2 登录
    ${driver2}    driver_set_up_and_logIn    ${Expert_User2_username}     ${universal_password}
    # 获取OTU和MHS link
    ${invite_otu_url}   send_meeting_room_link    ${driver1}   OTU
    ${invite_mhs_url}   send_meeting_room_link    ${driver1}   MHS
    # EU1 call EU2 from contact list
    make_calls_with_who     ${driver1}    ${driver2}    ${Expert_User2_username}
    # Someone directly call EU1 or EU2	Someone get messgage about EU1 is on another call
    ${driver3}    driver_set_up_and_logIn    ${Expert_User3_username}     ${universal_password}
    make_calls_with_who     ${driver3}    ${driver1}    ${Expert_User1_username}    no_anwser
    which_page_is_currently_on    ${driver3}    ${user_is_currently_on_another_call}
    exit_one_driver    ${driver3}
    # Someone click EU1 or EU2's MHS link	Someone get messgage about EU1 is on another call
    ${driver4}    driver_set_up_and_logIn    ${Expert_User4_username}     ${universal_password}
    user_make_call_via_meeting_link    ${driver4}    ${invite_mhs_url}
    which_page_is_currently_on    ${driver4}    ${user_is_currently_on_another_call}
    exit_one_driver    ${driver4}
    # someone click EU1 or EU2's OTU link	Someone get messgage about EU1 is on another call
    ${driver5}    driver_set_up_and_logIn    ${Expert_User5_username}     ${universal_password}
    user_make_call_via_meeting_link    ${driver5}    ${invite_otu_url}
    which_page_is_currently_on    ${driver5}    ${user_is_currently_on_another_call}
    exit_one_driver    ${driver5}
    [Teardown]      run keywords    Close
    ...             AND             exit_driver     ${driver1}    ${driver2}

Small_range_590
    [Documentation]     3PI - Direct call     TU1 call EU1 from contact list
    [Tags]    small range 590 line
    # TU1 登录
    ${driver1}    driver_set_up_and_logIn    ${Team_User1_username}     ${universal_password}
    # EU2 登录
    ${driver2}    driver_set_up_and_logIn    ${Expert_User1_username}     ${universal_password}
    # TU1 call EU1 from contact list
    make_calls_with_who     ${driver1}    ${driver2}    ${Expert_User1_username}
    # VP: TU1 can only invite, can not send 3PI
    enter_contacts_search_user     ${driver1}    ${Team_User2_name}
    which_page_is_currently_on     ${driver1}    ${invite_send_invite_tab}    not_currently_on
    [Teardown]      run keywords    Close
    ...             AND             exit_driver     ${driver1}    ${driver2}

Small_range_591
    [Documentation]     3PI - Direct call     TU1 call EU1 via EU1's MHS link
    [Tags]    small range 590 line
    # TU1 登录
    ${driver1}    driver_set_up_and_logIn    ${Team_User1_username}     ${universal_password}
    # EU2 登录
    ${driver2}    driver_set_up_and_logIn    ${Expert_User1_username}     ${universal_password}
    ${invite_mhs_url}   send_meeting_room_link    ${driver2}    MHS
    # TU1 call EU1 via EU1's MHS link
    user_make_call_via_meeting_link    ${driver1}    ${invite_mhs_url}
    user_anwser_call    ${driver2}
    # VP: TU1 can only invite, can not send 3PI
    enter_contacts_search_user     ${driver1}    ${Team_User2_name}
    which_page_is_currently_on     ${driver1}    ${invite_send_invite_tab}    not_currently_on
    [Teardown]      run keywords    Close
    ...             AND             exit_driver     ${driver1}    ${driver2}

Small_range_592
    [Documentation]     3PI - Direct call     Pre-condition: userS has personal contact from another site
    [Tags]    small range 590 line
    # userS 登录
    ${driver1}    driver_set_up_and_logIn    ${Expert_User5_username}     ${universal_password}
    # personal contact 登录
    ${driver2}    driver_set_up_and_logIn    ${ws_branding_A_user}     ${universal_password}
    # TU1 call EU1 from contact list
    make_calls_with_who     ${driver1}    ${driver2}    ${ws_branding_A_user}    anwser    is_personal
    # VP: The personal contact from different site does not have invite 3rd parcipant icon
    which_page_is_currently_on     ${driver2}     ${invite_user_in_calling}     not_currently_on
    [Teardown]      run keywords    Close
    ...             AND             exit_driver     ${driver1}    ${driver2}