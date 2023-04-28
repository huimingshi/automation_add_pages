*** Settings ***
Library           Selenium2Library
Library           OperatingSystem
Resource          ../../../Lib/public.robot
Resource          ../../../Lib/calls_resource.robot
Resource          ../../../Lib/All_Pages_Xpath/Normal/Messages.robot
Resource          ../../../Lib/hodgepodge_resource.robot
Library           call_python_Lib/call_action_lib_copy.py
Library           call_python_Lib/call_check_lib.py
Library           call_python_Lib/else_public_lib.py
Library           call_python_Lib/messages_page.py
Library           call_python_Lib/about_call.py
Library           call_python_Lib/finish_call.py
Library           call_python_Lib/login_lib.py
Force Tags        small_range


*** Test Cases ***
Small_range_1195_1197
    [Documentation]     Calls from message dialog       Create 1v1 message thread with offline contact user1
    [Tags]    small range 1195-1197 lines       message_case
    # user login
    ${driver}     driver_set_up_and_logIn     ${message_test0_user}
    # Create 1v1 message thread with offline contact user1
    contacts_different_page_search_user     ${driver}     ${py_team_page}       ${message_not_need_read_username}
    start_new_chat    ${driver}     ${message_not_need_read_username}
    # Say hello to contact
    send_message_by_different_data     ${driver}    ${need_send_hello}
    # Click Audio+ icon	     VP: Send invitation dialog displays asking “Would you like to invite them into a call via email”, with cancel and send invitation button.
    click_audio_video_button   ${driver}
    click_audio_video_button   ${driver}    Video
    [Teardown]      run keywords    delete_all_message_thread    ${driver}
    ...             AND             exit_driver

Small_range_1198_1210
    [Documentation]     Calls from message dialog       Create message group with no more than 6 members
    [Tags]    small range 1198-1210 lines     call_case        message_case
    # user login
    ${driver1}     driver_set_up_and_logIn     ${message_test0_user}
    ${driver2}     driver_set_up_and_logIn     ${message_test1_user}
    ${driver3}     driver_set_up_and_logIn     ${message_test2_user}
    ${driver4}     driver_set_up_and_logIn     ${message_test3_user}
    switch_to_diffrent_page     ${driver1}     ${py_messages_page}     ${py_messages_switch_success}    ${search_messages_box}
    create_a_new_message     ${driver1}     search     ${message_test1_username}     ${message_test2_username}     ${message_test3_username}
    confirm_create_message     ${driver1}

    # ---------  1198-1200  --------- #
    comment   --------- 1198-1200 ---------
    # Click Audio+ icon
    click_which_message     ${driver1}        ${message_test1_username}     ${message_test2_username}     ${message_test3_username}
    click_audio_video_button   ${driver1}    Audio    0
    # VP:outgoing call view	  VP: names, avatars on outgoing call view are correct
    check_outgoing_call_names      ${driver1}     ${message_test1_username}     ${message_test2_username}     ${message_test3_username}
    # VP: all other members receive incoming call
    which_page_is_currently_on    ${driver2}    ${anwser_call_button_xpath}
    which_page_is_currently_on    ${driver3}    ${anwser_call_button_xpath}
    which_page_is_currently_on    ${driver4}    ${anwser_call_button_xpath}
    # Cancel outgoing call        VP: all incoming call is cancelled
    user_end_call_by_self      ${driver1}
    sleep   10s
    which_page_is_currently_on    ${driver2}    ${anwser_call_button_xpath}     ${not_currently_on}
    which_page_is_currently_on    ${driver3}    ${anwser_call_button_xpath}     ${not_currently_on}
    which_page_is_currently_on    ${driver4}    ${anwser_call_button_xpath}     ${not_currently_on}

    # ---------  1201-1205  --------- #
    comment   --------- 1201-1205 ---------
    switch_to_diffrent_page     ${driver1}     ${py_contacts_page}     ${py_contacts_switch_success}    ${py_get_number_of_rows}
    switch_to_diffrent_page     ${driver1}     ${py_messages_page}     ${py_messages_switch_success}    ${search_messages_box}
    create_a_new_message     ${driver1}     search     ${message_test1_username}     ${message_test2_username}     ${message_test3_username}
    confirm_create_message     ${driver1}
    # Click Video icon	VP:outgoing call view	VP: names, avatars on outgoing call view are correct
    click_which_message     ${driver1}        ${message_test1_username}     ${message_test2_username}     ${message_test3_username}
    click_audio_video_button   ${driver1}    Video    0
    # VP: all other members receive incoming call
    which_page_is_currently_on    ${driver2}    ${anwser_call_button_xpath}
    which_page_is_currently_on    ${driver3}    ${anwser_call_button_xpath}
    which_page_is_currently_on    ${driver4}    ${anwser_call_button_xpath}
    # First contact userF decline incoming call	VP: others still see incoming call view
    user_decline_call    ${driver2}
    which_page_is_currently_on    ${driver2}    ${anwser_call_button_xpath}     ${not_currently_on}
    which_page_is_currently_on    ${driver3}    ${anwser_call_button_xpath}
    which_page_is_currently_on    ${driver4}    ${anwser_call_button_xpath}
    # Other contacts answer incoming	VP: Enter Video mode call
    user_anwser_call      ${driver3}
    user_anwser_call      ${driver4}
    which_page_is_currently_on        ${driver3}      ${end_call_button}
    which_page_is_currently_on        ${driver4}      ${end_call_button}
    # Invite first contact userF from In call	VP: userF receive incoming call
    inCall_enter_contacts_search_user     ${driver1}    ${message_test1_username}
    click_user_in_contacts_list     ${driver1}    ${message_test1_username}
    user_anwser_call    ${driver2}
    # UserF answer incoming call	VP: userF enter in call view video mode
    which_page_is_currently_on        ${driver2}      ${end_call_button}

    # ---------  1206-1210  --------- #
    comment   --------- 1206-1210 ---------
    end_call_for_all           ${driver1}
    close_call_ending_page     ${driver1}
    close_call_ending_page     ${driver3}
    close_call_ending_page     ${driver4}
    switch_to_diffrent_page     ${driver1}     ${py_contacts_page}     ${py_contacts_switch_success}    ${py_get_number_of_rows}
    switch_to_diffrent_page     ${driver1}     ${py_messages_page}     ${py_messages_switch_success}    ${search_messages_box}
    create_a_new_message     ${driver1}     search     ${message_test1_username}     ${message_test2_username}     ${message_test3_username}
    confirm_create_message     ${driver1}
    # Click Video icon	VP:outgoing call view	VP: names, avatars on outgoing call view are correct
    click_which_message     ${driver1}        ${message_test1_username}     ${message_test2_username}     ${message_test3_username}
    click_audio_video_button   ${driver1}    Video    0
    # VP: All other members receive incoming call
    which_page_is_currently_on    ${driver2}    ${anwser_call_button_xpath}
    which_page_is_currently_on    ${driver3}    ${anwser_call_button_xpath}
    which_page_is_currently_on    ${driver4}    ${anwser_call_button_xpath}
    # First contact answer incoming call
    user_anwser_call      ${driver2}
    # second contact decline incoming call
    user_decline_call     ${driver3}
    # Other contacts answer incoming   VP: all answered contact enter call with video mode
    user_anwser_call      ${driver4}
    which_page_is_currently_on        ${driver1}      ${end_call_button}
    which_page_is_currently_on        ${driver2}      ${end_call_button}
    which_page_is_currently_on        ${driver4}      ${end_call_button}
    # Invite other conact by sending 3PI link	VP: anonymous or loggin user is able to enter call via this 3PI link
    ${invite_url}     send_new_invite_in_calling      ${driver1}
    ${driver5}     anonymous_open_meeting_link      ${invite_url}
    which_page_is_currently_on        ${driver5}      ${end_call_before_anwser}
    user_decline_call     ${driver1}    no_direct
    [Teardown]      run keywords    end_call_for_all           ${driver1}
    ...             AND             close_call_ending_page     ${driver1}
    ...             AND             delete_all_message_thread        ${driver1}
    ...             AND             exit_driver

Small_range_1211_1214
    [Documentation]     Calls from message dialog       Create message group has more than 6 memebers
    [Tags]    small range 1198-1210 lines      call_case      message_case
    # user login
    ${driver1}     driver_set_up_and_logIn     ${message_test0_user}
    ${driver2}     driver_set_up_and_logIn     ${message_test1_user}
    ${driver3}     driver_set_up_and_logIn     ${message_test2_user}
    ${driver4}     driver_set_up_and_logIn     ${message_test3_user}
    ${driver5}     driver_set_up_and_logIn     ${message_test4_user}
    ${driver6}     driver_set_up_and_logIn     ${message_test5_user}
    ${driver7}     driver_set_up_and_logIn     ${message_test6_user}
    switch_to_diffrent_page     ${driver1}     ${py_messages_page}     ${py_messages_switch_success}    ${search_messages_box}
    create_a_new_message     ${driver1}     search     ${message_test1_username}     ${message_test2_username}     ${message_test3_username}     ${message_test4_username}     ${message_test5_username}     ${message_test6_username}
    confirm_create_message     ${driver1}
    # Click Video icon
    click_which_message     ${driver1}        ${message_test1_username}     ${message_test2_username}     ${message_test3_username}     ${message_test4_username}     ${message_test5_username}     ${message_test6_username}
    click_audio_video_button   ${driver1}    Video    0
    # VP:outgoing call view	VP: names, avatars on outgoing call view are correct
    check_outgoing_call_names      ${driver1}     ${message_test1_username}     ${message_test2_username}     ${message_test3_username}     ${message_test4_username}     ${message_test5_username}     ${message_test6_username}
    # VP: all other members receive incoming call
    which_page_is_currently_on    ${driver2}    ${anwser_call_button_xpath}
    which_page_is_currently_on    ${driver3}    ${anwser_call_button_xpath}
    which_page_is_currently_on    ${driver4}    ${anwser_call_button_xpath}
    which_page_is_currently_on    ${driver5}    ${anwser_call_button_xpath}
    which_page_is_currently_on    ${driver6}    ${anwser_call_button_xpath}
    which_page_is_currently_on    ${driver7}    ${anwser_call_button_xpath}
    # First 5 contacts answer incoming call	VP: 6 participants in call with audio+ mode
    user_anwser_call      ${driver2}
    user_anwser_call      ${driver3}
    user_anwser_call      ${driver4}
    user_anwser_call      ${driver5}
    user_anwser_call      ${driver6}
    which_page_is_currently_on        ${driver1}      ${end_call_button}
    which_page_is_currently_on        ${driver2}      ${end_call_button}
    which_page_is_currently_on        ${driver3}      ${end_call_button}
    which_page_is_currently_on        ${driver4}      ${end_call_button}
    which_page_is_currently_on        ${driver5}      ${end_call_button}
    which_page_is_currently_on        ${driver6}      ${end_call_button}
    # 6th contact answer incoming call	VP: 6th contacts see message like "Too many users in call", Stage environment allow no more than 6 participants in a call
    user_anwser_call      ${driver7}
    which_page_is_currently_on        ${driver7}       ${too_many_users_in_a_call}
    [Teardown]      run keywords    end_call_for_all           ${driver1}
    ...             AND             close_call_ending_page     ${driver1}
    ...             AND             delete_all_message_thread        ${driver1}
    ...             AND             exit_driver

Small_range_1215_1216
    [Documentation]     Search message
    [Tags]    small range 1215-1216 lines           message_case
    # user login
    ${driver1}     driver_set_up_and_logIn     ${message_test0_user}
    # Create 1V1 message thead from Team
    contacts_different_page_search_user     ${driver1}     ${py_team_page}       ${message_test1_username}
    start_new_chat    ${driver1}     ${message_test1_username}
    send_message_by_different_data     ${driver1}      ${need_send_hello}
    send_message_by_different_data     ${driver1}      ${how_old_are_you}
    send_message_by_different_data     ${driver1}      ${need_reply_world}
    # Create an another thread
    create_a_new_message     ${driver1}     search    ${message_test2_username}
    confirm_create_message     ${driver1}
    send_message_by_different_data     ${driver1}      ${need_send_hello}
    send_message_by_different_data     ${driver1}      ${how_old_are_you}
    send_message_by_different_data     ${driver1}      ${need_reply_world}
    # Search message contact name	VP: message thread list shows   Click any one in result list	VP: corresponding message thread is open
    # 此处有问题，暂时不写
    # Search meanfull words in English, like "Apple", "Tree"	(do not seach word like hi, the, a, an )
    search_messages_by_keyword      ${driver1}     old
    check_message_delete_success     ${driver1}     ${message_test1_username}     0
    check_message_delete_success     ${driver1}     ${message_test2_username}     0
    # VP: message thread and specific content shows	Click search result
    click_which_message     ${driver1}     ${message_test1_username}
    see_last_content_on_message_dialog     ${driver1}     ${how_old_are_you}
    [Teardown]      run keywords    delete_all_message_thread    ${driver1}
    ...             AND             exit_driver