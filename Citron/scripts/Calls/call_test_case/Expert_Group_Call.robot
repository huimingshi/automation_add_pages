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
    [Tags]     Call Center
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