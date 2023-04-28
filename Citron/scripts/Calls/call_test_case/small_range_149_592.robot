*** Settings ***
Library           Selenium2Library
Library           OperatingSystem
Resource          ../../../Lib/public.robot
Resource          ../../../Lib/calls_resource.robot
Resource          ../../../Lib/hodgepodge_resource.robot
Resource          call_case_set_up.robot
Library           call_python_Lib/call_action_lib_copy.py
Library           call_python_Lib/call_check_lib.py
Library           call_python_Lib/else_public_lib.py
Library           call_python_Lib/login_lib.py
Library           call_python_Lib/contacts_page.py
Library           call_python_Lib/about_call.py
Library           call_python_Lib/my_account.py
Library           call_python_Lib/finish_call.py
Force Tags        small_range

*** Test Cases ***
Join_call_162_167
    [Documentation]     Join call	MPC via dialer directly
    [Tags]     small range 162-167 lines        call_case     有bug：https://vipaar.atlassian.net/browse/CITRON-3494
    [Setup]   ws_open_directory    premium_user   switch_to_other   ${created_workspace}
    # EU1 登录
    ${driver1}   driver_set_up_and_logIn    ${Expert_User5_username}
    # TU2 登录
    ${driver2}   driver_set_up_and_logIn    ${Team_User1_username}
    # EU1 calls TU2. TU2 answers call
    contacts_witch_page_make_call   ${driver1}   ${driver2}  ${py_team_page}   ${Team_User1_name}
    # EU3 登录
    ${driver3}   driver_set_up_and_logIn    ${Expert_User4_username}
    # PU4 登录
    ${driver4}   driver_set_up_and_logIn    ${ws_branding_A_user}
    # DU5 登录
    ${driver5}   driver_set_up_and_logIn    ${ws_branding_B_user}
    # EU1 sends 3pi link.
    which_page_is_currently_on    ${driver1}    ${end_call_button}
    ${invite_url}     send_new_invite_in_calling    ${driver1}
    # EU3, PU (personal user 4, DU (different enterprise user) 5, AU (anonymous user) 6 clicks on 3pi link in rapid sequence.
    user_make_call_via_meeting_link    ${driver3}    ${invite_url}
    user_make_call_via_meeting_link    ${driver4}    ${invite_url}
    user_make_call_via_meeting_link    ${driver5}    ${invite_url}
    ${driver6}    anonymous_open_meeting_link    ${invite_url}
    # 确保call连接成功，但未接听
    make_sure_enter_call   ${driver6}
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
    ...             AND             exit_driver

Join_call_179_187
    [Documentation]     Join call	MPC via MHS link.
    [Tags]     small range 179-187 lines        call_case     有bug：https://vipaar.atlassian.net/browse/CITRON-3494
    [Setup]   ws_open_directory    premium_user   switch_to_other    ${created_workspace}
    # EU1 登录
    ${driver1}   driver_set_up_and_logIn    ${Expert_User5_username}
    # TU2 登录
    ${driver2}   driver_set_up_and_logIn    ${Team_User1_username}
    # TU2 clicks on EU1’s MHS link. EU1 answers call.
    ${invite_mhs_url}   send_meeting_room_link    ${driver1}   ${MHS_link_email}
    user_make_call_via_meeting_link    ${driver2}    ${invite_mhs_url}
    # 确保建立call，但未接听
    make_sure_enter_call    ${driver2}
    user_anwser_call    ${driver1}
    # EU1 sends 3pi link.
    which_page_is_currently_on    ${driver1}    ${end_call_button}
    ${invite_url}     send_new_invite_in_calling    ${driver1}
    # TU3 登录
    ${driver3}   driver_set_up_and_logIn    ${Team_User2_username}
    # EU4 登录
    ${driver4}   driver_set_up_and_logIn    ${Expert_User4_username}
    # PU5 登录
    ${driver5}   driver_set_up_and_logIn    ${ws_branding_A_user}
    # Following participants try to join call in rapid sequence: TU3 via MHS link. EU4 via MHS link.personal user 5 via MHS link.
    user_make_call_via_meeting_link    ${driver3}    ${invite_mhs_url}
    user_make_call_via_meeting_link    ${driver4}    ${invite_mhs_url}
    user_make_call_via_meeting_link    ${driver5}    ${invite_mhs_url}
    # VP: EU1 gets accept/decline request from TU3.   EU1 declines call.   TU3 doesn’t  join call.
    user_decline_call    ${driver1}    in_calling
    which_page_is_currently_on    ${driver3}    ${your_call_was_declined}
    exit_one_driver    ${driver3}
    # EU1 gets accept/decline request from EU4    EU1 declines call.   VP: EU4 doesn’t  join call.
    user_decline_call    ${driver1}    in_calling
    which_page_is_currently_on    ${driver4}    ${your_call_was_declined}
    exit_one_driver    ${driver4}
    # EU1 gets accept/decline request from PU5.   EU1 accepts call.	   VP: PU5 joins call.
    user_anwser_call    ${driver1}   no_direct
    which_page_is_currently_on    ${driver5}    ${end_call_button}

    # DU6 登录
    ${driver6}   driver_set_up_and_logIn    ${ws_branding_B_user}
    # Following participants try to join call in rapid sequence: different enterprise user 6 via 3pi link. anonymous user 7 via 3pi link.anonymous user 8 via MHS link.
    user_make_call_via_meeting_link    ${driver6}    ${invite_url}
    # 确保建立call，但未接听
    make_sure_enter_call    ${driver6}
    ${driver7}    anonymous_open_meeting_link    ${invite_url}
    # 确保call连接成功，但未接听
    make_sure_enter_call   ${driver7}
    ${driver8}    anonymous_open_meeting_link    ${invite_url}
    # 确保call连接成功，但未接听
    make_sure_enter_call   ${driver8}
    # VP: EU1 gets accept/decline request from DU6."   EU1 accepts call.   VP: DU6 joins call.
    user_anwser_call    ${driver1}   no_direct
    which_page_is_currently_on    ${driver6}    ${end_call_button}
    # EU1 gets accept/decline request from AU7."    EU1 declines call.    VP: AU7 doesn’t join call.
    user_decline_call    ${driver1}    in_calling
    which_page_is_currently_on    ${driver7}    ${your_call_was_declined}
    exit_one_driver    ${driver7}
    # EU1 gets accept/decline request from AU8."    EU1 accepts call.	VP: AU8 joins call.
    user_anwser_call    ${driver1}   no_direct
    which_page_is_currently_on    ${driver8}    ${end_call_button}
    [Teardown]      run keywords    Close
    ...             AND             exit_driver

Join_call_188_195
    [Documentation]     Join call	MPC via OTU link.
    [Tags]     small range 188-195 lines        call_case     有bug：https://vipaar.atlassian.net/browse/CITRON-3494
#    因为上个case已经做了这个初始化动作了，故这个case不再执行初始化
#    [Setup]   ws_open_directory    premium_user   switch_to_other    ${created_workspace}
    # EU1 登录
    ${driver1}   driver_set_up_and_logIn    ${Expert_User5_username}
    # Anonymous user 2 clicks on EU1’s OTU link. EU1 answers call.
    ${invite_otu_url}   send_meeting_room_link    ${driver1}   ${OTU_link_email}
    ${driver2}    anonymous_open_meeting_link    ${invite_otu_url}
    # 确保call连接成功，但未接听
    make_sure_enter_call   ${driver2}
    user_anwser_call    ${driver1}
    # TU3 登录
    ${driver3}   driver_set_up_and_logIn    ${Team_User2_username}
    # EU4 登录
    ${driver4}   driver_set_up_and_logIn    ${Expert_User4_username}
    # PU5 登录
    ${driver5}   driver_set_up_and_logIn    ${ws_branding_A_user}
    # EU1 sends 3pi link.
    which_page_is_currently_on    ${driver1}    ${end_call_button}
    ${invite_url}     send_new_invite_in_calling    ${driver1}
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
    exit_one_driver    ${driver4}
    # EU1 gets accept/decline request from PU5.   EU1 accepts call.	   VP: PU5 joins call.
    user_anwser_call    ${driver1}   no_direct
    which_page_is_currently_on    ${driver5}    ${end_call_button}
    # DU6 登录
    ${driver6}   driver_set_up_and_logIn    ${ws_branding_B_user}
    # Following participants try to join call in rapid sequence: different enterprise user 6 via 3pi link. anonymous user 7 via 3pi link.anonymous user 8 via MHS link.
    user_make_call_via_meeting_link    ${driver6}    ${invite_url}
    # 确保建立call，但未接听
    make_sure_enter_call    ${driver6}
    ${driver7}    anonymous_open_meeting_link    ${invite_url}
    # 确保call连接成功，但未接听
    make_sure_enter_call   ${driver7}
    # VP: EU1 gets accept/decline request from DU6."   EU1 accepts call.   VP: DU6 joins call.
    user_anwser_call    ${driver1}   no_direct
    which_page_is_currently_on    ${driver6}    ${end_call_button}
    # EU1 gets accept/decline request from AU7."    EU1 declines call.    VP: AU7 doesn’t join call.
    user_decline_call    ${driver1}    in_calling
    which_page_is_currently_on    ${driver7}    ${your_call_was_declined}
    exit_one_driver    ${driver7}
    [Teardown]      run keywords    Close
    ...             AND             exit_driver

Small_range_560_580
    [Documentation]     3PI - Direct call     EU1 call EU2 from contact list
    [Tags]    small range 560-580 lines     call_case     有bug：https://vipaar.atlassian.net/browse/CITRON-3494
#    因为上个case已经做了这个初始化动作了，故这个case不再执行初始化
#    [Setup]   ws_open_directory    premium_user   switch_to_other    ${created_workspace}
    # EU1 登录
    ${driver1}    driver_set_up_and_logIn    ${Expert_User1_username}
    # EU2 登录
    ${driver2}    driver_set_up_and_logIn    ${Expert_User2_username}
    # EU1 call EU2 from contact list
    contacts_witch_page_make_call     ${driver1}    ${driver2}   ${py_team_page}   ${Expert_User2_name}
    # VP: Invite contact tab is default for EU1 and EU2;Send 3PI link is available;
    open_invite_3rd_participant_dialog     ${driver1}
    close_invite_3th_page     ${driver1}
    open_invite_3rd_participant_dialog     ${driver1}
    close_invite_3th_page     ${driver1}
    open_invite_3rd_participant_dialog     ${driver2}
    close_invite_3th_page     ${driver2}
    open_invite_3rd_participant_dialog     ${driver2}
    close_invite_3th_page     ${driver2}
    # EU1 invite EU3 from Team contact
    ${driver3}    driver_set_up_and_logIn    ${Expert_User3_username}
    which_page_is_currently_on    ${driver1}    ${end_call_button}
    inCall_enter_contacts_search_user     ${driver1}    ${Expert_User3_name}
    click_user_in_contacts_list     ${driver1}    ${Expert_User3_name}
    user_anwser_call    ${driver3}
    # EU1 leave call
    leave_call    ${driver1}
    exit_one_driver    ${driver1}
    # EU2 invite EU4 from Directory
    ${driver4}    driver_set_up_and_logIn    ${Expert_User4_username}
    inCall_enter_contacts_search_user     ${driver2}    ${Expert_User4_name}
    click_user_in_contacts_list     ${driver2}    ${Expert_User4_name}
    user_anwser_call    ${driver4}
    # EU4 leave call
    exit_call    ${driver4}
    exit_one_driver    ${driver4}
    # EU3 invite TU1
    ${driver5}    driver_set_up_and_logIn    ${Team_User1_username}
    sleep   60s    # 等待一段时间后，driver3自动加载迟来Participants图标，方可操作
    inCall_enter_contacts_search_user     ${driver3}    ${Team_User1_name}
    click_user_in_contacts_list     ${driver3}    ${Team_User1_name}
    user_anwser_call    ${driver5}
    # EU2 leave call
    leave_call    ${driver2}
    exit_one_driver    ${driver2}
    sleep   60s    # 等待一段时间后，driver5自动加载迟来Participants图标，方可操作
    # VP: TU1 can invite
    inCall_enter_contacts_search_user     ${driver5}    ${Team_User2_name}
    # VP: TU1 can not send 3PI link
    which_page_is_currently_on     ${driver5}    ${invite_send_invite_tab}    ${not_currently_on}
    close_invite_3th_page     ${driver5}
    # EU3 send 3PI link to eMail
    which_page_is_currently_on    ${driver3}    ${end_call_button}
    ${invite_url}     send_new_invite_in_calling    ${driver3}
    close_invite_3th_page    ${driver3}
    # EU5 click 3PI link to join    VP: directly joint automatically, do not need anyone's accept
    ${driver6}    driver_set_up_and_logIn    ${Expert_User5_username}
    user_make_call_via_meeting_link    ${driver6}    ${invite_url}
    # 确保建立call，但未接听
    make_sure_enter_call    ${driver6}
    which_page_is_currently_on    ${driver6}    ${end_call_button}
    # EU5 leave call
    exit_call    ${driver6}
    exit_one_driver    ${driver6}
    # TU2 click 3PI link to join    VP: directly joint automatically, do not need anyone's accept
    ${driver7}    driver_set_up_and_logIn    ${Team_User2_username}
    user_make_call_via_meeting_link    ${driver7}    ${invite_url}
    # 确保建立call，但未接听
    make_sure_enter_call    ${driver7}
    which_page_is_currently_on    ${driver7}    ${end_call_button}
    # TU2 leave call
    exit_call    ${driver7}
    exit_one_driver    ${driver7}
    # Anonymous user click 3PI to join
    ${driver8}    anonymous_open_meeting_link    ${invite_url}
    # 确保call连接成功，但未接听
    make_sure_enter_call   ${driver8}
    # VP: EU3 get Accept dialog     EU3 accept
    user_anwser_call    ${driver3}   no_direct
    # EU3 leave call
    leave_call    ${driver3}
    exit_one_driver    ${driver3}
    sleep   80s
    # Expert user from different enterprise click 3PI link
    ${driver9}    driver_set_up_and_logIn    ${ws3_branding_C_user}
    user_make_call_via_meeting_link    ${driver9}    ${invite_url}
    # 确保建立call，但未接听
    make_sure_enter_call    ${driver9}
    # VP:TU1 get Accept dialog	TU1 accept
    user_anwser_call    ${driver5}   no_direct
    # End 3PC call
    end_call_for_all    ${driver5}
    sleep   30s
    # Login user click previous 3PI link       VP: Get msg "This meeting is over. Please contact the host to invite you to another meeting."
    user_make_call_via_meeting_link    ${driver9}    ${invite_url}
    # 确保建立call，但未接听
    make_sure_enter_call    ${driver9}
    which_page_is_currently_on    ${driver9}    ${this_call_is_over}
    # Anonymous user click 3PI         VP: Get msg "This meeting is over. Please contact the host to invite you to another meeting."
    user_make_call_via_meeting_link    ${driver8}    ${invite_url}
    # 确保建立call，但未接听
    make_sure_enter_call    ${driver8}
    which_page_is_currently_on    ${driver8}    ${this_call_is_over}
    [Teardown]      run keywords    Close
    ...             AND             exit_driver

Join_call_168_178
    [Documentation]     Join call	MPC via on-call group.
    [Tags]     small range 168-178 lines        call_case     有bug：https://vipaar.atlassian.net/browse/CITRON-3646
    [Setup]   ws_open_directory    site_admin   switch_to_other    ${created_workspace_branding_3}
    # TU2 登录
    ${driver1}   driver_set_up_and_logIn    ${test_WS3_TU1_user}
    # EU1 登录
    ${driver2}   driver_set_up_and_logIn    ${test_WS3_EU1_user}
    # TU2 clicks on on-call group 1 call. EU1 in on-call group 1 answers call.
    contacts_witch_page_make_call     ${driver1}    ${driver2}    ${py_team_page}   ${On_call_group_001}
    which_page_is_currently_on    ${driver2}    ${end_call_button}
    ${invite_url}    send_new_invite_in_calling    ${driver2}
    # Anonymous user 3 clicks on 3pi link. EU1 answers call.
    ${driver3}    anonymous_open_meeting_link    ${invite_url}
    # 确保call连接成功，但未接听
    make_sure_enter_call   ${driver3}
    user_anwser_call    ${driver2}   no_direct
    # VP: AU3 joins call.
    which_page_is_currently_on    ${driver3}    ${end_call_button}
    # TU2 invites TU4.   TU4 declines call.
    ${driver4}   driver_set_up_and_logIn    ${test_WS3_TU2_user}
    which_page_is_currently_on    ${driver1}    ${end_call_button}
    inCall_enter_contacts_search_user     ${driver1}    ${test_WS3_TU2_user_name}
    click_user_in_contacts_list     ${driver1}    ${test_WS3_TU2_user_name}
    user_decline_call    ${driver4}
    # VP: Team user 4 doesn’t join call
    which_page_is_currently_on    ${driver4}    ${py_contacts_switch_success}
    # TU2 invites TU4.   TU4 accepts call.
    inCall_enter_contacts_search_user     ${driver1}    ${test_WS3_TU2_user_name}
    click_user_in_contacts_list     ${driver1}    ${test_WS3_TU2_user_name}
    user_anwser_call    ${driver4}
    # VP: Team user 4 joins call.
    which_page_is_currently_on    ${driver4}    ${end_call_button}
    # TU2 invites on-call group 1   VP: experts in on-call group 1 receives rollover call.    EU5 answers call.
    ${driver5}   driver_set_up_and_logIn    ${test_WS3_EU3_user}
    inCall_enter_contacts_search_user     ${driver1}    ${On_call_group_001}
    click_user_in_contacts_list     ${driver1}    ${On_call_group_001}
    user_anwser_call    ${driver5}
    # TU2 invites on-call group 2   VP: other experts in on-call group 2 receives rollover call. Display message “No experts are available to take your call” if no experts login.
    ${driver6}   driver_set_up_and_logIn    ${test_WS3_EU2_user}
#    # 此处受bug导致  https://vipaar.atlassian.net/browse/CITRON-3646
#    inCall_enter_contacts_search_user     ${driver1}    ${On_call_group_002}
#    click_user_in_contacts_list     ${driver1}    ${On_call_group_002}
#    # All experts in on-call group 2 declines call.   Display message “No experts are available to take your call”.
#    user_decline_call    ${driver6}
#    which_page_is_currently_on    ${driver1}    ${no_experts_are_available_tips}
    # TU2 invites on-call group 2
    inCall_enter_contacts_search_user     ${driver1}    ${On_call_group_002}
    click_user_in_contacts_list     ${driver1}    ${On_call_group_002}
    # EU6 in on-call group2 answers call.	VP: expert user 6 joins call
    user_anwser_call    ${driver6}
    which_page_is_currently_on    ${driver6}    ${end_call_button}
    [Teardown]      run keywords    Close
    ...             AND             exit_driver

Small_range_581_582
    [Documentation]     3PI - Direct call     EU1 call EU2 from contact list
    [Tags]    small range 581-582 lines     call_case
    # EU1 登录
    ${driver1}    driver_set_up_and_logIn    ${Expert_User1_username}
    # EU2 登录
    ${driver2}    driver_set_up_and_logIn    ${Expert_User2_username}
    # EU1 call EU2 from contact list
    contacts_witch_page_make_call     ${driver1}    ${driver2}   ${py_team_page}   ${Expert_User2_name}
    # Expert 登录
    ${driver3}    driver_set_up_and_logIn    ${Expert_AaA_username}
    # EU1 invte on-call group
    which_page_is_currently_on    ${driver1}    ${end_call_button}
    inCall_enter_contacts_search_user     ${driver1}    ${AaA_on_call_group_name}
    click_user_in_contacts_list     ${driver1}    ${AaA_on_call_group_name}
    # VP: on-call group members can get rollover call    ExpetA answer rollover call	VP: rollover call stops
    user_anwser_call    ${driver3}
    which_page_is_currently_on    ${driver3}    ${end_call_button}
    [Teardown]      run keywords    Close
    ...             AND             exit_driver

#Small_range_583_585
#    [Documentation]     3PI - Direct call     EU1 call EU2 from contact list
#    [Tags]    small range 583-585 lines         call_case     有bug：https://vipaar.atlassian.net/browse/CITRON-3712
#    # EU1 登录
#    ${driver1}    driver_set_up_and_logIn    ${Expert_User1_username}
#    # EU2 登录
#    ${driver2}    driver_set_up_and_logIn    ${Expert_User2_username}
#    # 获取OTU和MHS link
#    ${invite_otu_url}   send_meeting_room_link    ${driver1}   ${OTU_link_email}
#    ${invite_mhs_url}   send_meeting_room_link    ${driver1}   ${MHS_link_email}
#    # EU1 call EU2 from contact list
#    contacts_witch_page_make_call     ${driver1}    ${driver2}    ${py_team_page}   ${Expert_User2_name}
#    # Someone directly call EU1 or EU2	Someone get messgage about EU1 is on another call
#    ${driver3}    driver_set_up_and_logIn    ${Expert_User3_username}
#    contacts_witch_page_make_call     ${driver3}    ${driver1}   ${py_team_page}   ${Expert_User1_name}    no_anwser
#    which_page_is_currently_on    ${driver3}    ${user_is_currently_on_another_call}
#    exit_one_driver    ${driver3}
#    # Someone click EU1 or EU2's MHS link	Someone get messgage about EU1 is on another call
#    ${driver4}    driver_set_up_and_logIn    ${Expert_User4_username}
#    user_make_call_via_meeting_link    ${driver4}    ${invite_mhs_url}
#    # 确保建立call，但未接听
#    make_sure_enter_call    ${driver4}
#    which_page_is_currently_on    ${driver4}    ${user_is_currently_on_another_call}
#    exit_one_driver    ${driver4}
#    # someone click EU1 or EU2's OTU link	Someone get messgage about EU1 is on another call
#    ${driver5}    driver_set_up_and_logIn    ${Expert_User5_username}
#    user_make_call_via_meeting_link    ${driver5}    ${invite_otu_url}
#    # 确保建立call，但未接听
#    make_sure_enter_call    ${driver5}
#    which_page_is_currently_on    ${driver5}    ${user_is_currently_on_another_call}
#    exit_one_driver    ${driver5}
#    [Teardown]      run keywords    Close
#    ...             AND             exit_driver

Small_range_590
    [Documentation]     3PI - Direct call     TU1 call EU1 from contact list
    [Tags]    small range 590 line      call_case
    # TU1 登录
    ${driver1}    driver_set_up_and_logIn    ${Team_User1_username}
    # EU2 登录
    ${driver2}    driver_set_up_and_logIn    ${Expert_User1_username}
    # TU1 call EU1 from contact list
    contacts_witch_page_make_call     ${driver1}    ${driver2}   ${py_team_page}   ${Expert_User1_name}
    # VP: TU1 can only invite, can not send 3PI
    which_page_is_currently_on    ${driver1}    ${end_call_button}
    inCall_enter_contacts_search_user     ${driver1}    ${Team_User2_name}
    which_page_is_currently_on     ${driver1}    ${invite_send_invite_tab}    ${not_currently_on}
    [Teardown]      run keywords    Close
    ...             AND             exit_driver

Small_range_591
    [Documentation]     3PI - Direct call     TU1 call EU1 via EU1's MHS link
    [Tags]    small range 590 line      call_case
    # TU1 登录
    ${driver1}    driver_set_up_and_logIn    ${Team_User1_username}
    # EU2 登录
    ${driver2}    driver_set_up_and_logIn    ${Expert_User1_username}
    ${invite_mhs_url}   send_meeting_room_link    ${driver2}    ${MHS_link_email}
    # TU1 call EU1 via EU1's MHS link
    user_make_call_via_meeting_link    ${driver1}    ${invite_mhs_url}
    user_anwser_call    ${driver2}
    # VP: TU1 can only invite, can not send 3PI
    which_page_is_currently_on    ${driver1}    ${end_call_button}
    inCall_enter_contacts_search_user     ${driver1}    ${Team_User2_name}
    which_page_is_currently_on     ${driver1}    ${invite_send_invite_tab}    ${not_currently_on}
    [Teardown]      run keywords    Close
    ...             AND             exit_driver

Small_range_592
    [Documentation]     3PI - Direct call     Pre-condition: userS has personal contact from another site
    [Tags]    small range 590 line      call_case
    # userS 登录
    ${driver1}    driver_set_up_and_logIn    ${Expert_User5_username}
    # personal contact 登录
    ${driver2}    driver_set_up_and_logIn    ${ws_branding_A_user}
    # TU1 call EU1 from contact list
    switch_to_diffrent_page   ${driver1}   ${py_personal_page}   ${py_personal_switch_success}    ${py_get_number_of_rows}
    contacts_witch_page_make_call     ${driver1}    ${driver2}   ${py_personal_page}   ${ws_branding_A_name}
    # VP: The personal contact from different site does not have invite 3rd parcipant icon
    which_page_is_currently_on     ${driver2}     ${invite_user_in_calling}     ${not_currently_on}
    [Teardown]      run keywords    Close
    ...             AND             exit_driver