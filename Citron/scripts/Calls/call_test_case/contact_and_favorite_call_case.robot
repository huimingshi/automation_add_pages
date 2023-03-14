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
Library           call_python_Lib/finish_call.py
Library           call_python_Lib/about_call.py
Library           call_python_Lib/contacts_page.py

*** Test Cases ***
Favorite_tap_group_name_to_start_expert_call
    [Documentation]    tap group name to start expert call in Favorite
    [Tags]    citron 35 line     call_case
    [Setup]     run keywords    Login_new_added_user   ${call_oncall_user_username}    # 登录
    ...         AND             add_to_favorite        on-call group 1  # 保证on-call group已添加favorite
    ...         AND             Close                  # 关闭driver
    # call on-call User log in
    ${driver1}  driver_set_up_and_logIn  ${call_oncall_user_username}
    # on-call User log in
    ${driver2}  driver_set_up_and_logIn  ${oncall_user_username}
    # 进入favorite页面
    switch_to_diffrent_page   ${driver1}   ${py_favorites_page}   ${py_favorites_switch_success}    ${py_get_number_of_rows}
    # make call with on-call
    contacts_witch_page_make_call   ${driver1}   ${driver2}   ${py_favorites_page}
    [Teardown]   run keywords    Close
    ...          AND             exit_driver

Send_meeting_room_link_By_Premium_User
    [Documentation]    Send meeting room link By Premium User
    [Tags]    citron 25 line     call_case
    # Premium User log in
    ${driver}  driver_set_up_and_logIn  ${crunch_site_username}   ${crunch_site_password}
    # Premium User Send meeting room link
    ${invite_url}    send_meeting_room_link   ${driver}   ${MHS_link_email}
    # anonymous open meeting link with website
    ${driver1}   anonymous_open_meeting_link    ${invite_url}
    # Premium User Aneser call
    user_anwser_call   ${driver}
    [Teardown]   exit_driver

Send_meeting_room_link_By_Enterprise_User
    [Documentation]    Send meeting room link By Enterprise User
    [Tags]    citron 26 line     call_case
    # Enterprise User log in
    ${driver}  driver_set_up_and_logIn  ${enterprise_username}   ${enterprise_password}
    # Enterprise User Send meeting room link
    ${invite_url}     send_meeting_room_link   ${driver}    ${MHS_link_email}
    # anonymous open meeting link with website
    ${driver1}  anonymous_open_meeting_link    ${invite_url}
    # Enterprise User Aneser call
    user_anwser_call   ${driver}
    [Teardown]   exit_driver

Send_one_time_meeting_room_link_By_Premium_User
    [Documentation]    Send  one-time meeting room link By Premium User
    [Tags]    citron 27 line     call_case
    # Premium User log in
    ${driver}  driver_set_up_and_logIn   ${crunch_site_username}   ${crunch_site_password}
    # Premium User Send meeting room link
    ${invite_url}    send_meeting_room_link   ${driver}   ${OTU_link_email}
    # anonymous open meeting link with website
    ${driver1}   anonymous_open_meeting_link    ${invite_url}
    # Premium User Aneser then exit call
    user_anwser_call   ${driver}
    [Teardown]   exit_driver

Send_one_time_meeting_room_link_By_Enterprise_User
    [Documentation]    Send  one-time meeting room link By Enterprise User
    [Tags]    citron 28 line     call_case
    # Enterprise User log in
    ${driver}  driver_set_up_and_logIn  ${enterprise_username}   ${enterprise_password}
    # Enterprise User Send meeting room link
    ${invite_url}     send_meeting_room_link   ${driver}   ${OTU_link_email}
    # anonymous open meeting link with website
    ${driver1}   anonymous_open_meeting_link    ${invite_url}
    # Enterprise User Aneser then exit call
    user_anwser_call   ${driver}
    [Teardown]   exit_driver

Set_Survey_off_Make_a_call_After_ending_call_No_Take_Survey_button
    [Documentation]    Set Survey off	Make a call via Citron & Client	After ending call	VP: No Take Survey button.
    [Tags]    citron 59 line     call_case
    [Setup]    set_survey_close_setUp
    # Start two drivers and logIn
    ${driver1}   driver_set_up_and_logIn    ${normal_username_for_calls}
    ${driver2}   driver_set_up_and_logIn    ${normal_username_for_calls_B}
    # make call
    contacts_witch_page_make_call    ${driver1}    ${driver2}    ${py_team_page}    ${normal_name_for_calls_B}
    # call on-call User exit call
    exit_call  ${driver1}
    # No Take Survey button
    check_survey_switch_success   ${driver1}
    [Teardown]      run keywords     Close
    ...             AND              exit_driver

Set_Survey_ON_and_set_URL_is_Null_Make_a_call_After_ending_call_No_Take_Survey_button
    [Documentation]    Set Survey on  Set URL=Null	Make a call via Citron & Client	After ending call	VP: No Take Survey button.
    [Tags]    citron 63 line   ，有bug：https://vipaar.atlassian.net/browse/CITRON-3344，MAC系统的Chrome浏览器不能设置Survey URL为空值        call_case
    [Setup]   set_survey_open_and_null
    # Start two drivers and logIn
    ${driver1}   driver_set_up_and_logIn    ${normal_username_for_calls}
    ${driver2}   driver_set_up_and_logIn    ${normal_username_for_calls_B}
    # make call
    contacts_witch_page_make_call     ${driver1}    ${driver2}   ${py_team_page}     ${normal_name_for_calls_B}
    # call on-call User exit call
    exit_call  ${driver1}
    # No Take Survey button
    check_survey_switch_success   ${driver1}
    [Teardown]   run keywords    Close
    ...          AND             exit_driver