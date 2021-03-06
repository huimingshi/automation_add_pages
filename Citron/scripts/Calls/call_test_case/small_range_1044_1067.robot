*** Settings ***
Library           Selenium2Library
Library           OperatingSystem
Resource          ../../../Lib/public.robot
Resource          ../../../Lib/calls_resource.robot
Resource          ../../../Lib/hodgepodge_resource.robot
Library           call_python_Lib/call_public_lib.py
Library           call_python_Lib/else_public_lib.py

*** Test Cases ***
Small_range_1045
    [Documentation]     External invitation message     set msg to pure character    Send MHS link to email and phone number
    [Tags]    small range 1045 line
    [Setup]     run keywords    Login_site_admin
    ...         AND             enter_workspace_settings_page       # 进入settings页面
    ...         AND             fill_invitation_message_content     You and I are dark horses     # 填写信息
    ...         AND             Close
    # user login
    ${driver}     driver_set_up_and_logIn     ${personal_user_username}       ${universal_password}
    # Send MHS link to email and phone number
    send_meeting_room_link     ${driver}     MHS      send
    # Open email and SMS of phone number,VP:In email "You have been invited to join [USERNAME] on a [ENTERPRISE]'s support call using Help Lightning." has been replaced by text set.
    check_invitation_message_correct_from_email     You and I are dark horses
    [Teardown]      run keywords    exit_driver     ${driver}
    ...             AND             Close

Small_range_1048
    [Documentation]     External invitation message     Set msg to Chinese character + special charator    Send MHS link to email and phone number
    [Tags]    small range 1048 line
    [Setup]     run keywords    Login_site_admin
    ...         AND             enter_workspace_settings_page       # 进入settings页面
    ...         AND             fill_invitation_message_content     德玛西亚皇子+[]()     # 填写信息
    ...         AND             Close
    # user login
    ${driver}     driver_set_up_and_logIn     ${personal_user_username}       ${universal_password}
    # Send MHS link to email and phone number
    send_meeting_room_link     ${driver}     MHS      send
    # Open email and SMS of phone number,VP: email and SMS shows customer text
    check_invitation_message_correct_from_email     =E5=BE=B7=E7=8E=9B=E8=A5=BF=E4=BA=9A=E7=9A=87=E5=AD=90+[]()
    [Teardown]      run keywords    exit_driver     ${driver}
    ...             AND             Close

Small_range_1051
    [Documentation]     External invitation message     Turn off feature    Send MHS link to email and phone number
    [Tags]    small range 1048 line
    [Setup]     run keywords    Login_site_admin
    ...         AND             enter_workspace_settings_page       # 进入settings页面
    ...         AND             close_invitation_message_set        # 关闭Before Call: Invitation Message配置项
    ...         AND             Close
    # user login
    ${driver}     driver_set_up_and_logIn     ${personal_user_username}       ${universal_password}
    # Send MHS link to email and phone number
    send_meeting_room_link     ${driver}     MHS      send
    # Open email and SMS of phone number,VP:Default message content
    check_invitation_message_correct_from_email     You have been invited to join Huiming.shi.helplightning+personal on a auto_default_workspace's support call using Help Lightning.
    [Teardown]      run keywords    exit_driver     ${driver}
    ...             AND             Close

Small_range_1046
    [Documentation]     External invitation message     set msg to pure character    Send One time use link to email and phone number
    [Tags]    small range 1046 line
    [Setup]     run keywords    Login_site_admin
    ...         AND             enter_workspace_settings_page       # 进入settings页面
    ...         AND             fill_invitation_message_content      You And I Are Dark Horses     # 填写信息
    ...         AND             Close
    # user login
    ${driver}     driver_set_up_and_logIn     ${personal_user_username}       ${universal_password}
    # Send MHS link to email and phone number
    send_meeting_room_link     ${driver}     OTU      send
    # Open email and SMS of phone number,VP: SMS content has customer text and follow by “Tap this link to join the call…”
    check_invitation_message_correct_from_email     You And I Are Dark Horses
    [Teardown]      run keywords    exit_driver     ${driver}
    ...             AND             Close

Small_range_1049
    [Documentation]     External invitation message     Set msg to Chinese character + special charator    Send One time use link to email and phone number
    [Tags]    small range 1049 line
    [Setup]     run keywords    Login_site_admin
    ...         AND             enter_workspace_settings_page       # 进入settings页面
    ...         AND             fill_invitation_message_content     德玛西亚皇子+[]-()      # 填写信息
    ...         AND             Close
    # user login
    ${driver}     driver_set_up_and_logIn     ${personal_user_username}       ${universal_password}
    # Send MHS link to email and phone number
    send_meeting_room_link     ${driver}     OTU      send
    # Open email and SMS of phone number,VP: email and SMS shows customer text
    check_invitation_message_correct_from_email     =E5=BE=B7=E7=8E=9B=E8=A5=BF=E4=BA=9A=E7=9A=87=E5=AD=90+[]-()
    [Teardown]      run keywords    exit_driver     ${driver}
    ...             AND             Close

Small_range_1052
    [Documentation]     External invitation message     Turn off feature    Send One time use link to email and phone number
    [Tags]    small range 1052 line
    [Setup]     run keywords    Login_site_admin
    ...         AND             enter_workspace_settings_page       # 进入settings页面
    ...         AND             close_invitation_message_set        # 关闭Before Call: Invitation Message配置项
    ...         AND             Close
    # user login
    ${driver}     driver_set_up_and_logIn     ${personal_user_username}       ${universal_password}
    # Send MHS link to email and phone number
    send_meeting_room_link     ${driver}     OTU      send
    # Open email and SMS of phone number,VP:Default message content
    check_invitation_message_correct_from_email     You have been invited to join Huiming.shi.helplightning+personal on a auto_default_workspace's support call using Help Lightning.
    [Teardown]      run keywords    exit_driver     ${driver}
    ...             AND             Close

Small_range_1047
    [Documentation]     External invitation message     set msg to pure character    Site user send 3PI link
    [Tags]    small range 1047 line
    [Setup]     run keywords    Login_site_admin
    ...         AND             enter_workspace_settings_page       # 进入settings页面
    ...         AND             fill_invitation_message_content      I Am Dark Horse     # 填写信息
    ...         AND             Close
    # user login
    ${driver1}     driver_set_up_and_logIn     ${normal_username_for_calls}       ${universal_password}
    ${driver2}     driver_set_up_and_logIn     ${normal_username_for_calls_B}       ${universal_password}
    # Site user send 3PI link
    make_calls_with_who      ${driver2}     ${driver1}     ${normal_username_for_calls_name}
    ${invite_url}     send_invite_in_calling_page    ${driver2}   send
    # Open email and SMS of phone number,VP: SMS and Email content has customer text.
    check_invitation_message_correct_from_email     I Am Dark Horse
    [Teardown]      run keywords    exit_driver     ${driver1}     ${driver2}
    ...             AND             Close

Small_range_1050
    [Documentation]     External invitation message     Set msg to Chinese character + special charator     Site user send 3PI link
    [Tags]    small range 1050 line
    [Setup]     run keywords    Login_site_admin
    ...         AND             enter_workspace_settings_page       # 进入settings页面
    ...         AND             fill_invitation_message_content      德玛西亚+[]-()     # 填写信息
    ...         AND             Close
    # user login
    ${driver1}     driver_set_up_and_logIn     ${normal_username_for_calls}       ${universal_password}
    ${driver2}     driver_set_up_and_logIn     ${normal_username_for_calls_B}       ${universal_password}
    # Site user send 3PI link
    make_calls_with_who      ${driver2}     ${driver1}     ${normal_username_for_calls_name}
    ${invite_url}     send_invite_in_calling_page    ${driver2}   send
    # Open email and SMS of phone number,VP: email and SMS shows customer text
    check_invitation_message_correct_from_email      =E5=BE=B7=E7=8E=9B=E8=A5=BF=E4=BA=9A+[]-()
    [Teardown]      run keywords    exit_driver     ${driver1}     ${driver2}
    ...             AND             Close

Small_range_1053
    [Documentation]     External invitation message     Turn off feature     Site user send 3PI link
    [Tags]    small range 1053 line
    [Setup]     run keywords    Login_site_admin
    ...         AND             enter_workspace_settings_page       # 进入settings页面
    ...         AND             close_invitation_message_set        # 关闭Before Call: Invitation Message配置项
    ...         AND             Close
    # user login
    ${driver1}     driver_set_up_and_logIn     ${normal_username_for_calls}       ${universal_password}
    ${driver2}     driver_set_up_and_logIn     ${normal_username_for_calls_B}       ${universal_password}
    # Site user send 3PI link
    make_calls_with_who      ${driver2}     ${driver1}     ${normal_username_for_calls_name}
    ${invite_url}     send_invite_in_calling_page    ${driver2}   send
    # Open email and SMS of phone number,VP:Default message content
    check_invitation_message_correct_from_email      You have been invited to join Huiming.shi.helplightning+0123456789 on a auto_default_workspace's support call using Help Lightning.
    [Teardown]      run keywords    exit_driver     ${driver1}     ${driver2}
    ...             AND             Close

#Small_range_1054_1060
#    [Documentation]     Launch edge browser
#    [Tags]    small range 1054-1060 lines
#    # Launch edge browser   Open website https://helplightning.com/
#    ${driver1}   open_website_without_chrome   edge    https://helplightning.com/
#    # New another tab and go to citron stage page
#    new_another_tab_and_go   ${driver1}   ${citron_website}
#    # Login to citron stage with userA
#    logIn_citron   ${driver1}   ${normal_username_for_calls}    ${universal_password}
#    # Close tab of citron stage, but keep edge browser open
#    close_last_window    ${driver1}
##    # Someone 登录
##    ${driver1}   open_website_without_chrome   edge    ${citron_website}
##    logIn_citron   ${driver1}   ${normal_username_for_calls}    ${universal_password}
#    # Someone 登录
#    ${driver2}   open_website_without_chrome   edge    ${citron_website}
#    logIn_citron   ${driver2}   ${normal_username_for_calls_B}    ${universal_password}
#    # Someone call userA
#    # Click the incoming call notification，Answer call
#    make_calls_with_who    ${driver2}    ${driver1}   ${normal_username_for_calls_name}
#    exit_call   ${driver2}
#    [Teardown]    exit_driver    ${driver1}   ${driver2}

#Small_range_1061_1067
#    [Documentation]     Launch Firefox browser
#    [Tags]    small range 1061-1067 lines
#    # Launch edge browser   Open website https://helplightning.com/
#    ${driver1}   open_website_without_chrome     firefox    https://helplightning.com/
#    # New another tab and go to citron stage page
#    new_another_tab_and_go   ${driver1}   ${citron_website}
#    # Login to citron stage with userA
#    logIn_citron   ${driver1}   ${normal_username_for_calls}    ${universal_password}
#    # Close tab of citron stage, but keep edge browser open
#    close_last_window    ${driver1}
##    # Someone 登录
##    ${driver1}   open_website_without_chrome   firefox    ${citron_website}
##    logIn_citron   ${driver1}   ${normal_username_for_calls}    ${universal_password}
#    # Someone 登录
#    ${driver2}   open_website_without_chrome   firefox    ${citron_website}
#    logIn_citron   ${driver2}   ${normal_username_for_calls_B}    ${universal_password}
#    # Someone call userA
#    # Click the incoming call notification，Answer call
#    make_calls_with_who    ${driver2}    ${driver1}   ${normal_username_for_calls_name}
#    exit_call   ${driver2}
#    [Teardown]    exit_driver    ${driver1}   ${driver2}