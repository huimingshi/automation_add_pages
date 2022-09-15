*** Settings ***
Library           Selenium2Library
Library           OperatingSystem
Resource          ../../../Lib/public.robot
Resource          ../../../Lib/calls_resource.robot
Resource          ../../../Lib/All_Pages_Xpath/Normal/Messages.robot
Resource          ../../../Lib/hodgepodge_resource.robot
Library           call_python_Lib/call_public_lib.py
Library           call_python_Lib/else_public_lib.py
Library           call_python_Lib/messages_page.py
Library           call_python_Lib/about_call.py
Library           call_python_Lib/finish_call.py
Library           call_python_Lib/login_lib.py
Force Tags        small_range


*** Test Cases ***
Small_range_1195_1197
    [Documentation]     Calls from message dialog       Create 1v1 message thread with offline contact user1
    [Tags]    small range 1195-1197 lines
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
    [Teardown]      run keywords    delete_message_chat    ${driver}
    ...             AND             exit_driver

Small_range_1198_1210
    [Documentation]     Calls from message dialog       Create message group with no more than 6 members
    [Tags]    small range 1198-1210 lines
    # user login
    ${driver1}     driver_set_up_and_logIn     ${message_test0_user}
    ${driver2}     driver_set_up_and_logIn     ${message_test1_user}
    ${driver3}     driver_set_up_and_logIn     ${message_test2_user}
    ${driver4}     driver_set_up_and_logIn     ${message_test3_user}
    switch_to_diffrent_page     ${driver1}     ${py_messages_page}     ${py_messages_switch_success}    ${search_messages_box}
    create_a_new_message     ${driver1}     search     ${message_test1_username}     ${message_test2_username}     ${message_test3_username}
    confirm_create_message     ${driver1}

    # ---------  1198-1200  --------- #
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
    which_page_is_currently_on    ${driver2}    ${anwser_call_button_xpath}     currently_on = 'not_currently_on'
    which_page_is_currently_on    ${driver3}    ${anwser_call_button_xpath}     currently_on = 'not_currently_on'
    which_page_is_currently_on    ${driver4}    ${anwser_call_button_xpath}     currently_on = 'not_currently_on'

    # ---------  1201-1205  --------- #
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
    which_page_is_currently_on    ${driver2}    ${anwser_call_button_xpath}     currently_on = 'not_currently_on'
    which_page_is_currently_on    ${driver3}    ${anwser_call_button_xpath}
    which_page_is_currently_on    ${driver4}    ${anwser_call_button_xpath}
    # Other contacts answer incoming	VP: Enter Video mode call
    user_anwser_call      ${driver3}
    user_anwser_call      ${driver4}
    which_page_is_currently_on        ${driver3}      ${end_call_button}
    which_page_is_currently_on        ${driver4}      ${end_call_button}
    # Invite first contact userF from In call	VP: userF receive incoming call
    enter_contacts_search_user     ${driver1}    ${message_test1_username}
    click_user_in_contacts_call     ${driver1}    ${message_test1_username}
    user_anwser_call    ${driver2}
    # UserF answer incoming call	VP: userF enter in call view video mode
    which_page_is_currently_on        ${driver2}      ${end_call_button}

    # ---------  1206-1210  --------- #
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
    # Other contacts answer incoming
    user_anwser_call      ${driver4}
    # Invite other conact by sending 3PI link
    ${driver5}     driver_set_up_and_logIn     ${message_test4_user}
    enter_contacts_search_user     ${driver1}    ${message_test4_username}
    click_user_in_contacts_call     ${driver1}    ${message_test4_username}
    user_anwser_call    ${driver5}
    [Teardown]      run keywords    end_call_for_all           ${driver1}
    ...             AND             close_call_ending_page     ${driver1}
    ...             AND             delete_message_chat        ${driver1}
#    ...             AND             exit_driver