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
    [Tags]     Call Center
    # User A calls user B. User B answers call.
    ${driver_U1}     driver_set_up_and_logIn     ${center_mode_user1}
    ${driver_U2}     driver_set_up_and_logIn     ${center_mode_user2}
    contacts_witch_page_make_call       ${driver_U1}   ${driver_U2}   ${py_team_page}   ${center_mode_username2}    audio='Video'
    make_sure_enter_call                ${driver_U2}
    sleep   10000
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
    check_in_photo_pdf_whiteboard_mode         photo    ${driver_U1}      ${driver_U2}
    # User C click share me	  VP:exit photo mode, C's live video
    share_me     ${driver_U3}
    # Co-host tries to remove giver (user B)(not host user A)	VP: Display message "If you remove giver, call will end for all participants"	VP: "Are you sure you want to remove <USER NAME>?"
    co_host_remove_sb     ${driver_U1}    ${center_mode_username2}    can   yes   giver
    # Confirm yes	VP: call ends for all the participants
    which_page_is_currently_on     ${driver_U1}    ${end_call_message}

call_center_Scenario_2
    [Documentation]
    [Tags]     Call Center     但这个cae，在我本地无法执行，始终会出现checking network quality，且没有merge按钮出现
    # Different workspace user B clicks on user A's MHS link. User A answers call.
    ${driver_UA}     driver_set_up_and_logIn     ${center_mode_user1}
    ${invite_url}    send_meeting_room_link    ${driver_UA}     MHS
    ${driver_DUB}     driver_set_up_and_logIn     ${center_mode_user11}
    user_make_call_via_meeting_link    ${driver_DUB}    ${invite_url}
    user_anwser_call     ${driver_UA}
        # VP: 1.Skip face-to-face mode and go straight to Collaboration mode.
        check_with_collaboration_mode     ${driver_UA}
        # 2. User A is giver
        check_is_giver     ${driver_UA}
        # 3.User B is receiver. Receiver’s camera auto-switched to their rear-facing cam.
        check_is_receiver     ${driver_DUB}
    # Agent start merge	VP: both giver and receiver's video displays
    click_merge_button     ${driver_UA}
    # Agent stop merge	VP: only display receiver's video.
    stop_merge_action     ${driver_UA}
    # Agent share pdf
    inCall_upload_photo_PDF     ${driver_UA}
    # Enter pdf sharing mode. User C joins call via user A's mhs link. User A clicks on Mode Share icon.	VP: Face to Face submenu is hidden; No one can stop sharing
    check_in_photo_pdf_whiteboard_mode    pdf   ${driver_UA}
    ${driver_UC}     driver_set_up_and_logIn     ${center_mode_user2}
    user_make_call_via_meeting_link    ${driver_UC}    ${invite_url}
    check_can_or_not_stop_share     ${driver_UA}
    # User C start merge	VP: pdf mode with C's live video
    click_merge_button     ${driver_UC}
    check_in_photo_pdf_whiteboard_mode     pdf   ${driver_UC}
    # User D joins call via invited. Co-host tries to removes observer	VP: Display message "Are you sure you want to remove user D?"
    ${driver_UD}     driver_set_up_and_logIn     ${center_mode_user3}
    user_make_call_via_meeting_link    ${driver_UD}    ${invite_url}
    # Confirm yes	VP: keep current mode. Related user is removed
    co_host_remove_sb     ${driver_DUB}    ${center_mode_username3}
    display_users_as_joined_order     ${driver_UA}    ${center_mode_username11}     ${center_mode_user2}
    # Co-host tries to removes receiver	VP: Display message "If you remove receiver, call will end for all participants"
    # Confirm yes	VP: call ends for all the participants.
    co_host_remove_sb     ${driver_DUB}    ${center_mode_username1}    can   yes     receiver
    which_page_is_currently_on     ${driver_DUB}    ${end_call_message}

call_center_Scenario_3
    [Documentation]     Test Point: Agent has no opportunity to show his video, always disabled; Receiver’s camera auto-switched to their rear-facing cam.
    [Tags]     Call Center     但这个cae，在我本地无法执行，始终会出现checking network quality，且没有展示user B's video.
    ###### 预置条件Workspace Setting: Call Center Mode is ON. "Enable agent‘s camera" is off
    # UserA send OTU link
    ${driver_UA}     driver_set_up_and_logIn     ${camera_off_user1}
    ${invite_url}    send_meeting_room_link    ${driver_UA}     OTU
    # Anonymous user B clicks on user A's OTU link. User A answers call.
    ${driver_UB}     anonymous_open_meeting_link    ${invite_url}
    user_anwser_call    ${driver_UA}
        # VP: 1.Skip face-to-face mode and go straight to Collaboration mode with only user B's video.
        check_with_collaboration_mode    ${driver_UA}
        # 2. User A is giver and should not see camera hint dialog if camera is pointed at not light field
        should_see_camera_button        ${driver_UA}     not_see
        # 3.User B is receiver.
        # VP: User A is not merged. User A can not start merge. A's camera is disabled.
        check_has_no_merge_menu       ${driver_UA}
        check_has_no_merged       ${driver_UA}
    # User A click freeze	VP: UserB's screen is frozen
    freeze_operation     ${driver_UA}
    # User A click share photo
    inCall_upload_photo_PDF     ${driver_UA}
    # User B click start merge	VP: User B's live video is shown; A or B can not freeze because receiver has no live video now.
    click_merge_button    ${driver_UB}
    # User A click share User B's live video
    share_live_video_from_sb     ${driver_UA}    ${anonymous_user_name}
    # Anonymous user C, user D joins call via 3pi link or OTU link.
    ${driver_UC}     anonymous_open_meeting_link    ${invite_url}
    user_anwser_call    ${driver_UA}    not_direct
    ${driver_UD}     anonymous_open_meeting_link    ${invite_url}
    user_anwser_call    ${driver_UA}    not_direct
    # Try to turn on co-host for Anonymous user C	VP: anonymous user can not be promote to co-host
    turn_on_co_host_for_sb     ${driver_UA}     Anonymous 2    gray
    # Anonymous user C start merge	VP: User C's live video shows, together with B's frozen screen
    click_merge_button    ${driver_UC}
    # Anonymous user C un-freeze	VP: User B is un-frozen
    freeze_operation     ${driver_UC}    un_freeze
    # User A end call for all
    end_call_for_all      ${driver_UA}

call_center_Scenario_4
    [Documentation]
    [Tags]     Call Center
    # User B starts expert group call. Expert User A answers call.
    ${driver_E1}     driver_set_up_and_logIn     ${camera_off_expert}
    ${driver_U2}     driver_set_up_and_logIn     ${camera_off_user1}
    contacts_witch_page_make_call       ${driver_U2}   ${driver_E1}   ${py_team_page}   ${camera_off_on_call_group}    audio='Video'
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
    check_in_photo_pdf_whiteboard_mode     photo   ${driver_E1}     ${driver_U2}     ${driver_C}     ${driver_D}
    # Giver or receiver leaves call.	VP: call ends for all the participants
    leave_call        ${driver_E1}
    which_page_is_currently_on     ${driver_D}    ${end_call_message}