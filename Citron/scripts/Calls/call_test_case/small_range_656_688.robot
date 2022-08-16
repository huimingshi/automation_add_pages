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
Small_range_656
    [Documentation]     No answer message   caller calls via normal way	   callee do not answer, waiting to timeout
    [Tags]    small range 656 line      call_case
    # Expert User1 登录（case中的caller）
    ${driver1}    driver_set_up_and_logIn    ${Expert_User1_username}     ${universal_password}
    # Expert User2 登录（case中的callee）
    ${driver2}    driver_set_up_and_logIn    ${Expert_User2_username}     ${universal_password}
    switch_to_diffrent_page   ${driver2}   ${py_recents_page}     ${py_recents_switch_success}    ${py_get_number_of_rows}   # Expert A 切换到Recents页面
    ${occurred_time_list}    get_recents_page_records_occurred_time    ${driver2}           # 获取Recents页面前两行call记录的时间
    # caller calls via normal way, callee do not answer
    contacts_witch_page_make_call   ${driver1}   ${driver2}    ${py_team_page}  ${Expert_User2_name}    no_care
    # waiting to timeout
    which_page_is_currently_on    ${driver2}   ${anwser_call_button}
    sleep  30s
    # Verify: "xxx didn't answer your call" In recent tab
    which_page_is_currently_on   ${driver1}    ${your_call_was_not_anwsered}
    # VP: The two users should not see rating dialog.
    which_page_is_currently_on   ${driver1}    ${five_star_high_praise}    not_currently_on
    which_page_is_currently_on   ${driver2}    ${five_star_high_praise}    not_currently_on
    # Expert User2 刷新Recents页面
    refresh_browser_page    ${driver2}
    ${occurred_time_list_1}    get_recents_page_records_occurred_time    ${driver2}           # 获取Recents页面前两行call记录的时间
    two_list_has_one_same_element    ${driver2}   ${occurred_time_list}    ${occurred_time_list_1}
    [Teardown]   exit_driver
#    [Teardown]   exit_driver    ${driver1}    ${driver2}

Small_range_657
    [Documentation]     No answer message   caller calls via normal way	   callee clicks on decline button
    [Tags]    small range 657 line      call_case
    # Expert User1 登录（case中的caller）
    ${driver1}    driver_set_up_and_logIn    ${Expert_User1_username}     ${universal_password}
    # Expert User2 登录（case中的callee）
    ${driver2}    driver_set_up_and_logIn    ${Expert_User2_username}     ${universal_password}
    switch_to_diffrent_page   ${driver2}   ${py_recents_page}     ${py_recents_switch_success}    ${py_get_number_of_rows}   # Expert A 切换到Recents页面
    ${occurred_time_list}    get_recents_page_records_occurred_time    ${driver2}           # 获取Recents页面前两行call记录的时间
    # caller calls via normal way
    contacts_witch_page_make_call   ${driver1}   ${driver2}    ${py_team_page}  ${Expert_User2_name}    no_care
    # callee clicks on decline button
    user_decline_call    ${driver2}
    # VP1: Your call was declined.2
    which_page_is_currently_on   ${driver1}    ${your_call_was_declined}
    # VP2: The two users should not see rating dialog.
    which_page_is_currently_on   ${driver1}    ${five_star_high_praise}    not_currently_on
    which_page_is_currently_on   ${driver2}    ${five_star_high_praise}    not_currently_on
    # Expert User2 刷新Recents页面
    refresh_browser_page    ${driver2}
    ${occurred_time_list_1}    get_recents_page_records_occurred_time    ${driver2}           # 获取Recents页面前两行call记录的时间
    two_list_has_one_same_element    ${driver2}   ${occurred_time_list}    ${occurred_time_list_1}
    [Teardown]   exit_driver
#    [Teardown]   exit_driver    ${driver1}    ${driver2}

Small_range_658
    [Documentation]     No answer message   caller calls via normal way	   caller calls one participant who is in another call
    [Tags]    small range 658 line      call_case
    # Expert User1 登录
    ${driver1}    driver_set_up_and_logIn    ${Expert_User1_username}     ${universal_password}
    switch_to_diffrent_page   ${driver1}   ${py_recents_page}     ${py_recents_switch_success}    ${py_get_number_of_rows}   # Expert A 切换到Recents页面
    ${occurred_time_list_0}    get_recents_page_records_occurred_time    ${driver1}           # 获取Recents页面前两行call记录的时间
    # Expert User2 登录（case中的callee）
    ${driver2}    driver_set_up_and_logIn    ${Expert_User2_username}     ${universal_password}
    switch_to_diffrent_page   ${driver2}   ${py_recents_page}     ${py_recents_switch_success}    ${py_get_number_of_rows}   # Expert A 切换到Recents页面
    ${occurred_time_list}    get_recents_page_records_occurred_time    ${driver2}     3        # 获取Recents页面前三行call记录的时间
    # caller calls via normal way
    switch_to_diffrent_page   ${driver1}   ${py_contacts_page}     ${py_contacts_switch_success}    ${py_get_number_of_rows}
    contacts_witch_page_make_call   ${driver1}   ${driver2}    ${py_team_page}  ${Expert_User2_name}
    # Expert User3 登录（case中的caller）
    ${driver3}    driver_set_up_and_logIn    ${Expert_User3_username}     ${universal_password}
    # caller calls one participant who is in another call
    contacts_witch_page_make_call   ${driver3}    ${driver2}    ${py_team_page}  ${Expert_User2_name}   no_care
    # VP1: "/Target user/ is currently on another call.
    which_page_is_currently_on   ${driver3}    ${user_is_currently_on_another_call}
    # VP2: rating dialog doesn’t display.
    which_page_is_currently_on   ${driver3}    ${five_star_high_praise}    not_currently_on
    ###### Verify: In recent tab, Callee has a missing incoming call record. And Caller has a outgoing call record.
    exit_call   ${driver1}    # 结束Call
    # Expert User2 刷新Recents页面
    close_call_ending_page      ${driver2}   # 关闭通话结束页面
    refresh_browser_page        ${driver2}   # 刷新页面
    ${occurred_time_list_1}    get_recents_page_records_occurred_time    ${driver2}       3     # 获取Recents页面前三行call记录的时间
    two_list_has_one_same_element    ${driver2}   ${occurred_time_list}    ${occurred_time_list_1}
    # Expert User1 刷新Recents页面
    close_call_ending_page      ${driver1}   # 关闭通话结束页面
    switch_to_diffrent_page     ${driver1}   ${py_recents_page}     ${py_recents_switch_success}    ${py_get_number_of_rows}   # Expert A 切换到Recents页面
    refresh_browser_page        ${driver1}   # 刷新页面
    ${occurred_time_list_01}    get_recents_page_records_occurred_time    ${driver1}           # 获取Recents页面前两行call记录的时间
    two_list_has_one_same_element    ${driver1}   ${occurred_time_list_0}   ${occurred_time_list_01}
    [Teardown]   exit_driver
#    [Teardown]   exit_driver    ${driver1}    ${driver2}    ${driver3}

#Small_range_660
#    [Documentation]     No answer message   caller calls via meeting link	   One-time meeting room link [Joiner's App is killed]
#    [Tags]    small range 660 line      call_case    有bug：https://vipaar.atlassian.net/browse/CITRON-3502
#    # Expert User1 登录（case中的caller），这个user属于big_admin
#    ${driver1}    driver_set_up_and_logIn    Huiming.shi.helplightning+free_user_1@outlook.com     ${universal_password}
#    # Expert User2 登录（case中的Joiner），这个user属于big_admin
#    ${driver2}    driver_set_up_and_logIn    Huiming.shi.helplightning+free_user_2@outlook.com     ${universal_password}
#    # 获取meeting link
#    ${invite_url}    send_meeting_room_link    ${driver2}    OTU   no_send
#    # Joiner's App is killed
#    logout_citron    ${driver2}
#    # caller calls via meeting link
#    user_make_call_via_meeting_link    ${driver1}   ${invite_url}
#    # 确保建立call，但未接听
#    make_sure_enter_call    ${driver1}
#    # Owner decline call
#    which_page_is_currently_on   ${driver1}    ${that_user_is_unreachable}
#    [Teardown]   exit_driver
##    [Teardown]   exit_driver    ${driver1}

Small_range_661
    [Documentation]     No answer message   caller calls via meeting link	  Meeting room link[Owner's App runs in backgroup]
    [Tags]    small range 661 line      call_case
    # Expert User1 登录（case中的caller）
    ${driver1}    driver_set_up_and_logIn    ${Expert_User1_username}     ${universal_password}
    # Expert User2 登录（case中的Joiner）
    ${driver2}    driver_set_up_and_logIn    ${Expert_User2_username}     ${universal_password}
    # 获取meeting link
    ${invite_url}    send_meeting_room_link    ${driver2}    OTU   no_send
    # caller calls via meeting link
    user_make_call_via_meeting_link    ${driver1}   ${invite_url}
    # 确保建立call，但未接听
    make_sure_enter_call    ${driver1}
    # Guest cancel call
    user_end_call_by_self    ${driver1}
    [Teardown]   exit_driver
#    [Teardown]   exit_driver    ${driver1}   ${driver2}

Small_range_662
    [Documentation]     User A call B enter call via normal way    User B invites callee [User C]
    [Tags]    small range 662 line      call_case
    # User A 登录
    ${driver1}    driver_set_up_and_logIn    ${Expert_User1_username}     ${universal_password}
    switch_to_diffrent_page   ${driver1}   ${py_recents_page}     ${py_recents_switch_success}    ${py_get_number_of_rows}
    ${occurred_time_list_A1}   get_recents_page_records_occurred_time   ${driver1}
    switch_to_diffrent_page   ${driver1}   ${py_contacts_page}     ${py_contacts_switch_success}    ${py_get_number_of_rows}
    # User B 登录
    ${driver2}    driver_set_up_and_logIn    ${Expert_User2_username}     ${universal_password}
    switch_to_diffrent_page   ${driver2}   ${py_recents_page}     ${py_recents_switch_success}    ${py_get_number_of_rows}
    ${occurred_time_list_B1}   get_recents_page_records_occurred_time   ${driver2}     3
    # User A call B enter call via normal way
    contacts_witch_page_make_call    ${driver1}   ${driver2}    ${py_team_page}  ${Expert_User2_name}
    # User C 登录
    ${driver3}    driver_set_up_and_logIn    ${Expert_User3_username}     ${universal_password}
    switch_to_diffrent_page   ${driver3}   ${py_recents_page}     ${py_recents_switch_success}    ${py_get_number_of_rows}
    ${occurred_time_list_C1}   get_recents_page_records_occurred_time   ${driver3}
    # User B invites callee [User C]
    which_page_is_currently_on    ${driver2}    ${end_call_button}
    enter_contacts_search_user    ${driver2}     ${Expert_User3_name}
    click_user_in_contacts_call   ${driver2}     ${Expert_User3_name}
    # User C] doesn't answer call until time out
    which_page_is_currently_on    ${driver3}   ${anwser_call_button}
    sleep  30s
    # VP: "xxx didn't answer your call"
    which_page_is_currently_on    ${driver2}   ${your_call_was_not_anwsered_in_call}
    # 结束Call
    exit_call   ${driver1}    1
    # Verify: In recent tab, User A has 1 outgoing call to User B.
    close_call_ending_page    ${driver1}
    switch_to_diffrent_page   ${driver1}   ${py_recents_page}     ${py_recents_switch_success}    ${py_get_number_of_rows}
    ${occurred_time_list_A2}   get_recents_page_records_occurred_time   ${driver1}
    two_list_has_one_same_element    ${driver1}    ${occurred_time_list_A1}   ${occurred_time_list_A2}
    verify_username_in_recents_page    ${driver1}   ${Expert_User2_name}
    # User B has 1 incoming call from User A, and 1 outgoing call to User C.
    close_call_ending_page    ${driver2}
    refresh_browser_page   ${driver2}
    ${occurred_time_list_B2}   get_recents_page_records_occurred_time   ${driver2}    3
    two_list_has_one_same_element    ${driver2}    ${occurred_time_list_B1}   ${occurred_time_list_B2}
    verify_username_in_recents_page    ${driver2}   ${Expert_User3_name}   ${Expert_User1_name}
    # User C has 1 missing incoming call from User B.
    refresh_browser_page   ${driver3}
    ${occurred_time_list_C2}   get_recents_page_records_occurred_time   ${driver3}
    two_list_has_one_same_element    ${driver3}    ${occurred_time_list_C1}   ${occurred_time_list_C2}
    verify_username_in_recents_page    ${driver3}   ${Expert_User2_name}
    [Teardown]   exit_driver
#    [Teardown]   exit_driver    ${driver1}   ${driver2}   ${driver3}

Small_range_663
    [Documentation]     User A call B enter call via normal way    User A invites User C] who doesn't login on any device
    [Tags]    small range 663 line      call_case
    # User A 登录
    ${driver1}    driver_set_up_and_logIn    ${Expert_User1_username}     ${universal_password}
    switch_to_diffrent_page   ${driver1}   ${py_recents_page}     ${py_recents_switch_success}    ${py_get_number_of_rows}
    ${occurred_time_list_A1}   get_recents_page_records_occurred_time   ${driver1}    3
    switch_to_diffrent_page   ${driver1}   ${py_contacts_page}     ${py_contacts_switch_success}    ${py_get_number_of_rows}
    # User B 登录
    ${driver2}    driver_set_up_and_logIn    ${Expert_User2_username}     ${universal_password}
    switch_to_diffrent_page   ${driver2}   ${py_recents_page}     ${py_recents_switch_success}    ${py_get_number_of_rows}
    ${occurred_time_list_B1}   get_recents_page_records_occurred_time   ${driver2}
    # User A call B enter call via normal way
    contacts_witch_page_make_call    ${driver1}   ${driver2}    ${py_team_page}  ${Expert_User2_name}
    # User C 登录
    ${driver3}    driver_set_up_and_logIn    ${Expert_User3_username}     ${universal_password}
    switch_to_diffrent_page   ${driver3}   ${py_recents_page}     ${py_recents_switch_success}    ${py_get_number_of_rows}
    ${occurred_time_list_C1}   get_recents_page_records_occurred_time   ${driver3}
    # User C 退出
    exit_one_driver    ${driver3}
    # User A invites User C] who doesn't login on any device
    which_page_is_currently_on    ${driver1}    ${end_call_button}
    enter_contacts_search_user    ${driver1}     ${Expert_User3_name}
    click_user_in_contacts_call   ${driver1}     ${Expert_User3_name}    can_not_reach
    # 结束Call
    exit_call   ${driver1}    1
    # Verify: In recent tab,User A has 1 outgoing call  to User C. and has 1 outgoing call to  User B.
    close_call_ending_page    ${driver1}
    switch_to_diffrent_page   ${driver1}   ${py_recents_page}     ${py_recents_switch_success}    ${py_get_number_of_rows}
    ${occurred_time_list_A2}   get_recents_page_records_occurred_time   ${driver1}    3
    two_list_has_one_same_element    ${driver1}    ${occurred_time_list_A1}   ${occurred_time_list_A2}
    verify_username_in_recents_page    ${driver1}    ${Expert_User3_name}   ${Expert_User2_name}
    # User B has 1 incoming call from User A.
    close_call_ending_page    ${driver2}
    refresh_browser_page   ${driver2}
    ${occurred_time_list_B2}   get_recents_page_records_occurred_time   ${driver2}
    two_list_has_one_same_element    ${driver2}    ${occurred_time_list_B1}   ${occurred_time_list_B2}
    verify_username_in_recents_page    ${driver2}   ${Expert_User1_name}
    # Verify:User C has a missing incoming from User A in recent tab.
    # User C 登录
    ${driver4}    driver_set_up_and_logIn    ${Expert_User3_username}     ${universal_password}
    switch_to_diffrent_page   ${driver4}   ${py_recents_page}     ${py_recents_switch_success}    ${py_get_number_of_rows}
    ${occurred_time_list_C2}   get_recents_page_records_occurred_time   ${driver4}
    two_list_has_one_same_element    ${driver4}    ${occurred_time_list_C1}   ${occurred_time_list_C2}
    verify_username_in_recents_page    ${driver4}   ${Expert_User1_name}
    [Teardown]   exit_driver
#    [Teardown]   exit_driver    ${driver1}   ${driver2}   ${driver3}  ${driver4}

Small_range_664
    [Documentation]     User A call B enter call via normal way    User A] invites User C
    [Tags]    small range 664 line      call_case
    # User A 登录
    ${driver1}    driver_set_up_and_logIn    ${Expert_User1_username}     ${universal_password}
    switch_to_diffrent_page   ${driver1}   ${py_recents_page}     ${py_recents_switch_success}    ${py_get_number_of_rows}
    ${occurred_time_list_A1}   get_recents_page_records_occurred_time   ${driver1}    3
    switch_to_diffrent_page   ${driver1}   ${py_contacts_page}     ${py_contacts_switch_success}    ${py_get_number_of_rows}
    # User B 登录
    ${driver2}    driver_set_up_and_logIn    ${Expert_User2_username}     ${universal_password}
    switch_to_diffrent_page   ${driver2}   ${py_recents_page}     ${py_recents_switch_success}    ${py_get_number_of_rows}
    ${occurred_time_list_B1}   get_recents_page_records_occurred_time   ${driver2}
    # User A call B enter call via normal way
    contacts_witch_page_make_call    ${driver1}   ${driver2}    ${py_team_page}  ${Expert_User2_name}
    # User C 登录
    ${driver3}    driver_set_up_and_logIn    ${Expert_User3_username}     ${universal_password}
    switch_to_diffrent_page   ${driver3}   ${py_recents_page}     ${py_recents_switch_success}    ${py_get_number_of_rows}
    ${occurred_time_list_C1}   get_recents_page_records_occurred_time   ${driver3}
    # User A] invites User C
    which_page_is_currently_on    ${driver1}    ${end_call_button}
    enter_contacts_search_user    ${driver1}     ${Expert_User3_name}
    click_user_in_contacts_call   ${driver1}     ${Expert_User3_name}
    # User C] clicks on decline button
    user_decline_call    ${driver3}
    # VP1: "Your call was declined.
    which_page_is_currently_on    ${driver1}   ${declined_your_call}
    # 结束Call
    exit_call   ${driver1}    1
    # VP2: user C should not see rating dialog.
    which_page_is_currently_on    ${driver3}   ${five_star_high_praise}    not_currently_on
    # Verify: In recent tab, User A has 1 outgoing call to User B, and 1 outgoing call to User C.
    close_call_ending_page    ${driver1}
    switch_to_diffrent_page   ${driver1}   ${py_recents_page}     ${py_recents_switch_success}    ${py_get_number_of_rows}
    ${occurred_time_list_A2}   get_recents_page_records_occurred_time   ${driver1}    3
    two_list_has_one_same_element    ${driver1}    ${occurred_time_list_A1}   ${occurred_time_list_A2}
    verify_username_in_recents_page    ${driver1}    ${Expert_User3_name}   ${Expert_User2_name}
    #User B has 1 incoming call from User A.
    close_call_ending_page    ${driver2}
    refresh_browser_page   ${driver2}
    ${occurred_time_list_B2}   get_recents_page_records_occurred_time   ${driver2}
    two_list_has_one_same_element    ${driver2}    ${occurred_time_list_B1}   ${occurred_time_list_B2}
    verify_username_in_recents_page    ${driver2}   ${Expert_User1_name}
    #User C has 1 missing incoming call from User A.
    refresh_browser_page   ${driver3}
    ${occurred_time_list_C2}   get_recents_page_records_occurred_time   ${driver3}
    two_list_has_one_same_element    ${driver3}    ${occurred_time_list_C1}   ${occurred_time_list_C2}
    verify_username_in_recents_page    ${driver3}   ${Expert_User1_name}
    [Teardown]   exit_driver
#    [Teardown]   exit_driver    ${driver1}   ${driver2}   ${driver3}

Small_range_665
    [Documentation]     User A call B enter call via normal way    caller calls one participant who is in another call via normal call
    [Tags]    small range 665 line      call_case
    # User A 登录
    ${driver1}    driver_set_up_and_logIn    ${Expert_User1_username}     ${universal_password}
    switch_to_diffrent_page   ${driver1}   ${py_recents_page}     ${py_recents_switch_success}    ${py_get_number_of_rows}
    ${occurred_time_list_A1}   get_recents_page_records_occurred_time   ${driver1}
    switch_to_diffrent_page   ${driver1}   ${py_contacts_page}     ${py_contacts_switch_success}    ${py_get_number_of_rows}
    # User C 登录
    ${driver3}    driver_set_up_and_logIn    ${Expert_User3_username}     ${universal_password}
    # User D 登录
    ${driver4}    driver_set_up_and_logIn    ${Expert_User4_username}     ${universal_password}
    switch_to_diffrent_page   ${driver4}   ${py_recents_page}     ${py_recents_switch_success}    ${py_get_number_of_rows}
    ${occurred_time_list_D1}   get_recents_page_records_occurred_time   ${driver4}    3
    # User A call B enter call via normal way
    contacts_witch_page_make_call    ${driver3}   ${driver4}    ${py_team_page}  ${Expert_User4_name}
    which_page_is_currently_on    ${driver3}    ${end_call_button}

    # caller calls one participant who is in another call via normal call
    contacts_witch_page_make_call    ${driver1}   ${driver4}    ${py_team_page}  ${Expert_User4_name}   no_care
    which_page_is_currently_on    ${driver1}    ${user_is_currently_on_another_call}
    # 结束Call
    exit_call   ${driver3}
    # Callee has a missing incoming call record.
    close_call_ending_page   ${driver4}
    refresh_browser_page    ${driver4}
    ${occurred_time_list_D2}    get_recents_page_records_occurred_time    ${driver4}       3
    two_list_has_one_same_element    ${driver4}   ${occurred_time_list_D1}    ${occurred_time_list_D2}
    verify_username_in_recents_page    ${driver4}   ${Expert_User3_name}    ${Expert_User1_name}
    # And Caller has a outgoing call record.
    switch_to_diffrent_page   ${driver1}   ${py_recents_page}     ${py_recents_switch_success}    ${py_get_number_of_rows}
    ${occurred_time_list_A2}    get_recents_page_records_occurred_time    ${driver1}
    two_list_has_one_same_element    ${driver1}   ${occurred_time_list_A1}    ${occurred_time_list_A2}
    verify_username_in_recents_page    ${driver1}    ${Expert_User4_name}
    [Teardown]   exit_driver
#    [Teardown]   exit_driver    ${driver1}   ${driver2}   ${driver3}  ${driver4}

#Small_range_666
#    [Documentation]     Guest 1 call meeting link Owner    Guest 2] calls one participant via meeting link    Owner] kill app during incoming call
#    [Tags]    small range 666 line，有bug：https://vipaar.atlassian.net/browse/CITRON-3288        call_case
#    # meeting link Owner 登录
#    ${driver1}    driver_set_up_and_logIn    ${Expert_User1_username}     ${universal_password}
#    switch_to_diffrent_page   ${driver1}   ${py_recents_page}     ${py_recents_switch_success}    ${py_get_number_of_rows}
#    ${occurred_time_list_A1}   get_recents_page_records_occurred_time   ${driver1}    3
#    switch_to_diffrent_page   ${driver1}   ${py_contacts_page}     ${py_contacts_switch_success}    ${py_get_number_of_rows}
#    ${invite_url}    send_meeting_room_link    ${driver1}    MHS   no_send
#    # Guest 1 登录
#    ${driver2}    driver_set_up_and_logIn    ${Expert_User2_username}     ${universal_password}
#    # Guest 1 call meeting link Owner
#    user_make_call_via_meeting_link    ${driver2}   ${invite_url}
#    # 确保建立call，但未接听
#    make_sure_enter_call    ${driver2}
#    switch_to_diffrent_page   ${driver2}   ${py_recents_page}     ${py_recents_switch_success}    ${py_get_number_of_rows}
#    ${occurred_time_list_B1}   get_recents_page_records_occurred_time   ${driver2}
#    # meeting link Owner 接受Call
#    user_anwser_call   ${driver1}
#    # Guest 2] 登录
#    ${driver3}    driver_set_up_and_logIn    ${Expert_User3_username}     ${universal_password}
#    switch_to_diffrent_page   ${driver3}   ${py_recents_page}     ${py_recents_switch_success}    ${py_get_number_of_rows}
#    ${occurred_time_list_C1}   get_recents_page_records_occurred_time   ${driver3}
#    # Guest 2] calls one participant via meeting link
#    user_make_call_via_meeting_link    ${driver3}   ${invite_url}
#     # 确保建立call，但未接听
#     make_sure_enter_call    ${driver3}
#    # Owner] kill app during incoming call
#    exit_one_driver  ${driver1}
#    sleep  58s
#    # VP: "xxx didn't answer your call"
#    which_page_is_currently_on    ${driver3}    ${did_not_answer_your_call}
#    # Verify: In recent tab,Owner has 1 incoming call from Guest 1. And 1 missing incoming call from Guest 2.
#    exit_call    ${driver2}
#    # meeting link Owner 重新登录
#    ${driver4}    driver_set_up_and_logIn    ${Expert_User1_username}     ${universal_password}
#    switch_to_diffrent_page   ${driver4}   ${py_recents_page}     ${py_recents_switch_success}    ${py_get_number_of_rows}
#    ${occurred_time_list_A2}   get_recents_page_records_occurred_time   ${driver4}    3
#    two_list_has_one_same_element    ${driver4}   ${occurred_time_list_A1}    ${occurred_time_list_A2}
#    verify_username_in_recents_page    ${driver4}    ${Expert_User1_name}   ${Expert_User2_name}
#    #Guest 1 has 1 outgoing call to Owner.
#    close_last_window    ${driver2}
#    refresh_browser_page    ${driver2}
#    ${occurred_time_list_B2}   get_recents_page_records_occurred_time   ${driver2}
#    two_list_has_one_same_element    ${driver2}   ${occurred_time_list_B1}    ${occurred_time_list_B2}
#    verify_username_in_recents_page    ${driver2}    ${Expert_User1_name}
#    #Guest 2 has 1 outgoing call to Owner.
#    close_last_window    ${driver3}
#    refresh_browser_page    ${driver3}
#    ${occurred_time_list_C2}   get_recents_page_records_occurred_time   ${driver3}
#    two_list_has_one_same_element    ${driver3}   ${occurred_time_list_C1}    ${occurred_time_list_C2}
#    verify_username_in_recents_page    ${driver3}    ${Expert_User1_name}
#    [Teardown]   exit_driver
##    [Teardown]   exit_driver    ${driver1}   ${driver2}   ${driver3}   ${driver4}

#Small_range_667
#    [Documentation]     Guest 1 call meeting link Owner    Guest 2] calls one participant via meeting link    Meeting Owner] declines call
#    [Tags]    small range 66 line，有bug：https://vipaar.atlassian.net/browse/CITRON-3288     call_case
#    # meeting link Owner 登录
#    ${driver1}    driver_set_up_and_logIn    ${Expert_User1_username}     ${universal_password}
#    switch_to_diffrent_page   ${driver1}   ${py_recents_page}      ${py_recents_switch_success}    ${py_get_number_of_rows}
#    ${occurred_time_list_A1}   get_recents_page_records_occurred_time   ${driver1}    3
#    switch_to_diffrent_page   ${driver1}   ${py_contacts_page}     ${py_contacts_switch_success}    ${py_get_number_of_rows}
#    ${invite_url}    send_meeting_room_link    ${driver1}    MHS   no_send
#    # Guest 1 登录
#    ${driver2}    driver_set_up_and_logIn    ${Expert_User2_username}     ${universal_password}
#    switch_to_diffrent_page   ${driver2}   ${py_recents_page}     ${py_recents_switch_success}    ${py_get_number_of_rows}
#    ${occurred_time_list_B1}   get_recents_page_records_occurred_time   ${driver2}
#    # Guest 1 call meeting link Owner
#    user_make_call_via_meeting_link    ${driver2}   ${invite_url}
#     # 确保建立call，但未接听
#     make_sure_enter_call    ${driver2}
#    # meeting link Owner 接受Call
#    user_anwser_call   ${driver1}
#    # Guest 2] 登录
#    ${driver3}    driver_set_up_and_logIn    ${Expert_User3_username}     ${universal_password}
#    switch_to_diffrent_page   ${driver3}   ${py_recents_page}     ${py_recents_switch_success}    ${py_get_number_of_rows}
#    ${occurred_time_list_C1}   get_recents_page_records_occurred_time   ${driver3}
#    # Guest 2] calls one participant via meeting link
#    user_make_call_via_meeting_link    ${driver3}   ${invite_url}
#     # 确保建立call，但未接听
#     make_sure_enter_call    ${driver3}
#    # Meeting Owner] declines call
#    user_decline_call    ${driver1}    in_calling
#    # VP1:"Your call was declined."
#    which_page_is_currently_on    ${driver3}     ${your_call_was_declined}
#    # VP2: guest 2 should not see rating dialog.
#    exit_call   ${driver1}
#    which_page_is_currently_on    ${driver3}   ${five_star_high_praise}    not_currently_on
#    # Verify: In recent tab, Guest 2 has a outgoing call record to Owner.
#    close_last_window   ${driver3}
#    refresh_browser_page    ${driver3}
#    ${occurred_time_list_C2}   get_recents_page_records_occurred_time   ${driver3}
#    two_list_has_one_same_element    ${driver3}   ${occurred_time_list_C1}    ${occurred_time_list_C2}
#    verify_username_in_recents_page    ${driver3}    ${Expert_User1_name}
#    #Guest 1 has a outgoing call record to Owner.
#    close_call_ending_page   ${driver2}
#    refresh_browser_page    ${driver2}
#    ${occurred_time_list_B2}   get_recents_page_records_occurred_time   ${driver2}
#    two_list_has_one_same_element    ${driver2}   ${occurred_time_list_B1}    ${occurred_time_list_B2}
#    verify_username_in_recents_page    ${driver4}    ${Expert_User1_name}
#    #Owner has 2 incoming call records, one is a missing incoming call from Guest 2. And the other is from Guest 1.
#    close_call_ending_page   ${driver1}
#    refresh_browser_page    ${driver1}
#    ${occurred_time_list_A2}   get_recents_page_records_occurred_time   ${driver1}    3
#    two_list_has_one_same_element    ${driver1}   ${occurred_time_list_A1}    ${occurred_time_list_A2}
#    verify_username_in_recents_page    ${driver4}    ${Expert_User1_name}   ${Expert_User2_name}
#    [Teardown]   exit_driver
##    [Teardown]   exit_driver    ${driver1}   ${driver2}   ${driver3}

Small_range_669_670
    [Documentation]     User set Do not Disturb(DND)   User A set Do not Disturb  from App
    [Tags]    small range 669+670 lines      call_case
    # User A login and set Do not disturb
    ${driver1}    driver_set_up_and_logIn    ${Expert_User1_username}     ${universal_password}    close_bounced     accept    set_disturb
    # User B 登录
    ${driver2}    driver_set_up_and_logIn    ${Expert_User2_username}     ${universal_password}
    # Become available from app
    do_not_disturb_become_available    ${driver1}
    # UserB call user A
    contacts_witch_page_make_call     ${driver2}    ${driver1}    ${py_team_page}  ${Expert_User1_name}
    # Verify:call connected
    exit_call    ${driver1}
    # 关闭call结束页面
    close_call_ending_page    ${driver1}
    [Teardown]      run keywords    do_not_disturb_become_available    ${driver1}
    ...             AND             exit_driver
#    ...             AND             exit_driver     ${driver1}    ${driver2}

#Small_range_671_672_673
#    [Documentation]     User set Do not Disturb(DND)   User A set Do not Disturb  from App
#    [Tags]    small range 671+672+673 lines     call_case     有bug：https://vipaar.atlassian.net/browse/CITRON-3504
#    # User A set Do not Disturb from App
#    ${driver1}    driver_set_up_and_logIn    ${Expert_User1_username}     ${universal_password}    no_check_toturial     close_bounced     accept    set_disturb
#    switch_to_diffrent_page   ${driver1}   ${py_recents_page}     ${py_recents_switch_success}    ${py_get_number_of_rows}
#    ${occurred_time_list_A1}   get_recents_page_records_occurred_time   ${driver1}
#    # User B 登录
#    ${driver2}    driver_set_up_and_logIn    ${Expert_User2_username}     ${universal_password}
#    switch_to_diffrent_page   ${driver2}   ${py_recents_page}     ${py_recents_switch_success}    ${py_get_number_of_rows}
#    ${occurred_time_list_B1}   get_recents_page_records_occurred_time   ${driver2}
#    switch_to_diffrent_page   ${driver2}   ${py_contacts_page}     ${py_contacts_switch_success}    ${py_get_number_of_rows}
#    # User B call user A from contact list
#    contacts_witch_page_make_call    ${driver2}   ${driver1}    ${py_team_page}  ${Expert_User1_name}   no_care
#    # Verify: UserB receives a UI indicator that User A is Not Available along with Not Available Message set by citron
#    which_page_is_currently_on     ${driver2}   ${pleas_do_not_disturb}
#    close_call_ending_page    ${driver2}
#    # VP: in Recents tab, User B has a outgoing call record of User A
#    switch_to_diffrent_page   ${driver2}    ${py_recents_page}     ${py_recents_switch_success}    ${py_get_number_of_rows}
#    ${occurred_time_list_B2}    get_recents_page_records_occurred_time    ${driver2}
#    two_list_has_one_same_element    ${driver2}   ${occurred_time_list_B1}    ${occurred_time_list_B2}
#    verify_username_in_recents_page    ${driver2}    ${Expert_User1_name}
#    # User A become available from app
#    do_not_disturb_become_available    ${driver1}
#    # VP: in recents tab,User A has a missing call from User B
#    refresh_browser_page   ${driver1}
#    ${occurred_time_list_A2}   get_recents_page_records_occurred_time   ${driver1}
#    two_list_has_one_same_element    ${driver1}   ${occurred_time_list_A1}    ${occurred_time_list_A2}
#    verify_username_in_recents_page    ${driver1}    ${Expert_User2_name}
#    # User A clicks this record.
#    refresh_browser_page   ${driver1}
#    recents_page_check_call    ${driver1}    ${Expert_User2_name}    can_connect   no_send_invite
#    # Verify:call connected
#    user_anwser_call     ${driver2}
#    exit_call    ${driver1}
#    # 关闭call结束页面
#    close_call_ending_page    ${driver1}
#    [Teardown]      run keywords    do_not_disturb_become_available    ${driver1}
#    ...             AND             exit_driver
##    ...             AND             exit_driver     ${driver1}    ${driver2}
#
#Small_range_674
#    [Documentation]     User set Do not Disturb(DND)   UserB call user A by meeting link
#    [Tags]    small range 674 line      call_case     有bug：https://vipaar.atlassian.net/browse/CITRON-3504
#    # User A login and set Do not disturb
#    ${driver1}    driver_set_up_and_logIn    ${Expert_User1_username}     ${universal_password}    no_check_toturial    close_bounced     accept    set_disturb
#    ${invite_url}    send_meeting_room_link    ${driver1}    MHS   no_send
#    # User B 登录
#    ${driver2}    driver_set_up_and_logIn    ${Expert_User2_username}     ${universal_password}
#    # UserB call user A by meeting link
#    user_make_call_via_meeting_link    ${driver2}   ${invite_url}
#    # 确保建立call，但未接听
#    make_sure_enter_call    ${driver2}
#    # Verify: UserB receives User A is Not Available along with Not Available Message
#    which_page_is_currently_on     ${driver2}   ${pleas_do_not_disturb}
#    [Teardown]      run keywords    do_not_disturb_become_available    ${driver1}
#    ...             AND             exit_driver
##    ...             AND             exit_driver     ${driver1}    ${driver2}
#
#Small_range_675
#    [Documentation]     User set Do not Disturb(DND)    InCall user invite User A to 3PC call
#    [Tags]    small range 675 line      call_case     有bug：https://vipaar.atlassian.net/browse/CITRON-3504
#    # User B 登录
#    ${driver2}    driver_set_up_and_logIn    ${Expert_User2_username}     ${universal_password}
#    # User C 登录
#    ${driver3}    driver_set_up_and_logIn    ${Expert_User3_username}     ${universal_password}
#    # User B make calls with User C
#    contacts_witch_page_make_call    ${driver2}   ${driver3}    ${py_team_page}  ${Expert_User3_name}
#    # User A login and set Do not disturb
#    ${driver1}    driver_set_up_and_logIn    ${Expert_User1_username}     ${universal_password}    no_check_toturial    close_bounced     accept    set_disturb
#    # InCall user invite User A to 3PC call
#    which_page_is_currently_on    ${driver2}    ${end_call_button}
#    enter_contacts_search_user   ${driver2}    ${Expert_User1_name}
#    click_user_in_contacts_call   ${driver2}   ${Expert_User1_name}
#    # Inviter receives User A is Not Available along with Not Available Message
#    which_page_is_currently_on     ${driver2}   ${pleas_do_not_disturb}
#    [Teardown]      run keywords    do_not_disturb_become_available     ${driver1}
#    ...             AND             exit_call       ${driver2}
#    ...             AND             exit_driver
##    ...             AND             exit_driver     ${driver1}    ${driver2}   ${driver3}
#
#Small_range_677_678_679_680
#    [Documentation]     User set Do not Disturb(DND)    Site Admin add user A to another workspace WS2
#    [Tags]    small range 677+678+679+680 lines     call_case     有bug：https://vipaar.atlassian.net/browse/CITRON-3504
#    #  user A 登录
#    ${driver1}    driver_set_up_and_logIn    ${belong_two_WS_username}     ${universal_password}
#    # User A send OTU link [link1]
#    ${invite_url_otu}   send_meeting_room_link   ${driver1}   OTU   no_send
#    #  user B 登录
#    ${driver2}    driver_set_up_and_logIn    ${Expert_User1_username}     ${universal_password}
#    # User A switch to WS2
#    user_switch_to_second_workspace   ${driver1}    ${Huiming_shi_Added_WS_another}
#    # User A turn on DND
#    set_do_not_disturb   ${driver1}
#    # User A send MHS link [link2]
#    ${invite_url_mhs}   send_meeting_room_link   ${driver1}   MHS   no_send
#    ### 678
#    # User B call A from contact list
#    contacts_witch_page_make_call    ${driver2}   ${driver1}    ${py_team_page}  ${belong_two_WS_name}
#    # 结束Call;VP: A receive incoming call, can enter call successfully
#    exit_call    ${driver2}
#    ### 679
#    # User B click otu link "link1"
#    user_make_call_via_meeting_link   ${driver2}  ${invite_url_otu}
#    # 确保建立call，但未接听
#    make_sure_enter_call    ${driver2}
#    # VP: A receive incoming call, can enter call successfully
#    user_anwser_call   ${driver1}
#    exit_call    ${driver2}
#    ### 680
#    # User B click mhs link "link2"
#    user_make_call_via_meeting_link   ${driver2}  ${invite_url_mhs}
#    # 确保建立call，但未接听
#    make_sure_enter_call    ${driver2}
#    # VP: B see DND message, with ougoing call fails
#    which_page_is_currently_on     ${driver2}   ${pleas_do_not_disturb}
#    [Teardown]      run keywords    close_call_ending_page     ${driver1}
#    ...             AND             do_not_disturb_become_available     ${driver1}
#    ...             AND             exit_driver
##    ...             AND             exit_driver     ${driver1}    ${driver2}
#
#Small_range_681_682_683
#    [Documentation]     User set Do not Disturb(DND)    Site Admin add user A to another workspace WS2
#    [Tags]    small range 601+682+683 lines     call_case     有bug：https://vipaar.atlassian.net/browse/CITRON-3504
#    #  user A 登录
#    ${driver1}    driver_set_up_and_logIn    ${belong_two_WS_username}     ${universal_password}
#    # User A send OTU link [link1]
#    ${invite_url_otu}   send_meeting_room_link   ${driver1}   OTU   no_send
#    #  WS2 contact  登录
#    ${driver2}    driver_set_up_and_logIn    ${another_WS_username}     ${universal_password}
#    # User A switch to WS2
#    user_switch_to_second_workspace   ${driver1}    ${Huiming_shi_Added_WS_another}
#    # User A turn on DND
#    set_do_not_disturb   ${driver1}
#    # User A send MHS link [link2]
#    ${invite_url_mhs}   send_meeting_room_link   ${driver1}   MHS   no_send
#    # User A switch back to WS1
#    user_switch_to_second_workspace   ${driver1}    ${Huiming_shi_Added_WS}
#    ### 681
#    # WS2 contact call User A
#    contacts_witch_page_make_call    ${driver2}   ${driver1}    ${py_team_page}  ${belong_two_WS_name}   no_care
#    # VP: WS2 contact get DND message
#    which_page_is_currently_on     ${driver2}   ${pleas_do_not_disturb}
#    ### 682
#    user_make_call_via_meeting_link   ${driver2}  ${invite_url_otu}
#    # 确保建立call，但未接听
#    make_sure_enter_call    ${driver2}
#    # VP: A receive incoming call, can enter call successfully
#    user_anwser_call   ${driver1}
#    exit_call    ${driver2}
#    ### 683
#    user_make_call_via_meeting_link   ${driver2}  ${invite_url_mhs}
#    # 确保建立call，但未接听
#    make_sure_enter_call    ${driver2}
#    # VP: B see DND message, with ougoing call fails
#    which_page_is_currently_on     ${driver2}   ${pleas_do_not_disturb}
#    [Teardown]      run keywords    close_call_ending_page     ${driver1}
#    ...             AND             user_switch_to_second_workspace    ${driver1}    ${Huiming_shi_Added_WS_another}
#    ...             AND             do_not_disturb_become_available     ${driver1}
#    ...             AND             exit_driver
##    ...             AND             exit_driver     ${driver1}    ${driver2}

#Small_range_687
#    [Documentation]     Join call via meeting call   Owner clicks on mhs link firstly
#    [Tags]    small range 687 line，有bug：https://vipaar.atlassian.net/browse/CITRON-3290        call_case
#    # Owner 登录
#    ${driver1}    driver_set_up_and_logIn    ${Expert_User1_username}     ${universal_password}
#    # 获取mhs link
#    ${invite_url}    send_meeting_room_link   ${driver1}  MHS   no_send
#    # Owner clicks on mhs link firstly
#    user_make_call_via_meeting_link    ${driver1}   ${invite_url}
#     # 确保建立call，但未接听
#     make_sure_enter_call    ${driver1}
#    # Owner sees message “You are attempting to join your own My Help Space, but there is no one else in the call.”
#    which_page_is_currently_on     ${driver1}      这块没法填写准确的xpath
#    [Teardown]      exit_driver
##    [Teardown]      exit_driver     ${driver1}

Small_range_688
    [Documentation]     Join call via meeting call   Owner clicks on otu link firstly
    [Tags]    small range 688 line      call_case
    # Owner 登录
    ${driver1}    driver_set_up_and_logIn    ${Expert_User1_username}     ${universal_password}
    # 获取otu link
    ${invite_url}    send_meeting_room_link   ${driver1}  OTU   no_send
    # first guest 登录
    ${driver2}    driver_set_up_and_logIn    ${Expert_User2_username}     ${universal_password}
    # Owner clicks on otu link firstly
    user_make_call_via_meeting_link    ${driver1}   ${invite_url}
    # 确保建立call，但未接听
    make_sure_enter_call    ${driver1}
    # The first guest clicks on otu link
    user_make_call_via_meeting_link    ${driver2}   ${invite_url}
    # 确保建立call，但未接听
    make_sure_enter_call    ${driver2}
    # Owner and the first guest auto joins call.
    exit_call     ${driver2}
    [Teardown]   exit_driver
#    [Teardown]   exit_driver    ${driver1}   ${driver2}