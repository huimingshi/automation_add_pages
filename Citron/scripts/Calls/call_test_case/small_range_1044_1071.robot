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
Library           call_python_Lib/finish_call.py
Library           call_python_Lib/login_lib.py
Library           call_python_Lib/contacts_page.py
Force Tags        small_range

*** Test Cases ***
Small_range_1045
    [Documentation]     External invitation message     set msg to pure character    Send MHS link to email and phone number
    [Tags]    small range 1045 line    call_case
    [Setup]     fill_invitation_message_content_setUp    site_admin    ${small_horse}
    # user login
    ${driver}     driver_set_up_and_logIn     ${personal_user_username}
    # Send MHS link to email and phone number
    send_meeting_room_link     ${driver}     ${MHS_link_email}      send
    # Open email and SMS of phone number,VP:In email "You have been invited to join [USERNAME] on a [ENTERPRISE]'s support call using Help Lightning." has been replaced by text set.
    check_invitation_message_correct_from_email     ${small_horse}
    [Teardown]      exit_driver

Small_range_1048
    [Documentation]     External invitation message     Set msg to Chinese character + special charator    Send MHS link to email and phone number
    [Tags]    small range 1048 line     call_case
    [Setup]     fill_invitation_message_content_setUp   site_admin    ${jarvan_fourth}
    # user login
    ${driver}     driver_set_up_and_logIn     ${personal_user_username}
    # Send MHS link to email and phone number
    send_meeting_room_link     ${driver}     ${MHS_link_email}      send
    # Open email and SMS of phone number,VP: email and SMS shows customer text
    check_invitation_message_correct_from_email     =E5=BE=B7=E7=8E=9B=E8=A5=BF=E4=BA=9A=E7=9A=87=E5=AD=90+[]()
    [Teardown]      exit_driver

Small_range_1051
    [Documentation]     External invitation message     Turn off feature    Send MHS link to email and phone number
    [Tags]    small range 1048 line      call_case
    [Setup]     close_invitation_message_set_setUp    site_admin
    # user login
    ${driver}     driver_set_up_and_logIn     ${personal_user_username}
    # Send MHS link to email and phone number
    send_meeting_room_link     ${driver}     ${MHS_link_email}      send
    # Open email and SMS of phone number,VP:Default message content
    check_invitation_message_correct_from_email     You have been invited to join Huiming.shi.helplightning+personal on a auto_default_workspace's support call using Help Lightning.
    [Teardown]      exit_driver

Small_range_1046
    [Documentation]     External invitation message     set msg to pure character    Send One time use link to email and phone number
    [Tags]    small range 1046 line     call_case
    [Setup]     fill_invitation_message_content_setUp   site_admin    ${big_horse}
    # user login
    ${driver}     driver_set_up_and_logIn     ${personal_user_username}
    # Send MHS link to email and phone number
    send_meeting_room_link     ${driver}     ${OTU_link_email}      send
    # Open email and SMS of phone number,VP: SMS content has customer text and follow by “Tap this link to join the call…”
    check_invitation_message_correct_from_email     ${big_horse}
    [Teardown]      exit_driver

Small_range_1049
    [Documentation]     External invitation message     Set msg to Chinese character + special charator    Send One time use link to email and phone number
    [Tags]    small range 1049 line     call_case
    [Setup]     fill_invitation_message_content_setUp   site_admin    ${jarvan_fourth_1}
    # user login
    ${driver}     driver_set_up_and_logIn     ${personal_user_username}
    # Send MHS link to email and phone number
    send_meeting_room_link     ${driver}     ${OTU_link_email}      send
    # Open email and SMS of phone number,VP: email and SMS shows customer text
    check_invitation_message_correct_from_email     =E5=BE=B7=E7=8E=9B=E8=A5=BF=E4=BA=9A=E7=9A=87=E5=AD=90+[]-()
    [Teardown]      exit_driver

Small_range_1052
    [Documentation]     External invitation message     Turn off feature    Send One time use link to email and phone number
    [Tags]    small range 1052 line    call_case
    [Setup]     close_invitation_message_set_setUp    site_admin
    # user login
    ${driver}     driver_set_up_and_logIn     ${personal_user_username}
    # Send MHS link to email and phone number
    send_meeting_room_link     ${driver}     ${OTU_link_email}      send
    # Open email and SMS of phone number,VP:Default message content
    check_invitation_message_correct_from_email     You have been invited to join Huiming.shi.helplightning+personal on a auto_default_workspace's support call using Help Lightning.
    [Teardown]      exit_driver

Small_range_1047
    [Documentation]     External invitation message     set msg to pure character    Site user send 3PI link
    [Tags]    small range 1047 line     call_case
    [Setup]     fill_invitation_message_content_setUp   site_admin    ${I_am_horse}
    # user login
    ${driver1}     driver_set_up_and_logIn     ${normal_username_for_calls}
    ${driver2}     driver_set_up_and_logIn     ${normal_username_for_calls_B}
    # Site user send 3PI link
    contacts_witch_page_make_call      ${driver2}     ${driver1}   ${py_team_page}   ${normal_username_for_calls_name}
    which_page_is_currently_on    ${driver2}    ${end_call_button}
    ${invite_url}     send_new_invite_in_calling    ${driver2}   send
    # Open email and SMS of phone number,VP: SMS and Email content has customer text.
    check_invitation_message_correct_from_email     ${I_am_horse}
     [Teardown]      exit_driver

Small_range_1050
    [Documentation]     External invitation message     Set msg to Chinese character + special charator     Site user send 3PI link
    [Tags]    small range 1050 line     call_case
    [Setup]     fill_invitation_message_content_setUp   site_admin    ${demacia}
    # user login
    ${driver1}     driver_set_up_and_logIn     ${normal_username_for_calls}
    ${driver2}     driver_set_up_and_logIn     ${normal_username_for_calls_B}
    # Site user send 3PI link
    contacts_witch_page_make_call      ${driver2}     ${driver1}   ${py_team_page}   ${normal_username_for_calls_name}
    which_page_is_currently_on    ${driver2}    ${end_call_button}
    ${invite_url}     send_new_invite_in_calling    ${driver2}   send
    # Open email and SMS of phone number,VP: email and SMS shows customer text
    check_invitation_message_correct_from_email      =E5=BE=B7=E7=8E=9B=E8=A5=BF=E4=BA=9A+[]-()
    [Teardown]      exit_driver

Small_range_1053
    [Documentation]     External invitation message     Turn off feature     Site user send 3PI link
    [Tags]    small range 1053 line     call_case
    [Setup]     close_invitation_message_set_setUp    site_admin
    # user login
    ${driver1}     driver_set_up_and_logIn     ${normal_username_for_calls}
    ${driver2}     driver_set_up_and_logIn     ${normal_username_for_calls_B}
    # Site user send 3PI link
    contacts_witch_page_make_call      ${driver2}     ${driver1}   ${py_team_page}   ${normal_username_for_calls_name}
    which_page_is_currently_on    ${driver2}    ${end_call_button}
    ${invite_url}     send_new_invite_in_calling    ${driver2}   send
    # Open email and SMS of phone number,VP:Default message content
    check_invitation_message_correct_from_email      You have been invited to join Huiming.shi.helplightning+0123456789 on a auto_default_workspace's support call using Help Lightning.
    [Teardown]      exit_driver

Small_range_1068_1071
    [Documentation]     Open the HTML file[Helplightning Integration Test Tool.html]
    [Tags]    small range 1068-1071 lines，有bug：https://vipaar.atlassian.net/browse/CITRON-3525，已修复     call_case
    # 被呼叫的用户先登录
    ${driver1}     driver_set_up_and_logIn     ${normal_username_for_calls_B}
    # 打开html页面并登录
    ${driver2}     open_html_create_call   ${driver1}    ${normal_username_for_calls}       ${universal_password}    ${normal_username_for_calls_B}
    ###### 失败了的话，可能需要在html上重新输入一次email
    # user接受call
    user_anwser_call    ${driver1}
    # 退出call
    exit_call    ${driver1}
    [Teardown]    exit_driver