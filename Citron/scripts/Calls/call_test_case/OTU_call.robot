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
OTU_call_Scenario_1
    [Documentation]      Workspace call center mode = OFF
    [Tags]     OTU Call
    # EU2 send OTU link
    ${driver_EU2}     driver_set_up_and_logIn     ${close_center_mode_user1}
    ${OTU_url}    send_meeting_room_link    ${driver_EU2}     OTU
    # Anonymous  user AU1 clicks on EU2’s OTU link. EU2 answers call.
    ${driver_AU1}     anonymous_open_meeting_link    ${OTU_url}
    user_anwser_call     ${driver_EU2}
    # EU2 invites U3 from contact list. U3 answers call.
    ${driver_U3}     driver_set_up_and_logIn     ${close_center_mode_user2}
    inCall_enter_contacts_search_user    ${driver_EU2}     ${close_center_mode_name2}
    click_user_in_contacts_list          ${driver_EU2}     ${close_center_mode_name2}
    user_anwser_call     ${driver_U3}
    # Following users join call in sequence: Different enterprise user 4 via OTU link. Logged in user 5 via OTU link. User 6 via 3pi link
    ${driver_DU4}     driver_set_up_and_logIn     ${close_center_mode_userA}
    user_make_call_via_meeting_link     ${driver_DU4}    ${OTU_url}
    user_anwser_call     ${driver_EU2}    not_direct
    ${driver_U5}     driver_set_up_and_logIn     ${close_center_mode_user3}
    user_make_call_via_meeting_link     ${driver_U5}    ${OTU_url}
    user_anwser_call     ${driver_EU2}    not_direct
    ${invite_url}     send_new_invite_in_calling     ${driver_EU2}
    ${driver_U6}     driver_set_up_and_logIn     ${close_center_mode_user4}
    user_make_call_via_meeting_link     ${driver_U6}    ${invite_url}
        # VP:  1. participants icon is invisible for the three users.
        participants_icon_is_visible    no      ${driver_DU4}     ${driver_U5}     ${driver_U6}
        # 2. Invite button should be hidden for users in enterprise A.
        invite_button_is_hidden     ${driver_EU2}
        # 3. Display users as joined order.
        display_users_as_joined_order     ${driver_EU2}   ${anonymous_user_name}    ${close_center_mode_name2}    ${close_center_mode_nameA}   ${close_center_mode_name3}   ${close_center_mode_name4}
        # 4. There should be one dot when 3-4 participants; two dots when 5-8 participants; 3 dots when 8-12 participants
        check_two_dots      ${driver_EU2}
            # VP: F2F mode;
            check_in_f2f_mode    ${driver_EU2}
            # VP: Web Desktop only - for the host/co-host, "Share Live Video from: <other participant(First one if multi)>"button
            check_show_share_live_video_from     ${driver_EU2}
    # EU2 turns on DU4’s co-host.
    turn_on_co_host_for_sb    ${driver_EU2}    ${close_center_mode_nameA}
    # VP: participants menu become visible for DU4.
    participants_icon_is_visible    yes     ${driver_DU4}

    comment       Enter pdf mode.
    # AU1 uploads a pdf with password.	VP: enter PDF mode.
    minimize_window_action     ${driver_AU1}    ${driver_EU2}    ${driver_U3}    ${driver_DU4}     ${driver_U5}     ${driver_U6}
    maximize_window_action     ${driver_AU1}
    inCall_upload_photo_PDF    ${driver_AU1}    PDF
    maximize_window_action     ${driver_U3}
    check_in_photo_pdf_whiteboard_mode    ${driver_AU1}    pdf
    # AU1 click Share menu again	VP: Document option is highlight
    check_if_is_highlight    ${driver_AU1}    PDF Document
    # AU1 start merge    VP: pdf picture + live video
    share_page    ${driver_AU1}
    click_merge_button     ${driver_AU1}
    check_in_photo_pdf_whiteboard_mode    ${driver_AU1}    pdf

    comment      CP: Change role in pdf mode.
    # U3 start merge   VP: pdf page + live video from TU1
    click_merge_button     ${driver_U3}
    check_in_photo_pdf_whiteboard_mode    ${driver_U3}    pdf
    # EU2 uploads a high resolution pdf file
    minimize_window_action     ${driver_AU1}    ${driver_EU2}    ${driver_U3}    ${driver_DU4}     ${driver_U5}     ${driver_U6}
    maximize_window_action     ${driver_EU2}
    inCall_upload_photo_PDF    ${driver_EU2}    PDF
    maximize_window_action     ${driver_AU1}    ${driver_U3}    ${driver_DU4}
    # EU2 clicks Share button to enter markup mode
    # EU2 start merge	VP: pdf + Live video from EU2
    share_page    ${driver_EU2}
    click_merge_button     ${driver_EU2}
    check_in_photo_pdf_whiteboard_mode    ${driver_EU2}    pdf
    # AU1 Share Whiteboard	VP: only see whiteboard
    share_whiteboard    ${driver_AU1}
    # AU1 click Share menu again	VP: Whiteboard option is hightlight
    check_if_is_highlight    ${driver_AU1}    Whiteboard
#    # U3 Stop sharing
#    stop_sharing_to_f2f    ${driver_U3}
#        # VP: back to F2F mode
#        check_in_f2f_mode      ${driver_U3}
#            # VP: F2F mode;
#            # VP: Web Desktop only - for the host/co-host, "Share Live Video from: <other participant(First one if multi)>"button
#            check_show_share_live_video_from     ${driver_EU2}    ${driver_U3}   ${driver_DU4}
    # U3 share Whiteboard	VP: only Whiteboard, no merged
    share_whiteboard    ${driver_U3}
    check_has_no_merged     ${driver_U3}
    # U3 Share Pdf, then share page	VP: pdf markup mode
    minimize_window_action     ${driver_U3}    ${driver_EU2}    ${driver_U3}    ${driver_DU4}     ${driver_U5}     ${driver_U6}
    maximize_window_action     ${driver_U3}
    inCall_upload_photo_PDF    ${driver_U3}    PDF
    maximize_window_action     ${driver_EU2}
    # EU2 share photo by take via camera	VP: only photo
    take_a_new_photo        ${driver_EU2}
    check_in_photo_pdf_whiteboard_mode    ${driver_EU2}    photo
    [Teardown]     exit_driver

OTU_call_Scenario_2
    [Documentation]      remove giver/receiver/observer in pdf mode.
    [Tags]     OTU Call
    # EU2 send OTU link
    ${driver_EU2}     driver_set_up_and_logIn     ${close_center_mode_user11}
    ${OTU_url}    send_meeting_room_link    ${driver_EU2}     OTU
    # Anonymous  user AU1 clicks on EU2’s OTU link. EU2 answers call.
    ${driver_AU1}     anonymous_open_meeting_link    ${OTU_url}
    user_anwser_call     ${driver_EU2}
    # EU2 invites U3 from contact list. U3 answers call.
    ${driver_U3}     driver_set_up_and_logIn     ${close_center_mode_user21}
    inCall_enter_contacts_search_user    ${driver_EU2}     ${close_center_mode_name21}
    click_user_in_contacts_list          ${driver_EU2}     ${close_center_mode_name21}
    user_anwser_call     ${driver_U3}
    # Following users join call in sequence: Different enterprise user 4 via OTU link. Logged in user 5 via OTU link. User 6 via 3pi link
    ${driver_DU4}     driver_set_up_and_logIn     ${close_center_mode_userB}
    user_make_call_via_meeting_link     ${driver_DU4}    ${OTU_url}
    user_anwser_call     ${driver_EU2}    not_direct
    ${driver_U5}     driver_set_up_and_logIn     ${close_center_mode_user31}
    user_make_call_via_meeting_link     ${driver_U5}    ${OTU_url}
    user_anwser_call     ${driver_EU2}    not_direct
    ${invite_url}     send_new_invite_in_calling     ${driver_EU2}
    ${driver_U6}     driver_set_up_and_logIn     ${close_center_mode_user41}
    user_make_call_via_meeting_link     ${driver_U6}    ${invite_url}
    # EU2 turns on DU4’s co-host.
    turn_on_co_host_for_sb    ${driver_EU2}    ${close_center_mode_nameB}

    comment      CP: different enterprise user turn on/off co-host
    # Different enterprise U4 turns on U5’s co-host.	VP: participants menu and mode submenu become visible for U5.
    turn_on_co_host_for_sb     ${driver_DU4}    ${close_center_mode_name31}
    participants_icon_is_visible    yes     ${driver_U5}
    turn_on_co_host_for_sb     ${driver_DU4}    ${close_center_mode_name41}
    participants_icon_is_visible    yes     ${driver_U5}
    # Different enterprise U4 turns off U5’s co-host.	VP: participants menu and mode submenu become invisible for U5.
    turn_off_co_host_for_sb     ${driver_DU4}    ${close_center_mode_name31}
    participants_icon_is_visible    no     ${driver_U5}
    # EU2 Share pdf page
    minimize_window_action     ${driver_AU1}    ${driver_EU2}    ${driver_U3}    ${driver_DU4}     ${driver_U5}     ${driver_U6}
    maximize_window_action     ${driver_EU2}
    inCall_upload_photo_PDF    ${driver_EU2}    PDF
    share_page    ${driver_EU2}
    maximize_window_action     ${driver_AU1}    ${driver_EU2}    ${driver_U3}    ${driver_DU4}     ${driver_U5}     ${driver_U6}
    # U3 start merge	 VP: pdf page + u3 video
    click_merge_button      ${driver_U3}

    comment      remove giver
    # U4 removes co-host giver( U3)	    VP: Present the user with a confirmation dialog: “Are you sure you want to remove <USER NAME>?”, Remove User (emphasis)/Cancel.
    co_host_remove_sb      ${driver_DU4}     ${close_center_mode_name21}      can    yes    giver   no
    # U4 confirms with Remove User.	VP:
        # 2. Show a toast message to all remaining users: “User Name (Giver) left the call. Switched back to Face to Face mode.”
        left_call_back_f2f_mode     ${driver_DU4}      ${close_center_mode_name21}
        close_invite_3th_page     ${driver_DU4}
        # 1. app enters Face to Face mode.
        check_in_f2f_mode    ${driver_DU4}
        # 3. User is removed from the call. He sees message “A Host has removed you from the Help Lightning call.” on the end-call screen.
        which_page_is_currently_on        ${driver_U3}       ${has_removed_you}
        exit_one_driver     ${driver_U3}
    # AU1 click Share my camera button	VP: AU1 live video
    share_me     ${driver_AU1}
    # U4 start merge	VP: pdf picture + live video from u4
    click_merge_button      ${driver_DU4}
    # U4 uploads a pdf	VP: pdf navigation mode
    minimize_window_action     ${driver_AU1}    ${driver_EU2}    ${driver_DU4}     ${driver_U5}     ${driver_U6}
    maximize_window_action     ${driver_DU4}
    inCall_upload_photo_PDF    ${driver_DU4}    PDF
    # U4 uploads a photo while other participants are doing pan/zoom	VP: enter photo mode; no one is merged
    inCall_upload_photo_PDF    ${driver_DU4}
    check_in_photo_pdf_whiteboard_mode    ${driver_EU2}    photo
    # AU1 uploads a new pdf	VP: enter pdf mode
    minimize_window_action     ${driver_AU1}    ${driver_EU2}    ${driver_DU4}     ${driver_U5}     ${driver_U6}
    maximize_window_action     ${driver_AU1}
    inCall_upload_photo_PDF    ${driver_AU1}    PDF      another.pdf
    maximize_window_action     ${driver_AU1}    ${driver_EU2}    ${driver_DU4}     ${driver_U5}     ${driver_U6}
    check_in_photo_pdf_whiteboard_mode    ${driver_AU1}    pdf

    comment       remove receiver
    # Co-host removes receiver(AU1) and confirms with Remove User.	VP:
    co_host_remove_sb      ${driver_DU4}     ${anonymous_user_name}      can    yes    observer   no
        # 2. Show a toast message to all remaining users: “User Name (Receiver) left the call. Switched back to Face to Face mode.”
        has_left_the_session     ${driver_DU4}      ${anonymous_user_name}
        close_invite_3th_page    ${driver_DU4}
        # 1. app enters Face to Face mode.
        check_in_f2f_mode    ${driver_DU4}
        # 3. User is removed from the call. He sees message “A Host has removed you from the Help Lightning call.” on the end-call screen.
        which_page_is_currently_on        ${driver_AU1}       ${has_removed_you}
        exit_one_driver     ${driver_AU1}
    # Add more users via invited or 3pi link until 6 participants in call.
    ${driver_U3}     driver_set_up_and_logIn     ${close_center_mode_user21}
    inCall_enter_contacts_search_user    ${driver_EU2}     ${close_center_mode_name21}
    click_user_in_contacts_list          ${driver_EU2}     ${close_center_mode_name21}
    user_anwser_call     ${driver_U3}
    ${driver_AU1}     anonymous_open_meeting_link    ${OTU_url}
    user_anwser_call     ${driver_EU2}    not_direct
    # U4 Share pdf
    minimize_window_action     ${driver_AU1}    ${driver_EU2}    ${driver_U3}    ${driver_DU4}     ${driver_U5}     ${driver_U6}
    maximize_window_action     ${driver_DU4}
    inCall_upload_photo_PDF    ${driver_DU4}    PDF
    share_page    ${driver_DU4}
    # EU2 start merge
    click_merge_button      ${driver_EU2}
    # EU2 share another pdf
    minimize_window_action     ${driver_AU1}    ${driver_EU2}    ${driver_U3}    ${driver_DU4}     ${driver_U5}     ${driver_U6}
    maximize_window_action     ${driver_EU2}
    inCall_upload_photo_PDF    ${driver_EU2}    PDF      another.pdf
    share_page    ${driver_EU2}
    maximize_window_action     ${driver_AU1}    ${driver_DU4}
    # VP: no one is merged
    check_has_no_merged     ${driver_AU1}    ${driver_EU2}    ${driver_U3}    ${driver_DU4}     ${driver_U5}     ${driver_U6}

    comment      remove observer
    # Co-host removes observer	 VP: warning dialog displays with message “Are you sure you want to remove User Name?”, OK/Cancel button.
    co_host_remove_sb      ${driver_DU4}     ${anonymous_user_name2}      can    yes    observer
    # Confirm with Ok.	VP:
        # 1. Removed user disappears from participants window. Removed user sees message “A Host has removed you from the Help Lightning call.” on the end-call screen.
        which_page_is_currently_on        ${driver_AU1}       ${has_removed_you}
        # 2. keep pdf sharing mode.
        check_in_photo_pdf_whiteboard_mode    ${driver_DU4}    pdf
    [Teardown]     Run Keywords     end_call_for_all    ${driver_EU2}
    ...            AND              exit_driver

OTU_call_Scenario_3
    [Documentation]       leave call in pdf mode
    [Tags]     OTU Call
    # EU2 send OTU link
    ${driver_EU2}     driver_set_up_and_logIn     ${close_center_mode_user1}
    ${OTU_url}    send_meeting_room_link    ${driver_EU2}     OTU
    # Anonymous  user AU1 clicks on EU2’s OTU link. EU2 answers call.
    ${driver_AU1}     anonymous_open_meeting_link    ${OTU_url}
    user_anwser_call     ${driver_EU2}
    # EU2 invites U3 from contact list. U3 answers call.
    ${driver_U3}     driver_set_up_and_logIn     ${close_center_mode_user2}
    inCall_enter_contacts_search_user    ${driver_EU2}     ${close_center_mode_name2}
    click_user_in_contacts_list          ${driver_EU2}     ${close_center_mode_name2}
    user_anwser_call     ${driver_U3}
    # Following users join call in sequence: Different enterprise user 4 via OTU link. Logged in user 5 via OTU link. User 6 via 3pi link
    ${driver_DU4}     driver_set_up_and_logIn     ${close_center_mode_userA}
    user_make_call_via_meeting_link     ${driver_DU4}    ${OTU_url}
    user_anwser_call     ${driver_EU2}    not_direct
    ${driver_U5}     driver_set_up_and_logIn     ${close_center_mode_user3}
    user_make_call_via_meeting_link     ${driver_U5}    ${OTU_url}
    user_anwser_call     ${driver_EU2}    not_direct
    ${invite_url}     send_new_invite_in_calling     ${driver_EU2}
    ${driver_U6}     driver_set_up_and_logIn     ${close_center_mode_user4}
    user_make_call_via_meeting_link     ${driver_U6}    ${invite_url}
    # U6 Share pdf
    minimize_window_action     ${driver_AU1}    ${driver_EU2}    ${driver_U3}    ${driver_DU4}     ${driver_U5}     ${driver_U6}
    maximize_window_action     ${driver_U6}
    inCall_upload_photo_PDF    ${driver_U6}    PDF
    # Non co-host U6 click on Exit button.	VP: “Yes” and “No” submenus display.
    check_has_no_end_call_button     ${driver_U6}     1     2
    # Confirm with Yes.
    sleep   10
    exit_call     ${driver_U6}
        # 3. Show a toast message to all remaining users: “User Name (Receiver) left the call. Switched back to Face to Face mode.”
        has_left_the_session     ${driver_EU2}      ${close_center_mode_name4}
        # VP: 1. Personal user leaves call and sees star rating dialog. survey should display for personal user.
        which_page_is_currently_on       ${driver_U6}      ${star_rating_dialog}
        which_page_is_currently_on       ${driver_U6}      ${end_call_take_survey}
        # 2. app enters Face to Face mode.
        check_in_f2f_mode     ${driver_EU2}
        exit_one_driver     ${driver_U6}
    # Make 3 or more participants (only two co-host) exist in the call
    turn_on_co_host_for_sb     ${driver_EU2}    ${close_center_mode_name2}
    # EU2 share pdf
    minimize_window_action     ${driver_AU1}    ${driver_EU2}    ${driver_U3}    ${driver_DU4}     ${driver_U5}
    maximize_window_action     ${driver_EU2}
    inCall_upload_photo_PDF    ${driver_EU2}    PDF
    share_page    ${driver_EU2}
    # EU2 start merge
    click_merge_button      ${driver_EU2}

    comment       owner leave call
    # EU2 (owner) clicks on Exit icon.	VP: “Leave call” and “End Call For All” submenus display.
    check_has_end_call_button     ${driver_EU2}     1     2
    # Confirm with “Leave call”.	VP: owner sees star rating dialog with survey, but without tag/comment. Call still continues for the remaining participants.
    leave_call     ${driver_EU2}
    which_page_is_currently_on       ${driver_EU2}      ${star_rating_dialog}
    which_page_is_currently_on       ${driver_EU2}      ${end_call_add_tag}         not_currently_on
    which_page_is_currently_on       ${driver_EU2}      ${end_call_add_comment}     not_currently_on
    which_page_is_currently_on       ${driver_EU2}      ${end_call_take_survey}
    which_page_is_currently_on       ${driver_AU1}      ${end_call_button}
    which_page_is_currently_on       ${driver_U3}      ${end_call_button}
    which_page_is_currently_on       ${driver_DU4}      ${end_call_button}
    which_page_is_currently_on       ${driver_U5}      ${end_call_button}
    # Owner closes rating dialog directly. Owner clicks on Take Survey button.
    # Owner closes survey page.	VP: Rating dialog should not display.
    # Open call details page from citron.	VP: Owner’s rating is none. Personal user's rating what you chose.
    [Teardown]     exit_driver

OTU_call_Scenario_5
    [Documentation]      Join call in pdf mode
    [Tags]     OTU Call
    # EU2 send OTU link
    ${driver_EU2}     driver_set_up_and_logIn     ${close_center_mode_user11}
    ${OTU_url}    send_meeting_room_link    ${driver_EU2}     OTU
    # Anonymous  user AU1 clicks on EU2’s OTU link. EU2 answers call.
    ${driver_AU1}     anonymous_open_meeting_link    ${OTU_url}
    user_anwser_call     ${driver_EU2}
    # EU2 invites U3 from contact list. U3 answers call.
    ${driver_U3}     driver_set_up_and_logIn     ${close_center_mode_user21}
    inCall_enter_contacts_search_user    ${driver_EU2}     ${close_center_mode_name21}
    click_user_in_contacts_list          ${driver_EU2}     ${close_center_mode_name21}
    user_anwser_call     ${driver_U3}
    # AU1 share pdf
    minimize_window_action     ${driver_AU1}    ${driver_EU2}    ${driver_U3}
    maximize_window_action     ${driver_AU1}
    inCall_upload_photo_PDF    ${driver_AU1}    PDF
    share_page    ${driver_AU1}
    maximize_window_action     ${driver_EU2}    ${driver_U3}
    # Anonymous user A joins call via OTU link.	VP: Anonymous user A joins call with image synchronized.
    ${driver_AUA}     anonymous_open_meeting_link    ${OTU_url}
    user_anwser_call     ${driver_EU2}    no_direct
    # Presenter returns pdf navigation mode.
    click_return_after_share_page    ${driver_AU1}
    # EU2 invites EU B to join call.	VP: EU B joins call with image synchronized.
    ${driver_EUB}     driver_set_up_and_logIn     ${close_center_mode_user31}
    inCall_enter_contacts_search_user    ${driver_EU2}     ${close_center_mode_name31}
    click_user_in_contacts_list          ${driver_EU2}     ${close_center_mode_name31}
    user_anwser_call     ${driver_EUB}
    # Presenter clicks on share button.
    share_me      ${driver_EU2}
    # EU B takes screen capture.
    click_screen_capture_button    ${driver_EUB}
        # VP: picture is saved. webapp[an automatic download to the user's default Download location for their browser.]
        check_jpg_picture_exists
        # VP: picture is shown in citron call details page
        # VP: picture content is correct.
    # EU B click Share My camera
    share_me      ${driver_EUB}

    comment       CP: leave call when other participants are anonymous user
    # Only keep EU2 as co-host
    # Co-host EU2 clicks on Exit icon.	VP: “Yes” and “No” submenus display.
    check_has_end_call_button     ${driver_EU2}     1     2
    # Confirm with Yes.	VP: call ends for all the participants
    end_call_for_all      ${driver_EU2}
    which_page_is_currently_on     ${driver_EU2}    ${thank_you_for_use}
    which_page_is_currently_on     ${driver_AU1}    ${thank_you_for_use}
    which_page_is_currently_on     ${driver_U3}     ${thank_you_for_use}
    which_page_is_currently_on     ${driver_AUA}    ${thank_you_for_use}
    which_page_is_currently_on     ${driver_EUB}    ${thank_you_for_use}
    [Teardown]     Run Keywords    delete_picture_jpg_file
    ...            AND             exit_driver