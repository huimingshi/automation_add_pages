#*** Settings ***
#Library           Selenium2Library
#Library           OperatingSystem
#Resource          ../../../Lib/public.robot
#Resource          ../../../Lib/calls_resource.robot
#Resource          ../../../Lib/hodgepodge_resource.robot
#Library           call_python_Lib/call_action_lib_copy.py
#Library           call_python_Lib/call_check_lib.py
#Library           call_python_Lib/else_public_lib.py
#Library           call_python_Lib/login_lib.py
#Library           call_python_Lib/contacts_page.py
#Library           call_python_Lib/about_call.py
#Library           call_python_Lib/finish_call.py
#Force Tags        small_range
#
#*** Test Cases ***
#Small_range_206
#    [Documentation]    2 users in face to face mode
#    [Tags]      small range 152 line     call_case
#    # TU1 log in
#    ${driver_TU1}  driver_set_up_and_logIn     ${Team_User1_username}
#    # EU2 log in
#    ${driver_EU2}  driver_set_up_and_logIn     ${Expert_User2_username}
#    # TU1 calls EU2. EU2 answers call.
#    contacts_witch_page_make_call   ${driver_TU1}   ${driver_EU2}   ${py_team_page}   ${Expert_User2_name}
#    make_sure_enter_call    ${driver_EU2}
#    # U3 log in
#    ${driver_U3}  driver_set_up_and_logIn     ${Expert_User3_username}
#    # TU1 invites U3 from contact list. U3 answers call.
#    inCall_enter_contacts_search_user   ${driver_TU1}    ${Expert_User3_name}
#    click_user_in_contacts_list    ${driver_TU1}     ${Expert_User3_name}
#    user_anwser_call    ${driver_U3}
#    make_sure_enter_call    ${driver_U3}
#    # VP: participants icon is visible for user 1 and user 2, but invisible for user 3.
#    participants_icon_is_visible   ${driver_TU1}
#    participants_icon_is_visible   ${driver_EU2}
#    participants_icon_is_visible   ${driver_U3}   no
#    # 获取invite link
#    ${invite_url}    send_new_invite_in_calling    ${driver_EU2}
#    close_invite_3th_page    ${driver_EU2}
#    # Anonymous user 4 via 3pi link
#    ${driver_U4}  anonymous_open_meeting_link    ${invite_url}
#    user_anwser_call    ${driver_TU1}    no_direct
#    # EU5 via 3pi link
#    ${driver_EU5}  driver_set_up_and_logIn     ${Expert_User5_username}
#    user_make_call_via_meeting_link   ${driver_EU5}   ${invite_url}
#    # U6 via 3pi link
#    ${driver_U6}  driver_set_up_and_logIn     ${Team_User2_username}
#    user_make_call_via_meeting_link   ${driver_U6}   ${invite_url}
#    # VP:
#    # 1. participants icon is invisible for the three users.
#    participants_icon_is_visible   ${driver_U4}   no
#    participants_icon_is_visible   ${driver_EU5}   no
#    participants_icon_is_visible   ${driver_U6}   no
#    # 2. Invite button should be hidden for users in enterprise A.
#    invite_button_should_be_hidden   ${driver_U4}
#    invite_button_should_be_hidden   ${driver_EU5}
#    invite_button_should_be_hidden   ${driver_U6}
#    # 3. Display users as joined order.
#    click_participants_icon   ${driver_TU1}
#    check_participants_correct    ${driver_TU1}    ${Expert_User2_name}   ${Expert_User3_name}    ${anonymous_user_name}    ${Expert_User5_name}    ${Team_User2_name}
#    click_participants_icon   ${driver_TU1}
#    # 4. There should be one dot when 3-4 participants; two dots when 5-8 participants; 3 dots when 8-12 participants
#    check_two_dots    ${driver_U6}
#    # Any one participant clicks on the second dot.	 VP: the second page displays with last two joined users.
#    clicks_the_hollow_dot       ${driver_U6}
#    check_current_participants   ${driver_U6}    ${anonymous_user_name}    ${Expert_User5_name}
#    # He clicks on the first dot.	VP: the first page displays.
#    clicks_the_hollow_dot       ${driver_U6}
#    check_current_participants   ${driver_U6}    ${Team_User2_name}    ${Team_User1_name}    ${Expert_User2_name}   ${Expert_User3_name}
#    # Any one participant swipes to left.	VP: the second page displays with last two joined users.
#    click_nav_right   ${driver_EU2}
#    check_current_participants   ${driver_EU2}   ${Expert_User5_name}   ${Team_User2_name}
#    # He swipe to right.	VP: the first page displays.
#    click_nav_left   ${driver_EU2}
#    check_current_participants   ${driver_EU2}    ${Expert_User2_name}    ${Team_User1_name}   ${Expert_User3_name}    ${anonymous_user_name}
#    # User 7 clicks on 3pi link.	VP: user 7 sees message “Too many users in a call”
#    ${driver_U7}  driver_set_up_and_logIn     ${Expert_User4_username}
#    user_make_call_via_meeting_link   ${driver_U7}   ${invite_url}
#    which_page_is_currently_on        ${driver_U7}       ${too_many_users_in_a_call}
#    exit_one_driver       ${driver_U7}
#    # All of the users clicks on mode menu.	VP: Mode submenu is visible for the first two joined users (user 1 and user 2), but not visible for the other users.
#    check_f2f_mode_show     ${driver_TU1}
#    check_f2f_mode_show     ${driver_EU2}
#    check_f2f_mode_show     ${driver_U3}    no_show
#    check_f2f_mode_show     ${driver_U4}    no_show
#    check_f2f_mode_show     ${driver_EU5}   no_show
#    check_f2f_mode_show     ${driver_U6}    no_show
#    # TU1 clicks on participants icon	VP:
#    click_participants_icon      ${driver_TU1}
#    # 1. Participants window displays with 4 columns: Participants, Mute, Co-Host, Remove.
#    participants_display_4_columns     ${driver_TU1}
#    # 2. TU1 isn’t in the table.   前面已经检查过了
#    # 3. Co-Host is turned on for the second joined user (EU2) by default, turned off for other users.
#    Co_Host_is_turned_on    ${driver_TU1}    ${Expert_User2_name}
#    Co_Host_is_turned_on    ${driver_TU1}    ${Expert_User3_name}    off
#    Co_Host_is_turned_on    ${driver_TU1}    ${anonymous_user_name}    off
#    Co_Host_is_turned_on    ${driver_TU1}    ${Expert_User5_name}    off
#    Co_Host_is_turned_on    ${driver_TU1}    ${Team_User2_name}    off
#    # 4. Participants are displayed by join order.    前面已经检查过了
#    # CP: TU turn on co-host	TU1 turns on co-host for U3.	VP: participants menu and mode submenu become visible for U3.
#    turn_on_co_host   ${driver_TU1}    ${Expert_User3_name}
#
#    Co_Host_is_turned_on    ${driver_TU1}    ${Expert_User3_name}
#    # CP: host cannot be demoted or removed.	EU2 (co-host) tries to turn off co-host for TU1	VP: host TU1 cannot be demoted.
#    click_participants_icon     ${driver_EU2}
#    co_host_can_not_turn_off    ${driver_EU2}    ${Team_User1_name}
#    # EU2 (co-host) tries to remove TU1.	VP: host TU1 cannot be removed
#    can_not_remove_participant    ${driver_EU2}    ${Team_User1_name}
#    click_participants_icon     ${driver_EU2}
#    # CP: anonymous user cannot be promoted to co-host	TU1 tries to turn on co-host for anonymous user	VP: anonymous user cannot be promoted to co-host.
#    turn_on_co_host   ${driver_TU1}    ${anonymous_user_name}
#    sleep  3s
#    check_f2f_mode_show     ${driver_U4}    no_show
#    # CP: co-host mute other participant	TU1 mutes other participant	VP: related participant sees disabled mic icon in action bar.
#    co_host_mute_other_participant    ${driver_TU1}     ${Expert_User5_name}
#    check_mic_is_off    ${driver_EU5}
#    # TU1 tries to unmute other participant.	VP: nothing happens. mic is still off for related participant.
#    try_unmute_other_participant    ${driver_TU1}     ${Expert_User5_name}
#    check_mic_is_off    ${driver_EU5}
#    # The muted participant turns on mic by himself.	VP: mic is on.
#    turns_on_mic_by_himself    ${driver_EU5}
#    check_mic_is_off   ${driver_EU5}   on
#    # CP: remove user in F2F	TU1 turns on EU5’s co-host, and then clicks on EU5’s remove button.	VP: warning dialog displays with message “Are you sure you want to remove EU5?”, OK/Cancel button.
#    turn_on_co_host    ${driver_TU1}    ${Expert_User5_name}
#    sleep  10
#    click_remove_which_participant    ${driver_TU1}    ${Expert_User5_name}
#    check_after_click_remove   ${driver_TU1}    ${Expert_User5_name}
#    # User 1 confirms Cancel.	VP: related user is not removed.
#    click_cancel_after_remove     ${driver_TU1}
#    check_participants_correct    ${driver_TU1}    ${Expert_User2_name}   ${Expert_User3_name}    ${anonymous_user_name}    ${Expert_User5_name}    ${Team_User2_name}
#    # User 1 removes EU5 and confirm OK.	VP: Removed user disappears from participants window.Removed user sees message “A Host has removed you from the Help Lightning call.” on the end-call screen.
#    click_remove_which_participant    ${driver_TU1}    ${Expert_User5_name}
#    click_confirm_after_remove     ${driver_TU1}
#    sleep  10
#    check_participants_correct    ${driver_TU1}    ${Expert_User2_name}   ${Expert_User3_name}    ${anonymous_user_name}     ${Team_User2_name}
#    click_participants_icon   ${driver_TU1}
#    check_removed_end_call_message    ${driver_EU5}
#    # CP: role selection dialog	Any one co-host clicks on mode icon.	VP: role selection dialog opens.
#    click_switch_role_icon  ${driver_TU1}
#    # 1. Title is “You are currently in Face to Face mode" under MODE. Text "Select who will Give Help" shows under title.
#    # 3. Step 1 of 2 displays in the bottom.
#    show_title_text_under_mode    ${driver_TU1}
#    # 2. Display users with default avatar thumbnails in joined order.
#    check_every_role    ${driver_TU1}    ${Team_User1_name}   ${Expert_User2_name}   ${Expert_User3_name}    ${anonymous_user_name}   ${Team_User2_name}
#    # 4. Co-host can scroll up/down to list more participants.
#    # Non co-host clicks on mode icon.	VP: mode submenu should not display.
#    mode_submenu_should_not_display    ${driver_U4}
#    mode_submenu_should_not_display    ${driver_U6}
#    # CP: enter giving/receiving help mode.	Co-host selects user 1 as giver.	VP: Text changes to "Select who will Receive Help". Step 2 of 2 displays in the bottom. User 1 is selected status.
#    Co_host_selects_user_1_as_giver    ${driver_TU1}    ${Team_User1_name}
#    show_title_text_under_mode_after_choose_giver    ${driver_TU1}
#    user_is_selected_status   ${driver_TU1}    ${Team_User1_name}
#    # Back button displays in the bottom.
#    back_button_displays_in_the_bottom    ${driver_TU1}
#    # Co-host clicks on back button	VP: the selection is cleared.
#    click_mode_back_button    ${driver_TU1}
#    user_is_selected_status   ${driver_TU1}    ${Team_User1_name}   no
#    # Co-host selects user 1 as giver, user 2 as receiver	VP: Continue button appears in the bottom
#    Co_host_selects_user_1_as_giver      ${driver_TU1}    ${Team_User1_name}
#    Co_host_selects_user_2_as_receiver   ${driver_TU1}    ${Expert_User2_name}
#    continue_button_appears_in_the_bottom    ${driver_TU1}
#    # Co-host clicks on back button.	VP: all the selections are cleared.
#    click_mode_back_button    ${driver_TU1}
#    user_is_selected_status   ${driver_TU1}    ${Team_User1_name}     no
#    user_is_selected_status   ${driver_TU1}    ${Expert_User2_name}   no
#    # Co-host selects user 1 as giver, then selects user 2 as receiver, then taps Continue.	VP: 1. enter merged reality mode with correct giver and receiver, other users are observer.
#    Co_host_selects_user_1_as_giver      ${driver_TU1}    ${Team_User1_name}
#    Co_host_selects_user_2_as_receiver   ${driver_TU1}    ${Expert_User2_name}
#    click_mode_continue_button   ${driver_TU1}
#    # 2. Mode icon displays as Giving help in action bar for giver.
#    mode_icon_displays_as     ${driver_TU1}
#    # 3. Mode icon displays as Receiving help in action bar for receiver.
#    mode_icon_displays_as     ${driver_EU2}    receiver
#    # 4. Mode icon displays as observer in action bar for observer.
#    mode_icon_displays_as     ${driver_U3}    observer
#    # 5. observer cannot enter freezing/photo/pdf mode. Revert camera and turn on/off flashlight is hidden for observer.
#    check_observer_permission    ${driver_U3}
#    [Teardown]    exit_driver