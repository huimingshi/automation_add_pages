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
Library           call_python_Lib/calls_page.py
Force Tags        call_case     new_call_case


*** Test Cases ***
6PC_direct_call
    [Documentation]       Screen capture -6pc
    [Tags]     6pc tag
    [Setup]     run keywords    delete_picture_jpg_file
    ...         AND             delete_picture_jpg_file     multipart-
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
    # Each participant Click Capture button
    click_screen_capture_button    ${driver_UA}    ${driver_UB}    ${driver_UC}    ${driver_UD}    ${driver_UE}    ${driver_UF}
    # VP: picture content is correct.
    ${file_count}   get_file_count
    should be equal as integers     ${file_count}    6
    delete_picture_jpg_file
    # Giver leaves
    click_merge_button     ${driver_UB}
    leave_call     ${driver_UB}
    exit_one_driver     ${driver_UB}
    # The remaining participants click on Capture button
    click_screen_capture_button    ${driver_UA}    ${driver_UC}    ${driver_UD}    ${driver_UE}    ${driver_UF}
    # VP: picture content is correct.
    ${file_count}   get_file_count
    should be equal as integers     ${file_count}    5
    delete_picture_jpg_file
    end_call_for_all     ${driver_UA}

    comment       Workspace admin logs in Citron -> Admin ->Call-> detail
    comment       Workspace admin can view, download, and delete picture
    sleep     120    # 等待服务端加载好配置返回给前端页面进行渲染
    # VP: All screen captures are displayed
    ${driver_WA}     driver_set_up_and_logIn     ${workspace_admin_username}
    switch_to_WS_calls_page     ${driver_WA}
    calls_click_first_details    ${driver_WA}
    sleep    10
    get_screen_captures_count      ${driver_WA}     11
    # click on download menu	select directory to save image	VP: format is JPG
    click_on_download_menu    ${driver_WA}
    close_details_page     ${driver_WA}
    ${file_count}    get_file_count     jpg     multipart-
    should be equal as integers     ${file_count}    1
    [Teardown]      run keywords    delete_picture_jpg_file
    ...             AND             delete_picture_jpg_file     multipart-
    ...             AND             exit_driver

6PC_expert_group_call
    [Documentation]       Screen capture -6pc
    [Tags]     6pc tag    有bug：https://vipaar.atlassian.net/browse/CITRON-3764
    [Setup]     run keywords    delete_picture_jpg_file
    ...         AND             delete_picture_jpg_file     multipart-
    comment     Freeze mode
    # 6PC expert group call.
    # EU2 in on-call group B; TU1 calls on-call group B
    ${driver_TU1}     driver_set_up_and_logIn     ${expert_group_call_userT1}
    ${driver_EU2}     driver_set_up_and_logIn     ${expert_group_call_userE2}
    contacts_witch_page_make_call       ${driver_TU1}   ${driver_EU2}   ${py_team_page}   ${expert_group_call_GROUP}
    # TU1 invites U3 from contact list. U3 answers call.
    ${driver_U3}     driver_set_up_and_logIn     ${expert_group_call_user3}
    inCall_enter_contacts_search_user    ${driver_TU1}     ${expert_group_call_name3}
    click_user_in_contacts_list          ${driver_TU1}     ${expert_group_call_name3}
    user_anwser_call     ${driver_U3}
    # Join call in sequence: Anonymous user AU4 via 3pi link. Logged in user U5 via 3pi link. Different site DU6 via 3pi link
    ${invite_url}     send_new_invite_in_calling     ${driver_EU2}
    ${driver_U4}     driver_set_up_and_logIn     ${expert_group_call_user4}
    user_make_call_via_meeting_link     ${driver_U4}    ${invite_url}
    ${driver_U5}     driver_set_up_and_logIn     ${expert_group_call_user5}
    user_make_call_via_meeting_link     ${driver_U5}    ${invite_url}
    ${driver_U6}     driver_set_up_and_logIn     ${expert_group_call_user6}
    user_make_call_via_meeting_link     ${driver_U6}    ${invite_url}
    # Giver & Receiver & Observer zoom in/out and panned image, and draw curves and arrows
    enter_video_connection     ${driver_TU1}
    sleep    10
    share_me     ${driver_TU1}
    freeze operation    ${driver_TU1}
    # Each participant Click Capture button
    click_screen_capture_button    ${driver_TU1}    ${driver_EU2}    ${driver_U3}    ${driver_U4}    ${driver_U5}    ${driver_U6}
    # VP: picture content is correct.
    ${file_count}   get_file_count
    should be equal as integers     ${file_count}    6
    delete_picture_jpg_file
    # Observer switches to giver	Click Capture button
    click_merge_button     ${driver_U4}
    click_screen_capture_button    ${driver_U4}
    # VP: picture content is correct.
    ${file_count}   get_file_count
    should be equal as integers     ${file_count}    1
    delete_picture_jpg_file
    # Receiver leaves call	VP: App back to F2F mode, no capture button
    leave_call     ${driver_TU1}
    check_in_f2f_mode    ${driver_U4}
    check_has_no_capture_button     ${driver_EU2}    ${driver_U3}    ${driver_U4}    ${driver_U5}    ${driver_U6}
    end_call_for_all     ${driver_EU2}

#    # 有bug：https://vipaar.atlassian.net/browse/CITRON-3764
#    comment           Parcipant logs in citron -> Calls -> details
#    comment           Normal user role has no permission delete
#    sleep     120    # 等待服务端加载好配置返回给前端页面进行渲染
#    # VP: select directory to save image	VP: format is JPG
#    ${driver_WA}     driver_set_up_and_logIn     ${expert_group_call_userT1}
#    switch_MY_TAB_calls_page    ${driver_WA}
#    calls_click_first_details    ${driver_WA}
#    sleep    10
#    get_screen_captures_count      ${driver_WA}     7
#    click_on_download_menu    ${driver_WA}
#    ${file_count}    get_file_count     jpg     multipart-
#    should be equal as integers     ${file_count}    1
#    # VP: All screen captures are displayed	click thumbnail or view button	close the full size of image by X button
#    click_full_screen_menu    ${driver_WA}
#    exit_full_screen    ${driver_WA}
#    close_details_page     ${driver_WA}
    [Teardown]      run keywords    delete_picture_jpg_file
    ...             AND             delete_picture_jpg_file     multipart-
    ...             AND             exit_driver

anonymous_start_a_6pc_meeting_call
    [Documentation]       Screen capture -6pc
    [Tags]     6pc tag    有bug：https://vipaar.atlassian.net/browse/CITRON-3764      upload_file_case
    [Setup]     run keywords    delete_picture_jpg_file
    ...         AND             delete_picture_jpg_file     multipart-
    comment     photo mode, pdf;
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
    ${driver_UE}     driver_set_up_and_logIn     ${center_mode_user11}
    user_make_call_via_meeting_link     ${driver_UE}   ${invite_url}
    user_anwser_call     ${driver_UA}   no_direct
    ${driver_UF}     anonymous_open_meeting_link    ${invite_url}
    user_anwser_call     ${driver_UA}    no_direct
    # Giver & Receiver & Observer Draw curve & arrow
    enter_video_connection    ${driver_UA}
    sleep    10
    minimize_window_action      ${driver_UA}    ${driver_UB}    ${driver_UC}    ${driver_UD}    ${driver_UE}    ${driver_UF}
    maximize_window_action      ${driver_UA}
    inCall_upload_photo_PDF     ${driver_UA}
    maximize_window_action      ${driver_UB}    ${driver_UC}    ${driver_UD}    ${driver_UE}    ${driver_UF}
    # Giver & Receiver & Observer zoom in/out and panned image, and draw curves and arrows	Participant clicks on Capture button.
    click_screen_capture_button    ${driver_UA}    ${driver_UB}    ${driver_UC}    ${driver_UD}
    # anonymous and personal user has no capture button
    check_has_no_capture_button    ${driver_UE}    ${driver_UF}
    # VP: picture content is correct.
    ${file_count}   get_file_count
    should be equal as integers     ${file_count}    4
    # another participant select another photo	Participant click screen capture
    minimize_window_action      ${driver_UA}    ${driver_UB}    ${driver_UC}    ${driver_UD}    ${driver_UE}    ${driver_UF}
    maximize_window_action      ${driver_UB}
    inCall_upload_photo_PDF     ${driver_UB}
    maximize_window_action      ${driver_UA}    ${driver_UC}    ${driver_UD}    ${driver_UE}    ${driver_UF}
    click_screen_capture_button    ${driver_UA}    ${driver_UB}    ${driver_UC}    ${driver_UD}
    # Share live video to back to merge reality	Participant click screen capture
    share_me    ${driver_UA}
    click_screen_capture_button    ${driver_UA}    ${driver_UB}    ${driver_UC}    ${driver_UD}
    # Paticipant share pdf	share button to enter markup mode	Participant click screen capture
    minimize_window_action      ${driver_UA}    ${driver_UB}    ${driver_UC}    ${driver_UD}    ${driver_UE}    ${driver_UF}
    maximize_window_action      ${driver_UC}
    inCall_upload_photo_PDF     ${driver_UC}    PDF
    share_page     ${driver_UC}
    maximize_window_action      ${driver_UA}    ${driver_UB}    ${driver_UD}    ${driver_UE}    ${driver_UF}
    click_screen_capture_button    ${driver_UA}    ${driver_UB}    ${driver_UC}    ${driver_UD}
    # Observer leaves	The remaining participants click on Capture button   VP: picture content is correct.
    exit_call      ${driver_UD}
    click_screen_capture_button    ${driver_UA}    ${driver_UB}    ${driver_UC}
    end_call_for_all      ${driver_UA}

    comment       Admin logs in Citron -> Admin ->Call-> detail
    sleep     120    # 等待服务端加载好配置返回给前端页面进行渲染
    # Admin logs in Citron -> Admin ->Call-> detail	VP: All screen captures are displayed	VP: images are in correct queue in call log
    ${driver_SA}     driver_set_up_and_logIn     ${site_admin_username}
    user_switch_to_second_workspace    ${driver_SA}     ${auto_default_workspace}
    switch_to_WS_calls_page     ${driver_SA}
    calls_click_first_details    ${driver_SA}
    sleep    10
    get_screen_captures_count      ${driver_SA}     19
    [Teardown]      run keywords    delete_picture_jpg_file
    ...             AND             delete_picture_jpg_file     multipart-
    ...             AND             exit_driver

Survey_Rate_6pc
    [Documentation]       Tag/Comment - 6pc
    [Tags]     6pc tag
    # TU1 calls EU2. EU2 answers call.
    ${driver_TU1}     driver_set_up_and_logIn     ${Team_User1_username}
    ${driver_EU2}     driver_set_up_and_logIn     ${Expert_User2_username}
    contacts_witch_page_make_call       ${driver_TU1}   ${driver_EU2}   ${py_team_page}   ${Expert_User2_name}
    make_sure_enter_call                ${driver_EU2}
    # TU1 invite U3 from contact
    ${driver_U3}      driver_set_up_and_logIn     ${Expert_User3_username}
    inCall_enter_contacts_search_user   ${driver_TU1}    ${Expert_User3_name}
    click_user_in_contacts_list         ${driver_TU1}     ${Expert_User3_name}
    user_anwser_call                    ${driver_U3}
    make_sure_enter_call                ${driver_U3}
    enter_video_connection              ${driver_TU1}
    # 获取invite link
    ${invite_url}     send_new_invite_in_calling    ${driver_EU2}
    # Other 3 users join call
    ${driver_U4}      anonymous_open_meeting_link    ${invite_url}
    user_anwser_call                    ${driver_TU1}    no_direct
    ${driver_EU5}     driver_set_up_and_logIn     ${Expert_User5_username}
    user_make_call_via_meeting_link     ${driver_EU5}   ${invite_url}
    ${driver_U6}      driver_set_up_and_logIn     ${Team_User2_username}
    user_make_call_via_meeting_link     ${driver_U6}   ${invite_url}
    sleep  10
    # 6 participants leave call one by one
    exit_call    ${driver_U6}
    exit_call    ${driver_EU5}
    exit_call    ${driver_U4}
    exit_call    ${driver_U3}
    exit_call    ${driver_EU2}
    # User clicks on any star icon.	VP: rating dialog still displays.
    five_star_evaluate    poor   ${driver_TU1}     ${driver_EU2}     ${driver_U3}    ${driver_U4}    ${driver_EU5}     ${driver_U6}
    # Each one add tag/comment and survey and rate start
    five_star_evaluate    excellent   ${driver_TU1}     ${driver_EU2}     ${driver_U3}    ${driver_U4}    ${driver_EU5}     ${driver_U6}
    # User taps other area beyond the star rating dialog.	VP: rating dialog should not disappear.
    rating_dialog_exists    ${driver_TU1}     ${driver_EU2}     ${driver_U3}    ${driver_U4}    ${driver_EU5}     ${driver_U6}
    # User adds tag/comment.
    give_call_comment    ${driver_TU1}     ${driver_EU2}     ${driver_U3}     ${driver_EU5}     ${driver_U6}
    # User  clicks on survey button.   VP: Survey page opens successfully.
    take_survey_action    ${driver_TU1}     ${driver_EU2}     ${driver_U3}    ${driver_EU5}     ${driver_U6}
    # User clicks on Done button.
    save_evaluate    ${driver_TU1}     ${driver_EU2}     ${driver_U3}    ${driver_EU5}     ${driver_U6}

    # Open call detials page from Citron.	VP: the rating stars are correct. Tag and comment are displayed correctly.
    sleep   120
    close_call_ending_page    ${driver_TU1}
    switch_MY_TAB_calls_page    ${driver_TU1}
    calls_click_first_details    ${driver_TU1}
    sleep    10
    check_star_evaluate    ${driver_TU1}
    check_call_comment     ${driver_TU1}
    exit_driver

    # Citron admin login to view call details	VP: rate and tag/comment participant added are all here
    ${driver_SA}     driver_set_up_and_logIn     ${crunch_site_username}    ${crunch_site_password}
    user_switch_to_second_workspace     ${driver_SA}     ${Huiming_shi_Added_WS}
    switch_to_WS_calls_page     ${driver_SA}
    calls_click_first_details    ${driver_SA}
    sleep    10
    check_star_evaluate    ${driver_SA}
    check_call_comment     ${driver_SA}
    [Teardown]     exit_driver