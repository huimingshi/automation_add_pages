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
expert_group_call_Scenario_1
    [Documentation]     Precondition: TU1, EU2, U3 are in the same enterprise A.  TU1 calls on-call group B. EU 2 in on-call group answers call.
    [Tags]     Expert Group Call
    # EU2 in on-call group B; TU1 calls on-call group B
    ${driver_TU1}     driver_set_up_and_logIn     ${expert_group_call_userT1}
    ${driver_EU2}     driver_set_up_and_logIn     ${expert_group_call_userE2}
    contacts_witch_page_make_call       ${driver_TU1}   ${driver_EU2}   ${py_team_page}   ${expert_group_call_GROUP}
    # TU1 invites U3 from contact list. U3 answers call.
    ${driver_U3}     driver_set_up_and_logIn     ${expert_group_call_user3}
    inCall_enter_contacts_search_user    ${driver_TU1}     ${expert_group_call_name3}
    click_user_in_contacts_list          ${driver_TU1}     ${expert_group_call_name3}
    user_anwser_call     ${driver_U3}
    # Join call in sequence: Anonymous user AU4 via 3pi link. Logged in user U5 via 3pi link. Different site DU6 via 3pi link
    ${invite_url}     send_new_invite_in_calling     ${driver_EU2}
    ${driver_AU4}     anonymous_open_meeting_link    ${invite_url}
    user_anwser_call     ${driver_EU2}    no_direct
    ${driver_U5}     driver_set_up_and_logIn     ${expert_group_call_user4}
    user_make_call_via_meeting_link     ${driver_U5}    ${invite_url}
    ${driver_DU6}     driver_set_up_and_logIn     ${close_center_mode_userA}
    user_make_call_via_meeting_link     ${driver_DU6}    ${invite_url}
    user_anwser_call     ${driver_EU2}    not_direct
    enter_video_connection     ${driver_TU1}
        # VP: 2. Invite(Add People) button should be hidden for users in enterprise A, room is full.
        invite_button_is_hidden     ${driver_TU1}    ${driver_EU2}
        # 3. Display users as joined order.
        display_users_as_joined_order     ${driver_TU1}    ${expert_group_call_nameE2}    ${expert_group_call_name3}    ${anonymous_user_name}    ${expert_group_call_name4}    ${close_center_mode_nameA}
        # VP: participants icon is visible for TU1 and EU2, but invisible for others.
        participants_icon_is_visible     yes    ${driver_TU1}    ${driver_EU2}
        participants_icon_is_visible     no    ${driver_U3}    ${driver_AU4}    ${driver_U5}    ${driver_DU6}
            # VP: F2F mode;
            check_in_f2f_mode     ${driver_TU1}
            # VP: Web Desktop only - for the host/co-host, "Share Live Video from: <other participant(First one if multi)>"button
            check_show_share_live_video_from     ${driver_TU1}    ${driver_EU2}
            check_not_show_share_live_video_from    ${driver_U3}    ${driver_AU4}    ${driver_U5}    ${driver_DU6}

    comment       CP: EU turn on/off co-host
    # EU2 turns on U5’s co-host.	VP: participants menu and 'Share my camera' button become visible for U5.
    turn_on_co_host_for_sb     ${driver_EU2}    ${expert_group_call_name4}
    participants_icon_is_visible     yes    ${driver_U5}
    check_share_sb_video_visible   ${driver_U5}    My Camera
    # EU2 turns off U5’s co-host.	VP: participants menu and 'Share my camera' button become invisible for U5.
    turn_off_co_host_for_sb     ${driver_EU2}    ${expert_group_call_name4}
    participants_icon_is_visible     no    ${driver_U5}
#    check_share_sb_video_visible   ${driver_U5}    My Camera    invisible
    # U1 share live video	VP: "You are sharing video." for U1, "Currently viewing video from U1" for others	"Now view video from xxx"
    share_me    ${driver_TU1}
    you_are_sharing_video    ${driver_TU1}
    currently_viewing_video_from_sb    ${expert_group_call_nameT1}    ${driver_EU2}    ${driver_U3}    ${driver_AU4}    ${driver_U5}    ${driver_DU6}

    # EU2 start merge	VP: merge preview dialog
    click_merge_button   ${driver_EU2}

    comment       Observer freeze
    # AU1 click freeze
    freeze_operation     ${driver_AU4}
    # U3 start merge as giver	VP: frozen mode + merged video from U3
    click_merge_button    ${driver_U3}
    check_has_unFreeze_button   ${driver_U3}
    # AU1 stop sharing	VP: back to F2F mode
    stop_sharing_to_f2f     ${driver_AU4}
    check_in_f2f_mode     ${driver_AU4}
    # U1 share live video
    share_me     ${driver_TU1}
    # DU5 click freeze	VP: frozen image only.
    freeze_operation     ${driver_U5}

    comment       Keep receiver, change giver
    # EU2 start merge	VP: merge preview dialog shows first; keep freezing mode;
    click_merge_button   ${driver_EU2}
    # EU2 click un-freeze
    freeze_operation   ${driver_EU2}   unfreeze

    comment       Exchange giver and receiver
    # EU2 Share My Camera	VP: Only live video from EU2, no one is merged
    share_me     ${driver_EU2}
    # Previous receiver U1 start merge
    click merge button      ${driver_TU1}
    # U1 in portrait view
    # U1 click freeze	VP: freezes image is correct
    freeze_operation      ${driver_TU1}
    [Teardown]      exit_driver

expert_group_call_Scenario_2
    [Documentation]      add/remove participant     Test point: participants list is updated after add or remove or leave	giver or receiver leave call, app back to F2F mode automatically
    [Tags]     Expert Group Call
    # EU2 in on-call group B; TU1 calls on-call group B
    ${driver_TU1}     driver_set_up_and_logIn     ${expert_group_call_userT11}
    ${driver_EU2}     driver_set_up_and_logIn     ${expert_group_call_userE21}
    contacts_witch_page_make_call       ${driver_TU1}   ${driver_EU2}   ${py_team_page}   ${expert_group_call_GROUP1}
    # TU1 invites U3 from contact list. U3 answers call.
    ${driver_U3}     driver_set_up_and_logIn     ${expert_group_call_user31}
    inCall_enter_contacts_search_user    ${driver_TU1}     ${expert_group_call_name31}
    click_user_in_contacts_list          ${driver_TU1}     ${expert_group_call_name31}
    user_anwser_call     ${driver_U3}
    # Join call in sequence: Anonymous user AU4 via 3pi link. Logged in user U5 via 3pi link. Different site DU6 via 3pi link
    ${invite_url}     send_new_invite_in_calling     ${driver_EU2}
    ${driver_AU4}     anonymous_open_meeting_link    ${invite_url}
    user_anwser_call     ${driver_EU2}    no_direct
    ${driver_U5}     driver_set_up_and_logIn     ${expert_group_call_user41}
    user_make_call_via_meeting_link     ${driver_U5}    ${invite_url}
    ${driver_DU6}     driver_set_up_and_logIn     ${close_center_mode_userB}
    user_make_call_via_meeting_link     ${driver_DU6}    ${invite_url}
    user_anwser_call     ${driver_EU2}    not_direct
        # VP: 2. Invite button should be hidden for users in enterprise A when room is full.
        invite_button_is_hidden     ${driver_TU1}    ${driver_EU2}
        # 3. Display users as joined order.
        display_users_as_joined_order     ${driver_TU1}    ${expert_group_call_nameE21}    ${expert_group_call_name31}    ${anonymous_user_name}    ${expert_group_call_name41}    ${close_center_mode_nameB}
        # VP: participants icon is visible for TU1 and EU2, but invisible for others.
        participants_icon_is_visible     yes    ${driver_TU1}    ${driver_EU2}
        participants_icon_is_visible     no    ${driver_U3}    ${driver_AU4}    ${driver_U5}    ${driver_DU6}
    # EU2 share TU1's live video as receiver	VP: Only EU2 and TU1 can share TU1's live video
    enter_video_connection     ${driver_EU2}
    share_live_video_from_sb     ${driver_EU2}     ${expert_group_call_nameT11}
    check_can_share_sb_live_video    ${driver_TU1}    My Camera
    check_can_share_sb_live_video    ${driver_EU2}    ${expert_group_call_nameT11}
    check_can_not_share_sb_live_video    ${expert_group_call_nameT11}    ${driver_U3}    ${driver_AU4}    ${driver_U5}    ${driver_DU6}
    # U3 start merge as giver
    click_merge_button      ${driver_U3}
    # Turn on co-host for U5	VP: U5 can manage participants
    turn_on_co_host_for_sb     ${driver_EU2}     ${expert_group_call_name41}
    participants_icon_is_visible     yes    ${driver_U5}

    comment        remove giver in freeze mode
    # U5 removes co-host giver U3     VP: AU1 sees confirm dialog "Are you sure you want to remove <USER NAME>?" ; VP: U3 left
    co_host_remove_sb     ${driver_U5}     ${expert_group_call_name31}     can   yes    observer    no
    #  Confirms with Remove User.
        # VP:
        # 2. Show a toast message to all remaining users: “User Name (Giver) left the call. Switched back to Face to Face mode.”
        left_call_back_f2f_mode     ${driver_U5}      ${expert_group_call_name31}
        close_invite_3th_page     ${driver_U5}
        # 1. app enters Face to Face mode.
        check_in_f2f_mode    ${driver_U5}
        # 3. User is removed from the call. He sees message “A Host has removed you from the Help Lightning call.” on the end-call screen.
        which_page_is_currently_on        ${driver_U3}       ${has_removed_you}
        exit_one_driver    ${driver_U3}

    comment        remove receiver in freeze mode
    # TU1 Share My camera
    share_me      ${driver_TU1}
    # EU2 click freeze	VP: enter merged reality mode with correct giver and receiver, other users are observer.
    freeze_operation        ${driver_EU2}
    # U5 removes receiver TU1 and confirms with Remove User.
    co_host_remove_sb     ${driver_U5}     ${expert_group_call_nameT11}     can   yes    observer    no
        # VP:
        # 2. Show a toast message to all remaining users: “User Name (Receiver) left the call. Switched back to Face to Face mode.”
        has_left_the_session     ${driver_U5}      ${expert_group_call_nameT11}
        close_invite_3th_page    ${driver_U5}
        # 1. app enters Face to Face mode.
        check_in_f2f_mode    ${driver_U5}
        # 3. User is removed from the call. He sees message “A Host has removed you from the Help Lightning call.” on the end-call screen.
        which_page_is_currently_on        ${driver_TU1}       ${has_removed_you}
        exit_one_driver    ${driver_TU1}
        # TU1 left
    # share AU4's live video
    share_live_video_from_sb     ${driver_U5}      ${anonymous_user_name}

    comment        remove observer in freeze mode
    # enter freeze mode
    freeze_operation        ${driver_EU2}
    # Co-host removes observer U5	VP: warning dialog displays with message “Are you sure you want to remove User Name?”, OK/Cancel button.	u5 left
    co_host_remove_sb     ${driver_EU2}     ${expert_group_call_name41}     can   yes    observer
    exit_one_driver    ${driver_U5}
    # Confirm with Ok.	VP:
        # 1. Removed user disappears from participants window.
        display_users_as_joined_order     ${driver_EU2}     ${anonymous_user_name}       ${close_center_mode_nameB}
        # Removed user sees message “A Host has removed you from the Help Lightning call.” on the end-call screen.
        which_page_is_currently_on        ${driver_U5}       ${has_removed_you}
        # 2. keep freezing mode.
        check_has_unFreeze_button     ${driver_EU2}

    comment        CP: Join call in freezing mode
    # EU7 joins call via 3pi link.	VP: TU A joins call with image synchronized.	%1$s has joined as obeserver
    ${driver_EU7}     driver_set_up_and_logIn     ${expert_group_call_user31}
    user_make_call_via_meeting_link     ${driver_EU7}    ${invite_url}    no_check
    has_joined_the_call     ${driver_EU2}    ${expert_group_call_name31}
    [Teardown]      exit_driver

expert_group_call_Scenario_4
    [Documentation]     leave call in frozen mode
    [Tags]     Expert Group Call     有bug：https://vipaar.atlassian.net/browse/CITRON-3749
    # EU2 in on-call group B; TU1 calls on-call group B
    ${driver_TU1}     driver_set_up_and_logIn     ${expert_group_call_userT1}
    ${driver_EU2}     driver_set_up_and_logIn     ${expert_group_call_userE2}
    contacts_witch_page_make_call       ${driver_TU1}   ${driver_EU2}   ${py_team_page}   ${expert_group_call_GROUP}
    # TU1 invites U3 from contact list. U3 answers call.
    ${driver_U3}     driver_set_up_and_logIn     ${expert_group_call_user3}
    inCall_enter_contacts_search_user    ${driver_TU1}     ${expert_group_call_name3}
    click_user_in_contacts_list          ${driver_TU1}     ${expert_group_call_name3}
    user_anwser_call     ${driver_U3}
    # Join call in sequence: Anonymous user AU4 via 3pi link. Logged in user U5 via 3pi link. Different site DU6 via 3pi link
    ${invite_url}     send_new_invite_in_calling     ${driver_EU2}
    ${driver_AU4}     anonymous_open_meeting_link    ${invite_url}
    user_anwser_call     ${driver_EU2}    no_direct
    ${driver_U5}     driver_set_up_and_logIn     ${expert_group_call_user4}
    user_make_call_via_meeting_link     ${driver_U5}    ${invite_url}
    ${driver_DU6}     driver_set_up_and_logIn     ${close_center_mode_userA}
    user_make_call_via_meeting_link     ${driver_DU6}    ${invite_url}
    user_anwser_call     ${driver_EU2}    not_direct
    # TU1 Share My camera
    enter_video_connection     ${driver_TU1}
    share_me    ${driver_TU1}
    # EU2 start merge as giver
    click_merge_button     ${driver_EU2}
    # Make only one co-host exist in the call, at least one remaining participant is expert, team, personal or different enterprise.
    # Turn off co-host for TU1
    turn_off_co_host_for_sb     ${driver_EU2}     ${expert_group_call_nameT1}

    comment        giver leave by kill app
    # giver EU2 kills app. Wait until he is disconnected from the call.
    exit_one_driver     ${driver_EU2}
        # 2. Show a toast message to all remaining users: “User Name (Giver) left the call. Switched back to Face to Face mode.”
        left_call_back_f2f_mode1     ${driver_TU1}     ${expert_group_call_nameE2}
        # VP: 1. app enters Face to Face mode for all remaining users.
        check_in_f2f_mode      ${driver_DU6}
#        # 3. all the remaining participants are promoted to co-host, except anonymous user. Participants menu is visible for them.
#        participants_icon_is_visible     yes    ${driver_TU1}    ${driver_U3}    ${driver_U5}    ${driver_DU6}
#        participants_icon_is_visible     no    ${driver_AU4}
#    # TU1 Share U3s live video	VP: TU1 is promt to co-host, can share other's live video
#    share_live_video_from_sb      ${driver_TU1}      ${expert_group_call_name3}
#    check_can_share_sb_live_video      ${driver_TU1}      ${expert_group_call_name3}     ${anonymous_user_name}     ${expert_group_call_name4}    ${close_center_mode_nameA}
#
#    comment        receiver directly leave
#    # Co-host receiver clicks on Leave icon.	VP: “Leave call” and “End Call For All” submenus display.
#    check_has_end_call_button     ${driver_TU1}     1    2
#    # Co-host receiver selects “Leave call”	VP: leaved user sees star rating dialog
#    leave_call     ${driver_TU1}
#    which_page_is_currently_on     ${driver_TU1}    ${five_star_high_praise}
    [Teardown]       exit_driver

expert_group_call_Scenario_5
    [Documentation]       Expert Group call through link
    [Tags]     Expert Group Call     有bug：https://vipaar.atlassian.net/browse/CITRON-3749
    # Anonymous AU1 click expert group link to start call
    ${driver_EU2}     driver_set_up_and_logIn     ${expert_group_call_userE21}
    ${driver_AU1}     anonymous_open_meeting_link    ${expert_group_link}
    # Expert EU2 answer call
    user_anwser_call     ${driver_EU2}    no_direct
    # Expert invite TU1 to join call
    ${driver_TU1}     driver_set_up_and_logIn     ${expert_group_call_userT11}
    inCall_enter_contacts_search_user    ${driver_EU2}     ${expert_group_call_nameT11}
    click_user_in_contacts_list          ${driver_EU2}     ${expert_group_call_nameT11}
    user_anwser_call     ${driver_TU1}
    # EU2 send 3PI link
    ${invite_url}     send_new_invite_in_calling     ${driver_EU2}
    # User3, AU4, User5, DU6 join call through 3PI link	VP: only host EU2 can see participant icon
    ${driver_U3}     driver_set_up_and_logIn     ${expert_group_call_user41}
    user_make_call_via_meeting_link     ${driver_U3}    ${invite_url}
    ${driver_AU4}     anonymous_open_meeting_link    ${invite_url}
    user_anwser_call     ${driver_EU2}    no_direct
    ${driver_DU6}     driver_set_up_and_logIn     ${close_center_mode_userB}
    user_make_call_via_meeting_link     ${driver_DU6}    ${invite_url}
    user_anwser_call     ${driver_EU2}    not_direct
    participants_icon_is_visible     yes    ${driver_EU2}
    participants_icon_is_visible     no    ${driver_TU1}    ${driver_AU1}    ${driver_AU4}    ${driver_U3}    ${driver_DU6}
    # AU1 turn on co-host for DU6	VP: DU6 can now see participant icon
    turn_on_co_host_for_sb     ${driver_EU2}    ${close_center_mode_nameB}
    participants_icon_is_visible     yes    ${driver_DU6}
    # DU6 mute other participant	VP: host and co-host can not un-mute other participants
    # DU6 turn off co-host other participants	VP: host EU2 can not be demoted
    # AU1 share her live video	VP: All users have merge option
    share_me     ${driver_AU1}
    sleep   30
    check_has_merge_menu     ${driver_TU1}    ${driver_EU2}     ${driver_AU4}    ${driver_U3}    ${driver_DU6}
    # Host EU2 start merge
    click_merge_button    ${driver_EU2}
    # User3 start merge to be giver	Observer change to giver
    click_merge_button    ${driver_U3}
    check_has_no_merged    ${driver_EU2}
    # AU4 click share My camera	observer change to receiver, VP: User3 keeps merged
    share me      ${driver_AU4}
    check_has_merged   ${driver_U3}

    comment         Giver share her own live video to be receiver
    # User 3 click Share My Camera	VP: User 3 is now sharing live video; no one is merged
    share_me     ${driver_U3}
    check_has_no_merged    ${driver_TU1}    ${driver_EU2}     ${driver_AU1}    ${driver_AU4}    ${driver_DU6}
    # Only keep EU2 as co-host. Turn off others
    turn_off_co_host_for_sb     ${driver_EU2}    ${close_center_mode_nameB}
    # Expert EU2 kill app, and wait for leave call	VP: other participants are promoted to co-host
    exit_one_driver     ${driver_EU2}
#    sleep    120
#    participants_icon_is_visible     yes    ${driver_TU1}    ${driver_AU1}    ${driver_U3}   ${driver_AU4}   ${driver_DU6}
#    # DU6 click participant icon	VP: DU6 has permission to turn on/off others as co-host
#
#    # Stop share	VP: back to F2F mode
#    stop_sharing_to_f2f    ${driver_U3}
#    check_in_f2f_mode      ${driver_U3}
#    # swipe page to view all participants
#    click_nav_right   ${driver_U3}
#    check_current_participants   ${driver_U3}   ${close_center_mode_nameB}
#    click_nav_left   ${driver_U3}
#    check_current_participants   ${driver_U3}    ${anonymous_user_name}    ${expert_group_call_nameT11}   ${expert_group_call_name41}    ${anonymous_user_name2}
    [Teardown]       exit_driver