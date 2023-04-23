*** Settings ***
Library           Selenium2Library
Library           OperatingSystem
Resource          ../../../Lib/public.robot
Library           call_python_Lib/call_action_lib_copy.py
Resource          ../../../Lib/calls_resource.robot
Resource          ../../../Lib/All_Pages_Xpath/Normal/load_file.robot
Library           call_python_Lib/in_call_info.py
Library           call_python_Lib/login_lib.py
Library           call_python_Lib/about_call.py
Library           call_python_Lib/finish_call.py
Library           call_python_Lib/else_public_lib.py
Library           call_python_Lib/call_check_lib.py
Library           call_python_Lib/contacts_page.py
Force Tags        call_case     new_call_case


*** Test Cases ***
6PC_direct_call
    [Documentation]       Screen capture -6pc
    [Tags]     6pc tag
    [Setup]     delete_picture_jpg_file
    comment     Cooperation mode
    # 6PC direct call
    ${driver_UA}     driver_set_up_and_logIn     ${message_test0_user}
    ${driver_UB}     driver_set_up_and_logIn     ${message_test1_user}
    contacts_witch_page_make_call       ${driver_UA}   ${driver_UB}   ${py_team_page}   ${message_test1_username}
    make_sure_enter_call                ${driver_UB}
    ${invite_url}     send_new_invite_in_calling    ${driver_UB}
    ${driver_UC}     driver_set_up_and_logIn     ${message_test2_user}
    user_make_call_via_meeting_link     ${driver_UC}   ${invite_url}
    ${driver_UD}     driver_set_up_and_logIn     ${message_test3_user}
    user_make_call_via_meeting_link     ${driver_UD}   ${invite_url}
    ${driver_UE}     driver_set_up_and_logIn     ${message_test4_user}
    user_make_call_via_meeting_link     ${driver_UE}   ${invite_url}
    ${driver_UF}     driver_set_up_and_logIn     ${message_test5_user}
    user_make_call_via_meeting_link     ${driver_UF}   ${invite_url}
    # Giver & Receiver & Observer Draw curve & arrow
    enter_video_connection    ${driver_UA}
    sleep    10
    share_me     ${driver_UA}
    click_screen_capture_button    ${driver_UA}    ${driver_UB}    ${driver_UC}    ${driver_UD}    ${driver_UE}    ${driver_UF}
    ${file_count}   get_file_count
    should be equal as integers     ${file_count}    6
    delete_picture_jpg_file

    # Giver leaves
    click_merge_button     ${driver_UB}
    leave_call     ${driver_UB}
    exit_driver     ${driver_UB}
    # The remaining participants click on Capture button
    click_screen_capture_button    ${driver_UA}    ${driver_UC}    ${driver_UD}    ${driver_UE}    ${driver_UF}
    ${file_count}   get_file_count
    should be equal as integers     ${file_count}    5
