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
Force Tags        small_range


*** Test Cases ***
Small_range_1220_1281
    [Documentation]     In call message
    [Tags]    small range 1260-1281 lines
    [Setup]   delete_zip_file     ${message_audio}
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
    send_message_by_different_file     ${driverA}     ${message_zip}    in_call
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
    # Select this call, click Detail button.	VP: the uploaded file should be shown up in Call log
    # 	VP: the thumbnail of uploaded picture file should be shown up in Call log.
    # Clicks the thumbnail of uploaded picture file	VP: the picture should be shown up in Preview field
    # Clicks the uploaded video file	VP: the Video file should be shown up in Preview field. What's more, it can be played.
    # Clicks the other type file	VP: the file should be saved to local
    # User C and D1 logs in Citron, navigates to My Help Lightning -> Calls
    # Select this call, click Detail button.	VP: there isn't content in Call log since the Message feature = OFF.
    # User A, User B & User D logs in Citron, navigates to My Help Lightning -> Calls
    # Select this call, click Detail button.	VP: the Messages contents should be shown up in Call log.
    [Teardown]      run keywords    delete_zip_file     ${particial_message_audio}
    ...             AND             delete_zip_file     IMG_CAP
    ...             AND             exit_driver