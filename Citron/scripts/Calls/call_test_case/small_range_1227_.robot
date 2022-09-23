#*** Settings ***
#Library           Selenium2Library
#Library           OperatingSystem
#Resource          ../../../Lib/public.robot
#Resource          ../../../Lib/calls_resource.robot
#Resource          ../../../Lib/All_Pages_Xpath/Normal/Messages.robot
#Resource          ../../../Lib/hodgepodge_resource.robot
#Library           call_python_Lib/call_public_lib.py
#Library           call_python_Lib/else_public_lib.py
#Library           call_python_Lib/messages_page.py
#Library           call_python_Lib/about_call.py
#Library           call_python_Lib/finish_call.py
#Library           call_python_Lib/login_lib.py
#Library           call_python_Lib/contacts_page.py
#Force Tags        small_range
#
#
#*** Test Cases ***
#Small_range_1227_1264
#    [Documentation]     In call message
#    [Tags]    small range 1227-1264 lines
#    # userA login
#    ${driverA}     driver_set_up_and_logIn     ${in_call_message_userA}
#    ${mhs_link}    send_meeting_room_link    ${driverA}     which_meeting='MHS'
#    # userB login
#    ${driverB}     driver_set_up_and_logIn     ${in_call_message_userB}
#    # User B clicks User A's MHS link
#    user_make_call_via_meeting_link     ${driverB}    ${mhs_link}
#    user_anwser_call    ${driverA}
#    make_sure_enter_call     ${driverB}
#    # userD login
#    ${driverD}     driver_set_up_and_logIn     ${in_call_message_userD}
#    # User A invites Expert Group
#    enter_contacts_search_user      ${driverA}     ${in_call_message_expert_group}
#    click_user_in_contacts_call     ${driverA}     ${in_call_message_expert_group}
#    # Expert User[User D] enter this call
#    user_anwser_call    ${driverD}
#    which_page_is_currently_on    ${driverD}     ${end_call_button}
#    # User A sends 3pci link
#    ${invite_link}      send_invite_in_calling_page     ${driverA}
#    close_invite_3th_page     ${driverA}
#    # userC    A1    D1   login
#    ${driverC}     driver_set_up_and_logIn     ${in_call_message_userC}
#    ${driverD1}     driver_set_up_and_logIn     ${in_call_message_userD1}
#    # User C enters this call via 3cpi
#    user_make_call_via_meeting_link     ${driverC}    ${invite_link}
#    user_anwser_call     ${driverA}    no_direct
#    # A1 enter this call via 3pci
#    ${driverA1}     anonymous_open_meeting_link    ${invite_link}
#    user_anwser_call     ${driverA}    no_direct
#    # D1 enter this call via 3pci
#    user_make_call_via_meeting_link     ${driverD1}    ${invite_link}
#    user_anwser_call     ${driverA}    no_direct
#    # User A clicks Message button
#    # VP: 1) Messages has been accessed, the drawer can be collapsed into the left margin.
#    # 2) Set transparency to 80% for the white message window background
#    in_call_click_message_button     ${driverA}
#    # User A  enters the Text message to send
#    in_call_send_message_data     ${driverA}    ${plain_english_text}
#    # VP: 1. The Text messages should be  taken from Fieldbit
#    # 2. User B, User C, User D, A1 & D1 should displays the number  of message  number through the Options Message menu
#    in_call_show_count_of_message       ${driverB}
#    in_call_show_count_of_message       ${driverC}
#    in_call_show_count_of_message       ${driverD}
#    in_call_show_count_of_message       ${driverA1}
#    in_call_show_count_of_message       ${driverD1}
#    # User A, User B, User C, User D, A1 & D1  Selects the ellipses
#    # VP: The Text messages should be  taken from Fieldbit
#    in_call_check_receive_message       ${driverB}      ${plain_english_text}
#    in_call_check_receive_message       ${driverC}      ${plain_english_text}
#    in_call_check_receive_message       ${driverD}      ${plain_english_text}
#    in_call_check_receive_message       ${driverA1}      ${plain_english_text}
#    in_call_check_receive_message       ${driverD1}      ${plain_english_text}
#
#
#    sleep  10000
#    user_make_call_via_meeting_link     ${driverD1}    ${invite_link}