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
Audio_Mode_Scenario_1
    [Documentation]       always in Audio+ mode
    [Tags]     Audio+
    comment     Face to Face mode
    # User A starts Audio+ call with user B.
    ${driver_UA}     driver_set_up_and_logIn     ${close_center_mode_user1}
    ${driver_UB}     driver_set_up_and_logIn     ${close_center_mode_user2}
    contacts_witch_page_make_call       ${driver_UA}   ${driver_UB}   ${py_team_page}   ${close_center_mode_name2}
    make_sure_enter_call                ${driver_UB}
        # VP:1."Ultra-Low Bandwidth Mode" is shown in the top.
        check_in_ultra_low_bandwidth_mode     ${driver_UA}     ${driver_UB}
        # 2. Not video but participant's avatar displays.
        participant_avatar_displays     ${driver_UA}
        participant_avatar_displays     ${driver_UB}
        # 4. Retry Video Connection button displays for A and B
        retry_video_connection_button_displays     yes    ${driver_UA}     ${driver_UB}
        # 5. Show face to face mode.
        check_in_f2f_mode     ${driver_UA}
    # More participants join call
    ${driver_U3}      driver_set_up_and_logIn     ${close_center_mode_user3}
    inCall_enter_contacts_search_user   ${driver_UB}    ${close_center_mode_name3}
    click_user_in_contacts_list         ${driver_UB}     ${close_center_mode_name3}
    user_anwser_call                    ${driver_U3}
        # VP:1."Ultra-Low Bandwidth Mode" is shown in the top
        check_in_ultra_low_bandwidth_mode     ${driver_U3}
        # 2. Not video but participant's avatar displays.
        participant_avatar_displays     ${driver_U3}    3
        # 4. Retry Video Connection/ Return to Ultra-Low Bandwidth button should not display for non-cohost in the bottom.
        retry_video_connection_button_displays     no    ${driver_U3}
        return_to_ULB_button_displays     no    ${driver_U3}
        # 5. Enter face to face mode.
        check_in_f2f_mode     ${driver_UA}

    comment        Share photo
    # Anyone Share -> Take New Photo  Web: Click on "Capture and Share" button
    take_a_new_photo     ${driver_UA}
        # VP: 1. For the uploader: a."Sending photo" progress bar shows in the top. b. Progress bar tracks upload bytes, then it goes to spinner until downloader sets ghop final state. c. Cancel button displays in the bottom.
        sending_photo_info     ${driver_UA}
        # VP: 2. For the downloader: a. starts with a spinner until it starts downloading (should be immediate) and shows a progress bar for the bytes it has downloaded. Text is : receiving photo from uploader. b. Once at 100% it sets ghop final state. c. Cancel button should not display.
        receiving_file_from_anybody       ${driver_UB}    ${close_center_mode_name1}    photo
        # VP: 3.The spinner should be shown in the notification bar.
    # Wait until entering photo mode.
        # 5. All users sees message "You can now draw on the shared photo" in the notification bar. Presenter sees "You are sharing a Photo" and others see "Currently viewing Photo from xxx(presenter)" on iOS, "xxx is sharing a photo" on Android and web
        you_can_draw_shared_photo     ${driver_UA}     ${driver_UB}     ${driver_U3}
        # VP: 1. Telestration icon is visible for all participants
        telestration_icon_is_visible     yes     ${driver_UA}     ${driver_UB}     ${driver_U3}
        # 2. Clear Shared Content button should display for all users.
        clear_shared_content_button_should_display     yes     ${driver_UA}     ${driver_UB}     ${driver_U3}
        # 6. Merged button is hidden for all participants
        check_has_no_merge_menu     ${driver_UA}     ${driver_UB}     ${driver_U3}
        # 7. Retry Video Connection button is hidden.
        retry_video_connection_button_displays     no    ${driver_UA}     ${driver_UB}

    comment         Clear Shared Content for Receiver
    # photo uploader clicks on "Clear Shared Content" button
    clear_shared_content_action     ${driver_UA}
        # VP: 1. Exit Photo mode.for photo uploader: The first default view with Audio+ special dialog should display for receiver and helper.
#        audio_special_dialog_display     yes     ${driver_UA}     ${driver_UB}
        show_special_dialog_in_bottom     ${driver_UA}
        show_special_dialog_in_bottom     ${driver_UB}
        # 2. Retry Video Connection button should be shown.
        retry_video_connection_button_displays     yes    ${driver_UA}     ${driver_UB}
    # Share -> Photo lib -> enter photo mode   VP: Clear Shared Content button should display for all users
    minimize_window_action      ${driver_UA}     ${driver_UB}     ${driver_U3}
    maximize_window_action      ${driver_UA}
    inCall_upload_photo_PDF        ${driver_UA}
    maximize_window_action      ${driver_UB}     ${driver_U3}
    clear_shared_content_button_should_display     yes     ${driver_UA}     ${driver_UB}     ${driver_U3}
    # Another participant Share pdf
    minimize_window_action      ${driver_UA}     ${driver_UB}     ${driver_U3}
    maximize_window_action      ${driver_U3}
    inCall_upload_photo_PDF        ${driver_U3}      PDF       ${load_test_pdf}       no_wait
        # VP: 1. For the uploader: a."Sending document" progress bar shows in the top.
        pending_document_sharing     ${driver_U3}
        sleep   10
        # All the participants cannot do pan/zoom/telestration/screen capture.
        cannot_do_pan_zoom     no     ${driver_UA}     ${driver_UB}     ${driver_U3}
        check_has_no_capture_button    ${driver_UA}     ${driver_UB}     ${driver_U3}
    # Wait until entering PDF navigation mode
        # VP: 1. Telestration icon is visible and off status
        telestration_icon_is_usable     no     ${driver_UA}     ${driver_UB}     ${driver_U3}
        # 2. Share button on bottom is visible.
        share_button_is_visible     yes     ${driver_U3}
        # 4. Clear Shared Content button is visible for all users
        clear_shared_content_button_should_display     yes     ${driver_UA}     ${driver_UB}     ${driver_U3}
        # 6. Merged menu is hidden for all
        check_has_no_merge_menu     ${driver_UA}     ${driver_UB}     ${driver_U3}
        # 7. Retry Video Connection button is hidden
        retry_video_connection_button_displays     no    ${driver_UA}     ${driver_UB}
    # Click on Share button
    share_page     ${driver_U3}
        # 5. Message "You can now draw on the shared document." shows in the notification bar.
        you_can_now_draw_on_the_shared_document     ${driver_U3}
        # VP: 1. Enter pdf sharing mode.
        check_in_photo_pdf_whiteboard_mode     pdf sharing     ${driver_U3}
        # 2. Telestration icon is enabled.
        telestration_icon_is_visible     yes     ${driver_UA}     ${driver_UB}     ${driver_U3}
        # 4. Retry Video Connection button is hidden.
        retry_video_connection_button_displays     no    ${driver_UA}     ${driver_U3}
        # 5. Clear Shared Content button is visible for all users
        clear_shared_content_button_should_display     yes     ${driver_UA}     ${driver_UB}     ${driver_U3}
    # Uploader clicks on Return button   # VP: Back to PDF navigation mode
    click_return_after_share_page     ${driver_U3}
    check_in_photo_pdf_whiteboard_mode     pdf     ${driver_U3}

    comment         CP: Clear Shared Content in PDF navigation mode for Receiver
    # Pdf uploader clicks on Clear Shared Content button.
    clear_shared_content_action      ${driver_U3}
        # VP: 1. All participants should exit PDF mode. The first default view with Audio+ special dialog should display for pdf uploader (receiver) and helper.
        show_special_dialog_in_bottom     ${driver_U3}
        show_special_dialog_in_bottom     ${driver_UB}
        # 2. Retry Video Connection button should be shown only for cohost.
        retry_video_connection_button_displays     yes    ${driver_UA}     ${driver_UB}
    # Click share a photo on special dialog and select a picture	VP: enter photo mode
    share_photo_on_special_dialog     ${driver_U3}
    check_in_photo_pdf_whiteboard_mode     photo     ${driver_U3}
    # Anyone stop sharing button	VP: back to Face to Face mode
    stop_sharing_to_f2f     ${driver_UB}
    # End call for all
    end_call_for_all    ${driver_UB}
    [Teardown]      exit_driver

Audio_Mode_Scenario_2
    [Documentation]       switch to SD in live video
    [Tags]     Audio+
    comment     All Users Enable Debug mode from account setting
    # User A starts Audio+ call with user B.
    ${driver_UA}     driver_set_up_and_logIn     ${close_center_mode_user11}
    ${driver_UB}     driver_set_up_and_logIn     ${close_center_mode_user21}
    contacts_witch_page_make_call       ${driver_UA}   ${driver_UB}   ${py_team_page}   ${close_center_mode_name21}
    make_sure_enter_call                ${driver_UB}
    # Anonymous join in call
    ${invite_url}     send_new_invite_in_calling    ${driver_UB}
    ${driver_AU}      anonymous_open_meeting_link    ${invite_url}
    user_anwser_call       ${driver_UA}    no_direct
    # Several user join in call
    ${driver_U4}     driver_set_up_and_logIn     ${close_center_mode_user31}
    user_make_call_via_meeting_link     ${driver_U4}   ${invite_url}
    # Open Call quality from Main submenus.
        # VP: Call Quality is visible for all participants, including anonymous user;
        # VP: Ultra-Low Bandwidth is selected status
        check_in_ultra_low_bandwidth_mode      ${driver_UA}    ${driver_UB}     ${driver_AU}    ${driver_U4}
        # VP: Call quality display with HD Video, SD Video and Ultra-Low Bandwidth options.
        call_quality_display_with     ${driver_UA}    ${driver_UB}     ${driver_AU}    ${driver_U4}
    # Anyone share whiteboard
    share_whiteboard    ${driver_AU}
        # VP: 1. Telestration icon is visible for all participants
        telestration_icon_is_visible     yes     ${driver_UA}    ${driver_UB}     ${driver_AU}    ${driver_U4}
        # 2. Clear Shared Content button should display for all users
        clear_shared_content_button_should_display     yes     ${driver_UA}    ${driver_UB}     ${driver_AU}    ${driver_U4}
        # 5. Uploader sees message "You can now draw on the shared photo" in the notification bar. Other participants see message "You can now draw on uploader's photo." in the notification bar.
        you_can_draw_shared_photo     ${driver_UA}    ${driver_UB}     ${driver_AU}    ${driver_U4}
        # 6. Merged button is hidden for all participants
        check_has_no_merge_menu     ${driver_UA}    ${driver_UB}     ${driver_AU}    ${driver_U4}
        # 7. Retry Video Connection button is hidden.
        retry_video_connection_button_displays     no    ${driver_UA}     ${driver_UB}
    # Helper or Receiver clicks on Cleared Shared Content.
    clear_shared_content_action    ${driver_AU}
        # VP: All participants should exit Whiteboard mode. The first default view with Audio+ special dialog should display for whiteboard selecter (receiver) and helper.
#        audio_special_dialog_display     yes     ${driver_AU}    ${driver_UA}
        show_special_dialog_in_bottom     ${driver_UA}
        show_special_dialog_in_bottom     ${driver_UA}
    # Co-host clicks on Retry Video Connection button.
    enter_video_connection     ${driver_UA}
        # VP: 1. Is HD mode in call quality
        # Merge menu visible for all except receiver.
        check_has_merge_menu     ${driver_UA}    ${driver_UB}    ${driver_U4}
        # 3. "Audio+ Mode" message disappears.
        # 4. Return to Ultra-Low Bandwidth mode button display only for cohost.
        return_to_ULB_button_displays     yes    ${driver_UA}     ${driver_UB}
    # Another participant confirm to start merge
    click_merge_button      ${driver_U4}
    # Anonymous switch to SD from call quality	VP: Return to Ultra-Low Bandwidth mode button should display only for cohost.
    switch_to_mode_from_call_quality    ${driver_UA}    SD
    return_to_ULB_button_displays     yes    ${driver_UA}     ${driver_UB}
    # Co-host clicks on Return to Ultra-Low Bandwidth Mode button
    return_ULB_mode     ${driver_UA}
        # VP: Return to Audio+ mode. Retry Video Connection button should display only for cohost.
        retry_video_connection_button_displays     yes    ${driver_UA}     ${driver_UB}
        # VP: for who merged previously show special dialog
        show_special_dialog_in_bottom       ${driver_AU}     2
        # VP: for who shared previously show special dialog
        show_special_dialog_in_bottom       ${driver_U4}     3
   [Teardown]     exit_driver

Audio_Mode_Scenario_3
    [Documentation]       switch call quality in photo, pdf mode
    [Tags]     Audio+
    # User A starts Audio+ call with user B.
    ${driver_UA}     driver_set_up_and_logIn     ${close_center_mode_user1}
    ${driver_UB}     driver_set_up_and_logIn     ${close_center_mode_user2}
    contacts_witch_page_make_call       ${driver_UA}   ${driver_UB}   ${py_team_page}   ${close_center_mode_name2}
    make_sure_enter_call                ${driver_UB}
    # Anonymous join in call, several user C, D join in call
    ${invite_url}     send_new_invite_in_calling    ${driver_UB}
    ${driver_AU}      anonymous_open_meeting_link    ${invite_url}
    user_anwser_call       ${driver_UA}    no_direct
    ${driver_UC}      driver_set_up_and_logIn     ${close_center_mode_user3}
    user_make_call_via_meeting_link     ${driver_UC}   ${invite_url}
    ${driver_UD}      driver_set_up_and_logIn     ${close_center_mode_user4}
    user_make_call_via_meeting_link     ${driver_UD}   ${invite_url}
    # User C switch to HD
    switch_to_mode_from_call_quality    ${driver_UC}    HD
    # User B shares his live video. User C confirm merge
    share_me    ${driver_UB}
    click_merge_button     ${driver_UC}
    # Co-host clicks on Return to Ultra-Low Bandwidth Mode button
    return_ULB_mode     ${driver_UA}
        # VP: Return to Audio+ mode. Retry Video Connection button should display only for cohost.
        retry_video_connection_button_displays     yes    ${driver_UA}     ${driver_UB}
        # VP: for who merged (userC) previously show special dialog
        show_special_dialog_in_bottom   ${driver_UC}    3
        # VP: for who shared previously(userB) show special dialog
        show_special_dialog_in_bottom   ${driver_UB}    2
    # UserC taps "Take a photo" in Audio+ special dialog.     Web:Click on Capture and Share button.
    share_photo_on_special_dialog      ${driver_UC}    take

    comment         photo mode, switch
    # Wait until entering photo mode.
    check_in_photo_pdf_whiteboard_mode    photo     ${driver_UC}
        # VP: 1. Merged Reality (Camera On) button is hidden.
        check_has_no_merge_menu     ${driver_UA}     ${driver_UB}    ${driver_AU}    ${driver_UC}     ${driver_UD}
        # 2. Retry Video Connection button should be hidden.
        retry_video_connection_button_displays     no    ${driver_UA}     ${driver_UB}
    # Switch to SD mode.
    switch_to_mode_from_call_quality    ${driver_UC}    SD
        # VP: keep photo mode. All should see merge menu.
        check_in_photo_pdf_whiteboard_mode    photo     ${driver_UC}
        check_has_merge_menu     ${driver_UA}     ${driver_UB}    ${driver_AU}    ${driver_UC}     ${driver_UD}
        # Return to Ultra-Low Bandwidth Mode button should be hidden
        return_to_ULB_button_displays     no    ${driver_UA}     ${driver_UB}

    comment        pdf navigation, switch
    # User C (giver) click Share - pdf document from menu
    minimize_window_action      ${driver_UA}     ${driver_UB}    ${driver_AU}    ${driver_UC}     ${driver_UD}
    maximize_window_action      ${driver_UC}
    inCall_upload_photo_PDF        ${driver_UC}      PDF       ${load_test_pdf}      no_wait
        # For the uploader: a."Sending document" progress bar shows in the top
        pending_document_sharing     ${driver_UC}
        maximize_window_action       ${driver_UA}     ${driver_UB}    ${driver_AU}    ${driver_UC}     ${driver_UD}
        sleep   10
        # All the participants cannot do pan/zoom/telestration/screen capture.
        cannot_do_pan_zoom     no      ${driver_UA}     ${driver_UB}    ${driver_AU}    ${driver_UC}     ${driver_UD}
        check_has_no_capture_button    ${driver_UA}     ${driver_UB}    ${driver_AU}    ${driver_UC}     ${driver_UD}
    # Wait until enter PDF navigation mode.  VP: Retry Video Connection / Return to Audio+ button should be hidden.
    check_in_photo_pdf_whiteboard_mode    pdf     ${driver_UC}
    retry_video_connection_button_displays     no    ${driver_UA}     ${driver_UB}
    return_to_ULB_button_displays     no    ${driver_UA}     ${driver_UB}
    # Switch to Audio+ mode.   VP: Keep current pdf mode.
    switch_to_mode_from_call_quality    ${driver_UC}    ULB
    check_in_photo_pdf_whiteboard_mode    pdf     ${driver_UC}
    # Enter PDF sharing mode
    share_page    ${driver_UC}
        # VP: No merge menu is shown. Retry Video Connection / Return to Audio+ button should be hidden.
        check_has_no_merge_menu     ${driver_UA}     ${driver_UB}    ${driver_AU}    ${driver_UC}     ${driver_UD}
        retry_video_connection_button_displays     no    ${driver_UA}     ${driver_UB}
        return_to_ULB_button_displays     no    ${driver_UA}     ${driver_UB}
        # Clear Shared Content button should be shown
        clear_shared_content_button_should_display    yes     ${driver_UA}     ${driver_UB}    ${driver_AU}    ${driver_UC}     ${driver_UD}

    comment         CP: Clear Shared Content button & PDF Sharing mode for Receiver
    # Giver(userC) taps Clear Shared Content button.
    clear_shared_content_action       ${driver_UC}
        # VP: 1. All participants should exit PDF sharing mode. The first default view with Audio+ special dialog should display for giver and receiver.
        show_special_dialog_in_bottom   ${driver_UC}    3
        show_special_dialog_in_bottom   ${driver_UB}    2
        # 2. Retry Video Connection button should be shown only for cohost.
        retry_video_connection_button_displays     yes    ${driver_UA}     ${driver_UB}
        retry_video_connection_button_displays     no     ${driver_AU}    ${driver_UC}     ${driver_UD}
    [Teardown]     exit_driver

Audio_Mode_Scenario_6
    [Documentation]       cancel sending progress in Audio+  mode
    [Tags]     Audio+
    # Start Audio+ mode direct call, user A, B, C in call
    ${driver_UA}     driver_set_up_and_logIn     ${close_center_mode_user11}
    ${driver_UB}     driver_set_up_and_logIn     ${close_center_mode_user21}
    contacts_witch_page_make_call       ${driver_UA}   ${driver_UB}   ${py_team_page}   ${close_center_mode_name21}
    make_sure_enter_call                ${driver_UB}
    ${driver_UC}      driver_set_up_and_logIn     ${close_center_mode_user31}
    inCall_enter_contacts_search_user   ${driver_UB}    ${close_center_mode_name31}
    click_user_in_contacts_list         ${driver_UB}     ${close_center_mode_name31}
    user_anwser_call                    ${driver_UC}

    comment        Scenario 6 - 1: face to face mode
    # A select photo, then cancel	VP: back to initial status with Audio+ special dialog.
    minimize_window_action       ${driver_UA}   ${driver_UB}    ${driver_UC}
    maximize_window_action       ${driver_UA}
    inCall_upload_photo_PDF      ${driver_UA}    Photo     ${big_size_jpg}    no_wait
    click_cancel_send_button      ${driver_UA}
    show_special_dialog_in_bottom     ${driver_UA}    2-2
    # B select a pdf	VP: no cancel button. Enter pdf navigation mode automatically.
    minimize_window_action       ${driver_UA}
    maximize_window_action       ${driver_UB}
    inCall_upload_photo_PDF      ${driver_UB}    PDF     ${big_size_pdf}    no_wait
    check_has_not_cancel_button    ${driver_UB}
    check_in_photo_pdf_whiteboard_mode    pdf     ${driver_UB}
    # B cancel on entering pdf markup mode	VP: keep in PDF navigation mode.

    comment         Scenario 6 - 2 : pdf to photo
    # B select a pdf in navigation mode
    # A select photo, then cancel	VP: back to initial status with Audio+ special dialog.
    minimize_window_action       ${driver_UB}
    maximize_window_action       ${driver_UA}
    inCall_upload_photo_PDF      ${driver_UA}    Photo     ${big_size_jpg}    no_wait
    click_cancel_send_button      ${driver_UA}
    show_special_dialog_in_bottom     ${driver_UA}    3

    comment         Scenario 6 - 3 : photo to pdf
    # A select photo, B select pdf file	VP: pdf navigation mode
    inCall_upload_photo_PDF      ${driver_UA}
    minimize_window_action       ${driver_UA}
    maximize_window_action       ${driver_UB}
    inCall_upload_photo_PDF      ${driver_UB}    PDF
    # B cancel on entering pdf markup mode	VP: back to pdf navigation mode
    check_in_photo_pdf_whiteboard_mode    pdf     ${driver_UB}
    [Teardown]     exit_driver

Audio_Mode_Scenario_7
    [Documentation]       cancel sending progress in video mode.
    [Tags]     Audio+
    # Start Audio+ mode direct call, user A, B, C in call
    ${driver_UA}     driver_set_up_and_logIn     ${close_center_mode_user1}
    ${driver_UB}     driver_set_up_and_logIn     ${close_center_mode_user2}
    contacts_witch_page_make_call       ${driver_UA}   ${driver_UB}   ${py_team_page}   ${close_center_mode_name2}     accept    video
    make_sure_enter_call                ${driver_UB}
    ${driver_UC}      driver_set_up_and_logIn     ${close_center_mode_user3}
    inCall_enter_contacts_search_user   ${driver_UB}    ${close_center_mode_name3}
    click_user_in_contacts_list         ${driver_UB}     ${close_center_mode_name3}
    user_anwser_call                    ${driver_UC}

    comment         Scenario 7-1: freeze
    # A share me, B confirm merge
    share_me     ${driver_UA}
    click_merge_button    ${driver_UB}
    # Anyone taps freeze icon	VP: only receiver can see cancel button.
    freeze_operation     ${driver_UA}    freeze     no_check
    # A click cancel as soon as possible	VP: back to A is in shared, B is in Merged, C is observing
    click_cancel_send_button      ${driver_UA}
    check_has_merged      ${driver_UB}
    check_has_merge_menu       ${driver_UC}

    comment         Scenario 7- 2 : freeze to photo
    # A share me, B confirm merge
    # A selects a photo and cancels sending progress.	VP: back to A is in shared, B is in Merged, C is observing
    minimize_window_action       ${driver_UA}   ${driver_UB}    ${driver_UC}
    maximize_window_action       ${driver_UA}
    inCall_upload_photo_PDF      ${driver_UA}    Photo     ${big_size_jpg}    no_wait
    click_cancel_send_button      ${driver_UA}
    check_has_merged      ${driver_UB}
    check_has_merge_menu       ${driver_UC}

    comment         Scenario 7-3: freeze to pdf
    # A share me, B confirm merge
    # B select pdf in navigation mode
    minimize_window_action       ${driver_UA}
    maximize_window_action       ${driver_UB}
    inCall_upload_photo_PDF      ${driver_UB}    PDF
    # B cancel on entering pdf markup mode	VP: A, B, C are in pdf navigation mode
    check_in_photo_pdf_whiteboard_mode    pdf     ${driver_UB}
    [Teardown]     exit_driver

Audio_Mode_Scenario_10
    [Documentation]        camera permission is denied
    [Tags]     Audio+
    # User A and B denies camera permission. User A starts video call or meeting call with user B. User B answers call. Make call in HD & F2F mode.
    ${driver_UA}     driver_set_up_and_logIn     ${close_center_mode_user11}    ${public_pass}     accept     not_set_disturb     close_camera
    ${driver_UB}     driver_set_up_and_logIn     ${close_center_mode_user21}    ${public_pass}     accept     not_set_disturb     close_camera
    contacts_witch_page_make_call       ${driver_UA}   ${driver_UB}   ${py_team_page}   ${close_center_mode_name21}     accept    video
        # VP: camera icon is not visible in F2F mode. “Share my camera" option is hidden from Share menu.
        check_can_not_share_sb_live_video     My Camera    ${driver_UA}   ${driver_UB}
    # User A shares user B's live video.
    share_live_video_from_sb     ${driver_UA}    ${close_center_mode_name21}
        # VP: Start Video dialog should display for giver and receiver.
        # Web/IOS: Receiver should see option Shar a Photo. Giver should see options Share a Document and Share a Photo.
        start_video_dialog_display     ${driver_UA}     giver     ${close_center_mode_name21}
        start_video_dialog_display     ${driver_UB}
    # Giver(userA) selects a photo and cancels sending progress.
    # Switch to Audio+ mode.
    switch_to_mode_from_call_quality    ${driver_UA}    ULB
        # VP: Start Video dialog should display for giver and receiver.
        # Web/IOS: Receiver should see option Shar a Photo. Giver should see options Share a Document and Share a Photo.
        show_special_dialog_in_bottom     ${driver_UA}     2-1
        show_special_dialog_in_bottom     ${driver_UB}     1
    # Giver chooses a photo and wait until entering photo mode.
    minimize_window_action     ${driver_UA}     ${driver_UB}
    maximize_window_action     ${driver_UA}
    share_photo_on_special_dialog    ${driver_UA}
    maximize_window_action     ${driver_UB}
    # VP: Clear Shared Content button should display
    clear_shared_content_button_should_display     yes     ${driver_UA}     ${driver_UB}
    # Receiver taps Clear Shared Content button.	VP: All participants exit photo mode. Back to initial status with Audio+ special dialog.
    clear_shared_content_action      ${driver_UB}
    show_special_dialog_in_bottom     ${driver_UA}     2-1
    show_special_dialog_in_bottom     ${driver_UB}     1
    # Receiver selects a PDF, taps Share button, wait until entering sharing PDF mode.
    minimize_window_action     ${driver_UA}     ${driver_UB}
    maximize_window_action     ${driver_UB}
    inCall_upload_photo_PDF    ${driver_UB}     PDF
    share_page      ${driver_UB}
    check_in_photo_pdf_whiteboard_mode     pdf sharing     ${driver_UB}
    [Teardown]     exit_driver


Audio_Mode_Scenario_another_1
    [Documentation]       Call Center Mode is on. Enable agent's camera is on.
    [Tags]     Audio+
    # User A starts Audio call with user B.
    ${driver_UA}     driver_set_up_and_logIn     ${center_mode_user1}
    ${driver_UB}     driver_set_up_and_logIn     ${center_mode_user2}
    contacts_witch_page_make_call       ${driver_UA}   ${driver_UB}   ${py_team_page}   ${center_mode_username2}
    make_sure_enter_call                ${driver_UB}
    # User C, D join call.
    ${invite_url}     send_new_invite_in_calling    ${driver_UB}
    ${driver_UC}     driver_set_up_and_logIn     ${center_mode_user3}
    user_make_call_via_meeting_link     ${driver_UC}   ${invite_url}
    ${driver_UD}     driver_set_up_and_logIn     ${center_mode_user4}
    user_make_call_via_meeting_link     ${driver_UD}   ${invite_url}
        # VP: 3D annotation will be disabled in Audio+ mode.
        # VP: Telestration icon is not visible.
        telestration_icon_is_visible    no   ${driver_UA}    ${driver_UB}    ${driver_UC}    ${driver_UD}
        # VP: Retry Video Connection button displays in the bottom only for cohost.
        retry_video_connection_button_displays     yes    ${driver_UA}     ${driver_UB}
        retry_video_connection_button_displays     no     ${driver_UC}     ${driver_UD}
            # 1. For user B:
            # a. shown a special dialog : Take a Photo, Share a Photo.
            show_special_dialog_in_bottom     ${driver_UB}
            # b. text is “Ultra-Low Bandwidth Mode. Select content to share.”.
            special_dialog_text    ${driver_UB}
            # c. Display live video as vague in background.
            # 2. For User A:
            # a.shown a special dialog: Take a Photo,Share a Document, Share a Photo.
            show_special_dialog_in_bottom     ${driver_UA}     3
            # b. text is “Ultra-Low Bandwidth Mode. Ask others to Take a Photo or Share Content.
            special_dialog_text     ${driver_UA}    ask
            # c. Display receiver's avatar in background.
    # B click takes a photo    VP: enter photo mode. Clear Shared Content button should
    share_photo_on_special_dialog      ${driver_UB}    take
    clear_shared_content_button_should_display     yes     ${driver_UA}     ${driver_UB}     ${driver_UC}     ${driver_UD}
    # Switch to HD/SD mode.	VP: keep photo mode. Stop sharing should be hidden from Share menu when call center mode on.
    switch_to_mode_from_call_quality    ${driver_UB}    SD
    check_in_photo_pdf_whiteboard_mode     photo     ${driver_UB}
    # C start merge	VP: keep in photo mode; C's live video is on screen.
    click_merge_button      ${driver_UC}
    check_in_photo_pdf_whiteboard_mode     photo     ${driver_UB}
    # Switch to Audio+ mode.	VP: Clear Shared Content button should
    switch_to_mode_from_call_quality    ${driver_UB}    ULB
    # User C taps Clear Shared Content button.
    clear_shared_content_action      ${driver_UC}
        # VP: 1. Exit photo mode for all participants.
        # 2. Shown the Audio+ special dialog for giver and receiver (C and B)	VP: C see giver's dialog, B see receiver's dialog
        show_special_dialog_in_bottom     ${driver_UB}
        show_special_dialog_in_bottom     ${driver_UC}    3
            # VP: C see giver's dialog, B see receiver's dialog
    # B selects a PDF, enter markup mode	VP: Clear Shared Content button should display for
    minimize_window_action     ${driver_UA}     ${driver_UB}     ${driver_UC}     ${driver_UD}
    maximize_window_action     ${driver_UB}
    inCall_upload_photo_PDF    ${driver_UB}      PDF
    maximize_window_action     ${driver_UA}     ${driver_UC}     ${driver_UD}
    clear_shared_content_button_should_display      yes     ${driver_UA}     ${driver_UB}     ${driver_UC}     ${driver_UD}
    # Switch to HD/SD mode.   VP: No one is merged status; keep pdf markup mode
    switch_to_mode_from_call_quality    ${driver_UB}    HD
    check_has_no_merge_menu      ${driver_UA}     ${driver_UB}     ${driver_UC}     ${driver_UD}
    check_in_photo_pdf_whiteboard_mode    pdf     ${driver_UB}
    [Teardown]      exit_driver

#Audio_Mode_Scenario_another_2
#    [Documentation]       Call Center Mode is on. Enable agent's camera is off.
#    [Tags]     Audio+
#    comment      该case无法构造bad network condition，因此部分检查点无法检查
#    # User A starts video call to B
#    ${driver_UA}     driver_set_up_and_logIn     ${camera_off_user1}
#    ${driver_UB}     driver_set_up_and_logIn     ${camera_off_user2}
#    contacts_witch_page_make_call       ${driver_UA}   ${driver_UB}   ${py_team_page}   ${camera_off_username2}    accept    video
#    make_sure_enter_call                ${driver_UB}
#        # VP: Both users should not see merge menu.
#        check_has_no_merge_menu      ${driver_UA}     ${driver_UB}
#        # VP: Buttons: Retry Video Connection on bottom right.
#    # User C, D join call.
#    ${invite_url}     send_new_invite_in_calling    ${driver_UB}
#    ${driver_UC}     driver_set_up_and_logIn     ${camera_off_user3}
#    user_make_call_via_meeting_link     ${driver_UC}   ${invite_url}
#    ${driver_UD}     driver_set_up_and_logIn     ${camera_off_user4}
#    user_make_call_via_meeting_link     ${driver_UD}   ${invite_url}
#    # Click Retry Video Connection button.	VP: Call should be switched to HD mode. Return to Ultra-Low Bandwidth mode button should display only for cohost.
#    enter_video_connection     ${driver_UA}
#    return_to_ULB_button_displays     yes    ${driver_UA}     ${driver_UB}
#    return_to_ULB_button_displays     no     ${driver_UC}     ${driver_UD}
#    # Click on Return to Return to Ultra-Low Bandwidth modebutton.
#    return_ULB_mode    ${driver_UA}
#        # VP: For user B: receiver special dialog; Display live video as vague in background
#        show_special_dialog_in_bottom    ${driver_UB}
#        # VP: for user A: can not merge; giver special dialog
#        check has no merge menu   ${driver_UA}
#        show_special_dialog_in_bottom     ${driver_UA}    3
#        # For Others: a. should not see the dialog. b. Display receiver's avatar in background
#        not_show_special_dialog_in_bottom     ${driver_UC}     ${driver_UD}
#        # VP: 4. 3D annotation will be disabled in Audio+ mode.
#        # VP: 5. Telestration icon is not visible.
#        telestration_icon_is_visible    no    ${driver_UA}     ${driver_UB}     ${driver_UC}     ${driver_UD}
#        # VP: 6. Retry Video Connection button displays in the bottom only for cohost
#        retry_video_connection_button_displays     yes    ${driver_UA}     ${driver_UB}
#        retry_video_connection_button_displays     no     ${driver_UC}     ${driver_UD}
#    # B share - pdf document
#    inCall_upload_photo_PDF     ${driver_UB}      PDF
#    # Switch to HD/SD mode.	VP: keep pdf navigation mode
#    switch_to_mode_from_call_quality    ${driver_UB}    HD
#    check_in_photo_pdf_whiteboard_mode     pdf     ${driver_UB}
#    # Enter pdf markup mode	VP: user A can not merge, others can merge,
#    check_has_no_merge_menu     ${driver_UA}
#    check_has_merge_menu        ${driver_UB}     ${driver_UC}     ${driver_UD}
#    # User D click share me	VP: user A can not merge (Because camera is OFF)
#    share_me      ${driver_UD}
#    # User C starts merge.
#    click_merge_button     ${driver_UC}
#    # Switch to Audio+ mode.	VP: C shows giver special dialog; D shows receiver special dialog
#    switch_to_mode_from_call_quality    ${driver_UC}    ULB
#
#    # C leave call	Call end for all
#    end_call_for_all      ${driver_UC}