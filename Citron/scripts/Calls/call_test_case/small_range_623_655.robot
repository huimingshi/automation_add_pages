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
Small_range_623_two_users_login
    [Documentation]     check team list according to citron
    [Tags]    small range 623 line      call_case
    # User A 登录
    ${driver1}    driver_set_up_and_logIn    ${User_A_username}     ${universal_password}
    # team list for user A is:Quantum Mechanics (on-call group is marked with visual indication, email field is blank for web side)  Feynman  Gell-mann  User B  (the order to show from top to below: on-call groups  alphabetically, users in external and internal groups alphabetically
    check_contacts_list   ${driver1}    ${Quantum_Mechanics_group_name}   Huiming.shi.helplightning+Feynman    Huiming.shi.helplightning+Gell-mann    Huiming.shi.helplightning+User_B
    # on-call group is marked with visual indication
    ${css_value}   get_css_value   ${driver1}   ${first_data_background_color}     background-color
    two_option_is_equal    ${driver1}    rgba(160, 220, 238, 1)    ${css_value}
#    should be equal as strings    rgba(160, 220, 238, 1)    ${css_value}
    # Feynman 登录
    ${driver2}    driver_set_up_and_logIn    ${Feynman_username}     ${universal_password}
    # team list for Feynman is:null
    check_contacts_list   ${driver2}
    # user A searches on-call group with name
    different_page_search_single_users   ${driver1}   ${py_contacts_page}    ${py_input_search}    ${py_get_number_of_rows}    ${Quantum_Mechanics_group_name}
    [Teardown]   exit_driver
#    [Teardown]   exit_driver    ${driver1}    ${driver2}

Small_range_625_627
    [Documentation]     Pre-condition: expert A B and C belong to Workspace ws1     Expert A set on for on-Call option.
    [Tags]    small range 625-627 lines     call_case
    # Expert A 登录
    ${driver1}    driver_set_up_and_logIn    ${Expert_A_username}    ${universal_password}
    # User A 登录
    ${driver2}    driver_set_up_and_logIn    ${User_A_username}      ${universal_password}
    #-------------------------------------------------------------------------#
    # After logging in App, Reset the disclaimer in Citron.
    Login_premium_user                  # big_admin 登录
    switch_to_created_workspace      ${created_workspace}     # 选择我创建的WS
    enter_workspace_settings_page       # 进入settings页面
    expand_option_delete_user           # EXPAND delete user 选项
    set_disclaimer_is_on                # 设置Disclaimer为open状态
    set_delete_user_close               # 设置delete user为close状态
    reset_all_accepted_disclaimers      # Reset All Accepted Disclaimers
    Close                               # close browser
    #-------------------------------------------------------------------------#
    # Expert A receives an incoming from contact on-call group name.
    different_page_search_single_users    ${driver2}   ${py_contacts_page}    ${py_input_search}    ${py_get_number_of_rows}    ${Quantum_Mechanics_group_name}  # search on-call-group in Team page
    make_call_to_onCall     ${driver2}   ${driver1}    ${Quantum_Mechanics_group_name}
    # End Call.
    exit_call     ${driver2}
    # VP:Expert A shows his enterprise's Disclaimer window.
    refresh_browser_page    ${driver1}   no_care
    disclaimer_should_be_shown_up_or_not     ${driver1}
    # Expert A clicks Decline button. VP: Expert A returns to login page.
    user_decline_or_accept_disclaimer    ${driver1}
    which_page_is_currently_on   ${driver1}   ${login_page_username}
    # Expert A logs in App.VP: Disclaimer window is shown up.
    ${driver3}    driver_set_up_and_logIn    ${Expert_A_username}    ${universal_password}   no_check_toturial   no_care    no_care    no_care
    disclaimer_should_be_shown_up_or_not     ${driver3}
    # Expert A clicks Accept button.
    user_decline_or_accept_disclaimer    ${driver3}   accept
    [Teardown]      run keywords    Close
    ...             AND             exit_driver
#    ...             AND             exit_driver    ${driver1}    ${driver2}   ${driver3}

Small_range_628_629
    [Documentation]     Pre-condition: expert A B and C belong to Workspace ws1     Expert B set on  for on-Call option.
    [Tags]    small range 628-629 lines     call_case
    # Expert A 登录
    ${driver1}    driver_set_up_and_logIn    ${Expert_B_username}    ${universal_password}
    #-------------------------------------------------------------------------#
    # After logging in App, Reset the disclaimer in Citron.
    Login_premium_user                  # big_admin 登录
    switch_to_created_workspace       ${created_workspace}  # 选择我创建的WS
    enter_workspace_settings_page       # 进入settings页面
    expand_option_delete_user           # EXPAND delete user 选项
    set_disclaimer_is_on                # 设置Disclaimer为open状态
    set_delete_user_close               # 设置delete user为close状态
    reset_all_accepted_disclaimers      # Reset All Accepted Disclaimers
    Close                               # close browser
    #-------------------------------------------------------------------------#
    # Anonymous clicks Expert's universal link [https://[stage].cn/help?enterprise_id=1234&group_id=5678&name=test]
    ${driver2}    anonymous_open_meeting_link   https://app-stage.helplightning.net.cn/help?enterprise_id=6614&group_id=10690&group_name=Quantum+Mechanics    no_care    # Quantum+Mechanics这个group的On-Call Group Url
    # VP: Anonymous should pop up the expert's disclaimer before outgoing call window
    disclaimer_should_be_shown_up_or_not     ${driver2}
    #Anonymous clicks Accept button.
    user_decline_or_accept_disclaimer    ${driver2}      accept
    # 确保call连接成功，但未接听
    make_sure_enter_call   ${driver2}
    # VP: Anonymous enter the outgoing call window.
    which_page_is_currently_on    ${driver2}      ${end_call_before_anwser}
    # Expert B receives an incoming call from Anonymous.
    user_anwser_call     ${driver1}
    # End Call.
    exit_call    ${driver1}
    close_call_ending_page    ${driver1}
    # VP:Expert B shows his enterprise's Disclaimer window.
    refresh_browser_page    ${driver1}   no_care
    disclaimer_should_be_shown_up_or_not     ${driver1}
    # Expert B clicks Accept button.
    user_decline_or_accept_disclaimer    ${driver1}   accept
    # VP: Expert B returns to call end page. .
    which_page_is_currently_on    ${driver1}    ${tutorial_page_xpaths}
    [Teardown]      run keywords    Close
    ...             AND             exit_driver
#    ...             AND             exit_driver    ${driver1}    ${driver2}

Small_range_630_631
    [Documentation]     Pre-condition: expert A B and C belong to Workspace ws1     Expert C set on  for on-Call option.	Expert C is in call.
    [Tags]    small range 630-631 lines     call_case
    ###-----------------------------------------------------------------------------------###
    # 闲置的会先收到call，比如第一次 expert 1 join call，第二次expert 2会先收到incoming
    # 为确保流程会按照case所写的走下去，所以进行这一串操作
    # User B 登录   case中的customer
    ${driver11}    driver_set_up_and_logIn    ${User_B_username}     ${universal_password}
    # Expert B 登录
    ${driver22}    driver_set_up_and_logIn    ${Expert_B_username}    ${universal_password}
    # customer makes expert call via group name
    different_page_search_single_users    ${driver11}   ${py_contacts_page}    ${py_input_search}    ${py_get_number_of_rows}    ${Quantum_Mechanics_group_name}   # search on-call-group in Team page
    # expert A declines call
    make_call_to_onCall     ${driver11}   ${driver22}    ${Quantum_Mechanics_group_name}
    # 结束通话
    exit_call       ${driver11}
    # 退出driver
    exit_driver     ${driver11}    ${driver22}
    ###-----------------------------------------------------------------------------------###
    # User A 登录
    ${driver1}    driver_set_up_and_logIn    ${User_A_username}     ${universal_password}
    # Expert C 登录
    ${driver2}    driver_set_up_and_logIn    ${Expert_C_username}    ${universal_password}
    # Expert C is in call.
    different_page_search_single_users    ${driver1}   ${py_contacts_page}    ${py_input_search}    ${py_get_number_of_rows}    ${Quantum_Mechanics_group_name}   # search on-call-group in Team page
    make_call_to_onCall     ${driver1}   ${driver2}    ${Quantum_Mechanics_group_name}
    # User B 登录   case中的customer
    ${driver3}    driver_set_up_and_logIn    ${User_B_username}     ${universal_password}
    # Expert A 登录
    ${driver4}    driver_set_up_and_logIn    ${Expert_A_username}    ${universal_password}
    switch_to_diffrent_page   ${driver4}   ${py_recents_page}     ${py_recents_switch_success}    ${py_get_number_of_rows}   # Expert A 切换到Recents页面
    ${occurred_time_list}    get_recents_page_records_occurred_time    ${driver4}           # 获取Recents页面前两行call记录的时间
    # Expert B 登录
    ${driver5}    driver_set_up_and_logIn    ${Expert_B_username}    ${universal_password}
    # customer makes expert call via group name
    different_page_search_single_users    ${driver3}   ${py_contacts_page}    ${py_input_search}    ${py_get_number_of_rows}    ${Quantum_Mechanics_group_name}   # search on-call-group in Team page
    # expert A declines call
    make_call_to_onCall     ${driver3}   ${driver4}    ${Quantum_Mechanics_group_name}    no_accept
    # VP: Expert A No disclaimer window since he has accepted it.
    disclaimer_should_be_shown_up_or_not    ${driver4}    not_appear
    # expert B receives incoming call，expert B declines call
    user_decline_call   ${driver5}
    # VP: Expert B No disclaimer window since he has accepted it.
    disclaimer_should_be_shown_up_or_not    ${driver5}    not_appear      2
#    exit_one_driver    ${driver5}
    # VP: customer gets message "No Experts are currently available to take your call."
    which_page_is_currently_on    ${driver3}     ${no_experts_are_available}
    # Expert A 刷新Recents页面
    refresh_browser_page    ${driver4}
    ${occurred_time_list_1}    get_recents_page_records_occurred_time    ${driver4}           # 获取Recents页面前两行call记录的时间
    two_list_has_one_same_element    ${driver4}   ${occurred_time_list}    ${occurred_time_list_1}
    # 结束call
    exit_call       ${driver2}
    [Teardown]      exit_driver
#    [Teardown]      exit_driver     ${driver1}    ${driver2}    ${driver3}    ${driver4}

Small_range_632
    [Documentation]     Pre-condition: expert A B and C belong to Workspace ws1      Expert C set on  for on-Call option.	Expert C is in call.
    [Tags]    small range 632 line      call_case
    ###-----------------------------------------------------------------------------------###
    # 闲置的会先收到call，比如第一次 expert 1 join call，第二次expert 2会先收到incoming
    # 为确保流程会按照case所写的走下去，所以进行这一串操作
    # User B 登录   case中的customer
    ${driver11}    driver_set_up_and_logIn    ${User_B_username}     ${universal_password}
    # Expert B 登录
    ${driver22}    driver_set_up_and_logIn    ${Expert_B_username}    ${universal_password}
    # customer makes expert call via group name
    different_page_search_single_users    ${driver11}   ${py_contacts_page}    ${py_input_search}    ${py_get_number_of_rows}    ${Quantum_Mechanics_group_name}   # search on-call-group in Team page
    # expert A declines call
    make_call_to_onCall     ${driver11}   ${driver22}    ${Quantum_Mechanics_group_name}
    # 结束通话
    exit_call       ${driver11}
    # 退出driver
    exit_driver     ${driver11}    ${driver22}
    ###-----------------------------------------------------------------------------------###
    # User A 登录
    ${driver1}    driver_set_up_and_logIn    ${User_A_username}     ${universal_password}
    # Expert C 登录
    ${driver2}    driver_set_up_and_logIn    ${Expert_C_username}    ${universal_password}
    # Expert C is in call.
    different_page_search_single_users    ${driver1}   ${py_contacts_page}    ${py_input_search}    ${py_get_number_of_rows}    ${Quantum_Mechanics_group_name}   # search on-call-group in Team page
    make_call_to_onCall     ${driver1}   ${driver2}    ${Quantum_Mechanics_group_name}
    # User B 登录   case中的customer
    ${driver3}    driver_set_up_and_logIn    ${User_B_username}     ${universal_password}
    # Expert A 登录
    ${driver4}    driver_set_up_and_logIn    ${Expert_A_username}    ${universal_password}
    switch_to_diffrent_page   ${driver4}   ${py_recents_page}     ${py_recents_switch_success}    ${py_get_number_of_rows}   # Expert A 切换到Recents页面
    ${occurred_time_list}    get_recents_page_records_occurred_time    ${driver4}           # 获取Recents页面前两行call记录的时间
    # Expert B 登录
    ${driver5}    driver_set_up_and_logIn    ${Expert_B_username}    ${universal_password}
    # customer makes expert call via group name
    different_page_search_single_users    ${driver3}   ${py_contacts_page}    ${py_input_search}    ${py_get_number_of_rows}    ${Quantum_Mechanics_group_name}   # search on-call-group in Team page
    # expert A no answer call
    make_call_to_onCall     ${driver3}   ${driver4}    ${Quantum_Mechanics_group_name}       no_care
    # expert B receives incoming call after timeout 40s,expert B answers call
    sleep  30s
    user_anwser_call     ${driver5}
    # VP: expert B enter call view
    which_page_is_currently_on     ${driver5}    ${end_call_button}
    #expert C should not receive incoming call
    which_page_is_currently_on     ${driver2}    ${end_call_button}
    # Expert A 刷新Recents页面
    refresh_browser_page    ${driver4}
    ${occurred_time_list_1}    get_recents_page_records_occurred_time    ${driver4}           # 获取Recents页面前两行call记录的时间
    two_list_has_one_same_element    ${driver4}   ${occurred_time_list}    ${occurred_time_list_1}
    [Teardown]      run keywords    exit_call       ${driver2}
    ...             AND             exit_call       ${driver3}
    ...             AND             exit_driver     ${driver1}    ${driver2}    ${driver3}    ${driver4}    ${driver5}
    # Verify: In Citron -> Admin -> Calls, the participant’s name should correctly shows up
    # big_admin 登录
    ...             AND             Login_premium_user
    # 选择我创建的WS
    ...             AND             switch_to_created_workspace     ${created_workspace}
    # 进入Calls页面
    ...             AND             enter_workspace_calls_page
    # 查看第一条通话记录
    ...             AND             enter_which_call_details    0
    ...             AND             check_details_participant_count    2
    ...             AND             check_details_participant_name       ${Expert_B_name}
    ...             AND             check_details_participant_name       ${User_B_name}
    ...             AND             close_call_details
    # 查看第二条通话记录
    ...             AND             enter_which_call_details    1
    ...             AND             check_details_participant_count    2
    ...             AND             check_details_participant_name       ${Expert_C_name}
    ...             AND             check_details_participant_name       ${User_A_name}
    ...             AND             close_call_details
    ...             AND             Close

Small_range_633
    [Documentation]     Pre-condition: expert A B and C belong to Workspace ws1      Expert C set on  for on-Call option.	Expert C is in call.
    [Tags]    small range 633 line      call_case
    ###-----------------------------------------------------------------------------------###
    # 闲置的会先收到call，比如第一次 expert 1 join call，第二次expert 2会先收到incoming
    # 为确保流程会按照case所写的走下去，所以进行这一串操作
    # User B 登录   case中的customer
    ${driver11}    driver_set_up_and_logIn    ${User_B_username}     ${universal_password}
    # Expert B 登录
    ${driver22}    driver_set_up_and_logIn    ${Expert_B_username}    ${universal_password}
    # customer makes expert call via group name
    different_page_search_single_users    ${driver11}   ${py_contacts_page}    ${py_input_search}    ${py_get_number_of_rows}    ${Quantum_Mechanics_group_name}   # search on-call-group in Team page
    # expert A declines call
    make_call_to_onCall     ${driver11}   ${driver22}    ${Quantum_Mechanics_group_name}
    # 结束通话
    exit_call       ${driver11}
    # 退出driver
    exit_driver     ${driver11}    ${driver22}
    ###-----------------------------------------------------------------------------------###
    # User A 登录
    ${driver1}    driver_set_up_and_logIn    ${User_A_username}     ${universal_password}
    # Expert C 登录
    ${driver2}    driver_set_up_and_logIn    ${Expert_C_username}    ${universal_password}
    # Expert C is in call.
    different_page_search_single_users    ${driver1}   ${py_contacts_page}    ${py_input_search}    ${py_get_number_of_rows}    ${Quantum_Mechanics_group_name}   # search on-call-group in Team page
    make_call_to_onCall     ${driver1}   ${driver2}    ${Quantum_Mechanics_group_name}
    # User B 登录   case中的customer
    ${driver3}    driver_set_up_and_logIn    ${User_B_username}     ${universal_password}
    # Expert A 登录
    ${driver4}    driver_set_up_and_logIn    ${Expert_A_username}    ${universal_password}
    switch_to_diffrent_page   ${driver4}   ${py_recents_page}     ${py_recents_switch_success}    ${py_get_number_of_rows}   # Expert A 切换到Recents页面
    ${occurred_time_list}    get_recents_page_records_occurred_time    ${driver4}           # 获取Recents页面前两行call记录的时间
    # Expert B 登录
    ${driver5}    driver_set_up_and_logIn    ${Expert_B_username}    ${universal_password}
    # customer makes expert call via group name
    different_page_search_single_users    ${driver3}   ${py_contacts_page}    ${py_input_search}    ${py_get_number_of_rows}    ${Quantum_Mechanics_group_name}   # search on-call-group in Team page
    # expert A answers call
    make_call_to_onCall     ${driver3}   ${driver4}    ${Quantum_Mechanics_group_name}
    # VP: expert A enter call view
    which_page_is_currently_on     ${driver4}    ${end_call_button}
    # other experts should not receive incoming call
    which_page_is_currently_on     ${driver5}    ${contacts_page_send_email}
    which_page_is_currently_on     ${driver2}    ${end_call_button}
    # 结束Call
    exit_call       ${driver2}
    exit_call       ${driver3}
    # Expert A 关闭通话结束页面
    close_call_ending_page    ${driver4}
    # Expert A 刷新Recents页面
    refresh_browser_page    ${driver4}
    ${occurred_time_list_1}    get_recents_page_records_occurred_time    ${driver4}           # 获取Recents页面前两行call记录的时间
    two_list_has_one_same_element    ${driver4}   ${occurred_time_list}    ${occurred_time_list_1}
    [Teardown]      exit_driver
#    [Teardown]      exit_driver     ${driver1}    ${driver2}    ${driver3}    ${driver4}    ${driver5}

Small_range_634
    [Documentation]     Pre-condition: expert A B and C belong to Workspace ws1      Expert C set on  for on-Call option.	Expert C is in call.
    [Tags]    small range 634 line      call_case
    ###-----------------------------------------------------------------------------------###
    # 闲置的会先收到call，比如第一次 expert 1 join call，第二次expert 2会先收到incoming
    # 为确保流程会按照case所写的走下去，所以进行这一串操作
    # User B 登录   case中的customer
    ${driver11}    driver_set_up_and_logIn    ${User_B_username}     ${universal_password}
    # Expert B 登录
    ${driver22}    driver_set_up_and_logIn    ${Expert_B_username}    ${universal_password}
    # customer makes expert call via group name
    different_page_search_single_users    ${driver11}   ${py_contacts_page}    ${py_input_search}    ${py_get_number_of_rows}    ${Quantum_Mechanics_group_name}   # search on-call-group in Team page
    # expert A declines call
    make_call_to_onCall     ${driver11}   ${driver22}    ${Quantum_Mechanics_group_name}
    # 结束通话
    exit_call       ${driver11}
    # 退出driver
    exit_driver     ${driver11}    ${driver22}
    ###-----------------------------------------------------------------------------------###
    # User A 登录
    ${driver1}    driver_set_up_and_logIn    ${User_A_username}     ${universal_password}
    # Expert C 登录
    ${driver2}    driver_set_up_and_logIn    ${Expert_C_username}    ${universal_password}
    # Expert C is in call.
    different_page_search_single_users    ${driver1}   ${py_contacts_page}    ${py_input_search}    ${py_get_number_of_rows}    ${Quantum_Mechanics_group_name}   # search on-call-group in Team page
    make_call_to_onCall     ${driver1}   ${driver2}    ${Quantum_Mechanics_group_name}
    # User B 登录   case中的customer
    ${driver3}    driver_set_up_and_logIn    ${User_B_username}     ${universal_password}
    # Expert A 登录
    ${driver4}    driver_set_up_and_logIn    ${Expert_A_username}    ${universal_password}
    switch_to_diffrent_page   ${driver4}   ${py_recents_page}     ${py_recents_switch_success}    ${py_get_number_of_rows}   # Expert A 切换到Recents页面
    ${occurred_time_list}    get_recents_page_records_occurred_time    ${driver4}           # 获取Recents页面前两行call记录的时间
    # Expert B 登录
    ${driver5}    driver_set_up_and_logIn    ${Expert_B_username}    ${universal_password}
    # customer makes expert call via group name
    different_page_search_single_users    ${driver3}   ${py_contacts_page}    ${py_input_search}    ${py_get_number_of_rows}    ${Quantum_Mechanics_group_name}   # search on-call-group in Team page
    # expert A not care call
    make_call_to_onCall     ${driver3}   ${driver4}    ${Quantum_Mechanics_group_name}    no_care
    # customer cancels call
    user_end_call_by_self   ${driver3}
    # VP: No expert has incoming call anymore.
    which_page_is_currently_on     ${driver5}    ${contacts_page_send_email}
    which_page_is_currently_on     ${driver4}    ${recents_page_tag}
    which_page_is_currently_on     ${driver2}    ${end_call_button}
    # Expert A 刷新Recents页面
    refresh_browser_page    ${driver4}
    ${occurred_time_list_1}    get_recents_page_records_occurred_time    ${driver4}           # 获取Recents页面前两行call记录的时间
    two_list_has_one_same_element    ${driver4}   ${occurred_time_list}    ${occurred_time_list_1}
    # 结束call
    exit_call       ${driver2}
    [Teardown]      exit_driver
#    [Teardown]      exit_driver     ${driver1}    ${driver2}    ${driver3}    ${driver4}    ${driver5}

Small_range_636
    [Documentation]     Pre-condition: expert A B and C belong to Workspace ws1      check recent call	   3pc
    [Tags]    small range 636 line      call_case
    # User A 登录
    ${driver1}    driver_set_up_and_logIn    ${User_Aa_username}     ${universal_password}
    # Expert 登录
    ${driver2}    driver_set_up_and_logIn    ${Expert_Bb_username}    ${universal_password}
    # expert and user A are in a call
    different_page_search_single_users    ${driver1}   ${py_contacts_page}    ${py_input_search}    ${py_get_number_of_rows}    ${another_on_call_group_name}   # search on-call-group in Team page
    make_call_to_onCall     ${driver1}   ${driver2}    ${another_on_call_group_name}
    # User B 登录
    ${driver3}    driver_set_up_and_logIn    ${User_Bb_username}     ${universal_password}
    # expert invites user B
    which_page_is_currently_on    ${driver2}    ${end_call_button}
    enter_contacts_search_user    ${driver2}     ${User_Bb_name}
    click_user_in_contacts_call     ${driver2}    ${User_Bb_name}
    # user B answers call
    user_anwser_call    ${driver3}
    # expert leaves call
    leave_call    ${driver2}
    # then user A leaves call
    exit_call   ${driver1}    10
    # 关闭通话结束展示页面
    close_call_ending_page     ${driver1}
    close_call_ending_page     ${driver2}
    close_call_ending_page     ${driver3}
    # 进入到Recents页面
    switch_to_diffrent_page   ${driver1}   ${py_recents_page}     ${py_recents_switch_success}    ${py_get_number_of_rows}
    switch_to_diffrent_page   ${driver2}   ${py_recents_page}     ${py_recents_switch_success}    ${py_get_number_of_rows}
    switch_to_diffrent_page   ${driver3}   ${py_recents_page}     ${py_recents_switch_success}    ${py_get_number_of_rows}
    # expert side:  user A and user B
    verify_username_in_recents_page     ${driver2}    ${User_Bb_name}     ${User_Aa_name}
    #user A: on-call group name
    verify_username_in_recents_page     ${driver1}    ${another_on_call_group_name}
    #user B: expert name
    verify_username_in_recents_page     ${driver3}    ${Expert_Bb_name}
    [Teardown]     exit_driver
#    [Teardown]     exit_driver    ${driver1}   ${driver2}   ${driver3}

Small_range_637_642
    [Documentation]     Pre-condition: expert A B and C belong to Workspace ws1      check recent call	   3pc
    [Tags]    small range 637+642 lines     call_case
    # User A 登录
    ${driver1}    driver_set_up_and_logIn    ${User_Aa_username}     ${universal_password}
    # Expert 登录
    ${driver2}    driver_set_up_and_logIn    ${Expert_Bb_username}    ${universal_password}
    # expert and user A are in a call
    different_page_search_single_users    ${driver1}   ${py_contacts_page}    ${py_input_search}    ${py_get_number_of_rows}    ${another_on_call_group_name}   # search on-call-group in Team page
    make_call_to_onCall     ${driver1}   ${driver2}    ${another_on_call_group_name}
    # User B 登录
    ${driver3}    driver_set_up_and_logIn    ${User_Bb_username}     ${universal_password}
    # expert invites user B
    which_page_is_currently_on    ${driver2}    ${end_call_button}
    enter_contacts_search_user    ${driver2}     ${User_Bb_name}
    click_user_in_contacts_call     ${driver2}    ${User_Bb_name}
    # user B declines call
    user_decline_call    ${driver3}
    # user A leaves call
    exit_call   ${driver1}    10
    # 关闭通话结束展示页面
    close_call_ending_page     ${driver1}
    close_call_ending_page     ${driver2}
    # 进入到Recents页面
    switch_to_diffrent_page   ${driver1}   ${py_recents_page}     ${py_recents_switch_success}    ${py_get_number_of_rows}
    switch_to_diffrent_page   ${driver2}   ${py_recents_page}     ${py_recents_switch_success}    ${py_get_number_of_rows}
    switch_to_diffrent_page   ${driver3}   ${py_recents_page}     ${py_recents_switch_success}    ${py_get_number_of_rows}
    # expert side:  user A and user B
    verify_username_in_recents_page     ${driver2}    ${User_Bb_name}     ${User_Aa_name}
    #user A: on-call group name
    verify_username_in_recents_page     ${driver1}    ${another_on_call_group_name}
    #user B: expert name
    verify_username_in_recents_page     ${driver3}    ${Expert_Bb_name}
    # customer clicks on on-call group name
    refresh_browser_page   ${driver1}
    can_connect_call_or_not    ${driver1}    ${another_on_call_group_name}   can_connect    no_send_invite
    # the same customer receives incoming call	customer accepts call
    user_anwser_call    ${driver2}
    # enter call view
    exit_call   ${driver1}
    [Teardown]     exit_driver
#    [Teardown]     exit_driver    ${driver1}   ${driver2}   ${driver3}

Small_range_638_640
    [Documentation]     Pre-condition: expert A B and C belong to Workspace ws1      check recent call	   3pc
    [Tags]    small range 638+640 lines     call_case
    # User A 登录
    ${driver1}    driver_set_up_and_logIn    ${User_Aa_username}     ${universal_password}
    # Expert 登录
    ${driver2}    driver_set_up_and_logIn    ${Expert_Bb_username}    ${universal_password}
    # expert and user A are in a call
    different_page_search_single_users    ${driver1}   ${py_contacts_page}    ${py_input_search}    ${py_get_number_of_rows}    ${another_on_call_group_name}   # search on-call-group in Team page
    make_call_to_onCall     ${driver1}   ${driver2}    ${another_on_call_group_name}
    # User C 登录
    ${driver3}    driver_set_up_and_logIn    ${User_Cc_username}     ${universal_password}
    # user A invites user C
    which_page_is_currently_on    ${driver1}    ${end_call_button}
    enter_contacts_search_user    ${driver1}     ${User_Cc_name}
    click_user_in_contacts_call     ${driver1}    ${User_Cc_name}
    # user B answers call
    user_anwser_call    ${driver3}
    # expert leaves call
    leave_call    ${driver2}
    # then user C leaves call
    exit_call   ${driver3}    10
    # 关闭通话结束展示页面
    close_call_ending_page     ${driver1}
    close_call_ending_page     ${driver2}
    close_call_ending_page     ${driver3}
    # 进入到Recents页面
    switch_to_diffrent_page   ${driver1}   ${py_recents_page}     ${py_recents_switch_success}    ${py_get_number_of_rows}
    switch_to_diffrent_page   ${driver2}   ${py_recents_page}     ${py_recents_switch_success}    ${py_get_number_of_rows}
    switch_to_diffrent_page   ${driver3}   ${py_recents_page}     ${py_recents_switch_success}    ${py_get_number_of_rows}
    # expert side:  user A and user B
    verify_username_in_recents_page     ${driver2}    ${User_Aa_name}
    #user A: on-call group name
    verify_username_in_recents_page     ${driver1}    ${User_Cc_name}     ${another_on_call_group_name}
    #user B: expert name
    verify_username_in_recents_page     ${driver3}    ${User_Aa_name}
    # make call via recent tab	expert clicks on customer's name
    refresh_browser_page   ${driver3}
    can_connect_call_or_not    ${driver3}   ${User_Aa_name}   can_connect    no_send_invite
    # the same customer receives incoming call	customer accepts call
    user_anwser_call    ${driver1}
    # enter call view
    exit_call   ${driver3}
    [Teardown]     exit_driver
#    [Teardown]     exit_driver    ${driver1}   ${driver2}   ${driver3}

Small_range_639
    [Documentation]     Pre-condition: expert A B and C belong to Workspace ws1      check recent call	   3pc
    [Tags]    small range 639 line      call_case
    # User A 登录
    ${driver1}    driver_set_up_and_logIn    ${User_Aa_username}     ${universal_password}
    # Expert 登录
    ${driver2}    driver_set_up_and_logIn    ${Expert_Bb_username}    ${universal_password}
    # expert and user A are in a call
    different_page_search_single_users    ${driver1}   ${py_contacts_page}    ${py_input_search}    ${py_get_number_of_rows}    ${another_on_call_group_name}   # search on-call-group in Team page
    make_call_to_onCall     ${driver1}   ${driver2}    ${another_on_call_group_name}
    # User C 登录
    ${driver3}    driver_set_up_and_logIn    ${User_Cc_username}     ${universal_password}
    # user A invites user C
    which_page_is_currently_on    ${driver1}    ${end_call_button}
    enter_contacts_search_user    ${driver1}     ${User_Cc_name}
    click_user_in_contacts_call     ${driver1}    ${User_Cc_name}
    # user C doesn't answer call
    # user A leaves call
    exit_call   ${driver1}    10
    # 关闭通话结束展示页面
    close_call_ending_page     ${driver1}
    close_call_ending_page     ${driver2}
    # 进入到Recents页面
    switch_to_diffrent_page   ${driver1}   ${py_recents_page}     ${py_recents_switch_success}    ${py_get_number_of_rows}
    switch_to_diffrent_page   ${driver2}   ${py_recents_page}     ${py_recents_switch_success}    ${py_get_number_of_rows}
    user_decline_call    ${driver3}
    switch_to_diffrent_page   ${driver3}   ${py_recents_page}     ${py_recents_switch_success}    ${py_get_number_of_rows}
    # expert side:  user A and user B
    verify_username_in_recents_page     ${driver2}    ${User_Aa_name}
    #user A: on-call group name
    verify_username_in_recents_page     ${driver1}    ${User_Cc_name}     ${another_on_call_group_name}
    #user B: expert name
    verify_username_in_recents_page     ${driver3}    ${User_Aa_name}
    [Teardown]     exit_driver
#    [Teardown]     exit_driver    ${driver1}   ${driver2}   ${driver3}

Small_range_646
    [Documentation]     Pre-condition: expert A B and C belong to Workspace ws1      Citron site admin add expert A to another workspace WS2
    [Tags]    small range 646 line      call_case
    #------------------------------------------------------------------------------------------------------#
    # 闲置的会先收到call，比如第一次 expert 1 join call，第二次expert 2会先收到incoming
    # 为确保流程会按照case所写的走下去，所以进行这一串操作
    # User of WS1 登录
    ${driver1}    driver_set_up_and_logIn    ${User_Aa_username}     ${universal_password}
    # expert A 登录
    ${driver3}    driver_set_up_and_logIn    ${Expert_Aa_username}    ${universal_password}
    make_call_to_onCall     ${driver1}   ${driver3}    ${another_on_call_group_name}
    exit_call    ${driver3}
    close_call_ending_page  ${driver1}
    close_call_ending_page  ${driver3}
    #------------------------------------------------------------------------------------------------------#
    # other experts 登录
    ${driver2}    driver_set_up_and_logIn    ${Expert_Bb_username}    ${universal_password}
    # Expert A switch to WS2
    user_switch_to_second_workspace    ${driver3}    BigAdmin Premium
    # User of WS1 directly click on-call group name in contact list
    make_call_to_onCall     ${driver1}   ${driver2}    ${another_on_call_group_name}    no_care
    # VP: If other experts do not answer call, Expert A will receive incoming call
    sleep  30s
    # Expert A answer call
    user_anwser_call     ${driver3}
    # VP: Expert A can successfully enter Face to Face mode
    exit_call    ${driver3}
    [Teardown]     exit_driver
#    [Teardown]     exit_driver    ${driver1}   ${driver2}   ${driver3}

Small_range_647_648_649_650
    [Documentation]     3PI - Expert call
    [Tags]    small range 647+648+649+650 lines     call_case
    # EU1 登录
    ${driver1}    driver_set_up_and_logIn    ${Expert_User1_username}     ${universal_password}
    # expertA 登录
    ${driver2}    driver_set_up_and_logIn    ${Expert_AaA_username}    ${universal_password}
    # EU1 call on-call group from Team contacts
    different_page_search_single_users    ${driver1}   ${py_contacts_page}    ${py_input_search}    ${py_get_number_of_rows}    ${AaA_on_call_group_name}   # search on-call-group in Team page
    make_call_to_onCall     ${driver1}   ${driver2}    ${AaA_on_call_group_name}
    # expertB 登录
    ${driver3}    driver_set_up_and_logIn    ${Expert_BbB_username}    ${universal_password}
    # EU1 invite on-call group
    which_page_is_currently_on    ${driver1}    ${end_call_button}
    enter_contacts_search_user    ${driver1}     ${AaA_on_call_group_name}
    click_user_in_contacts_call     ${driver1}    ${AaA_on_call_group_name}
    # expertB answer rollover call
    user_anwser_call    ${driver3}
    # # VP: 3PC call established successfully
    end_call_for_all    ${driver1}
    [Teardown]     exit_driver
#    [Teardown]      exit_driver         ${driver1}   ${driver2}   ${driver3}

Small_range_651_652_653
    [Documentation]     3PI - Expert call
    [Tags]    small range 651+652+653 lines     call_case
    # EU1 登录
    ${driver1}    driver_set_up_and_logIn    ${Expert_User1_username}     ${universal_password}
    # expertA 登录
    ${driver2}    driver_set_up_and_logIn    ${Expert_AaA_username}    ${universal_password}
    # EU1 call on-call group from Team contacts
    different_page_search_single_users    ${driver1}   ${py_contacts_page}    ${py_input_search}    ${py_get_number_of_rows}    ${AaA_on_call_group_name}   # search on-call-group in Team page
    make_call_to_onCall     ${driver1}   ${driver2}    ${AaA_on_call_group_name}
    # expertA send 3PI link to anonymous user
    which_page_is_currently_on    ${driver2}    ${end_call_button}
    ${invite_url}   send_invite_in_calling_page    ${driver2}
    close_invite_3th_page    ${driver2}
    # Anonymous user click 3PI link
    ${driver3}   anonymous_open_meeting_link    ${invite_url}
    # 确保call连接成功，但未接听
    make_sure_enter_call   ${driver3}
    # VP:expertA receive Accept dialog
    user_anwser_call    ${driver2}    no_direct
    # VP: 3PC call established successfully
    end_call_for_all    ${driver2}
    [Teardown]     exit_driver
#    [Teardown]      exit_driver         ${driver1}   ${driver2}   ${driver3}

Small_range_654_655
    [Documentation]     3PI - Expert call
    [Tags]    small range 654+655 lines     call_case
    # TU1 登录
    ${driver1}    driver_set_up_and_logIn    ${Team_User1_username}     ${universal_password}
    # expertA 登录
    ${driver2}    driver_set_up_and_logIn    ${Expert_AaA_username}    ${universal_password}
    # TU1 call on-call group via expert link
    user_make_call_via_meeting_link    ${driver1}    https://app-stage.helplightning.net.cn/help?enterprise_id=6614&group_id=10705&group_name=Expert_AaA_on_call_group     # Expert_AaA_on_call_group这个group的On-Call Group Url
    # 确保建立call，但未接听
    make_sure_enter_call    ${driver1}
    # expertA answer call
    user_anwser_call   ${driver2}
    # EU2 登录
    ${driver3}    driver_set_up_and_logIn    ${Expert_User2_username}     ${universal_password}
    # TU1 invite EU2
    which_page_is_currently_on    ${driver1}    ${end_call_button}
    enter_contacts_search_user    ${driver1}     ${Expert_User2_name}
    click_user_in_contacts_call     ${driver1}    ${Expert_User2_name}
    # EU2 clicks answer button to join call
    user_anwser_call   ${driver3}
    # VP: Expert A and TU1 should not show accept/decline dialog window
    disclaimer_should_be_shown_up_or_not   ${driver2}  not_appear
    disclaimer_should_be_shown_up_or_not   ${driver1}  not_appear
    # VP: 3PC call established successfully
    end_call_for_all    ${driver1}
    [Teardown]     exit_driver
#    [Teardown]      exit_driver         ${driver1}   ${driver2}   ${driver3}