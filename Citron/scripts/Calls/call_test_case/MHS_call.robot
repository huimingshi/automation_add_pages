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
MHS_call_Scenario_1
    [Documentation]      Key Point: Anonymous can not be promote to co-host; can not turn off co-host for 2pc call
    [Tags]     MHS Call
    # Precondition: TU1, EU2, U3 are in the same enterprise A.  TU1 clicks on EU2’s mhs link. EU2 answers call.
    # Precondition: tag/comment is on, survey is off.
    ${driver_TU1}     driver_set_up_and_logIn     ${Team_User1_username}
    ${driver_EU2}     driver_set_up_and_logIn     ${Expert_User2_username}
    ${MHS_url}    send_meeting_room_link    ${driver_EU2}     MHS
    user_make_call_via_meeting_link    ${driver_TU1}    ${MHS_url}
    user_anwser_call     ${driver_EU2}
    # EU2 invites U3 from contact list. U3 answers call.    VP: participants icon is visible for TU1 and EU2, but invisible for U3.
    ${driver_U3}     driver_set_up_and_logIn     ${Expert_User3_username}
    inCall_enter_contacts_search_user    ${driver_EU2}     ${Expert_User3_name}
    click_user_in_contacts_list          ${driver_EU2}     ${Expert_User3_name}
    user_anwser_call     ${driver_U3}
    participants_icon_is_visible    yes     ${driver_TU1}      ${driver_EU2}
    participants_icon_is_visible    no      ${driver_U3}
    # Following users join call in sequence: Anonymous user 4 via MHS link. Logged in user 5 via MHS link. User 6 via 3pi link
    ${driver_AU4}     anonymous_open_meeting_link    ${MHS_url}
    user_anwser_call     ${driver_EU2}    not_direct
    ${driver_U5}     driver_set_up_and_logIn     ${Expert_User5_username}
    user_make_call_via_meeting_link    ${driver_U5}    ${MHS_url}
    user_anwser_call     ${driver_EU2}    not_direct
    ${driver_U6}     driver_set_up_and_logIn     ${Team_User2_username}
    ${invite_url}     send_new_invite_in_calling     ${driver_EU2}
    user_make_call_via_meeting_link    ${driver_U6}    ${invite_url}
        # VP: 1. participants icon is invisible for the three users.
        participants_icon_is_visible     no      ${driver_AU4}   ${driver_U5}   ${driver_U6}
        # 2. Invite button should be hidden for users in enterprise A.
        invite_button_is_hidden     ${driver_TU1}     ${driver_EU2}
        # 3. Display users as joined order.
        display_users_as_joined_order    ${driver_TU1}   ${Expert_User2_name}    ${Expert_User3_name}    ${anonymous_user_name}   ${Expert_User5_name}   ${Team_User2_name}
        # 4. There should be one dot when 3-4 participants; two dots when 5-8 participants; 3 dots when 8-12 participants
        check_two_dots   ${driver_TU1}
            # VP: only host and co-host has participants icon;   上个校验点已校验
            # add people button is hidden, as meeting zoom is full; user name avatar display as join sequence;   上个校验点已校验
                # VP: F2F mode;
                check_in_f2f_mode     ${driver_TU1}
                # VP: Web Desktop only - for the host/co-host, "Share Live Video from: <other participant(First one if multi)>"button
                check_show_share_live_video_from    ${driver_TU1}     ${driver_EU2}
                check_not_show_share_live_video_from     ${driver_U3}     ${driver_AU4}   ${driver_U5}   ${driver_U6}
    # TU1 Share live video
    share_me        ${driver_TU1}
    # TU1 swap camera

    # co-host EU2 start merge	VP: enter merged reality mode with correct giver and receiver, other users are observer.
    click_merge_button       ${driver_EU2}
    check_has_merged         ${driver_EU2}
    check_is_receiver        ${driver_TU1}
    check_is_giver           ${driver_EU2}

    comment      Enter photo mode.
    # U3 enters photo mode (take photo via camera)	VP: enter photo mode.
    take_a_new_photo        ${driver_U3}
    check_in_photo_pdf_whiteboard_mode      photo     ${driver_U3}
    # U3 click Share menu again	VP: Take a New photo option is highlight
    check_if_is_highlight      ${driver_U3}     Take a New Photo
    #  U3 click merge menu   U3 select different camera on merge preview
    click_merge_button       ${driver_U3}
    # AU4 start merge
    click_merge_button       ${driver_AU4}
    # U3 uploads a new photo from gallery
    minimize_window_action        ${driver_TU1}   ${driver_EU2}    ${driver_U3}   ${driver_AU4}   ${driver_U5}   ${driver_U6}
    maximize_window_action        ${driver_U3}
    inCall_upload_photo_PDF       ${driver_U3}
    maximize_window_action        ${driver_AU4}
    # AU4 uploads a new photo via camera	VP: new photo is loaded for all the participants.
    take_a_new_photo              ${driver_AU4}
    # Giver (AU4) stop merge	VP: photo, no live video
    stop_merge_action             ${driver_AU4}
    check_in_photo_pdf_whiteboard_mode      photo     ${driver_AU4}
    [Teardown]      exit_driver

MHS_call_Scenario_2
    [Documentation]      remove giver/receiver/observer in photo mode
    [Tags]     MHS Call
    # Precondition: TU1, EU2, U3 are in the same enterprise A.  TU1 clicks on EU2’s mhs link. EU2 answers call.
    ${driver_TU1}     driver_set_up_and_logIn     ${Team_User1_username}
    ${driver_EU2}     driver_set_up_and_logIn     ${Expert_User2_username}
    ${MHS_url}    send_meeting_room_link    ${driver_EU2}     MHS
    user_make_call_via_meeting_link    ${driver_TU1}    ${MHS_url}
    user_anwser_call     ${driver_EU2}
    # EU2 invites U3 from contact list. U3 answers call.    VP: participants icon is visible for TU1 and EU2, but invisible for U3.
    ${driver_U3}     driver_set_up_and_logIn     ${Expert_User3_username}
    inCall_enter_contacts_search_user    ${driver_EU2}     ${Expert_User3_name}
    click_user_in_contacts_list          ${driver_EU2}     ${Expert_User3_name}
    user_anwser_call     ${driver_U3}
    participants_icon_is_visible    yes     ${driver_TU1}      ${driver_EU2}
    participants_icon_is_visible    no      ${driver_U3}
    # Following users join call in sequence: Anonymous user 4 via MHS link. Logged in user 5 via MHS link. User 6 via 3pi link
    ${driver_AU4}     anonymous_open_meeting_link    ${MHS_url}
    user_anwser_call     ${driver_EU2}    not_direct
    ${driver_U5}     driver_set_up_and_logIn     ${Expert_User5_username}
    user_make_call_via_meeting_link    ${driver_U5}    ${MHS_url}
    user_anwser_call     ${driver_EU2}    not_direct
    ${driver_U6}     driver_set_up_and_logIn     ${Team_User2_username}
    ${invite_url}     send_new_invite_in_calling     ${driver_EU2}
    user_make_call_via_meeting_link    ${driver_U6}    ${invite_url}
    # U3 uploads a photo from gallery	VP: photo, no live video; All participants has Merge menu
    minimize_window_action        ${driver_TU1}   ${driver_EU2}    ${driver_U3}   ${driver_AU4}   ${driver_U5}   ${driver_U6}
    maximize_window_action        ${driver_U3}
    inCall_upload_photo_PDF       ${driver_U3}
    maximize_window_action        ${driver_TU1}   ${driver_EU2}    ${driver_AU4}   ${driver_U5}   ${driver_U6}
    check_in_photo_pdf_whiteboard_mode      photo     ${driver_U3}
    check_has_merge_menu       ${driver_TU1}   ${driver_EU2}    ${driver_U3}   ${driver_AU4}   ${driver_U5}   ${driver_U6}
    # U4 start merge
    click_merge_button       ${driver_AU4}

    comment      CP: TU turn on/off co-host
    # TU1 turns on U5’s co-host.	VP: participants menu become visible for U5
    turn_on_co_host_for_sb      ${driver_TU1}     ${Expert_User5_name}
    participants_icon_is_visible    yes     ${driver_U5}
    # TU1 turns off U5’s co-host.	VP: participants menu become invisible for U5.
    turn_off_co_host_for_sb      ${driver_TU1}     ${Expert_User5_name}
    participants_icon_is_visible    no     ${driver_U5}

    comment      remove giver
    # TU1 removes co-host giver(U4)
        # VP: Present the user with a confirmation dialog:, Remove User (emphasis)/Cancel.	confirm msg is "Are you sure you want to remove <USER NAME>?"
    # TU1 confirms Remove
    co_host_remove_sb     ${driver_TU1}     ${anonymous_user_name}      can    yes    observer   no
        # VP:
        # 2. Show a toast message to all remaining users: “User Name (Giver) left the call. Switched back to Face to Face mode.”
        has_left_the_session     ${driver_TU1}      ${anonymous_user_name}
        close_invite_3th_page    ${driver_TU1}
        # 1. app enters Face to Face mode.
        check_in_f2f_mode    ${driver_TU1}
        # 3. User is removed from the call. He sees message “A Host has removed you from the Help Lightning call.” on the end-call screen.
        which_page_is_currently_on        ${driver_AU4}       ${has_removed_you}
        exit_one_driver     ${driver_AU4}
            # VP: F2F mode;
            # VP: Web Desktop only - for the host/co-host, "Share Live Video from: <other participant(First one if multi)>"button
            check_show_share_live_video_from    ${driver_TU1}     ${driver_EU2}
            check_not_show_share_live_video_from     ${driver_U3}    ${driver_U5}   ${driver_U6}
    # U3 Share photo by take photo	VP: photo, no live video; All participants has Merge menu
    minimize_window_action        ${driver_TU1}   ${driver_EU2}    ${driver_U3}   ${driver_U5}   ${driver_U6}
    maximize_window_action        ${driver_U3}
    take_a_new_photo              ${driver_U3}
    maximize_window_action        ${driver_TU1}   ${driver_EU2}    ${driver_U5}   ${driver_U6}
    check_in_photo_pdf_whiteboard_mode      photo     ${driver_U3}
    check_has_merge_menu       ${driver_TU1}   ${driver_EU2}    ${driver_U3}    ${driver_U5}   ${driver_U6}
    # U3 Share whiteboard	VP: whiteboard, no live video, All participants has Merge menu
    share_whiteboard       ${driver_U3}
    check_in_photo_pdf_whiteboard_mode      whiteboard     ${driver_U3}
    check_has_merge_menu       ${driver_TU1}   ${driver_EU2}    ${driver_U3}    ${driver_U5}   ${driver_U6}

    comment      remove receiver
    # Cohost removes receiver(U3)
        # VP: Present the user with a confirmation dialog: “If you remove this Receiver, then you will switch back to Face to Face mode.”, Remove User (emphasis)/Cancel.
        # confirm msg is "Are you sure you want to remove <USER NAME>?"
    #  Confirms with Remove
    co_host_remove_sb     ${driver_TU1}     ${Expert_User3_name}      can    yes    observer   no
        # VP:
        # 2. Show a toast message to all remaining users: “User Name (Receiver) left the call. Switched back to Face to Face mode.”
        left_call_back_f2f_mode     ${driver_TU1}      ${Expert_User3_name}
        close_invite_3th_page    ${driver_TU1}
        # 1. app enters Face to Face mode.
        check_in_f2f_mode    ${driver_TU1}
        # 3. User is removed from the call. He sees message “A Host has removed you from the Help Lightning call.” on the end-call screen.
        which_page_is_currently_on        ${driver_U3}       ${has_removed_you}
        exit_one_driver     ${driver_U3}
    # TU1 share whiteboard	VP: whiteboard, no live video, All participants has Merge menu
    share_whiteboard       ${driver_TU1}
    check_in_photo_pdf_whiteboard_mode           whiteboard     ${driver_TU1}
    check_has_merge_menu       ${driver_TU1}   ${driver_EU2}     ${driver_U5}   ${driver_U6}
    # Other participant click Share menu	VP: Whiteboard option is not highlight
    check_if_is_highlight    ${driver_EU2}       Whiteboard     not_highlight
    check_if_is_highlight    ${driver_U5}        Whiteboard     not_highlight
    check_if_is_highlight    ${driver_U6}        Whiteboard     not_highlight

    comment       remove observer
    # Co-host removes observer	VP: warning dialog displays with message “Are you sure you want to remove User Name?”, OK/Cancel button.
    # Confirm with Ok.	VP:
    co_host_remove_sb     ${driver_TU1}     ${Team_User2_name}      can    yes    observer   no
        # 1. Removed user disappears from participants window.Removed user sees message “A Host has removed you from the Help Lightning call.” on the end-call screen.
        has_left_the_session     ${driver_TU1}      ${Team_User2_name}
        close_invite_3th_page    ${driver_TU1}
        # 2. keep whiteboard mode.
        check_in_photo_pdf_whiteboard_mode      whiteboard     ${driver_TU1}
    [Teardown]      exit_driver

MHS_call_Scenario_3
    [Documentation]      Join call in photo mode
    [Tags]     MHS Call
    # TU1 click EU2's MHS link to start call
    ${driver_TU1}     driver_set_up_and_logIn     ${Team_User1_username}
    ${driver_EU2}     driver_set_up_and_logIn     ${Expert_User2_username}
    ${MHS_url}    send_meeting_room_link    ${driver_EU2}     MHS
    user_make_call_via_meeting_link    ${driver_TU1}    ${MHS_url}
    user_anwser_call     ${driver_EU2}
    # Invite user3 from contact list
    ${driver_U3}     driver_set_up_and_logIn     ${Expert_User3_username}
    inCall_enter_contacts_search_user    ${driver_EU2}     ${Expert_User3_name}
    click_user_in_contacts_list          ${driver_EU2}     ${Expert_User3_name}
    user_anwser_call     ${driver_U3}
    # TU1 share photo
    minimize_window_action        ${driver_TU1}   ${driver_EU2}    ${driver_U3}
    maximize_window_action        ${driver_TU1}
    inCall_upload_photo_PDF       ${driver_TU1}
    maximize_window_action        ${driver_EU2}    ${driver_U3}
    # TU1 start merge
    click_merge_button            ${driver_TU1}
    # Send 3PI link
    ${invite_url}     send_new_invite_in_calling    ${driver_EU2}
    # AU1 joins call via 3pi link.	VP: AU1 joins call with image synchronized.	%1$s has joined the call
    ${driver_AU1}      anonymous_open_meeting_link    ${invite_url}
    user_anwser_call          ${driver_EU2}         no_direct
    has_joined_the_call       ${driver_EU2}         ${anonymous_user_name}
    # Anonymous user 2, 3 click 3PI link to join		%1$s has joined the call
    ${driver_AU2}      anonymous_open_meeting_link    ${invite_url}
    user_anwser_call          ${driver_EU2}         no_direct
    has_joined_the_call       ${driver_EU2}         ${anonymous_user_name2}
    # AU1 start merge as giver
    click_merge_button            ${driver_AU1}

    comment       CP: leave call in photo mode.
    # Giver (AU1) leaves call.
    exit_call     ${driver_AU1}
        # 3. Show a toast message to all remaining users: “User Name left the call. Switched back to Face to Face mode.”
        left_call_back_f2f_mode     ${driver_EU2}     ${anonymous_user_name}
        # VP: 1. anonymous user sees star rating dialog. tag/comment, survey should not display for anonymous user.
        which_page_is_currently_on       ${driver_AU1}      ${star_rating_dialog}
        which_page_is_currently_on       ${driver_AU1}      ${end_call_add_tag}         not_currently_on
        which_page_is_currently_on       ${driver_AU1}      ${end_call_add_comment}     not_currently_on
        which_page_is_currently_on       ${driver_AU1}      ${end_call_take_survey}     not_currently_on
        # For web side, x button on the right top should not display for anonymous user.
        which_page_is_currently_on       ${driver_AU1}      ${end_call_page_close}      not_currently_on
        exit_one_driver     ${driver_AU1}
        # 2. app enters Face to Face mode.
        check_in_f2f_mode       ${driver_EU2}
    # Anonymous user AU2 share whiteboard
    share_whiteboard     ${driver_AU2}
    # Receiver (AU2) leaves call.
    exit_call     ${driver_AU2}
        # 3. Show a toast message to all remaining users: “User Name left the call. Switched back to Face to Face mode.”
        has_left_the_session     ${driver_EU2}     ${anonymous_user_name2}
        # VP: 1. AU2 sees star rating dialog. 2. app enters Face to Face mode.
        which_page_is_currently_on       ${driver_AU2}      ${star_rating_dialog}
        # 4.tag/comment, survey should not display for personal user.
        which_page_is_currently_on       ${driver_AU2}      ${end_call_add_tag}         not_currently_on
        which_page_is_currently_on       ${driver_AU2}      ${end_call_add_comment}     not_currently_on
        which_page_is_currently_on       ${driver_AU2}      ${end_call_take_survey}     not_currently_on
        exit_one_driver     ${driver_AU2}

    comment       CP: mhs owner leaves
    # Make sure there are 3 participants at least in the call. Owner clicks on Exit icon.	VP: “End call for all” submenu displays. “Leave call” menu should not display for owner in MHS call.
    ${driver_AU3}      anonymous_open_meeting_link    ${invite_url}
    user_anwser_call          ${driver_EU2}         no_direct
    has_joined_the_call       ${driver_EU2}         ${anonymous_user_name3}
    check_has_end_call_button       ${driver_EU2}     1
    check_has_no_end_call_button    ${driver_EU2}     2
    # AU3 share TU1's live video
    share_me        ${driver_AU3}
    # AU3 stop sharing	VP: Back to Face to Face mode
    stop_sharing_to_f2f             ${driver_AU3}
    check_in_f2f_mode               ${driver_AU3}
    # Owner clicks on “End call for all”	VP: Present the user with a confirmation dialog: “Are you sure you want to end this call for all participants?” OK/Cancel
    end_call_for_all     ${driver_EU2}     check
    # Owner confirms with OK.	VP: call ends for all the participants. Owner sees star rating dialog above tag/comment view.
    which_page_is_currently_on       ${driver_EU2}      ${star_rating_dialog}
    which_page_is_currently_on       ${driver_EU2}      ${end_call_add_tag}
    which_page_is_currently_on       ${driver_EU2}      ${end_call_add_comment}
    [Teardown]      exit_driver