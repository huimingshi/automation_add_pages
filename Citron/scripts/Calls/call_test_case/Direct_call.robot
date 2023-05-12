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
Force Tags        call_case     new_call_case


*** Test Cases ***
direct_call_Scenario_1
    [Documentation]   Test Point: change role(change receiver)
    [Tags]     Direct Call      upload_file_case
    # TU1 log in
    ${driver_TU1}     driver_set_up_and_logIn     ${Team_User1_username}
    # EU2 log in
    ${driver_EU2}     driver_set_up_and_logIn     ${Expert_User2_username}
    # TU1 calls EU2. EU2 answers call.
    contacts_witch_page_make_call       ${driver_TU1}   ${driver_EU2}   ${py_team_page}   ${Expert_User2_name}
    make_sure_enter_call                ${driver_EU2}
    # U3 log in
    ${driver_U3}      driver_set_up_and_logIn     ${Expert_User3_username}
    # TU1 invites U3 from contact list. U3 answers call.
    inCall_enter_contacts_search_user   ${driver_TU1}    ${Expert_User3_name}
    click_user_in_contacts_list         ${driver_TU1}     ${Expert_User3_name}
    user_anwser_call                    ${driver_U3}
    make_sure_enter_call                ${driver_U3}
    enter_video_connection              ${driver_TU1}
    # VP: participants icon is visible for user 1 and user 2, but invisible for user 3.
    participants_icon_is_visible    yes     ${driver_TU1}      ${driver_EU2}
    participants_icon_is_visible    no      ${driver_U3}
    # 获取invite link
    ${invite_url}     send_new_invite_in_calling    ${driver_EU2}
    # Anonymous user 4 via 3pi link
    ${driver_U4}      anonymous_open_meeting_link    ${invite_url}
    user_anwser_call                    ${driver_TU1}    no_direct
    # EU5 via 3pi link
    ${driver_EU5}     driver_set_up_and_logIn     ${Expert_User5_username}
    user_make_call_via_meeting_link     ${driver_EU5}   ${invite_url}
    # U6 via 3pi link
    ${driver_U6}      driver_set_up_and_logIn     ${Team_User2_username}
    user_make_call_via_meeting_link     ${driver_U6}   ${invite_url}
    # VP: F2F mode;
    check_in_f2f_mode           ${driver_TU1}
    # VP: Web Desktop only - for the host/co-host, "Share Live Video from: <other participant(First one if multi)>"button
    check_show_share_live_video_from       ${driver_TU1}   ${driver_EU2}
    check_not_show_share_live_video_from   ${driver_U3}   ${driver_U4}   ${driver_EU5}   ${driver_U6}

    comment   Check Point: change receiver
    # TU1 share me
    share_live_video_from_sb            ${driver_TU1}    My Camera
    # VP: other 5 persons has Merge menu
    check_has_merge_menu                ${driver_EU2}   ${driver_U3}   ${driver_U4}   ${driver_EU5}   ${driver_U6}
    # host(TU1) and co-host (Eu2) click share menu
    # VP: host and co-host can share anyone's live video
    check_can_share_sb_live_video       ${driver_TU1}    ${Expert_User2_name}    ${Expert_User3_name}    ${anonymous_user_name}    ${Expert_User5_name}    ${Team_User2_name}
    check_can_share_sb_live_video       ${driver_EU2}    ${Team_User1_name}      ${Expert_User3_name}    ${anonymous_user_name}    ${Expert_User5_name}    ${Team_User2_name}
    # non host or co-host (AU1,U3, U5,U6) click share menu
    # VP: they can only share theirslef; they can freeze,share photo, pdf, whiteboard
    check_only_can_share_themself       ${driver_U3}   ${driver_U4}   ${driver_EU5}   ${driver_U6}
    check_has_freeze_button             ${driver_U3}   ${driver_U4}   ${driver_EU5}   ${driver_U6}
    check_has_photo_PDF_whiteboard      ${driver_U3}   ${driver_U4}   ${driver_EU5}   ${driver_U6}
    # AU1 click freeze
    freeze_operation                    ${driver_U4}      freeze    un_check
    # VP: TU1 is frozen; TU1 has no Merge menu
    check_has_unFreeze_button           ${driver_TU1}
    check_has_no_merge_menu             ${driver_TU1}
    # U3 confirm start merge
    click_merge_button                  ${driver_U3}
    # VP: video merged (TU1 + U3)
    check_has_merged                    ${driver_U3}

    comment   (From coding perspective, TU1 is still receiver role, U3 is giver role, remove TU1 will bring call back to F2F mode)
    # U3 share photo
    minimize_window_action        ${driver_TU1}   ${driver_EU2}   ${driver_U3}   ${driver_U4}   ${driver_EU5}   ${driver_U6}
    maximize_window_action        ${driver_U3}
    inCall_upload_photo_PDF       ${driver_U3}
    # VP: merged ( photo+ U3 live video)
    check_has_merged              ${driver_U3}
    # U3 click Share menu
    # Indicator of what is sharing (Photo option is highlight)
    check_if_is_highlight         ${driver_U3}     Photo from library

    comment    (From coding perspective, AU1 is receiver role, U3 is giver, U3 leave call will bring call to F2F mode)
    # AU1 share pdf, markup mode
    minimize_window_action        ${driver_TU1}   ${driver_EU2}   ${driver_U3}   ${driver_U4}   ${driver_EU5}   ${driver_U6}
    maximize_window_action        ${driver_U4}
    inCall_upload_photo_PDF       ${driver_U4}     PDF
    # VP: no one is merged status
    maximize_window_action        ${driver_TU1}   ${driver_EU2}   ${driver_U3}   ${driver_U4}   ${driver_EU5}   ${driver_U6}
    check_has_no_merge_menu       ${driver_TU1}   ${driver_EU2}   ${driver_U4}   ${driver_EU5}   ${driver_U6}
    # AU1 click Share menu
    # Indicator of what is sharing (Pdf document option is highlight)
    check_if_is_highlight         ${driver_U4}     PDF Document
    # EU2 share U5's live video
    share_live_video_from_sb      ${driver_EU2}    ${Expert_User5_name}    no_wait
    # VP: exit pdf mode, only U5's live video
    exiting_document_sharing_mode      ${driver_EU2}
    sleep   30
    # U3 click Freeze
    freeze_operation              ${driver_U3}        freeze    un_check
    # VP: U5 is frozen
    check_has_unFreeze_button     ${driver_EU5}
    # U3 Share whiteboard
    share_whiteboard              ${driver_U3}
    # VP: Whiteboard only
    check_in_photo_pdf_whiteboard_mode     photo      ${driver_U3}
    # EU2 Share pdf
    minimize_window_action        ${driver_TU1}   ${driver_EU2}   ${driver_U3}   ${driver_U4}   ${driver_EU5}   ${driver_U6}
    maximize_window_action        ${driver_EU2}
    inCall_upload_photo_PDF       ${driver_EU2}     PDF
    # VP: pdf navigation mode
    check_in_photo_pdf_whiteboard_mode      pdf       ${driver_EU2}
    [Teardown]     exit_driver

direct_call_Scenario_2
    [Documentation]   Test Point: change role(change giver)
    [Tags]     Direct Call
    # TU1 log in
    ${driver_TU1}     driver_set_up_and_logIn     ${STeam_User1_username}
    # EU2 log in
    ${driver_EU2}     driver_set_up_and_logIn     ${SExpert_User2_username}
    # TU1 calls EU2. EU2 answers call.
    contacts_witch_page_make_call       ${driver_TU1}   ${driver_EU2}   ${py_team_page}   ${SExpert_User2_name}
    make_sure_enter_call                ${driver_EU2}
    # U3 log in
    ${driver_U3}      driver_set_up_and_logIn     ${SExpert_User3_username}
    # TU1 invites U3 from contact list. U3 answers call.
    inCall_enter_contacts_search_user   ${driver_TU1}    ${SExpert_User3_name}
    click_user_in_contacts_list         ${driver_TU1}     ${SExpert_User3_name}
    user_anwser_call                    ${driver_U3}
    make_sure_enter_call                ${driver_U3}
    enter_video_connection              ${driver_TU1}
    # VP:Only Host and co-host can see participants icon. participants icon is invisible for u3.
    participants_icon_is_visible     yes     ${driver_TU1}     ${driver_EU2}
    participants_icon_is_visible     no      ${driver_U3}
    # Participant send 3pi link
    ${invite_url}     send_new_invite_in_calling    ${driver_EU2}
    # Anonymous user AU1 through 3pi link
    ${driver_AU1}      anonymous_open_meeting_link    ${invite_url}
    user_anwser_call                    ${driver_TU1}    no_direct
    # U5 and U6 via 3pi link.
    ${driver_EU5}     driver_set_up_and_logIn     ${SExpert_User5_username}
    user_make_call_via_meeting_link     ${driver_EU5}   ${invite_url}
    ${driver_U6}      driver_set_up_and_logIn     ${STeam_User2_username}
    user_make_call_via_meeting_link     ${driver_U6}   ${invite_url}
    # VP: F2F mode
    check_in_f2f_mode           ${driver_TU1}
    # U5 click share me
    enter_video_connection      ${driver_TU1}
    share_me                    ${driver_EU5}
    # VP: U5 is receiver, no one is in merge status; All has Merge menu
    check_has_no_merge_menu     ${driver_EU5}
    check_has_merge_menu        ${driver_TU1}    ${driver_EU2}    ${driver_U3}    ${driver_AU1}    ${driver_U6}
    check_has_no_merged         ${driver_TU1}    ${driver_EU2}    ${driver_U3}    ${driver_AU1}    ${driver_U6}
    # EU2 start merge
    click_merge_button          ${driver_EU2}

    comment    (AU1 is giver; U5 is still receiver)
    # AU1 start merge
    click_merge_button          ${driver_AU1}
    # VP: merged ( Au1 + U5)
    # U5 stop sharing
    stop_sharing_to_f2f         ${driver_EU5}
    # VP: F2F mode;
    check_in_f2f_mode           ${driver_TU1}
    # VP: Web Desktop only - for the host/co-host, "Share Live Video from: <other participant(First one if multi)>"button
    check_show_share_live_video_from       ${driver_TU1}     ${driver_EU2}
    check_not_show_share_live_video_from   ${driver_U3}      ${driver_AU1}   ${driver_EU5}   ${driver_U6}

    comment    (TU1 is receiver, server choose host EU2 as giver)
    # Share TU1's live video
    share_live_video_from_sb               ${driver_EU2}     ${STeam_User1_name}
    # Turn off co-host for EU2
    turn_off_co_host_for_sb                ${driver_TU1}     ${SExpert_User2_name}
    # EU2 has no participants menu
    participants_icon_is_visible           no                ${driver_EU2}

    comment    (TU1 is receiver, server choose first join co-host  EU2 as giver)
    # TU1 share whiteboard	VP: only whiteboard
    share_whiteboard                       ${driver_TU1}
    # EU2 start merge	VP: EU2's live video + telestration
    click_merge_button          ${driver_EU2}

    comment    ( EU2 is giver)
    # EU2 share photo by take photo
    take_a_new_photo            ${driver_EU2}
    # EU2 click Share menu again	VP: option Take a New Photo option is hightlight
    check_if_is_highlight       ${driver_EU2}     Take a New Photo

    comment    (AU1 is giver)
    # AU1 click to start merge	VP: AU1's video + photo
    click_merge_button          ${driver_AU1}

    comment    (AU 1 is receiver, No giver,server choose host TU1 as giver TU1 leave call will back to F2F)
    # AU1 Share me	VP: no one is merged status
    share_me    ${driver_AU1}
    # AU1 stop sharing	VP: F2F mode	VP: F2F mode;
    stop_sharing_to_f2f         ${driver_AU1}
    check_in_f2f_mode           ${driver_AU1}
    # VP: Web Desktop only - for the host/co-host, "Share Live Video from: <other participant(First one if multi)>"button
    check_show_share_live_video_from       ${driver_TU1}
    check_not_show_share_live_video_from   ${driver_U3}     ${driver_EU2}     ${driver_AU1}   ${driver_EU5}   ${driver_U6}

    comment    (TU1 is giver)
    # AU1 click share me
    share_me    ${driver_AU1}
    # VP: EU2 has no "End Call for all" option
    check_has_end_call_button   ${driver_EU2}
    [Teardown]     exit_driver

direct_call_Scenario_3
    [Documentation]   Test Point: remove giver or receiver will back to F2F mode
    [Tags]     Direct Call
    # TU1 calls EU2. EU2 answers call.
    ${driver_TU1}     driver_set_up_and_logIn     ${Team_User1_username}
    ${driver_EU2}     driver_set_up_and_logIn     ${Expert_User2_username}
    contacts_witch_page_make_call       ${driver_TU1}   ${driver_EU2}   ${py_team_page}   ${Expert_User2_name}
    make_sure_enter_call                ${driver_EU2}
    # TU1 invites U3 from contact list. 	Info:Your invite to %1$s was sent successfully
    ${driver_U3}      driver_set_up_and_logIn     ${Expert_User3_username}
    inCall_enter_contacts_search_user   ${driver_TU1}    ${Expert_User3_name}
    click_user_in_contacts_list         ${driver_TU1}     ${Expert_User3_name}
    your_invite_to_was_sent_successfully    ${driver_TU1}     ${Expert_User3_name}
    # U3 answers call.      Info:%1$s has accepted your call
    user_anwser_call                    ${driver_U3}
    has_accepted_your_call     ${driver_TU1}     ${Expert_User3_name}
    make_sure_enter_call                ${driver_U3}
    # VP:Only Host and co-host can see participants icon. participants icon iinvisible for u3.
    participants_icon_is_visible     yes     ${driver_TU1}     ${driver_EU2}
    participants_icon_is_visible     no      ${driver_U3}
    # Participant send 3pi link
    ${invite_url}     send_new_invite_in_calling    ${driver_EU2}
    # Anonymous user AU1 through 3pi link
    ${driver_AU1}      anonymous_open_meeting_link      ${invite_url}
    user_anwser_call                    ${driver_TU1}    no_direct
    # U5 and U6 via 3pi link.	VP: F2F mode;
    ${driver_EU5}     driver_set_up_and_logIn     ${Expert_User5_username}
    user_make_call_via_meeting_link     ${driver_EU5}   ${invite_url}
    ${driver_U6}      driver_set_up_and_logIn     ${Team_User2_username}
    user_make_call_via_meeting_link     ${driver_U6}    ${invite_url}
    check_in_f2f_mode           ${driver_TU1}
    # VP: Web Desktop only - for the host/co-host, "Share Live Video from: <other participant(First one if multi)>"button
    enter_video_connection      ${driver_TU1}
    check_show_share_live_video_from       ${driver_TU1}     ${driver_EU2}
    check_not_show_share_live_video_from   ${driver_U3}      ${driver_AU1}   ${driver_EU5}   ${driver_U6}
    # VP: Invite button is hidden for all participants. (stage only allow 6 in call);
    invite_button_is_hidden    ${driver_TU1}     ${driver_EU2}
    # Display users as joined order.
    display_users_as_joined_order   ${driver_TU1}   ${Expert_User2_name}    ${Expert_User3_name}    ${anonymous_user_name}   ${Expert_User5_name}   ${Team_User2_name}
    # All participants view others name avatar by swiping screen
    click_nav_right   ${driver_TU1}
    check_current_participants   ${driver_TU1}   ${Expert_User5_name}   ${Team_User2_name}
    click_nav_left   ${driver_TU1}
    check_current_participants   ${driver_TU1}    ${Team_User1_name}    ${Expert_User2_name}   ${Expert_User3_name}    ${anonymous_user_name}
    # User 7 clicks on 3pi link.	VP: user 7 sees message “Too many users in a call”
    ${driver_U7}  driver_set_up_and_logIn     ${Expert_User4_username}
    user_make_call_via_meeting_link   ${driver_U7}   ${invite_url}
    which_page_is_currently_on        ${driver_U7}       ${too_many_users_in_a_call}
    exit one driver  ${driver_U7}
    # All of the users clicks share icon	Only Host and co-host can share anyone's live video;	VP: name on share dialog
    check_can_share_sb_live_video       ${driver_TU1}    ${Expert_User2_name}    ${Expert_User3_name}    ${anonymous_user_name}    ${Expert_User5_name}    ${Team_User2_name}
    check_can_share_sb_live_video       ${driver_EU2}    ${Team_User1_name}      ${Expert_User3_name}    ${anonymous_user_name}    ${Expert_User5_name}    ${Team_User2_name}
    check_only_can_share_themself       ${driver_U3}   ${driver_AU1}   ${driver_EU5}   ${driver_U6}
    # TU1 turns off, on camera	VP: camera works fine	VP: no swap camera on f2f moce
    turns_off_on_camera       ${driver_TU1}
    turns_off_on_camera       ${driver_TU1}    on
    # TU1 clicks on participants icon	VP:
#        # 1. Participants has 4 columns: Participants, Mute, Co-Host, Remove.
#        participants_display_4_columns     ${driver_TU1}
        # 2. TU1 isn’t in the table.
        # 3. Co-Host is turned on for EU2 by default, is off for other users.
        who_is_co_host      ${driver_TU1}     ${Expert_User2_name}
        # 4. Participants are displayed by join order.
        display_users_as_joined_order    ${driver_TU1}   ${Expert_User2_name}    ${Expert_User3_name}    ${anonymous_user_name}   ${Expert_User5_name}   ${Team_User2_name}
    # TU1 turns on co-host for U3.	VP: participants menu and mode submenu become visible for U3.
    turn_on_co_host_for_sb    ${driver_TU1}      ${Expert_User3_name}
    participants_icon_is_visible     yes     ${driver_U3}

    comment    CP: host cannot be demoted or removed.
    # EU2 (co-host) tries to turn off co-host for TU1	VP: host TU1 cannot be demoted.
    turn_off_co_host_for_sb     ${driver_EU2}     ${Team_User1_name}    can_not
    # EU2 (co-host) tries to remove TU1.	VP: host TU1 cannot be removed
    co_host_remove_sb           ${driver_EU2}     ${Team_User1_name}    can_not

    comment    CP: anonymous user can not be promoted to co-host
    # TU1 tries to turn on co-host for anonymous user	VP: anonymous user can not be promoted to co-host.
    turn_on_co_host_for_sb      ${driver_TU1}     ${anonymous_user_name}      gray
    # AU1 mutes other participant   VP: are mute
    co_host_mute_sb       ${driver_TU1}      mute    can    ${Expert_User2_name}    ${Expert_User3_name}    ${anonymous_user_name}   ${Expert_User5_name}   ${Team_User2_name}
    sleep    30
    # TU1 tries to unmute other participant.   VP: co-host can not un-mute others
#    co_host_mute_sb       ${driver_TU1}      unmute    can_not    ${Expert_User2_name}    ${Expert_User3_name}    ${anonymous_user_name}   ${Expert_User5_name}   ${Team_User2_name}
    # The muted participant turns on mic by himself.	VP: mic is on.
    turns_on_mic_by_himself      ${driver_EU2}     ${driver_U3}   ${driver_AU1}   ${driver_EU5}   ${driver_U6}
    # co-host Share EU2's live video	(EU2's consider as receiver)
    share_live_video_from_sb      ${driver_TU1}     ${Expert_User2_name}
    # U3 confirm start merge	(U3 is consider as giver)
    click_merge_button      ${driver_U3}
    #	VP:observer can merge, freezing/photo/pdf/whitboard mode. Revert camera and turn on/off flashlight is hidden for observer.

    comment    Remove observer
    # TU1 try to remove EU5	VP:  message “Are you sure you want to remove EU5?”, OK/Cancel button.
    # TU1 confirms Cancel.	VP: related user is not removed.
    co_host_remove_sb           ${driver_TU1}     ${Expert_User5_name}    can    not_remove
    display_users_as_joined_order   ${driver_TU1}   ${Expert_User2_name}    ${Expert_User3_name}    ${anonymous_user_name}   ${Expert_User5_name}   ${Team_User2_name}
    # TU1 removes EU5 and confirm OK.	VP:
    co_host_remove_sb           ${driver_TU1}     ${Expert_User5_name}
        # 1. is Removed from participants window.
        display_users_as_joined_order   ${driver_TU1}   ${Expert_User2_name}    ${Expert_User3_name}    ${anonymous_user_name}   ${Team_User2_name}
        # 2. keep current mode.
        check_has_merge_menu           ${driver_TU1}
        # 3.  “A Host has removed you from the Help Lightning call.” on EU5's end-call screen.
        which_page_is_currently_on        ${driver_EU5}       ${has_removed_you}
    # Turn on co-host for U6
    turn_on_co_host_for_sb           ${driver_TU1}     ${Team_User2_name}

    comment    CP: observer leaves call in cooperation mode
    # Co-host observer clicks on Exit icon.	VP: “Leave call” and “End Call For All” submenus display.
    check_has_end_call_button       ${driver_EU2}      1    2
    # Co-host observer clicks on Leave call.	VP: Keep current mode.
    leave_call       ${driver_EU2}
    has_left_the_session     ${driver_TU1}      ${Expert_User2_name}
    check_in_f2f_mode           ${driver_TU1}

    comment    CP: remove giver （merging status）
    # Co-host removes giver (U3)	VP: confirmation dialog: “Are you sure you want to remove <USER NAME>?”, Remove User (emphasis)/Cancel.
    # Cancel remove
    co_host_remove_sb           ${driver_TU1}     ${Expert_User3_name}    can    not_remove
    # Co-host removes giver (U3) and confirms with Remove.	VP:
    co_host_remove_sb           ${driver_TU1}     ${Expert_User3_name}    can    yes    observer   no
        # 2. Show a toast message to all remaining users: “User Name left the call. Switched back to Face to Face mode.”
        has_left_the_session     ${driver_TU1}      ${Expert_User3_name}
        close_invite_3th_page    ${driver_TU1}
        # 1. app enters Face to Face mode.
        check_in_f2f_mode           ${driver_TU1}
        # 3. User is removed sees message “A Host has removed you from the Help Lightning call.” on the end-call screen.
        which_page_is_currently_on        ${driver_U3}       ${has_removed_you}

    comment    CP: remove receiver
    # Enter cooperation mode ( someone share live video )
    share_me     ${driver_U6}
    # Co-host removes receiver (The participant who is sharing live video)	VP: confirmation dialog: “Are you sure you want to remove <USER NAME>?”, Remove User (emphasis)/Cancel.
    # Confirm with Remove.	VP:
    co_host_remove_sb           ${driver_TU1}     ${Team_User2_name}    can    yes    observer   no
        # 2. Show a toast message to all remaining users: “User Name (Receiver) left the call. Switched back to Face to Face mode.”
        has_left_the_session     ${driver_TU1}      ${Team_User2_name}
        close_invite_3th_page    ${driver_TU1}
        # 1. app enters Face to Face mode.
        check_in_f2f_mode           ${driver_TU1}
        # 3. User is removed sees message “A Host has removed you from the Help Lightning call.” on the end-call screen.
        which_page_is_currently_on        ${driver_U6}       ${has_removed_you}
    # Participants leave call in Face to Face mode one by one
    exit_call         ${driver_TU1}
    [Teardown]      exit_driver

direct_call_Scenario_4
    [Documentation]   Test Point: giver or receiver leave call, app back to F2F mode; observer leave call, app keep current mode.
    [Tags]     Direct Call
    # TU1 calls EU2. EU2 answers call.
    ${driver_TU1}     driver_set_up_and_logIn     ${STeam_User1_username}
    ${driver_EU2}     driver_set_up_and_logIn     ${SExpert_User2_username}
    contacts_witch_page_make_call       ${driver_TU1}   ${driver_EU2}   ${py_team_page}   ${SExpert_User2_name}
    make_sure_enter_call                ${driver_EU2}
    # TU1 invites U3 from contact list. U3 answers call.
    ${driver_U3}      driver_set_up_and_logIn     ${SExpert_User3_username}
    inCall_enter_contacts_search_user   ${driver_TU1}    ${SExpert_User3_name}
    click_user_in_contacts_list         ${driver_TU1}     ${SExpert_User3_name}
    user_anwser_call                    ${driver_U3}
    make_sure_enter_call                ${driver_U3}
    # VP:Only Host and co-host can see participants icon. participants icon iinvisible for u3.
    participants_icon_is_visible     yes     ${driver_TU1}     ${driver_EU2}
    participants_icon_is_visible     no      ${driver_U3}
    # Participant send 3pi link
    ${invite_url}     send_new_invite_in_calling    ${driver_EU2}
    # Anonymous user AU1 through 3pi link
    ${driver_AU1}      anonymous_open_meeting_link      ${invite_url}
    user_anwser_call                    ${driver_TU1}    no_direct
    # U5 and U6 via 3pi link.
    ${driver_EU5}     driver_set_up_and_logIn     ${SExpert_User5_username}
    user_make_call_via_meeting_link     ${driver_EU5}   ${invite_url}
    ${driver_U6}      driver_set_up_and_logIn     ${STeam_User2_username}
    user_make_call_via_meeting_link     ${driver_U6}    ${invite_url}
    # VP: F2F mode;
    check_in_f2f_mode           ${driver_TU1}
    # VP: Web Desktop only - for the host/co-host, "Share Live Video from: <other participant(First one if multi)>"button
    enter_video_connection      ${driver_TU1}
    check_show_share_live_video_from       ${driver_TU1}     ${driver_EU2}
    check_not_show_share_live_video_from   ${driver_U3}      ${driver_AU1}   ${driver_EU5}   ${driver_U6}

    comment    CP: Giver leaves call in normal merge mode.
    # Make only two co-host exist in the call.
    # TU1 share other's live video
    share_live_video_from_sb      ${driver_TU1}     ${SExpert_User5_name}
    # TU1 click merge button	TU1 is giver
    click_merge_button       ${driver_TU1}
    # TU1 clicks End Call icon	VP: “Leave call” and “End Call For All” submenus display.
    check_has_end_call_button       ${driver_TU1}      1    2
    # TU1 Leave call.	VP:
    leave_call      ${driver_TU1}
        # 2.  toast message to all remaining users: “User Name (Giver) left the call. Switched back to Face to Face mode.”
        left_call_back_f2f_mode     ${driver_EU2}      ${STeam_User1_name}
        # 1. app enters Face to Face mode.
        check_in_f2f_mode           ${driver_EU2}

    comment    CP: Receiver leaves call in normal giving/receiving help mode.
    # Share EU2's live video	"Now view video from xxx"
    share_me       ${driver_EU2}
    # EU2 clicks on Exit icon	VP: “Leave call” and “End Call For All” submenus display.
    check_has_end_call_button       ${driver_EU2}      1    2
    # Choose “Leave Call”	VP: text "You must select another co-host before you can Leave Call."	"End Call for All" button in the left bottom is enabled. "Leave Call" button is disabled.
    sleep   20s    # 需要等待一段时间，EU2在点击leave call时才会出现提示信息You must select another co-host before you can Leave Call.
    click_participants_div    ${driver_EU2}
    close_invite_3th_page     ${driver_EU2}
    leave_call      ${driver_EU2}
    you_must_select_another_co_host          ${driver_EU2}
    participants_page_end_call_for_all       ${driver_EU2}
    participants_page_leave_call_disable     ${driver_EU2}
    # EU2 tries to turn on co-host for anonymous AU1.	VP: AU1 cannot be prompted as Co-host.
    select_co_host_back     ${driver_EU2}      ${anonymous_user_name}    can_not
    # EU2 turn on co-host for  U5.	VP: "Leave Call" button is enabled.
    select_co_host_back     ${driver_EU2}      ${SExpert_User5_name}
    participants_page_leave_call_disable     ${driver_EU2}    able
    # EU2 turn off co-host for  U5.	VP: Leave Call button changes to disabled.
    select_co_host_back     ${driver_EU2}      ${SExpert_User5_name}     can    turn_off
    participants_page_leave_call_disable     ${driver_EU2}
    # EU2 turn on co-host for  U5.
    select_co_host_back     ${driver_EU2}      ${SExpert_User5_name}
    # EU2 leave call	VP:
    leave_call      ${driver_EU2}
        # 2. Toast message to all remaining users: “User Name (Giver) left the call. Switched back to Face to Face mode.”	%1$s (%2$s) left the call. Switched back to Face to Face mode.
        has_left_the_session        ${driver_EU5}      ${SExpert_User2_name}
        # 1. app enters Face to Face mode.
        check_in_f2f_mode           ${driver_EU5}
    # U5 share another one's live video	VP: U5 is the only co-host in call
    share_live_video_from_sb        ${driver_EU5}       ${STeam_User2_name}
    participants_icon_is_visible     yes     ${driver_EU5}
    participants_icon_is_visible     no      ${driver_U3}   ${driver_AU1}   ${driver_U6}

    comment    CP: observer leaves call in cooperation mode (End call for All) （ U3 is now host)
    # co-host U5 observer clicks on Exit icon	VP: “Leave call” and “End Call For All” submenus display.
    check_has_end_call_button       ${driver_EU5}      1    2
    # Co-host observer selects Leave call.	VP: dialog "You must select another co-host before you can Leave Call.".	"End Call for All" button in the left bottom is enabled. "Leave Call" button in the right bottom is disabled.
    sleep   20s    # 需要等待一段时间，EU5在点击leave call时才会出现提示信息You must select another co-host before you can Leave Call.
    click_participants_div    ${driver_EU5}
    close_invite_3th_page     ${driver_EU5}
    leave_call      ${driver_EU5}
    you_must_select_another_co_host          ${driver_EU5}
    participants_page_end_call_for_all       ${driver_EU5}
    participants_page_leave_call_disable     ${driver_EU5}
    # Co-host clicks on “End Call for All” button.	VP: Confirmation dialog: “Are you sure you want to end this call for all participants?” OK/Cancel
    # Confirm with Ok.	VP: call ends for all the participants.
    end_call_for_all_in_participants         ${driver_EU5}
    which_page_is_currently_on        ${driver_U3}        ${thank_you_for_use}
    which_page_is_currently_on        ${driver_AU1}       ${thank_you_for_use}
    which_page_is_currently_on        ${driver_U6}        ${thank_you_for_use}
    [Teardown]      exit_driver