*** Settings ***
Library           Selenium2Library
Library           OperatingSystem
Resource          ../../../Lib/public.robot
Resource          ../../../Lib/calls_resource.robot
Resource          ../../../Lib/All_Pages_Xpath/Normal/Messages.robot
Resource          ../../../Lib/hodgepodge_resource.robot
Library           call_python_Lib/call_action_lib.py
Library           call_python_Lib/call_check_lib.py
Library           call_python_Lib/else_public_lib.py
Library           call_python_Lib/messages_page.py
Library           call_python_Lib/login_lib.py
Library           call_python_Lib/public_lib.py
Force Tags        small_range

*** Test Cases ***
Small_range_1078_1082
    [Documentation]     Permission check
    [Tags]    small range 1078-1082 lines     message_case
    [Setup]     run keywords    Login_workspaces_admin
    ...         AND             enter_workspace_settings_page           # 进入settings页面
    ...         AND             turn_on_workspace_directory             # 打开Workspace Directory设置
    # user login
    ${driver}     driver_set_up_and_logIn     ${workspace_admin_username}
    # 进入到workspace settings页面
    switch_to_settings_page    ${driver}
    # message is a workspace feature
    scroll_into_view     ${driver}      ${Workspace_Messaging}
    which_page_is_currently_on       ${driver}     ${Workspace_Messaging}
    which_page_is_currently_on       ${driver}     ${Workspace_Messaging_description}
    # Only person in same worksapce can chat with each other
    # Go to Personal contacts，VP: only the person in same workspace with login user has Message icon
    switch_to_diffrent_page     ${driver}     ${py_contacts_page}     ${py_contacts_switch_success}    ${py_get_number_of_rows}     switch_tree
    contacts_different_page_search_user     ${driver}     ${py_team_page}     Huiming.shi.helplightning+13857584759
    suspension_of_the_mouse     ${driver}     Huiming.shi.helplightning+13857584759
    sleep  6
    ${return_value}    get_css_value     ${driver}     ${message_button_xpath}     display
    should be equal as strings     ${return_value}     flex
    # Favite a personal contact	VP: only the person in same workspace with login user has Message icon
    switch_to_diffrent_page     ${driver}     ${py_favorites_page}     ${py_contacts_switch_success}    ${py_get_number_of_rows}
    contacts_different_page_search_user     ${driver}     ${py_favorites_page}     hlnauto+p1
    suspension_of_the_mouse     ${driver}     hlnauto+p1
    sleep  6
    ${return_value}    get_css_value     ${driver}     ${message_button_xpath}     display
    should be equal as strings     ${return_value}     none

    # turn off message from workspace setting
    switch_to_settings_page    ${driver}
    scroll_into_view     ${driver}      ${Workspace_Messaging}
    switch_to_other_tab       ${driver}      ${Workspace_Messaging_close_xpath}
    # Message tab or nav bar is hiden
    switch_to_other_tab       ${driver}      //div[@role="tree"]/div[1]
    which_page_is_currently_on       ${driver}     ${contacts_menu_xpath}
    which_page_is_currently_on       ${driver}     ${message_menu_xpath}     not_currently_on
    # Go to Contacts	Message icon for each contact is not visible	VP: icon is not visible for favorites, team, personal, directory
    switch_to_diffrent_page     ${driver}     ${py_contacts_page}     ${py_contacts_switch_success}    ${py_get_number_of_rows}
    contacts_different_page_search_user     ${driver}     ${py_team_page}     Huiming.shi.helplightning+13857584759
    suspension_of_the_mouse     ${driver}     Huiming.shi.helplightning+13857584759
    sleep  6
    ${return_value}    get_css_value     ${driver}     ${message_button_xpath}     display
    should be equal as strings     ${return_value}     none
    # VP: icon is not visible for favorites, team, personal, directory
    switch_to_diffrent_page     ${driver}     ${py_favorites_page}     ${py_contacts_switch_success}    ${py_get_number_of_rows}
    contacts_different_page_search_user     ${driver}     ${py_favorites_page}     hlnauto+p1
    suspension_of_the_mouse     ${driver}     hlnauto+p1
    sleep  6
    ${return_value}    get_css_value     ${driver}     ${message_button_xpath}     display
    should be equal as strings     ${return_value}     none
    # VP: icon is not visible for favorites, team, personal, directory
    switch_to_diffrent_page     ${driver}     ${py_personal_page}     ${py_contacts_switch_success}    ${py_get_number_of_rows}
    contacts_different_page_search_user     ${driver}     ${py_personal_page}     hlnauto+p1
    suspension_of_the_mouse     ${driver}     hlnauto+p1
    sleep  6
    ${return_value}    get_css_value     ${driver}     ${message_button_xpath}     display
    should be equal as strings     ${return_value}     none
    # VP: icon is not visible for favorites, team, personal, directory
    switch_to_diffrent_page     ${driver}     ${py_directory_page}     ${py_contacts_switch_success}    ${py_get_number_of_rows}
    contacts_different_page_search_user     ${driver}     ${py_directory_page}     Huiming.shi.helplightning+13857584759
    suspension_of_the_mouse     ${driver}     Huiming.shi.helplightning+13857584759
    sleep  6
    ${return_value}    get_css_value     ${driver}     ${message_button_xpath}     display
    should be equal as strings     ${return_value}     none
    [Teardown]      run keywords     switch_to_settings_page    ${driver}
    ...             AND              scroll_into_view     ${driver}      ${Workspace_Messaging}
    ...             AND              switch_to_other_tab       ${driver}      ${Workspace_Messaging_open_xpath}
    ...             AND              exit_driver

Small_range_1083_1091
    [Documentation]     Prepare message test data
    [Tags]    small range 1083-1091 lines     message_case
    # user login
    ${driver}     driver_set_up_and_logIn     ${message_test0_user}
    switch_to_diffrent_page     ${driver}     ${py_contacts_page}     ${py_contacts_switch_success}    ${py_get_number_of_rows}
    contacts_different_page_search_user     ${driver}     ${py_team_page}       ${message_test1_username}
    start_new_chat    ${driver}     ${message_test1_username}
    # plain text in English
    send_message_by_different_data     ${driver}     ${plain_english_text}
    # plain text in Chinese
    send_message_by_different_data     ${driver}     ${plain_chinese_text}
    # HL My help space urls - MHS
    send_message_by_different_data     ${driver}     ${My_help_space_urls_MHS}    ${message_type_url}
    # HL My help space urls - OTU
    send_message_by_different_data     ${driver}     ${My_help_space_urls_OTU}    ${message_type_url}
    # external urls
    send_message_by_different_data     ${driver}     ${http_www_baidu_com}     ${message_type_url}
    # file format with jpg, jpeg, png,gif,bmp, tiff	    file name include Chinese and space	    file name include special character
    send_message_by_different_file     ${driver}     ${message_jpg}
    # file format with .mp3, wav, mov,mp4,m4a	file name include Chinese and space	    file name include special character
    send_message_by_different_file     ${driver}     ${message_audio}
    # pdf file	file name include Chinese and space	file name include special character
    send_message_by_different_file     ${driver}     ${message_pdf}
    # other format files	.zip, .dmg, .xlsx, .docx
    send_message_by_different_file     ${driver}     ${message_zip}
    [Teardown]      run keywords    delete_all_message_thread    ${driver}
    ...             AND             exit_driver

Small_range_1092_1099_1111_1113
    [Documentation]     Start new chat    UserA click message icon from team     with online contact userB
    [Tags]    small range 1078-1082 + 1111_1113 lines       message_case
    # user login
#    ${driver1}     driver_set_up_and_logIn     ${message_test0_user}
#    ${driver2}     driver_set_up_and_logIn     ${message_test1_user}
    ${drivers_list}   multi_login   ${message_test0_user}   ${message_test1_user}
    ${driver1}   Get From List   ${drivers_list}    0
    ${driver2}   Get From List   ${drivers_list}    1
    contacts_different_page_search_user     ${driver2}     ${py_team_page}       ${anyone_user}
    start_new_chat    ${driver2}     ${anyone_user}
    # VP: can not chat with expert group directly
    contacts_different_page_search_user     ${driver1}     ${py_team_page}       ${on_call_group_1}
    suspension_of_the_mouse     ${driver1}     ${on_call_group_1}
    sleep  6
    ${return_value}    get_css_value     ${driver1}     ${message_button_xpath}     display
    should be equal as strings     ${return_value}     none
    # UserA click message icon from team,with online contact userB   VP: new message dialog is open; show contact name, avatar
    contacts_different_page_search_user     ${driver1}     ${py_team_page}       ${message_test1_username}
    start_new_chat    ${driver1}     ${message_test1_username}
    # 1. userA say "Hello!" to userB      VP: userB can see same "Hello!" in message thread list	VP: unread count on thread is increased
    send_message_by_different_data     ${driver1}     ${need_send_hello}
    get_unread_message_count    ${driver2}
    check_last_message_content    ${driver2}     ${need_send_hello}
    # 2. userB open this message thread	    VP: userB see same "Hello!" on message dialog	  VP: There is no increased red unread count for this thread, because dialog is open, all message is read
    click_which_message     ${driver2}     ${message_test0_username}
    see_last_content_on_message_dialog     ${driver2}     ${need_send_hello}
    sleep  4s
    get_unread_message_count    ${driver2}     0
    # 3. userB replay any words	      VP: userA see same text; timestamp is correct;	   VP: There is no increased red unread count for this thread, because dialog is open, all message is read
    send_message_by_different_data     ${driver2}     ${need_reply_world}
    see_last_content_on_message_dialog     ${driver1}     ${need_reply_world}
    sleep  4s
    get_unread_message_count    ${driver1}     0
    # 5. userA and userB Touch link in message content	VP: direct to corresponding web addres
    send_message_by_different_data     ${driver2}     ${http_www_baidu_com}      ${message_type_url}
    click_url_on_message_dialog    ${driver2}
    switch_to_last_window    ${driver2}
    check_goto_baidu    ${driver2}
    switch_first_window    ${driver2}
    # 5. userA and userB Touch link in message content	VP: direct to corresponding web addres
    click_url_on_message_dialog    ${driver1}
    switch_to_last_window    ${driver1}
    check_goto_baidu    ${driver1}
    close_last_window    ${driver1}
    sleep   5s
    # 1111_1113 lines
    # favorite a contact userD	VP: message icon is visible in Team list and Favorite list
    refresh_browser_page     ${driver1}
    switch_to_diffrent_page     ${driver1}     ${py_contacts_page}      ${py_contacts_switch_success}    ${py_get_number_of_rows}
    # click message icon to this userD from team	VP: message thread is created	VP: message thread is with correct person
    contacts_different_page_search_user     ${driver1}     ${py_team_page}     ${anyone_favorite_user}
    start_new_chat    ${driver1}     ${anyone_favorite_user}
    # click message icon to userD from favorite	VP: message thread is created	VP: message thread is with correct person
    switch_to_diffrent_page     ${driver1}     ${py_contacts_page}      ${py_contacts_switch_success}    ${py_get_number_of_rows}
    switch_to_diffrent_page     ${driver1}     ${py_favorites_page}     ${py_contacts_switch_success}    ${py_get_number_of_rows}
    contacts_different_page_search_user     ${driver1}     ${py_favorites_page}     ${anyone_favorite_user}
    start_new_chat    ${driver1}     ${anyone_favorite_user}
    [Teardown]      run keywords    delete_all_message_thread    ${driver1}
    ...             AND             exit_driver

Small_range_1100_1109
    [Documentation]     Start new chat    UserA click message icon from team     with offline contact userC
    [Tags]    small range 1100-1109 lines     message_case
    # user login     UserA click message icon from team     with offline contact userC  VP: new message thread is created	VP: name, avatar is correct
    ${driver1}     driver_set_up_and_logIn     ${message_test0_user}
    contacts_different_page_search_user     ${driver1}     ${py_team_page}       ${message_test2_username}
    start_new_chat    ${driver1}     ${message_test2_username}
    # click info icon	VP: members are correct
    click_message_info_check     ${driver1}          ${message_test0_username}    ${message_test2_username}
    # 1. userA send prepared test data above(text and files)	 VP: name,avatar,timestamp in message content are correct
    send_message_by_different_data     ${driver1}         ${http_www_baidu_com}      ${message_type_url}
    see_last_content_on_message_dialog     ${driver1}     ${http_www_baidu_com}
    # 2. userA Touch link in message content	VP: direct to corresponding web addres
    click_url_on_message_dialog    ${driver1}
    switch_to_last_window    ${driver1}
    check_goto_baidu    ${driver1}
    switch_first_window    ${driver1}
    # 3. Offline contact userC login	VP: Unread count on Messags tab/nav is correct
    ${driver2}     driver_set_up_and_logIn     ${message_test2_user}
    contacts_different_page_search_user     ${driver2}     ${py_team_page}       ${message_not_need_read_username}
    start_new_chat    ${driver2}     ${message_not_need_read_username}
    sleep  6s
    # 4. touch messages tab, see message thread list	VP: Unread count on this Messags thread list is correct
    get_unread_message_count    ${driver2}
    # 5. open this thread	VP: message content is correct
    click_which_message     ${driver2}     ${message_test0_username}
    see_last_content_on_message_dialog     ${driver2}     ${http_www_baidu_com}
    # 6. userC reply some words	     VP: userA see same text; timestamp is correct;
    send_message_by_different_data     ${driver2}         ${need_send_hello}
    see_last_content_on_message_dialog     ${driver1}     ${need_send_hello}
    # 7. userC back to thread list
    click_which_message     ${driver2}     ${message_not_need_read_username}
    # 8. userA send some more text	    VP: unread count is correct   	VP: unread latest message content is correct
    send_message_by_different_data     ${driver1}         ${need_reply_world}
    get_unread_message_count    ${driver2}
    check_last_message_content    ${driver2}     ${need_reply_world}
    [Teardown]      run keywords    delete_all_message_thread    ${driver1}
    ...             AND             exit_driver

Small_range_1115_1117
    [Documentation]     Start new chat    click message icon from favorite     with online contact
    [Tags]    small range 1115-1117 lines      message_case
    # user login     click message icon from favorite	  with online contact   VP: new message thread is created
    ${driver1}     driver_set_up_and_logIn     ${message_test0_user}
    switch_to_diffrent_page     ${driver1}     ${py_favorites_page}     ${py_contacts_switch_success}    ${py_get_number_of_rows}
    start_new_chat    ${driver1}     ${message_not_need_read_username}
    # press Enter key in text field	IOS: new line; webapp: send out content
    ${random_str}    send_message_by_keyboard        ${driver1}
    see_last_content_on_message_dialog     ${driver1}     ${random_str}
    # Shift+ Enter key	Webapp: multi-lines
    ${random_str}    send_message_by_keyboard        ${driver1}     shift_enter
    ${finalStr}   catenate   SEPARATOR=    ${random_str}    ANOTHERLINE
    see_last_content_on_message_dialog     ${driver1}     ${finalStr}
    [Teardown]      run keywords    delete_all_message_thread    ${driver1}
    ...             AND             exit_driver

Small_range_1121_1122
    [Documentation]     Start new chat    click message icon from directory
    [Tags]    small range 1121-1122 lines       message_case
    [Setup]     run keywords    Login_workspaces_admin
    ...         AND             enter_workspace_settings_page           # 进入settings页面
    ...         AND             turn_on_workspace_directory             # 打开Workspace Directory设置
    # user login
    ${driver1}     driver_set_up_and_logIn     ${message_test0_user}
    # click message icon from directory	   with the contact not in Team     click message icon on this user  	VP: message thread is with correct person
    switch_to_diffrent_page     ${driver1}     ${py_directory_page}     ${py_contacts_switch_success}    ${py_get_number_of_rows}
    contacts_different_page_search_user     ${driver1}     ${py_directory_page}     ${anyone_user}
    start_new_chat    ${driver1}     ${anyone_user}
    # press Enter key in text field	IOS: new line; webapp: send out content
    switch_to_diffrent_page     ${driver1}     ${py_contacts_page}     ${py_contacts_switch_success}    ${py_get_number_of_rows}
    switch_to_diffrent_page     ${driver1}     ${py_directory_page}     ${py_contacts_switch_success}    ${py_get_number_of_rows}
    contacts_different_page_search_user     ${driver1}     ${py_directory_page}     ${directory_user}
    start_new_chat    ${driver1}       ${directory_user}
    [Teardown]      exit_driver

Small_range_1125_1143
    [Documentation]     Start new chat    Create 1V1 chat from Message Tab
    [Tags]    small range 1125-1143 lines      message_case
    [Setup]    delete_zip_file     original
    ${drivers_list}   multi_login   ${message_test0_user}   ${message_test1_user}
    # user1 login
    ${driver1}   Get From List   ${drivers_list}    0
    # user2 login
    ${driver2}   Get From List   ${drivers_list}    1
#    # user login
#    ${driver1}     driver_set_up_and_logIn     ${message_test0_user}
    switch_to_diffrent_page     ${driver1}     ${py_messages_page}     ${py_messages_switch_success}    ${search_messages_box}
#    ${driver2}     driver_set_up_and_logIn     ${message_test1_user}
    # Click create icon	    VP: has Send My Help Space Link option; has Start a Message Group option; able to cancel
    check_create_message_back     ${driver1}
    # Select one contact from list	VP: contact is marked as selected
    create_a_new_message     ${driver1}      search     ${message_test1_username}
    confirm_create_message     ${driver1}
    # Click Create	VP: new message thread is created with correct person	VP: show this person's full name
    click_message_info_check          ${driver1}      ${message_test0_username}    ${message_test1_username}
    # send prepared test data	send plain text in English	VP: message is correctly send out and received
    send_message_by_different_data     ${driver1}    ${plain_english_text}
    switch_to_diffrent_page     ${driver2}     ${py_messages_page}     ${py_messages_switch_success}    ${search_messages_box}
    click_which_message     ${driver2}     ${message_test0_username}
    see_last_content_on_message_dialog     ${driver2}     ${plain_english_text}
    # send plain text in Chinese
    send_message_by_different_data     ${driver1}    ${plain_chinese_text}
    see_last_content_on_message_dialog     ${driver2}     ${plain_chinese_text}
    # send url address	Send a My helpspace link
    send_message_by_different_data     ${driver1}     ${My_help_space_urls_MHS}      ${message_type_url}
    see_last_content_on_message_dialog     ${driver2}     ${My_help_space_urls_MHS}
    # Send external website link
    send_message_by_different_data     ${driver1}     ${http_www_baidu_com}      ${message_type_url}
    see_last_content_on_message_dialog     ${driver2}     ${http_www_baidu_com}
    # send attachment	VP: has options: Photo/Video; camera;Document
    # send image files (prepared test data)	VP: files are correctly send out
    send_message_by_different_file     ${driver1}     ${message_jpg}
    see_last_attachName_on_message_dialog     ${driver2}     ${message_jpg}
    # send audio files  (prepared test data)	VP: files are correctly send out
    send_message_by_different_file     ${driver1}     ${message_audio}
    see_last_attachName_on_message_dialog     ${driver2}     ${message_audio}
    # send video files  (prepared test data)	VP: files are correctly send out
    send_message_by_different_file     ${driver1}     ${message_video}
    see_last_attachName_on_message_dialog     ${driver2}     ${message_video}
    # send other file format	.zip, .dmg, .xlsx, .docx	VP: files are correctly send out
    send_message_by_different_file     ${driver1}     ${message_zip}
    see_last_attachName_on_message_dialog     ${driver2}     ${message_zip}
    # VP: files can be downloaded by receiver
    download_attach_on_message_dialog     ${driver2}     ${message_zip}
    # Send or receive  many messages more than 1 screen	Scroll message dialog to view chat history	VP: History loaded smoothly
    new_another_tab_and_go     ${driver2}     ${login_citron_messages}
    close_tutorial_action     ${driver2}
    click_which_message     ${driver2}     ${message_test0_username}
    send_message_by_different_data     ${driver2}    ${plain_chinese_text}
    see_last_content_on_message_dialog     ${driver1}     ${plain_chinese_text}

    ${all_text_2}      get_message_dialog_text       ${driver2}
    ${all_attach_2}    get_message_dialog_attach     ${driver2}
    switch_first_window     ${driver2}
    ${all_text_1}      get_message_dialog_text       ${driver2}
    ${all_attach_1}    get_message_dialog_attach     ${driver2}
    two_option_is_equal     ${driver2}      ${all_text_2}       ${all_text_1}
    two_option_is_equal     ${driver2}      ${all_attach_2}     ${all_attach_1}
    [Teardown]      run keywords    delete_zip_file     original
    ...             AND             delete_all_message_thread    ${driver1}
    ...             AND             exit_driver

Small_range_1144_1153
    [Documentation]     Start new chat    Create chat group from Message Tab     select from entire list
    [Tags]    small range 1144-1153 lines      message_case
    ${drivers_list}   multi_login   ${used_by_message_user01}    ${used_by_message_user02}    ${used_by_message_user03}
    # user1 login
    ${driver1}   Get From List   ${drivers_list}    0
    # user2 login
    ${driver2}   Get From List   ${drivers_list}    1
    # user3 login
    ${driver3}   Get From List   ${drivers_list}    2
#    # user login
#    ${driver1}     driver_set_up_and_logIn     ${used_by_message_user01}
    switch_to_diffrent_page     ${driver1}     ${py_messages_page}     ${py_messages_switch_success}    ${search_messages_box}
#    ${driver2}     driver_set_up_and_logIn     ${used_by_message_user02}
    switch_to_diffrent_page     ${driver2}     ${py_messages_page}     ${py_messages_switch_success}    ${search_messages_box}
#    ${driver3}     driver_set_up_and_logIn     ${used_by_message_user03}
    switch_to_diffrent_page     ${driver3}     ${py_messages_page}     ${py_messages_switch_success}    ${search_messages_box}
    # Click create icon	    VP: has Send My Help Space Link option; has Start a Message Group option; able to cancel
    check_create_message_back     ${driver1}
    # select from entire list	Steps:
    # 1. Select several contacts   VP: contacts are marked as selected
    create_a_new_message     ${driver1}     not_search     ${used_by_message_username02}      ${used_by_message_username03}      ${used_by_message_username04}
    # 2. De-select one	VP: contact is marked as unselected
    de_select_one_user     ${driver1}      ${used_by_message_username04}
    # 3. Click Create	VP: Message thread is created with empty content
    confirm_create_message     ${driver1}
    get_message_dialog_text     ${driver1}       0
    # 4. Click Info icon	Click Memebers button
    click_message_info_check     ${driver1}      ${used_by_message_username01}      ${used_by_message_username02}      ${used_by_message_username03}
    # 5. members send message one by one
    send_message_by_different_data     ${driver1}      ${plain_english_text}
    click_which_message     ${driver2}     ${used_by_message_username01}     ${used_by_message_username03}
    send_message_by_different_data     ${driver2}      ${plain_english_text}
    click_which_message     ${driver3}     ${used_by_message_username01}     ${used_by_message_username02}
    send_message_by_different_data     ${driver3}      ${plain_english_text}
    [Teardown]      run keywords    delete_all_message_thread    ${driver1}
    ...             AND             exit_driver

Small_range_1154_1160
    [Documentation]     Start new chat    Create chat group from Message Tab     Select from search result list
    [Tags]    small range 1154-1160 lines       message_case
    ${drivers_list}   multi_login   ${message_test0_user}    ${message_test1_user}    ${message_test2_user}
    # user1 login
    ${driver1}   Get From List   ${drivers_list}    0
    # user2 login
    ${driver2}   Get From List   ${drivers_list}    1
    # user3 login
    ${driver3}   Get From List   ${drivers_list}    2
#    # user login
#    ${driver1}     driver_set_up_and_logIn     ${message_test0_user}
    switch_to_diffrent_page     ${driver1}     ${py_messages_page}     ${py_messages_switch_success}    ${search_messages_box}
#    ${driver2}     driver_set_up_and_logIn     ${message_test1_user}
    switch_to_diffrent_page     ${driver2}     ${py_messages_page}     ${py_messages_switch_success}    ${search_messages_box}
#    ${driver3}     driver_set_up_and_logIn     ${message_test2_user}
    switch_to_diffrent_page     ${driver3}     ${py_messages_page}     ${py_messages_switch_success}    ${search_messages_box}
    # Click create icon	    VP: has Send My Help Space Link option; has Start a Message Group option; able to cancel
    check_create_message_back     ${driver1}
    # Select from search result list	Steps:
    # 1. Search contacts    VP: search contact works with correct result
    # 2. select conact from search result    VP: search contact works with correct result
    create_a_new_message     ${driver1}      search     ${message_test1_username}      ${message_test2_username}      ${message_not_need_read_username}
    # 3. De-select one	VP: contact is marked as unselected
    de_select_one_user     ${driver1}      ${message_not_need_read_username}
    # 4. Click Create	VP: Message thread is created with empty content    VP: Show contacts' First Name on message dialog title
    confirm_create_message     ${driver1}
    get_message_dialog_text     ${driver1}       0
    # 5. Click Info icon	Click Memebers button      VP: member list is correct, all memeber is list, include myself
    click_message_info_check     ${driver1}      ${message_test0_username}      ${message_test1_username}      ${message_test2_username}
    # 6. members send message one by one    VP: Each message timestamp is correct
    send_message_by_different_data     ${driver1}      ${plain_english_text}
    click_which_message     ${driver2}     ${message_test0_username}     ${message_test2_username}
    send_message_by_different_data     ${driver2}      ${plain_english_text}
    click_which_message     ${driver3}     ${message_test0_username}     ${message_test1_username}
    send_message_by_different_data     ${driver3}      ${plain_english_text}
    [Teardown]      run keywords    delete_all_message_thread    ${driver1}
    ...             AND             exit_driver

Small_range_1161
    [Documentation]     Start new chat    Create multi message thread
    [Tags]    small range 1161 lines       message_case
    # user login
    ${driver1}     driver_set_up_and_logIn     ${message_test0_user}
    # Create 1V1 message thead from Team
    switch_to_diffrent_page     ${driver1}     ${py_contacts_page}     ${py_contacts_switch_success}    ${py_get_number_of_rows}
    contacts_different_page_search_user     ${driver1}     ${py_team_page}       ${message_test1_username}
    start_new_chat    ${driver1}     ${message_test1_username}
    # Create message group from Message Tab
    create_a_new_message     ${driver1}     search    ${message_test2_username}     ${message_test3_username}
    confirm_create_message     ${driver1}
    # Say "Hello" to contact
    ${random_str}    get_random_str
    # VP: message thread is with correct person
    click_which_message    ${driver1}     ${message_test2_username}     ${message_test3_username}
    send_message_by_different_data     ${driver1}      ${random_str}
    click_message_info_check     ${driver1}          ${message_test0_username}    ${message_test2_username}    ${message_test3_username}
    click_which_message    ${driver1}     ${message_test1_username}
    sleep    6s
    send_message_by_different_data     ${driver1}      ${random_str}
    click_message_info_check     ${driver1}          ${message_test0_username}    ${message_test1_username}
    ${drivers_list}   multi_login   ${message_test1_user}    ${message_test2_user}    ${message_test3_user}
    # user1 login
    ${driver2}   Get From List   ${drivers_list}    0
    # user2 login
    ${driver3}   Get From List   ${drivers_list}    1
    # user3 login
    ${driver4}   Get From List   ${drivers_list}    2
    # VP: memebers receive message
#    ${driver2}     driver_set_up_and_logIn     ${message_test1_user}
    switch_to_diffrent_page     ${driver2}     ${py_messages_page}     ${py_messages_switch_success}    ${search_messages_box}
    click_which_message    ${driver2}     ${message_test0_username}
    see_last_content_on_message_dialog    ${driver2}     ${random_str}
    # VP: memebers receive message
#    ${driver3}     driver_set_up_and_logIn     ${message_test2_user}
    switch_to_diffrent_page     ${driver3}     ${py_messages_page}     ${py_messages_switch_success}    ${search_messages_box}
    click_which_message    ${driver3}     ${message_test0_username}     ${message_test3_username}
    see_last_content_on_message_dialog    ${driver3}     ${random_str}
    # VP: memebers receive message
#    ${driver4}     driver_set_up_and_logIn     ${message_test3_user}
    switch_to_diffrent_page     ${driver4}     ${py_messages_page}     ${py_messages_switch_success}    ${search_messages_box}
    click_which_message    ${driver4}     ${message_test0_username}     ${message_test2_username}
    see_last_content_on_message_dialog    ${driver4}     ${random_str}
    [Teardown]      run keywords    delete_all_message_thread    ${driver1}
    ...             AND             exit_driver

Small_range_1162
    [Documentation]     Start new chat    Create multi message thread
    [Tags]    small range 1162 lines      message_case
    # user login
    ${driver1}     driver_set_up_and_logIn     ${message_test0_user}
    # Create message group from Message group
    ${random_str}    get_random_str
    switch_to_diffrent_page     ${driver1}     ${py_messages_page}     ${py_messages_switch_success}    ${search_messages_box}
    create_a_new_message     ${driver1}     search    ${message_test2_username}     ${message_test3_username}
    confirm_create_message     ${driver1}
    send_message_by_different_data     ${driver1}      ${random_str}
    click_message_info_check     ${driver1}      ${message_test0_username}    ${message_test2_username}    ${message_test3_username}
    # Create 1V1 message thread from favorite
    switch_to_diffrent_page     ${driver1}     ${py_contacts_page}     ${py_contacts_switch_success}    ${py_get_number_of_rows}
    contacts_different_page_search_user     ${driver1}     ${py_team_page}       ${message_test1_username}
    start_new_chat    ${driver1}     ${message_test1_username}
    # VP message thread is with correct person
    ${string1}    catenate     SEPARATOR=    ${message_test2_username}     ,
    ${string1}    catenate     ${string1}    ${message_test3_username}
    send_message_by_different_data     ${driver1}      ${random_str}
    click_message_info_check     ${driver1}      ${message_test0_username}    ${message_test1_username}
    ${drivers_list}   multi_login   ${message_test1_user}    ${message_test2_user}    ${message_test3_user}
    # user1 login
    ${driver2}   Get From List   ${drivers_list}    0
    # user2 login
    ${driver3}   Get From List   ${drivers_list}    1
    # user3 login
    ${driver4}   Get From List   ${drivers_list}    2
    # VP: memebers receive message
#    ${driver2}     driver_set_up_and_logIn     ${message_test1_user}
    switch_to_diffrent_page     ${driver2}     ${py_messages_page}     ${py_messages_switch_success}    ${search_messages_box}
    click_which_message    ${driver2}     ${message_test0_username}
    see_last_content_on_message_dialog    ${driver2}     ${random_str}
    # VP: memebers receive message
#    ${driver3}     driver_set_up_and_logIn     ${message_test2_user}
    switch_to_diffrent_page     ${driver3}     ${py_messages_page}     ${py_messages_switch_success}    ${search_messages_box}
    click_which_message    ${driver3}     ${message_test0_username}     ${message_test3_username}
    see_last_content_on_message_dialog    ${driver3}     ${random_str}
    # VP: memebers receive message
#    ${driver4}     driver_set_up_and_logIn     ${message_test3_user}
    switch_to_diffrent_page     ${driver4}     ${py_messages_page}     ${py_messages_switch_success}    ${search_messages_box}
    click_which_message    ${driver4}     ${message_test0_username}     ${message_test2_username}
    see_last_content_on_message_dialog    ${driver4}     ${random_str}
    [Teardown]      run keywords    delete_all_message_thread    ${driver1}
    ...             AND             exit_driver

Small_range_1164_1165
    [Documentation]     Start new chat    Create a already exist thread
    [Tags]    small range 1164-1165 lines       message_case
    # user login
    ${driver1}     driver_set_up_and_logIn     ${message_test0_user}
    # Create 1V1 message thead from Team
    switch_to_diffrent_page     ${driver1}     ${py_contacts_page}     ${py_contacts_switch_success}    ${py_get_number_of_rows}
    contacts_different_page_search_user     ${driver1}     ${py_team_page}       ${message_test1_username}
    start_new_chat    ${driver1}     ${message_test1_username}
    ${random_str}    get_random_str
    send_message_by_different_data     ${driver1}      ${random_str}
    # Create a thread have same members
    create_a_new_message     ${driver1}     search    ${message_test1_username}
    confirm_create_message     ${driver1}
    # VP: dialog shows thread message history
    ${all_text}      get_message_dialog_text       ${driver1}
    two_option_is_equal     ${driver1}      ${all_text}[0]       ${random_str}
    [Teardown]      run keywords    delete_all_message_thread    ${driver1}
    ...             AND             exit_driver

Small_range_1166_1169
    [Documentation]     Delete Message thread    Delete 1v1 message
    [Tags]    small range 1166-1169 lines        message_case
#    # user login
#    ${driver1}     driver_set_up_and_logIn     ${message_test0_user}
#    ${driver2}     driver_set_up_and_logIn     ${message_test1_user}
    ${drivers_list}   multi_login   ${message_test0_user}   ${message_test1_user}
    # user1 login
    ${driver1}   Get From List   ${drivers_list}    0
    # user2 login
    ${driver2}   Get From List   ${drivers_list}    1
    contacts_different_page_search_user     ${driver1}     ${py_team_page}       ${message_test1_username}
    start_new_chat    ${driver1}     ${message_test1_username}
    # Open message thread -> Info icon -> Delete message
    # confirmation dialog 'This permanently deletes this message thread for all participants. Are you Sure?' Cancel or Delete.
    check_delete_message_confirmation_dialog    ${driver1}
    send_message_by_different_data     ${driver1}      ${plain_english_text}
    # Other contact has this message thread open	I confirm delete	VP: message history is deleted for both sides
    switch_to_diffrent_page     ${driver2}     ${py_messages_page}     ${py_messages_switch_success}    ${search_messages_box}
    click_which_message    ${driver2}     ${message_test0_username}
    delete_message_chat     ${driver1}
    switch_to_diffrent_page     ${driver1}     ${py_contacts_page}     ${py_contacts_switch_success}    ${py_get_number_of_rows}
    switch_to_diffrent_page     ${driver1}     ${py_messages_page}     ${py_messages_switch_success}    ${search_messages_box}
    check_message_delete_success     ${driver1}     ${message_test1_username}
    check_message_delete_success     ${driver2}     ${message_test0_username}
    # Other contact is on message thread list screen	I Confirm delete	VP: message thread is deleted for both sides
    create_a_new_message     ${driver1}     search    ${message_test1_username}
    confirm_create_message     ${driver1}
    send_message_by_different_data     ${driver1}      ${plain_english_text}
    switch_to_diffrent_page     ${driver2}     ${py_contacts_page}     ${py_contacts_switch_success}    ${py_get_number_of_rows}
    contacts_different_page_search_user     ${driver2}     ${py_team_page}       ${message_test3_username}
    start_new_chat    ${driver2}     ${message_test3_username}
    delete_message_chat     ${driver1}
    switch_to_diffrent_page     ${driver1}     ${py_contacts_page}     ${py_contacts_switch_success}    ${py_get_number_of_rows}
    switch_to_diffrent_page     ${driver1}     ${py_messages_page}     ${py_messages_switch_success}    ${search_messages_box}
    check_message_delete_success     ${driver1}     ${message_test1_username}
    check_message_delete_success     ${driver2}     ${message_test0_username}
    # Other contact is sending chat content to me	I confirm delete	VP: message history is deleted for both sides
    create_a_new_message     ${driver1}     search    ${message_test1_username}
    confirm_create_message     ${driver1}
    send_message_by_different_data     ${driver1}      ${plain_english_text}
    click_which_message    ${driver2}     ${message_test0_username}
    send_message_by_different_data     ${driver2}      ${plain_english_text}    text     no_send
    delete_message_chat     ${driver1}
    switch_to_diffrent_page     ${driver1}     ${py_contacts_page}     ${py_contacts_switch_success}    ${py_get_number_of_rows}
    switch_to_diffrent_page     ${driver1}     ${py_messages_page}     ${py_messages_switch_success}    ${search_messages_box}
    check_message_delete_success     ${driver1}     ${message_test1_username}
    check_message_delete_success     ${driver2}     ${message_test0_username}
    [Teardown]      run keywords    delete_all_message_thread    ${driver1}
    ...             AND             exit_driver

Small_range_1170_1173
    [Documentation]     Delete Message thread    Delete message group
    [Tags]    small range 1170-1173 lines        message_case
    ${drivers_list}   multi_login   ${message_test0_user}   ${message_test1_user}    ${message_test2_user}
    # user1 login
    ${driver1}   Get From List   ${drivers_list}    0
    # user2 login
    ${driver2}   Get From List   ${drivers_list}    1
    # user3 login
    ${driver3}   Get From List   ${drivers_list}    2
#    # user login
#    ${driver1}     driver_set_up_and_logIn     ${message_test0_user}
    switch_to_diffrent_page     ${driver1}     ${py_messages_page}     ${py_messages_switch_success}    ${search_messages_box}
    create_a_new_message     ${driver1}      search     ${message_test1_username}      ${message_test2_username}
    confirm_create_message     ${driver1}
    send_message_by_different_data     ${driver1}      ${plain_english_text}
#    ${driver2}     driver_set_up_and_logIn     ${message_test1_user}
    switch_to_diffrent_page     ${driver2}     ${py_messages_page}     ${py_messages_switch_success}    ${search_messages_box}
#    ${driver3}     driver_set_up_and_logIn     ${message_test2_user}
    switch_to_diffrent_page     ${driver3}     ${py_messages_page}     ${py_messages_switch_success}    ${search_messages_box}
    # Open message thread -> Info icon -> Delete message	cancel on confirm dialog	VP: thead is not delete
    delete_message_chat     ${driver1}     0
    ${string1}    catenate     SEPARATOR=    ${message_test1_username}     ,
    ${string1}    catenate     ${string1}    ${message_test2_username}
    ${string2}    catenate     SEPARATOR=    ${message_test0_username}     ,
    ${string2}    catenate     ${string2}    ${message_test2_username}
    ${string3}    catenate     SEPARATOR=    ${message_test0_username}     ,
    ${string3}    catenate     ${string3}    ${message_test1_username}
    check_message_delete_success     ${driver1}     ${string1}       0
    check_message_delete_success     ${driver2}     ${string2}       0
    check_message_delete_success     ${driver3}     ${string3}       0
    # confirm delete	Message history are deleted for all sides
    delete_message_chat     ${driver1}
    switch_to_diffrent_page     ${driver1}     ${py_contacts_page}     ${py_contacts_switch_success}    ${py_get_number_of_rows}
    switch_to_diffrent_page     ${driver1}     ${py_messages_page}     ${py_messages_switch_success}    ${search_messages_box}
    check_message_delete_success     ${driver1}     ${string1}
    check_message_delete_success     ${driver2}     ${string2}
    check_message_delete_success     ${driver3}     ${string3}
    # Search contact name after delete message thread		     VP: result does not list deleted thead
    search_messages_by_keyword      ${driver1}     ${string1}
    check_message_delete_success     ${driver1}     ${string1}
    # Search message content after delete message thread	         VP: result does not list deleted thead
    search_messages_by_keyword      ${driver1}     ${plain_english_text}
    check_message_delete_success     ${driver1}     ${string1}
    [Teardown]      run keywords    delete_all_message_thread    ${driver1}
    ...             AND             exit_driver