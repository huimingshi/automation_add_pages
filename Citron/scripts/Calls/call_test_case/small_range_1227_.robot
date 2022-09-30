*** Settings ***
Library           Selenium2Library
Library           OperatingSystem
Resource          ../../../Lib/public.robot
Resource          ../../../Lib/calls_resource.robot
Resource          ../../../Lib/All_Pages_Xpath/Normal/Messages.robot
Resource          ../../../Lib/hodgepodge_resource.robot
Library           call_python_Lib/call_public_lib.py
Library           call_python_Lib/else_public_lib.py
Library           call_python_Lib/messages_page.py
Library           call_python_Lib/about_call.py
Library           call_python_Lib/finish_call.py
Library           call_python_Lib/login_lib.py
Library           call_python_Lib/contacts_page.py
Library           call_python_Lib/recents_page.py
Force Tags        small_range


*** Test Cases ***
Small_range_1220_1281
    [Documentation]     In call message
    [Tags]    small range 1260-1281 lines       call_case
    [Setup]   run keywords    delete_zip_file     ${message_audio}
    ...       AND             delete_zip_file     ${particial_message_audio}
    ...       AND             delete_zip_file     ${screen_capture_file_name}
    ...       AND             delete_zip_file     ${downloaded_file_name}
    # userA login
    ${driverA}     driver_set_up_and_logIn     ${in_call_message_userA}
    ${mhs_link}    send_meeting_room_link    ${driverA}     which_meeting='MHS'
    # userB login
    ${driverB}     driver_set_up_and_logIn     ${in_call_message_userB}
    # User B clicks User A's MHS link
    user_make_call_via_meeting_link     ${driverB}    ${mhs_link}
    user_anwser_call    ${driverA}
    make_sure_enter_call     ${driverB}
    # userD login
    ${driverD}     driver_set_up_and_logIn     ${in_call_message_userD}
    # User A invites Expert Group
    enter_contacts_search_user      ${driverA}     ${in_call_message_expert_group}
    click_user_in_contacts_call     ${driverA}     ${in_call_message_expert_group}
    # Expert User[User D] enter this call
    user_anwser_call    ${driverD}
    which_page_is_currently_on    ${driverD}     ${end_call_button}
    # User A sends 3pci link
    ${invite_link}      send_invite_in_calling_page     ${driverA}
    close_invite_3th_page     ${driverA}
    # userC    A1    D1   login
    ${driverC}     driver_set_up_and_logIn     ${in_call_message_userC}
    ${driverD1}     driver_set_up_and_logIn     ${in_call_message_userD1}
    # User C enters this call via 3cpi
    user_make_call_via_meeting_link     ${driverC}    ${invite_link}
    user_anwser_call     ${driverA}    no_direct
    make_sure_enter_call     ${driverC}
    # A1 enter this call via 3pci
    ${driverA1}     anonymous_open_meeting_link    ${invite_link}
    user_anwser_call     ${driverA}    no_direct
    make_sure_enter_call     ${driverA1}
    # D1 enter this call via 3pci
    user_make_call_via_meeting_link     ${driverD1}    ${invite_link}
    user_anwser_call     ${driverA}    no_direct
    make_sure_enter_call     ${driverD1}
    # User A clicks Message button
    # VP: 1) Messages has been accessed, the drawer can be collapsed into the left margin.
    # 2) Set transparency to 80% for the white message window background
    in_call_click_message_button     ${driverA}
    # User A  enters the Text message to send
    in_call_send_message_data     ${driverA}    ${plain_english_text}
    # VP: 1. The Text messages should be  taken from Fieldbit
    # 2. User B, User C, User D, A1 & D1 should displays the number  of message  number through the Options Message menu
    in_call_show_count_of_message       ${driverB}
    in_call_show_count_of_message       ${driverC}
    in_call_show_count_of_message       ${driverD}
    in_call_show_count_of_message       ${driverA1}
    in_call_show_count_of_message       ${driverD1}
    # User A, User B, User C, User D, A1 & D1  Selects the ellipses
    # VP: The Text messages should be  taken from Fieldbit
    in_call_check_receive_message       ${driverB}      ${plain_english_text}
    in_call_check_receive_message       ${driverC}      ${plain_english_text}
    in_call_check_receive_message       ${driverD}      ${plain_english_text}
    in_call_check_receive_message       ${driverA1}      ${plain_english_text}
    in_call_check_receive_message       ${driverD1}      ${plain_english_text}
    # send attachment	VP: has options: Photo; camera;Document
    in_call_click_upload_attach     ${driverA}
    # send image files (prepared test data)	VP: files are correctly send out
    send_message_by_different_file     ${driverA}     ${message_jpg}      in_call
    send_message_by_different_file     ${driverA}     ${message_pdf}      in_call
    # send audio files  (prepared test data)	VP: files are correctly send out
    send_message_by_different_file     ${driverA}     ${message_audio}    in_call
    # send video files  (prepared test data)	VP: files are correctly send out
    send_message_by_different_file     ${driverA}     ${message_video}    in_call
    # send photo from Camera.	VP: files are correctly send out
    # send big size files	more than 5M	VP: There is an alert message to pop. The big file isn't uploaded.
    send_message_by_different_file     ${driverA}     ${big_size_file}    file_is_too_large
    file_is_too_large     ${driverA}
    # send other file format	.zip, .dmg, .xlsx, .docx	VP: files are correctly send out
#   上传zip文件的话，details打不开，此处已提bug：https://vipaar.atlassian.net/browse/CITRON-3575
##########################################################################################
#    send_message_by_different_file     ${driverA}     ${message_zip}    in_call
    # VP: files can be downloaded by receiver
    in_call_download_file     ${driverB}     ${message_audio}
    delete_zip_file     ${particial_message_audio}
    # User C select 1 uploaded picture from chat list, click sub-menu 'Share' button.	VP: this file should be shown in main video screen.(前提条件：需要先进入到giving receiving help mode下)
    enter_giver_mode     ${driverA}      ${in_call_message_usernameB}     ${in_call_message_usernameC}
    proceed_with_camera_on     ${driverA}
    proceed_with_camera_on     ${driverB}
    share_in_main_screen     ${driverC}        ${message_jpg}
    # User A, User B, User C, User D, A1 & D1  do some sample operations	VP: These operations should be worked.

    # User A clicks ScreenCapture button	VP: The screen capture is uploaded into Message List for User A, User B, User C, User D, A1 & D1.
    in_call_click_message_button     ${driverA}     operation='close'
    click_screen_capture_button     ${driverA}
    in_call_click_message_button     ${driverA}
    in_call_check_receive_attach       ${driverA}      ${screen_capture_name}
    in_call_check_receive_attach       ${driverB}      ${screen_capture_name}
    in_call_check_receive_attach       ${driverC}      ${screen_capture_name}
    in_call_check_receive_attach       ${driverD}      ${screen_capture_name}
    in_call_check_receive_attach       ${driverA1}      ${screen_capture_name}
    in_call_check_receive_attach       ${driverD1}      ${screen_capture_name}
    # User A, User B, User C, User D, A1 & D1  select 1 uploaded file, click sub-menu Download button	VP: the file should be saved to local
    in_call_download_file     ${driverA}     ${message_audio}
    delete_zip_file     ${particial_message_audio}
    in_call_download_file     ${driverC}     ${message_audio}
    delete_zip_file     ${particial_message_audio}
    in_call_download_file     ${driverD}     ${message_audio}
    delete_zip_file     ${particial_message_audio}
    in_call_download_file     ${driverA1}     ${message_audio}
    delete_zip_file     ${particial_message_audio}
    in_call_download_file     ${driverD1}     ${message_audio}
    delete_zip_file     ${particial_message_audio}
    # User B select 1 uploaded PDF file, click sub-menu 'Share' button	VP: this file should be shown in main video screen.
    # User B clicks Share button to enter Markup mode
    share_in_main_screen     ${driverB}        ${message_pdf}    file_type='pdf'
    # User A, User B, User C, User D, A1 & D1  do some telestrations

    # User A and D1 clicks Screen Capture button	VP: The 2 screen captures are uploaded into Message List for User A, User B, User C, User D, A1 & D1.
    in_call_click_message_button       ${driverA}       operation='close'
    click_screen_capture_button        ${driverA}
    in_call_click_message_button       ${driverA}
    in_call_check_receive_attach       ${driverA}       ${screen_capture_name}     attach_count=2
    in_call_check_receive_attach       ${driverB}       ${screen_capture_name}     attach_count=2
    in_call_check_receive_attach       ${driverC}       ${screen_capture_name}     attach_count=2
    in_call_check_receive_attach       ${driverD}       ${screen_capture_name}     attach_count=2
    in_call_check_receive_attach       ${driverA1}      ${screen_capture_name}     attach_count=2
    in_call_check_receive_attach       ${driverD1}      ${screen_capture_name}     attach_count=2
    in_call_click_message_button       ${driverD1}       operation='close'
    click_screen_capture_button        ${driverD1}
    in_call_click_message_button       ${driverD1}
    in_call_check_receive_attach       ${driverA}       ${screen_capture_name}     attach_count=3
    in_call_check_receive_attach       ${driverB}       ${screen_capture_name}     attach_count=3
    in_call_check_receive_attach       ${driverC}       ${screen_capture_name}     attach_count=3
    in_call_check_receive_attach       ${driverD}       ${screen_capture_name}     attach_count=3
    in_call_check_receive_attach       ${driverA1}      ${screen_capture_name}     attach_count=3
    in_call_check_receive_attach       ${driverD1}      ${screen_capture_name}     attach_count=3
    # ------------------------ 1271-1281 ------------------------ #
    # End call
    back_to_face_to_face_mode      ${driverA}
    end_call_for_all      ${driverA}
    exit_driver
    # Site Admin navigates to Site Administration -> Calls, WS Adminitration -> Calls
    ${driverSA}     driver_set_up_and_logIn     ${site_admin_username}
    user_switch_to_second_workspace      ${driverSA}     ${message_test_WS_A}
    switch_to_diffrent_page      ${driverSA}     ${py_recents_page}     ${py_recents_switch_success}    ${py_get_number_of_rows}     switch_tree      2
    # Select this call, click Detail button.
    calls_click_details_button      ${driverSA}
    # VP: the uploaded file should be shown up in Call log
    uploaded_file_show_in_call_log      ${driverSA}     ${message_pdf}
    uploaded_file_show_in_call_log      ${driverSA}     ${message_audio}
    uploaded_file_show_in_call_log      ${driverSA}     ${message_video}
#   上传zip文件的话，details打不开，此处已提bug：https://vipaar.atlassian.net/browse/CITRON-3575
##########################################################################################
#    uploaded_file_show_in_call_log      ${driverSA}     ${message_zip}
    # VP: the thumbnail of uploaded picture file should be shown up in Call log.
    show_thumbnail      ${driverSA}
    # Clicks the thumbnail of uploaded picture file	VP: the picture should be shown up in Preview field
    click_thumbnail_show_preview      ${driverSA}
    # Clicks the uploaded video file	VP: the Video file should be shown up in Preview field. What's more, it can be played.
    click_uploaded_video_and_play      ${driverSA}     ${message_video}
    # Clicks the other type file	VP: the file should be saved to local
    click_attach_then_download      ${driverSA}     ${message_audio}       ${downloaded_file_name}
    delete_zip_file     ${downloaded_file_name}
    click_attach_then_download      ${driverSA}     ${message_pdf}         ${downloaded_file_name}
    # User C and D1 logs in Citron, navigates to My Help Lightning -> Calls
    ${driverC}     driver_set_up_and_logIn     ${in_call_message_userC}
    switch_to_diffrent_page      ${driverC}     ${py_recents_page}     ${py_recents_switch_success}    ${py_get_number_of_rows}
    ${driverD1}     driver_set_up_and_logIn     ${in_call_message_userD1}
    switch_to_diffrent_page      ${driverD1}     ${py_recents_page}     ${py_recents_switch_success}    ${py_get_number_of_rows}
    # Select this call, click Detail button.	VP: there isn't content in Call log since the Message feature = OFF.
    calls_click_details_button      ${driverC}
    uploaded_file_show_in_call_log      ${driverC}     ${message_pdf}        not_exists
    uploaded_file_show_in_call_log      ${driverC}     ${message_audio}      not_exists
    uploaded_file_show_in_call_log      ${driverC}     ${message_video}      not_exists
    calls_click_details_button      ${driverD1}
    uploaded_file_show_in_call_log      ${driverD1}     ${message_pdf}        not_exists
    uploaded_file_show_in_call_log      ${driverD1}     ${message_audio}      not_exists
    uploaded_file_show_in_call_log      ${driverD1}     ${message_video}      not_exists
    # User A, User B & User D logs in Citron, navigates to My Help Lightning -> Calls
    ${driverA}     driver_set_up_and_logIn     ${in_call_message_userA}
    switch_to_diffrent_page      ${driverA}     ${py_recents_page}     ${py_recents_switch_success}    ${py_get_number_of_rows}
    ${driverB}     driver_set_up_and_logIn     ${in_call_message_userB}
    switch_to_diffrent_page      ${driverB}     ${py_recents_page}     ${py_recents_switch_success}    ${py_get_number_of_rows}
    ${driverD}     driver_set_up_and_logIn     ${in_call_message_userD}
    switch_to_diffrent_page      ${driverD}     ${py_recents_page}     ${py_recents_switch_success}    ${py_get_number_of_rows}
    # Select this call, click Detail button.	VP: the Messages contents should be shown up in Call log.
    calls_click_details_button      ${driverA}
    uploaded_file_show_in_call_log      ${driverA}      ${message_pdf}
    uploaded_file_show_in_call_log      ${driverA}      ${message_audio}
    uploaded_file_show_in_call_log      ${driverA}      ${message_video}
    calls_click_details_button      ${driverB}
    uploaded_file_show_in_call_log      ${driverB}      ${message_pdf}        not_exists
    uploaded_file_show_in_call_log      ${driverB}      ${message_audio}      not_exists
    uploaded_file_show_in_call_log      ${driverB}      ${message_video}      not_exists
#    User D[expert group member] 查看不到消息内容，此处已提bug：https://vipaar.atlassian.net/browse/CITRON-3577
##########################################################################################
#    calls_click_details_button      ${driverD}
#    uploaded_file_show_in_call_log      ${driverD}      ${message_pdf}
#    uploaded_file_show_in_call_log      ${driverD}      ${message_audio}
#    uploaded_file_show_in_call_log      ${driverD}      ${message_video}
    [Teardown]      run keywords    delete_zip_file     ${particial_message_audio}
    ...             AND             delete_zip_file     ${message_audio}
    ...             AND             delete_zip_file     ${screen_capture_file_name}
    ...             AND             delete_zip_file     ${downloaded_file_name}
    ...             AND             exit_driver
#
#small_range_1282_1332
#    [Documentation]     Audio+ Mode
#    [Tags]    small range 1282-1332 lines       call_case
#    # Enable Debug mode from User A starts Audio call with user B.User answers call.
#    ${driverA}     driver_set_up_and_logIn     ${in_call_message_userA}
#    ${driverB}     driver_set_up_and_logIn     ${in_call_message_userB}
#    contacts_witch_page_make_call    ${driverA}     ${driverB}     ${py_team_page}    ${in_call_message_usernameB}
#    make_sure_enter_call   ${driverB}
#    # VP: 1. "Poor Network Quality: Audio Mode" is shown in the top.
#    # 2. Not video but participant's avatar displays.
#    # 3. video source icon is red and off status.(No video source on Android).
#    # 4. Audio + displays in the bottom.
#    # 5. Show face to face mode.
#    # 6. Display participant's avatar
##    which_mode_shown_in_the_top    ${driverA}
#    display_participants_avatar    ${driverA}
#    video_source_icon_is_red_and_off    ${driverA}     ${driverB}
##    which_mode_display_in_the_bottom    ${driverA}
#    show_which_mode_in_right    ${driverA}
#    display_participants_avatar    ${driverA}
#    # More participants join call
#    ${driverD}     driver_set_up_and_logIn     ${in_call_message_userD}
#    enter_contacts_search_user      ${driverA}     ${in_call_message_expert_group}
#    click_user_in_contacts_call     ${driverA}     ${in_call_message_expert_group}
#    user_anwser_call    ${driverD}
#    which_page_is_currently_on    ${driverD}     ${end_call_button}
#    # VP: 1. "Poor Network Quality: Audio Mode" is shown in the top.
#    # 2. Not video but participant's avatar displays.
#    # 3. video source icon is red and off status(No video source on Android).
#    # 4. Audio + displays in the bottom.
#    # 5. Enter face to face mode.
#    # 6. Display participant's avatar
##    which_mode_shown_in_the_top          ${driverA}
#    display_participants_avatar          ${driverA}
#    video_source_icon_is_red_and_off     ${driverA}     ${driverB}     ${driverD}
##    which_mode_display_in_the_bottom     ${driverA}
#    show_which_mode_in_right             ${driverA}
#    display_participants_avatar          ${driverA}
#    # Switch to giving/receiving help mode
#    enter_giver_mode    ${driverA}    ${in_call_message_usernameA}    ${in_call_message_usernameB}
#    # VP: 1. For receiver:
#        # a. shown a special dialog prompting them to take one of three actions: Take New Photo, Choose Existing Photo, and Choose Document.
#        # b. text is “Audio+ Mode. Share Content("Audio+ Mode. Select content to share" on android).” .
#        # c. Display live video as vague in background.
#    shown_a_special_dialog_prompting     ${driverB}     role='receiver'
#    show_text_in_bottom                  ${driverB}
#    display_live_video_in_background     ${driverB}
#    # VP: 2. For giver:
#        # a. shown a special dialog prompting them to take one of three actions: Take New Photo, Choose Existing Photo, and Choose Document.
#        # b. text is “Audio+ Mode. Ask Receiver to Share Content.(+"Or you may share content" on android)
#        # c. Display receiver's avatar in background
#    shown_a_special_dialog_prompting     ${driverA}
#    show_text_in_bottom                  ${driverA}     which_role='giver'
#    display_which_user_avatar            ${driverA}
#    # VP. 3. For Observer:
#        # a. should not see the dialog "Take New Photo, Choose Existing Photo, and Choose Document."
#        # b. Display receiver's avatar in background.
#    shown_a_special_dialog_prompting     ${driverD}     role='observer'
#    display_which_user_avatar            ${driverD}
#    # VP: 4. 3D annotation will be disabled in Audio+ mode.
#    # VP: 5. Telestration icon is not visible
#    telestration_icon_is_or_not_visible   ${driverA}    is_visible='no'
#    telestration_icon_is_or_not_visible   ${driverB}    is_visible='no'
#    telestration_icon_is_or_not_visible   ${driverD}    is_visible='no'
#    # VP: 6. The bottom-right drop down (Audio+, SD, HD) should be shown
##    Audio_SD_HD_should_be_shown    ${driverA}
##    Audio_SD_HD_should_be_shown    ${driverB}
##    Audio_SD_HD_should_be_shown    ${driverD}    useable = 'not_sure'
#    # Giver/Receiver clicks on Source menu in action bar VP: Only photo and document submenu display.
#    click_source_menu_in_action_bar    ${driverA}     Photo    Document
#    click_source_menu_in_action_bar    ${driverB}     Photo    Document
#    # Click on Take New Photo     VP:  (web) display take photo dialog.
#    # Capture a photo    VP: "Retake" and "Use Photo" options shows in bottom
#    # Click on "Use Photo"
#        # VP: 1. For the uploader:
#            # a."Sending photo" progress bar shows in the top.
#            # b. Progress bar tracks upload bytes, then it goes to spinner until downloader sets ghop final state.
#            # c. Cancel button displays in the bottom.
#        # VP: 2. For the downloader:
#            # a. starts with a spinner until it starts downloading (should be immediate) and shows a progress bar for the bytes it has downloaded. Text is : receiving photo from uploader.
#            # b. Once at 100% it sets ghop final state.
#            # c. Cancel button should not display.
#        # VP: 3.The spinner should be shown in the notification bar.
#    ${if_has_button}    take_new_photo     ${driverA}
#    show_sending_photo_progress     ${driverA}
#    show_sending_photo_progress     ${driverB}
#    show_sending_photo_progress     ${driverD}
#    return_button_display     ${driverB}
#    return_button_display     ${driverA}
#    return_button_display     ${driverD}    display='no'
#    # Wait until entering photo mode.
#    # VP: 1. Telestration icon is visible.
#    # 2. Screen Capture button is visible.
#    # 3. Video source icon changes to Photo icon.
#    # 4. Return button displays in the bottom only for receiver.
#    # 5. Uploader sees message "You can now draw on the shared photo" in the notification bar. Other participants see message "You can now draw on uploader's photo." in the notification bar.
#    # 6. Merged Reality (Camera On) button is hidden for the Giver.
#    # 7. The bottom-right drop down (Audio+, SD, HD) should be hidden
#    telestration_icon_is_or_not_visible         ${driverA}
#    telestration_icon_is_or_not_visible         ${driverB}
#    telestration_icon_is_or_not_visible         ${driverD}
#    screen_capture_button_is_visible            ${driverA}
#    screen_capture_button_is_visible            ${driverB}
#    screen_capture_button_is_visible            ${driverD}
#    show_which_mode_in_right                    ${driverA}     which_mode='ghop_on'
#    show_which_mode_in_right                    ${driverB}     which_mode='ghop_on'
#    show_which_mode_in_right                    ${driverD}     which_mode='ghop_on'
#    show_you_can_now_draw                       ${driverA}