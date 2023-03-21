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
Force Tags        call_case


*** Test Cases ***
call_center_Scenario_1
    [Documentation]
    [Tags]     Call Center     call_case
    # User A calls user B. User B answers call.
    ${driver_U1}     driver_set_up_and_logIn     ${center_mode_user1}
    ${driver_U2}     driver_set_up_and_logIn     ${center_mode_user2}
    contacts_witch_page_make_call       ${driver_U1}   ${driver_U2}   ${py_team_page}   ${center_mode_username2}    audio='Video'
    make_sure_enter_call                ${driver_U2}
        # VP:1. begin with Collaboration mode.
        check_with_collaboration_mode     ${driver_U1}
        # 2. User A is able to start merge.
        check_has_no_merged     ${driver_U1}
        # 3.User B is receiver. Receiver’s camera auto-switched to their rear-facing cam.
        check_is_receiver     ${driver_U2}
    # VP:both giver and receiver's video displays  VP: giver and receiver can not stop share to back to Face to Face mode
    check_can_or_not_stop_share    ${driver_U1}
    check_can_or_not_stop_share    ${driver_U2}
    # User A click share me    VP: User A is receiver now
    share_me    ${driver_U1}
    check_is_receiver     ${driver_U1}
    # User B start merge   VP: User A is receiver. User B is giver.
    click_merge_button     ${driver_U2}
    check_is_receiver     ${driver_U1}
    check_is_giver     ${driver_U2}
    # User C joins call via user A's invite
    ${driver_U3}     driver_set_up_and_logIn     ${center_mode_user3}
    ${invite_url}    send_new_invite_in_calling    ${driver_U1}
    user_make_call_via_meeting_link    ${driver_U3}    ${invite_url}
    # User C click freeze to Enter freezing mode
    freeze_operation    ${driver_U3}
    # User C try to stop share VP: can not stop share, back to face to face mode
    check_can_or_not_stop_share   ${driver_U3}
    # User A share photo
    minimize_window_action     ${driver_U1}    ${driver_U2}     ${driver_U3}
    maximize_window_action     ${driver_U1}
    inCall_upload_photo_PDF    ${driver_U1}
    # user B share photo
    minimize_window_action     ${driver_U1}    ${driver_U2}     ${driver_U3}
    maximize_window_action     ${driver_U2}
    inCall_upload_photo_PDF    ${driver_U2}
    # Enter photo mode. Co-host keep current receiver, change giver.	VP:keep photo mode + B's live video
    maximize_window_action     ${driver_U1}    ${driver_U3}
    check_in_photo_pdf_whiteboard_mode         ${driver_U1}      ${driver_U2}
    # User C click share me	  VP:exit photo mode, C's live video
    share_me     ${driver_U3}
    # Co-host tries to remove giver (user B)(not host user A)	VP: Display message "If you remove giver, call will end for all participants"	VP: "Are you sure you want to remove <USER NAME>?"
    co_host_remove_sb     ${driver_U1}    ${center_mode_username2}     if_giver='not_giver'
    # Confirm yes	VP: call ends for all the participants
    which_page_is_currently_on     ${driver_U1}    ${end_call_message}

call_center_Scenario_2
    [Documentation]
    [Tags]     Call Center     call_case
    # Different workspace user B clicks on user A's MHS link. User A answers call.
    ${driver_U1}     driver_set_up_and_logIn     ${center_mode_user1}
    ${invite_url}    send_meeting_room_link    ${driver_U1}     MHS
    ${driver_DUB}     driver_set_up_and_logIn     ${center_mode_user11}
    user_make_call_via_meeting_link    ${driver_DUB}    ${invite_url}
    user_anwser_call     ${driver_U1}
        # VP: 1.Skip face-to-face mode and go straight to Collaboration mode.
        check_with_collaboration_mode     ${driver_U1}
        # 2. User A is giver
        check_is_giver     ${driver_U1}
        # 3.User B is receiver. Receiver’s camera auto-switched to their rear-facing cam.
        check_is_receiver     ${driver_DUB}
    # Agent start merge	VP: both giver and receiver's video displays
    click_merge_button     ${driver_U1}
    # Agent stop merge	VP: only display receiver's video.

    # Agent share pdf

call_center_Scenario_4
    [Documentation]
    [Tags]     Call Center     call_case
    # User B starts expert group call. Expert User A answers call.
    ${driver_E1}     driver_set_up_and_logIn     ${center_mode_expert}
    ${driver_U2}     driver_set_up_and_logIn     ${center_mode_user1}
    contacts_witch_page_make_call       ${driver_U2}   ${driver_E1}   ${py_team_page}   ${center_mode_on_call_group}    audio='Video'
        # VP: 1.Skip face-to-face mode and go straight to Collaboration mode with only user B's video.
        check_with_collaboration_mode    ${driver_U2}
        should_see_camera_button         ${driver_U2}
        # 2. User A is giver and should not see camera hint dialog if camera is pointed at not light field.
        should_see_camera_button        ${driver_E1}    not_see
        # 3.User B is receiver. Receiver’s camera auto-switched to their rear-facing cam.
    # Anonymous user C, user D joins call via 3pi link.
    ${invite_url}    send_new_invite_in_calling    ${driver_E1}
    ${driver_C}     anonymous_open_meeting_link    ${invite_url}
    user_anwser_call     ${driver_E1}    not_direct
    ${driver_D}     anonymous_open_meeting_link    ${invite_url}
    user_anwser_call     ${driver_E1}    not_direct
    # User A clicks on Share icon.	VP: take a new photo option should not display.
    has_no_take_a_new_photo_option      ${driver_E1}
    # User A uploads photo	VP: enter photo mode
    minimize_window_action        ${driver_E1}     ${driver_U2}     ${driver_C}     ${driver_D}
    maximize_window_action          ${driver_E1}
    inCall_upload_photo_PDF         ${driver_E1}
    check_in_photo_pdf_whiteboard_mode     ${driver_E1}     ${driver_U2}     ${driver_C}     ${driver_D}
    # Giver or receiver leaves call.	VP: call ends for all the participants
    leave_call        ${driver_E1}
    which_page_is_currently_on     ${driver_D}    ${end_call_message}