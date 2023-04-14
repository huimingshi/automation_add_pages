*** Settings ***
Library           Selenium2Library
Library           OperatingSystem
Resource          ../../../Lib/public.robot
Library           call_python_Lib/call_action_lib_copy.py
Resource          ../../../Lib/calls_resource.robot
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
        button_not_display_for_non_host    ${driver_U3}    1    2
        # 5. Enter face to face mode.
        check_in_f2f_mode     ${driver_UA}

    sleep   10000
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
        audio_special_dialog_display     yes     ${driver_UA}     ${driver_UB}
        # 2. Retry Video Connection button should be shown.
        retry_video_connection_button_displays     yes    ${driver_UA}     ${driver_UB}
    # Share -> Photo lib -> enter photo mode   VP: Clear Shared Content button should display for all users
    minimize_window_action      ${driver_UA}     ${driver_UB}     ${driver_U3}
    maximize_window_action      ${driver_UA}
    inCall_upload_photo_PDF        ${driver_UA}
    maximize_window_action      ${driver_UB}     ${driver_U3}
    clear_shared_content_button_should_display     yes     ${driver_UA}     ${driver_UB}     ${driver_U3}
