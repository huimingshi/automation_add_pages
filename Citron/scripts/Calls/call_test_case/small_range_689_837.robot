*** Settings ***
Library           Selenium2Library
Library           OperatingSystem
Resource          ../../../Lib/public.robot
Resource          ../../../Lib/calls_resource.robot
Resource          ../../../Lib/hodgepodge_resource.robot
Library           call_python_Lib/call_public_lib.py
Library           call_python_Lib/else_public_lib.py
Force Tags        small_range

*** Test Cases ***
Small_range_689_690_691_692
    [Documentation]     3PI - Meeting call     EU1 send one time use link to anonymous UserB.
    [Tags]    small range 689+690+691+692 lines
    # EU1 登录
    ${driver1}    driver_set_up_and_logIn    ${Expert_User1_username}     ${universal_password}
    ${invite_url}    send_meeting_room_link    ${driver1}    OTU   no_send
    # UserB clicks link and join the call.
    ${driver2}    anonymous_open_meeting_link    ${invite_url}
    # EU1 接受Call
    user_anwser_call   ${driver1}
    # TU1 登录
    ${driver3}    driver_set_up_and_logIn    ${Team_User1_username}     ${universal_password}
    # TU1 click EU1's one-time link
    user_make_call_via_meeting_link    ${driver3}   ${invite_url}
    # VP: EU1 get Accept dialog     EU1 接受Call
    user_anwser_call   ${driver1}     no_direct
    [Teardown]      run keywords    end_call_for_all     ${driver1}      # VP: 3PC call established successfully
    ...             AND             exit_driver     ${driver1}    ${driver2}    ${driver3}

Small_range_693_694_695
    [Documentation]     3PI - Meeting call     EU1 send MHS link to anonymous UserB.
    [Tags]    small range 693+694+695 lines
    # EU1 登录
    ${driver1}    driver_set_up_and_logIn    ${Expert_User1_username}     ${universal_password}
    ${invite_url}    send_meeting_room_link    ${driver1}    MHS   no_send
    # UserB clicks link and join the call.
    ${driver2}    anonymous_open_meeting_link    ${invite_url}
    # EU1 接受Call
    user_anwser_call   ${driver1}
    # EU2 登录
    ${driver3}    driver_set_up_and_logIn    ${Expert_User2_username}     ${universal_password}
    # EU2 click EU1's MHS link
    user_make_call_via_meeting_link    ${driver3}   ${invite_url}
    # VP: EU1 get Accept dialog     EU1 接受Call
    user_anwser_call   ${driver1}     no_direct
    [Teardown]      run keywords    end_call_for_all     ${driver1}      # VP: 3PC call established successfully
    ...             AND             exit_driver     ${driver1}    ${driver2}    ${driver3}

Small_range_696_697_698_699
    [Documentation]     3PI - Meeting call     UserA send one time use link to anonymous UserB.
    [Tags]    small range 696+697+698+699 lines
    # UserA 登录
    ${driver1}    driver_set_up_and_logIn    ${Expert_User1_username}     ${universal_password}
    ${invite_url}    send_meeting_room_link    ${driver1}    OTU   no_send
    # UserB clicks link and join the call.
    ${driver2}    anonymous_open_meeting_link    ${invite_url}
    # EU1 接受Call
    user_anwser_call   ${driver1}
    # User C 登录
    ${driver3}    driver_set_up_and_logIn    ${Expert_User2_username}     ${universal_password}
    # UserA sends a 3pi link to logged in UserC.
    which_page_is_currently_on    ${driver1}    ${end_call_button}
    ${invite_url_1}   send_invite_in_calling_page    ${driver1}
    close_invite_3th_page    ${driver1}
    # UserC click the 3PI link join the call.
    user_make_call_via_meeting_link    ${driver3}     ${invite_url_1}
    # UserA left session.
    leave_call   ${driver1}   need_select
    # Expected : session does not end and still active.
    exit_call    ${driver3}     5
    [Teardown]      exit_driver     ${driver1}    ${driver2}    ${driver3}

Small_range_700_701_702_703
    [Documentation]     3PI - Meeting call     UserA send MHS link to anonymous UserB.
    [Tags]    small range 700+701+702+703 lines
    # UserA 登录
    ${driver1}    driver_set_up_and_logIn    ${Expert_User1_username}     ${universal_password}
    ${invite_url}    send_meeting_room_link    ${driver1}    MHS   no_send
    # UserB clicks link and join the call.
    ${driver2}    anonymous_open_meeting_link    ${invite_url}
    # UserA 接受Call
    user_anwser_call   ${driver1}
    # UserA sends a 3pi link to anonymous UserC.
    which_page_is_currently_on    ${driver1}    ${end_call_button}
    ${invite_url_1}   send_invite_in_calling_page    ${driver1}
    close_invite_3th_page    ${driver1}
    # UserC click the link join the call.
    ${driver3}    anonymous_open_meeting_link    ${invite_url_1}
    # UserA 接受Call
    user_anwser_call   ${driver1}    no_direct
    # UserA left session.
    end_call_for_all   ${driver1}
    # Expected : session end
    which_page_is_currently_on     ${driver2}   ${five_star_high_praise}
    which_page_is_currently_on     ${driver3}   ${five_star_high_praise}
    [Teardown]      exit_driver     ${driver1}    ${driver2}    ${driver3}

Small_range_704_705_706_707
    [Documentation]     3PI - Meeting call     UserA send MHS link to expert UserB.
    [Tags]    small range 704+705+706_707 lines
    # UserA 登录
    ${driver1}    driver_set_up_and_logIn    ${Expert_User1_username}     ${universal_password}
    ${invite_url}    send_meeting_room_link    ${driver1}    MHS   no_send
    # UserB 登录
    ${driver2}    driver_set_up_and_logIn    ${Expert_User2_username}     ${universal_password}
    # UserB clicks link and join the call.
    user_make_call_via_meeting_link   ${driver2}   ${invite_url}
    # UserA 接受Call
    user_anwser_call   ${driver1}
    # UserA sends a 3pi link to team license UserC.
    which_page_is_currently_on    ${driver1}    ${end_call_button}
    ${invite_url_1}   send_invite_in_calling_page    ${driver1}
    close_invite_3th_page    ${driver1}
    # UserC click the link join the call.
    ${driver3}    driver_set_up_and_logIn    ${Team_User1_username}     ${universal_password}
    user_make_call_via_meeting_link   ${driver3}   ${invite_url_1}
    # UserA left session.
    end_call_for_all   ${driver1}
    # Expected : session end
    which_page_is_currently_on     ${driver2}   ${five_star_high_praise}
    which_page_is_currently_on     ${driver3}   ${five_star_high_praise}
    [Teardown]      exit_driver     ${driver1}    ${driver2}    ${driver3}

Small_range_708_709
    [Documentation]     3PI - Meeting call     EU1 click EU2's MHS link
    [Tags]    small range 708+709 lines
    # EU1 登录
    ${driver1}    driver_set_up_and_logIn    ${Expert_User1_username}     ${universal_password}
    # EU2 登录
    ${driver2}    driver_set_up_and_logIn    ${Expert_User2_username}     ${universal_password}
    ${invite_url}    send_meeting_room_link    ${driver2}    MHS   no_send
    # EU1 click EU2's MHS link
    user_make_call_via_meeting_link   ${driver1}   ${invite_url}
    # EU2 接受Call
    user_anwser_call   ${driver2}
    # ExpetA 登录
    ${driver3}    driver_set_up_and_logIn    ${Expert_AaA_username}     ${universal_password}
    # EU1 invte on-call group
    which_page_is_currently_on    ${driver1}    ${end_call_button}
    enter_contacts_search_user     ${driver1}     ${AaA_on_call_group_name}
    click_user_in_contacts_call    ${driver1}     ${AaA_on_call_group_name}
    # ExpetA 接受Call
    user_anwser_call    ${driver3}
    [Teardown]      run keywords    end_call_for_all     ${driver1}      # VP: 3PC call established successfully
    ...             AND             exit_driver     ${driver1}    ${driver2}    ${driver3}

Small_range_710_723
    [Documentation]     3PI - Meeting call     EU1 click EU2's MHS link
    [Tags]    small range 710-723 lines，有bug：https://vipaar.atlassian.net/browse/CITRON-3313
    # EU1 登录
    ${driver1}    driver_set_up_and_logIn    ${Expert_User1_username}     ${universal_password}
    switch_to_diffrent_page   ${driver1}   ${py_directory_page}     ${py_directory_switch_success}    ${py_get_number_of_rows}    # 进入Directory页面
    ${user_directory_list}   get_all_data_on_the_page   ${driver1}
    # EU2 登录
    ${driver2}    driver_set_up_and_logIn    ${Expert_User2_username}     ${universal_password}
    ${invite_url_otu}    send_meeting_room_link    ${driver2}    OTU   no_send
    ${invite_url_mhs}    send_meeting_room_link    ${driver2}    MHS   no_send
    ###### EU1 click EU2's MHS link       710行
    user_make_call_via_meeting_link   ${driver1}   ${invite_url_mhs}
    # EU2 接受Call
    user_anwser_call   ${driver2}
    # EU3 登录
    ${driver3}    driver_set_up_and_logIn    ${Expert_User3_username}     ${universal_password}
    ###### EU1 invite EU3 from Team contact    710行
    which_page_is_currently_on    ${driver1}    ${end_call_button}
    enter_contacts_search_user     ${driver1}     ${Expert_User3_name}
    click_user_in_contacts_call    ${driver1}     ${Expert_User3_name}
    # EU3 接受Call
    user_anwser_call    ${driver3}
    ###### VP: 3PC call established successfully    EU3 leave call     710+711行
    exit_call     ${driver3}
    ###### EU1 check on "Show directory" on invite screen     712行
    open_invite_3rd_participant_dialog     ${driver1}    no_enter
    check_user_show_up_or_not_when_invite_3rd   ${driver1}   1   click_show
    ###### VP: Title and location are shown in Directory list     712行
    which_page_is_currently_on    ${driver1}    ${contact_title_xpath}
    which_page_is_currently_on    ${driver1}    ${contact_location_xpath}
    close_invite_3th_page    ${driver1}
    ###### VP: On-call groups are not shown in the Directory view     712行
    enter_contacts_search_user    ${driver1}    ${AaA_on_call_group_name}   click_show   has_no_user_data
    close_invite_3th_page    ${driver1}
    ###### VP: user list is same with User directory ones     712行
    open_invite_3rd_participant_dialog     ${driver1}    no_enter
    check_user_show_up_or_not_when_invite_3rd   ${driver1}   1   click_show
    ${user_directory_list_1}   get_all_data_on_the_page   ${driver1}    contact-name
    close_invite_3th_page     ${driver1}
    lists should be equal     ${user_directory_list}     ${user_directory_list_1}
    exit_one_driver     ${driver3}
    ###### VP:Title and location are shown in Contact list         712行
    open_invite_3rd_participant_dialog     ${driver1}    no_enter
    check_user_show_up_or_not_when_invite_3rd   ${driver1}   1
    which_page_is_currently_on    ${driver1}    ${contact_title_xpath}
    which_page_is_currently_on    ${driver1}    ${contact_location_xpath}
    close_invite_3th_page    ${driver1}
    ###### EU1 search specific contact	VP: result is correct       713行
    open_invite_3rd_participant_dialog     ${driver1}    no_enter
    check_user_show_up_or_not_when_invite_3rd   ${driver1}   1
    close_invite_3th_page    ${driver1}
    enter_contacts_search_user    ${driver1}    ${Expert_User4_name}
    close_invite_3th_page    ${driver1}
    ###### EU2 invite EU4 from Directory        714行
    # EU4 登录
    ${driver4}    driver_set_up_and_logIn    ${Expert_User4_username}     ${universal_password}
    which_page_is_currently_on    ${driver2}    ${end_call_button}
    enter_contacts_search_user    ${driver2}    ${Expert_User4_name}
    click_user_in_contacts_call   ${driver2}    ${Expert_User4_name}
    ###### VP: 3PC call established successfully    EU4 leave call         712+715行
    user_anwser_call    ${driver4}
    exit_call    ${driver4}
    exit_one_driver     ${driver4}
    ###### EU1 send 3PI link to eMail      716行
    which_page_is_currently_on    ${driver1}    ${end_call_button}
    ${invite_url}   send_invite_in_calling_page    ${driver1}
    close_invite_3th_page    ${driver1}
    ###### EU5 click 3PI link        717行
    # EU5 登录
    ${driver5}    driver_set_up_and_logIn    ${Expert_User5_username}     ${universal_password}
    user_make_call_via_meeting_link   ${driver5}   ${invite_url}
    ###### VP: directly join call, don't need anyone's accept    EU5 leave call         717+718行
    exit_call     ${driver5}
    exit_one_driver     ${driver5}
    ###### EU1's contact directly call EU1	VP: contact get message like "EU1 is in another call"       721行
    # EU1's contact TU1 登录
    ${driver6}    driver_set_up_and_logIn    ${Team_User1_username}     ${universal_password}
    make_calls_with_who    ${driver6}   ${driver1}   ${Expert_User1_username}   no_care
    which_page_is_currently_on    ${driver6}    ${user_is_currently_on_another_call}
    ###### EU2's contact directly call EU2	VP: contact get message like "EU1 is in another call"       722行
    # EU1's contact TU2 登录
    ${driver7}    driver_set_up_and_logIn    ${Team_User2_username}     ${universal_password}
    make_calls_with_who    ${driver7}   ${driver2}   ${Expert_User2_username}   no_care
    which_page_is_currently_on    ${driver7}    ${user_is_currently_on_another_call}
    ###### Click EU2's OTU link	VP: Get message like "EU2 is in another call"       723行
    user_make_call_via_meeting_link   ${driver7}     ${invite_url_otu}
    which_page_is_currently_on    ${driver7}    ${user_is_currently_on_another_call}
    [Teardown]      run keywords     exit_call    ${driver1}
    ...             AND              exit_driver    ${driver1}  ${driver2}   ${driver6}   ${driver7}

Small_range_724_742
    [Documentation]     3PI - Meeting call     EU1 click EU2's OTU link
    [Tags]    small range 724-742 lines，有bug：https://vipaar.atlassian.net/browse/CITRON-3313
    # EU1 登录
    ${driver1}    driver_set_up_and_logIn    ${Expert_User1_username}     ${universal_password}
    # EU2 登录
    ${driver2}    driver_set_up_and_logIn    ${Expert_User2_username}     ${universal_password}
    ${invite_url_mhs}    send_meeting_room_link    ${driver2}    MHS   no_send
    ${invite_url_otu}    send_meeting_room_link    ${driver2}    OTU   no_send
    ###### EU1 click EU2's OTU link         724行
    user_make_call_via_meeting_link   ${driver1}   ${invite_url_otu}
    # EU2 接受Call
    user_anwser_call   ${driver2}
    # EU3 登录
    ${driver3}    driver_set_up_and_logIn    ${Expert_User3_username}     ${universal_password}
    ###### EU1 invite EU3 from Team contact       724行
    which_page_is_currently_on    ${driver1}    ${end_call_button}
    enter_contacts_search_user     ${driver1}     ${Expert_User3_name}
    click_user_in_contacts_call    ${driver1}     ${Expert_User3_name}
    # EU3 接受Call
    user_anwser_call    ${driver3}
    ###### VP: 3PC call established successfully    EU3 leave call       724+725行
    exit_call     ${driver3}
    exit_one_driver    ${driver3}
    ###### EU2 invite EU4 from Directory       726行
    # EU4 登录
    ${driver4}    driver_set_up_and_logIn    ${Expert_User4_username}     ${universal_password}
    which_page_is_currently_on    ${driver2}    ${end_call_button}
    enter_contacts_search_user    ${driver2}    ${Expert_User4_name}
    click_user_in_contacts_call   ${driver2}    ${Expert_User4_name}
    ###### VP: 3PC call established successfully    EU4 leave call       726+727行
    user_anwser_call    ${driver4}
    exit_call    ${driver4}
    exit_one_driver    ${driver4}
    ###### EU1 send 3PI link 1 to eMail       728行
    ${invite_url_1}   send_invite_in_calling_page    ${driver1}
    close_invite_3th_page    ${driver1}
    ###### EU5 click 3PI link 1       729行
    # EU5 登录
    ${driver5}    driver_set_up_and_logIn    ${Expert_User5_username}     ${universal_password}
    user_make_call_via_meeting_link   ${driver5}   ${invite_url_1}
    ###### VP: directly join call, don't need anyone's accept    EU5 leave call       730+731行
    exit_call     ${driver5}
    exit_one_driver    ${driver5}
    ###### EU2 send 3PI link 2 to eMail       731行
    which_page_is_currently_on    ${driver2}    ${end_call_button}
    ${invite_url_2}   send_invite_in_calling_page    ${driver2}
    close_invite_3th_page    ${driver2}
    ###### Expert user from another enterprise click 3PI link 1 to join       732行
    # Expert user from another enterprise 登录
    ${driver6}    driver_set_up_and_logIn    ${personal_user_username}     ${universal_password}
    user_make_call_via_meeting_link   ${driver6}    ${invite_url_1}
    ###### VP: EU2 get Accept dialog    EU2 accept       732+733行
    user_anwser_call    ${driver2}    no_direct
    ###### EU1's contact directly call EU1	VP: contact get message like "EU1 is in another call"       734行
    # EU1's contact TU1 登录
    ${driver7}    driver_set_up_and_logIn    ${Team_User1_username}     ${universal_password}
    make_calls_with_who    ${driver7}   ${driver1}   ${Expert_User1_username}   no_care
    which_page_is_currently_on    ${driver7}    ${user_is_currently_on_another_call}
    ###### EU2's contact directly call EU2	VP: contact get message like "EU1 is in another call"       735行
    # EU1's contact TU2 登录
    ${driver8}    driver_set_up_and_logIn    ${Team_User2_username}     ${universal_password}
    make_calls_with_who    ${driver8}   ${driver2}   ${Expert_User2_username}   no_care
    which_page_is_currently_on    ${driver8}    ${user_is_currently_on_another_call}
    ###### Click EU2's MHS link	VP: Get message like "EU2 is in another call"       736行
    user_make_call_via_meeting_link   ${driver8}     ${invite_url_mhs}
    which_page_is_currently_on    ${driver8}    ${user_is_currently_on_another_call}
    ##### EU2 leave call   VP: call is not end    737行
    leave_call   ${driver2}
    exit_one_driver    ${driver2}
    which_page_is_currently_on    ${driver1}    ${end_call_button}
    ###### Anonymous user click link 2    VP: EU1 get Accept dialog    EU1 accept    738+739行
    ${driver9}    anonymous_open_meeting_link    ${invite_url_2}
    user_anwser_call      ${driver1}     no_direct
    ###### VP: 3PC call established successfully    Anonymous leave call    739+740行
    which_page_is_currently_on    ${driver9}    ${end_call_button}
    exit_call   ${driver9}
    exit_one_driver    ${driver9}
    ###### EU2 click 3PI link 2 to join       741行
    user_make_call_via_meeting_link   ${driver2}    ${invite_url_2}
    ###### VP: 3PC call established successfully    End 3PC call    741+742行
    end_call_for_all       ${driver1}
    [Teardown]    exit_driver    ${driver1}   ${driver6}   ${driver7}   ${driver8}

Small_range_743_744
    [Documentation]     3PI - Meeting call     EU1 click EU2's OTU link
    [Tags]    small range 743-744 lines
    # EU1 登录
    ${driver1}    driver_set_up_and_logIn    ${Expert_User1_username}     ${universal_password}
    # EU2 登录
    ${driver2}    driver_set_up_and_logIn    ${Expert_User2_username}     ${universal_password}
    ${invite_url_mhs}    send_meeting_room_link    ${driver2}    MHS   no_send
    ${invite_url_otu}    send_meeting_room_link    ${driver2}    OTU   no_send
    ###### EU1 click EU2's OTU link         724行
    user_make_call_via_meeting_link   ${driver1}   ${invite_url_otu}
    # EU2 接受Call
    user_anwser_call   ${driver2}
    ###### EU1 send 3PI link 1 to eMail       728行
    which_page_is_currently_on    ${driver1}    ${end_call_button}
    ${invite_url_1}   send_invite_in_calling_page    ${driver1}
    close_invite_3th_page    ${driver1}
    ###### EU2 send 3PI link 2 to eMail       731行
    which_page_is_currently_on    ${driver2}    ${end_call_button}
    ${invite_url_2}   send_invite_in_calling_page    ${driver2}
    close_invite_3th_page    ${driver2}
    # 结束Call
    exit_call    ${driver1}
    ###### Login user click previous 3PI link 1	VP: Get msg "This meeting is over. Please contact the host to invite you to another meeting."     743行
    # EU3 登录
    ${driver3}    driver_set_up_and_logIn    ${Expert_User3_username}     ${universal_password}
    user_make_call_via_meeting_link   ${driver3}    ${invite_url_1}
    which_page_is_currently_on    ${driver3}    ${this_call_is_over}
    ###### Anonymous user click 3PI link 2	VP: Get msg "This meeting is over. Please contact the host to invite you to another meeting."       744行
    ${driver10}    anonymous_open_meeting_link    ${invite_url_2}
    which_page_is_currently_on    ${driver10}    ${this_call_is_over}
    [Teardown]    exit_driver    ${driver1}   ${driver2}   ${driver3}   ${driver10}

Small_range_745
    [Documentation]     3PI - Meeting call     Pre-condition: user is beong to workspace WS-A and WS-B	User is currently on WS-B
    [Tags]    small range 745 line
    # user is beong to workspace WS-A and WS-B 登录
    ${driver1}    driver_set_up_and_logIn    ${belong_two_WS_username}     ${universal_password}
    user_switch_to_second_workspace    ${driver1}    ${Huiming_shi_Added_WS_another}
    # another User beong to workspace WS-A登录
    ${driver2}    driver_set_up_and_logIn    ${Expert_User1_username}     ${universal_password}
    ${invite_url}    send_meeting_room_link    ${driver2}    MHS   no_send
    # User1 click User2's MHS link
    user_make_call_via_meeting_link   ${driver1}   ${invite_url}
    # another User 接受Call
    user_anwser_call   ${driver2}
    # VP: This User does not have invite 3rd participant icon on menu bar
    sleep  20s
    which_page_is_currently_on    ${driver1}    ${invite_user_in_calling}   not_currently_on
    [Teardown]      run keywords    exit_call     ${driver2}
    ...             AND             exit_driver     ${driver1}    ${driver2}

Small_range_746
    [Documentation]     3PI - Meeting call     Pre-condition: user is belong to workspace WS-A and WS-B	User is currently on WS-B
    [Tags]    small range 746 line
    # user is beong to workspace WS-A and WS-B 登录
    ${driver1}    driver_set_up_and_logIn    ${belong_two_WS_username}     ${universal_password}
    ${user_list_1}    get_all_data_on_the_page    ${driver1}
    # another User beong to workspace WS-A登录
    ${driver2}    driver_set_up_and_logIn    ${Expert_User1_username}     ${universal_password}
    ${invite_url}    send_meeting_room_link    ${driver2}    MHS   no_send
    # User1 click User2's MHS link
    user_make_call_via_meeting_link   ${driver1}   ${invite_url}
    # another User 接受Call
    user_anwser_call   ${driver2}
    # VP: This User has invite 3rd participant icon on menu bar
    open_invite_3rd_participant_dialog      ${driver1}    no_enter
    # VP: contact list is same as team list from ws-A
    ${user_list_2}    get_all_data_on_the_page    ${driver1}      contact-name
    lists should be equal  ${user_list_1}   ${user_list_2}
    [Teardown]      run keywords    exit_call     ${driver2}
    ...             AND             exit_driver     ${driver1}    ${driver2}

Small_range_751
    [Documentation]      Resolution Check    Web on PC   VP: Resolution = 1280x720
    [Tags]    small range 751 line
    # User A 登录
    ${driver1}    driver_set_up_and_logIn    ${big_admin_first_WS_username}     ${universal_password}
    # User B 登录
    ${driver2}    driver_set_up_and_logIn    ${big_admin_third_WS_username}     ${universal_password}
    # 在Settings打开Debug Tools配置
    switch_to_settings_page    ${driver2}    Settings    1    no_click_tree
    open_debug_tools_in_settings   ${driver2}
    # 进行Call
    make_calls_with_who   ${driver1}   ${driver2}    ${big_admin_third_WS_username}
    sleep  20s    # 等待通话稳定
    # 检查Debug页面的Resolution是否为1280x720
    open_debug_dialog_check_resolution   ${driver2}
    [Teardown]      run keywords    exit_call    ${driver1}
    ...             AND             exit_driver     ${driver1}    ${driver2}

Small_range_799_802
    [Documentation]      Set Declaimer ->'delete user' is selected    Normal call
    [Tags]    small range 799 800 801 802 lines
    [Setup]     run keywords    check_file_if_exists_delete
    ...         AND             Login_site_admin
    ...         AND             enter_workspace_settings_page       # 进入settings页面
    ...         AND             open_workspace_directory            # 打开Workspace Directory设置
    ...         AND             expand_option_delete_user           # EXPAND delete user 选项
    ...         AND             set_disclaimer_is_on                # 设置Disclaimer为open状态
    ...         AND             set_delete_user_open                # 设置delete user为open状态
    # 进入users页面
    enter_workspace_users
    # 新建一个normal user
    ${random}   get_random_number
    ${email}   add_a_normal_user   ${random}
    # 根据邮件打开链接并设置密码
    set_password_mailbox

    # User A 登录
    ${driver1}    driver_set_up_and_logIn    ${normal_username_for_calls}       ${universal_password}
    # User B 登录
    ${driver2}    driver_set_up_and_logIn    ${normal_username_for_calls_B}     ${universal_password}
    # User C 登录
    ${driver3}    driver_set_up_and_logIn    ${email}                           ${universal_password}
    # Normal call    User A, User B & User C are in a call
    make_calls_with_who    ${driver3}   ${driver2}   ${normal_username_for_calls_B}
    which_page_is_currently_on    ${driver3}    ${end_call_button}
    enter_contacts_search_user     ${driver3}     ${normal_username_for_calls_name}
    click_user_in_contacts_call    ${driver3}     ${normal_username_for_calls_name}
    user_anwser_call      ${driver1}
    # End call, User A, User B & User C enter the call tag & comment.
    leave_call    ${driver3}
    exit_call    ${driver2}     5

    # 进入到workspace settings page
    enter_workspace_settings_page
    # EXPAND delete user 选项
    expand_option_delete_user
    # Citron Admin reset disclaimer
    reset_all_accepted_disclaimers
    # Close browser
    Close
    # User C decline this disclaimer
    refresh_browser_page   ${driver3}   no_close_tutorial
    disclaimer_should_be_shown_up_or_not   ${driver3}    # 校验出现disclaimer确认对话框
    user_decline_or_accept_disclaimer   ${driver3}      # 点击decline按钮
    erase_my_account   ${driver3}       # 点击两次Erase My Account按钮确认删除账号
    # Returns to login page without user's info
    which_page_is_currently_on      ${driver3}    ${login_page_username}
    # Enter User C & Password to verify this user should not be login.
    re_login_citron   ${driver3}   ${email}

    # 800 line
    # In Crunch to check this audit log should be recorded.
    Login_crunch
    # enter crunch Audit Logs page
    enter_enterprises_audit_log
    # In Crunch to check this audit log should be recorded.
    ${LogList}    get_all_logs_in_audit_logs
    log_in_crunch_is_correct    User ${random}    ${LogList}
    log_in_crunch_is_correct    was deleted after declining the disclaimer.     ${LogList}
    log_in_crunch_is_correct    has declined the Disclaimer text.     ${LogList}
    log_in_crunch_is_correct    property 'disclaimer_accepted' to 'false'.    ${LogList}
    # close browser
    Close

    # 801 line
    # VP: In Citron->Admin  1)-> Calls, to check any reference to the User becomes "Deleted User".
    Login_site_admin
    enter_workspace_calls_page
    enter_which_call_details     1    # 进入第一条call记录的details
    refresh_web_page
    check_details_participant_count     3   # participant数目为3
    refresh_web_page
    check_details_participant_name      Deleted User    # Deleted User在participant中
    refresh_web_page
    check_event_log_deleted_user    2  # event log中有两条deleted user
    enter_calls_menu
    # VP: In Citron->Admin  3)->Calls -> expert current it table, to check the csv file: the user name should be changed to Deleted User, email should be changed to Null.
    export_current_table
    ${owner_name_get_from_excel}    ${owner_email_get_from_excel}    check_export_file_data
    should be equal as strings    ${owner_name_get_from_excel}    Deleted User
    should be empty     ${owner_email_get_from_excel}
    # VP: In Citron->Admin  2)-> Users, to check this user is not in Active User & Deactive User & Invitation User List.
    enter_workspace_users
    users_page_search_deleted_user   ${random}
    enter_workspace_users_invitations
    users_page_search_deleted_user   ${random}
    enter_workspace_users_deactivated_users
    users_page_search_deleted_user   ${random}

    # 802 line
    # VP: User A client:1) Check User A's Favorites, Directory, and Contacts Lists
    Login_new_added_user   ${normal_username_for_calls}
    users_page_search_deleted_user   ${random}
    enter_directory_page
    users_page_search_deleted_user   ${random}
    enter_favorites_page
    users_page_search_deleted_user   ${random}
    # VP: User A client:2) Check this call info of User A's recent call list
    enter_recents_page
    check_page_first_owner_is_deleted_user    name
    # VP: User A client:3) Check the call record should not be recalled for User C from User A's recent call
    recents_page_first_line_has_no_call_button
    [Teardown]      run keywords    check_file_if_exists_delete
    ...             AND             exit_driver     ${driver1}    ${driver2}     ${driver3}
    ...             AND             Close

Disclaimer_805
    [Documentation]    Disclaimer   Set Declaimer ->'delete user' is NOT selected   Enterprise Admin Reset Disclaimer
    [Tags]     small range 805 line
    [Setup]     run keywords      Login_workspaces_admin            # log in with workspace admin
    ...         AND               enter_workspace_settings_page     # 进入settings页面
    ...         AND               expand_option_delete_user         # EXPAND delete user 选项
    ...         AND               set_disclaimer_is_on              # 设置Disclaimer为open状态
    ...         AND               set_delete_user_close             # 设置delete user为close状态
    ...         AND               Close
    # User登录
    ${driver1}   driver_set_up_and_logIn   ${personal_user_username}        ${personal_user_password}
    # Enterprise Admin登录
    ${driver2}   driver_set_up_and_logIn   ${workspace_admin_username}      ${workspace_admin_password}
    # Workspace Admin进入到WS下的Settings页面
    switch_to_settings_page   ${driver2}
    # Enterprise Admin Reset Disclaimer
    expand_which_setting    ${driver2}     Before Call: Disclaimer      # EXPAND Before Call: Disclaimer
    reset_disclaimer   ${driver2}
    # App stays on the background for 40s.	App is back to forefront.
    sleep   40s
    refresh_browser_page   ${driver1}
    # App is reconnected to server. Disclaimer should be shown up.
    disclaimer_should_be_shown_up_or_not   ${driver1}
    [Teardown]      run keywords    Close
    ...             AND             exit_driver   ${driver1}   ${driver2}

Disclaimer_806_807
    [Documentation]    Set Declaimer ->'delete user' is NOT selected    2 enterprise users in call	 Invite User C who is in same enterprise who has accepted disclaimer when logs in App.
    [Tags]     small range 806-807 lines
    [Setup]     run keywords      Login_premium_user                # log in with Site admin
    ...         AND               enter_workspace_settings_page     # 进入settings页面
    ...         AND               expand_option_delete_user         # EXPAND delete user 选项
    ...         AND               set_disclaimer_is_on              # 设置Disclaimer为open状态
    ...         AND               set_delete_user_close             # 设置delete user为close状态
    ...         AND               Close
    # User A 登录
    ${driver1}   driver_set_up_and_logIn   ${switch_workspace_username}        ${switch_workspace_password}
    # User B 登录
    ${driver2}   driver_set_up_and_logIn   ${big_admin_first_WS_username}      ${big_admin_first_WS_password}
    # User C 登录
    ${driver3}   driver_set_up_and_logIn   ${big_admin_third_WS_username}      ${big_admin_third_WS_password}
    # A和B进行Call
    make_calls_with_who    ${driver1}   ${driver2}    ${big_admin_first_WS_username}

    #######  806 line
    # User A 进入到邀请第三位用户进入call 的页面，并查询User C
    which_page_is_currently_on    ${driver1}    ${end_call_button}
    enter_contacts_search_user   ${driver1}   ${big_admin_third_WS_name}
    # 点击查询到的User C
    click_user_in_contacts_call   ${driver1}   ${big_admin_third_WS_name}
    # User A 接收打进来的Call
    user_anwser_call   ${driver3}
    # User C leave call
    exit_call   ${driver3}
    # User C hasn't disclaimer window.
    disclaimer_should_be_shown_up_or_not   ${driver3}  not_appear

    #######  807 line
    # User A 进入到邀请第三位用户进入call 的页面，并查询User C
    enter_contacts_search_user   ${driver1}   ${big_admin_third_WS_name}
    # 点击查询到的User C
    click_user_in_contacts_call   ${driver1}   ${big_admin_third_WS_name}
    # User C Decline打进来的Call
    user_decline_call   ${driver3}
    # User C hasn't disclaimer window.
    disclaimer_should_be_shown_up_or_not   ${driver3}  not_appear

    # User A end call
    exit_call   ${driver1}
    [Teardown]      run keywords    Close
    ...             AND             exit_driver  ${driver1}   ${driver2}   ${driver3}

Disclaimer_808_809
    [Documentation]   Set Declaimer ->'delete user' is NOT selected    logout app and click one-time meeting link
    [Tags]     small range 808-809 lines
    [Setup]     run keywords      Login_premium_user                # log in with Site admin
    ...         AND               enter_workspace_settings_page     # 进入settings页面
    ...         AND               expand_option_delete_user         # EXPAND delete user 选项
    ...         AND               set_disclaimer_is_on              # 设置Disclaimer为open状态
    ...         AND               set_delete_user_close             # 设置delete user为close状态
    ...         AND               Close
    # User A 登录
    ${driver1}   driver_set_up_and_logIn   ${switch_workspace_username}        ${switch_workspace_password}
    # 获取OTU meeting-link
    ${invite_url}  send_meeting_room_link   ${driver1}   OTU

    ###### 809 line
    ${driver2}   anonymous_open_meeting_link   ${invite_url}   decline
    # 退出driver
    exit_one_driver   ${driver2}

    ###### 808 line
    ${driver3}   anonymous_open_meeting_link   ${invite_url}
    # Anonymous enter the outgoing call window.	The owner should receive the incoming call	After accepting, the call should be successfully connected.
    user_anwser_call   ${driver1}
    exit_call  ${driver1}
    [Teardown]      run keywords    Close
    ...             AND             exit_driver    ${driver1}    ${driver2}  ${driver3}

Small_range_820_821
    [Documentation]     Call recording feature     Pre-condition：set to always record      Anonymous user call meeting owner
    [Tags]    small range 820-821 lines
    [Setup]     run keywords    Login_site_admin
    ...         AND             switch_to_created_workspace         ${created_workspace_branding_3}   # 切换到我自己创建的WS
    ...         AND             enter_workspace_settings_page           # 进入settings页面
    ...         AND             expand_during_call_recording            # 展开During Call: Recording设置
    ...         AND             turn_on_during_call_recording           # 打开During Call: Recording设置
    ...         AND             choose_witch_recording_feature      ${always_on_select}    # set to always record
    ...         AND             Close
    # User A 登录
    ${driver1}   driver_set_up_and_logIn   ${ws3_branding_A_user}        ${switch_workspace_password}
    # 获取meeting link
    ${invite_url}    send_meeting_room_link     ${driver1}    OTU
    # Anonymous user call meeting owner
    ${driver2}   anonymous_open_meeting_link    ${invite_url}
    # 接受Call
    user_anwser_call      ${driver1}
    # Another enterprise user join call
    ${driver3}   driver_set_up_and_logIn   ${Expert_User5_username}        ${switch_workspace_password}
    user_make_call_via_meeting_link      ${driver3}     ${invite_url}
    # 接受Call
    user_anwser_call      ${driver1}     no_direct
    # VP: REC is on, can not changed
    which_page_is_currently_on    ${driver1}    ${end_call_button}
    rec_is_on_or_off     ${driver1}
    which_page_is_currently_on    ${driver2}    ${end_call_button}
    rec_is_on_or_off     ${driver2}
    which_page_is_currently_on    ${driver3}    ${end_call_button}
    rec_is_on_or_off     ${driver3}
    # Change mode of giver/receiver/Observer;In mode of Freeze/GHoP/Doc Share
    # In each mode, Say some words while do telestrations.	VP: REC is still on
    enter_giver_mode     ${driver1}      ${ws3_branding_A_username}    ${Expert_User5_name}
    rec_is_on_or_off     ${driver1}
    rec_is_on_or_off     ${driver2}
    rec_is_on_or_off     ${driver3}
    enter_FGD_mode     ${driver1}      Document
    rec_is_on_or_off     ${driver1}
    rec_is_on_or_off     ${driver2}
    rec_is_on_or_off     ${driver3}
    enter_FGD_mode     ${driver1}      Photo
    rec_is_on_or_off     ${driver1}
    rec_is_on_or_off     ${driver2}
    rec_is_on_or_off     ${driver3}
#    enter_FGD_mode     ${driver3}      Freeze
#    rec_is_on_or_off     ${driver1}
#    rec_is_on_or_off     ${driver2}
#    rec_is_on_or_off     ${driver3}
    # end call
    end_call_for_all     ${driver1}
    [Teardown]      run keywords    Close
    ...             AND             exit_driver    ${driver1}    ${driver2}  ${driver3}

Small_range_823
    [Documentation]     Call on-call group from contact list
    [Tags]    small range 823 line
    [Setup]     run keywords    Login_site_admin
    ...         AND             switch_to_created_workspace         ${created_workspace_branding_3}   # 切换到我自己创建的WS
    ...         AND             enter_workspace_settings_page           # 进入settings页面
    ...         AND             expand_during_call_recording            # 展开During Call: Recording设置
    ...         AND             turn_on_during_call_recording           # 打开During Call: Recording设置
    ...         AND             choose_witch_recording_feature      ${always_on_select}    # set to always record
    ...         AND             Close
    # User A 登录
    ${driver1}   driver_set_up_and_logIn   ${ws3_branding_A_user}        ${switch_workspace_password}
    # On-call user登录
    ${driver2}   driver_set_up_and_logIn   ${ws3_branding_B_user}        ${switch_workspace_password}
    # Call on-call group from contact list
    make_call_to_onCall     ${driver1}    ${driver2}    ${Expert_Group_1}
    # VP: REC is on, can not changed. What's more, on both sides, REC logo should be shown up.
    which_page_is_currently_on    ${driver1}    ${end_call_button}
    rec_is_on_or_off     ${driver1}
    which_page_is_currently_on    ${driver2}    ${end_call_button}
    rec_is_on_or_off     ${driver2}
    # In mode of Freeze/GHoP/Doc Share，VP: REC is still on
    enter_giver_mode     ${driver1}      none    none     2
    rec_is_on_or_off     ${driver1}
    rec_is_on_or_off     ${driver2}
    enter_FGD_mode     ${driver1}      Document
    rec_is_on_or_off     ${driver1}
    rec_is_on_or_off     ${driver2}
    enter_FGD_mode     ${driver1}      Photo
    rec_is_on_or_off     ${driver1}
    rec_is_on_or_off     ${driver2}
#    enter_FGD_mode     ${driver2}      Freeze
#    rec_is_on_or_off     ${driver1}
#    rec_is_on_or_off     ${driver2}
    # end call
    exit_call    ${driver1}
    [Teardown]      run keywords    Close
    ...             AND             exit_driver    ${driver1}    ${driver2}

Small_range_825_826
    [Documentation]     Call recording feature     Pre-condition：set to Default-OFF
    [Tags]    small range 825+826 lines
    [Setup]     run keywords    Login_premium_user              # another company user whose rec is on
    ...         AND             switch_to_created_workspace         ${created_workspace}   # 切换到我自己创建的WS
    ...         AND             enter_workspace_settings_page           # 进入settings页面
    ...         AND             expand_during_call_recording            # 展开During Call: Recording设置
    ...         AND             turn_on_during_call_recording           # 打开During Call: Recording设置
    ...         AND             choose_witch_recording_feature      ${always_on_select}    # set to always record
    ...         AND             Close
    # User A 登录
    ${driver1}   driver_set_up_and_logIn   ${ws3_branding_A_user}        ${switch_workspace_password}
    # another company user登录
    ${driver2}   driver_set_up_and_logIn   ${Expert_User5_username}        ${switch_workspace_password}
    # Pre-condition：set to Default-OFF
    # VP: After setting changing,new call  should be OFF immediately . Do not need to logout.
    Login_site_admin              # another company user whose rec is on
    switch_to_created_workspace         ${created_workspace_branding_3}   # 切换到我自己创建的WS
    enter_workspace_settings_page           # 进入settings页面
    expand_during_call_recording            # 展开During Call: Recording设置
    turn_on_during_call_recording           # 打开During Call: Recording设置
    choose_witch_recording_feature      ${opt_in_select}    # set to Default-OFF
    Close
    # MHS owner get incoming call from another company user whose rec is on
    ${invite_url}    send_meeting_room_link     ${driver1}    MHS
    user_make_call_via_meeting_link      ${driver2}     ${invite_url}
    user_anwser_call     ${driver1}
    # VP: REC is off, only owner can change it
    which_page_is_currently_on    ${driver1}    ${end_call_button}
    rec_is_on_or_off     ${driver1}     off   can_change
    which_page_is_currently_on    ${driver2}    ${end_call_button}
    rec_is_on_or_off     ${driver2}     off   none
    # Change role of giver/receiver
    enter_giver_mode     ${driver1}      none    none     2
    # VP: only owner can change rec
    rec_is_on_or_off     ${driver1}     off   can_change
    rec_is_on_or_off     ${driver2}     off   none
    # VP:  Msg of "$Username has enabled/turned off recording for this call." show to all participants
    record_or_do_not_record    record          ${ws3_branding_A_username}    ${driver1}    ${driver2}
    record_or_do_not_record    do_not_record        ${ws3_branding_A_username}    ${driver1}    ${driver2}
    # end call
    exit_call    ${driver1}
    [Teardown]      run keywords    Close
    ...             AND             exit_driver    ${driver1}    ${driver2}

Small_range_827
    [Documentation]     Expert  get incoming call
    [Tags]    small range 827 line
    [Setup]     run keywords    Login_site_admin
    ...         AND             switch_to_created_workspace         ${created_workspace_branding_3}   # 切换到我自己创建的WS
    ...         AND             enter_workspace_settings_page           # 进入settings页面
    ...         AND             expand_during_call_recording            # 展开During Call: Recording设置
    ...         AND             turn_on_during_call_recording           # 打开During Call: Recording设置
    ...         AND             choose_witch_recording_feature      ${opt_in_select}    # set to Default-OFF
    ...         AND             Close
    # User A 登录
    ${driver1}   driver_set_up_and_logIn   ${ws3_branding_A_user}        ${switch_workspace_password}
    # Expert 登录
    ${driver2}   driver_set_up_and_logIn   ${ws3_branding_B_user}        ${switch_workspace_password}
    # Expert  get incoming call
    make_call_to_onCall     ${driver1}    ${driver2}    ${Expert_Group_1}
    # VP: REC is off, only expert can change it
    which_page_is_currently_on    ${driver1}    ${end_call_button}
    rec_is_on_or_off     ${driver1}     off   none
    which_page_is_currently_on    ${driver2}    ${end_call_button}
    rec_is_on_or_off     ${driver2}     off   can_change
    # invite another expert to join as 3PC
    ${driver3}   driver_set_up_and_logIn   ${ws3_branding_C_user}        ${switch_workspace_password}
    which_page_is_currently_on    ${driver1}    ${end_call_button}
    enter_contacts_search_user    ${driver1}     ${ws3_branding_C_username}
    click_user_in_contacts_call   ${driver1}     ${ws3_branding_C_username}
    user_anwser_call    ${driver3}
    # VP: only first expert can change rec
    rec_is_on_or_off     ${driver1}     off   none
    rec_is_on_or_off     ${driver2}     off   can_change
    rec_is_on_or_off     ${driver3}     off   none
    # 结束Call
    end_call_for_all     ${driver1}
    [Teardown]      run keywords    Close
    ...             AND             exit_driver    ${driver1}    ${driver2}  ${driver3}

Small_range_829
    [Documentation]     Call enterprise contact
    [Tags]    small range 829 line
    [Setup]     run keywords    Login_site_admin
    ...         AND             switch_to_created_workspace         ${created_workspace_branding_3}   # 切换到我自己创建的WS
    ...         AND             enter_workspace_settings_page           # 进入settings页面
    ...         AND             expand_during_call_recording            # 展开During Call: Recording设置
    ...         AND             turn_on_during_call_recording           # 打开During Call: Recording设置
    ...         AND             choose_witch_recording_feature      ${opt_in_select}    # set to Default-OFF
    ...         AND             Close
    # User A 登录
    ${driver1}   driver_set_up_and_logIn   ${ws3_branding_A_user}        ${switch_workspace_password}
    # Expert 登录
    ${driver2}   driver_set_up_and_logIn   ${site_admin_username}        ${switch_workspace_password}
    # Call enterprise contact
    make_calls_with_who     ${driver1}    ${driver2}    ${site_admin_username}
    # VP: REC is off, only caller can change it
    which_page_is_currently_on    ${driver1}    ${end_call_button}
    rec_is_on_or_off     ${driver1}     off   can_change
    which_page_is_currently_on    ${driver2}    ${end_call_button}
    rec_is_on_or_off     ${driver2}     off   none
    # Change role of giver/receiver
    enter_giver_mode     ${driver1}      none    none     2
    # VP: only owner can change rec
    rec_is_on_or_off     ${driver1}     off   can_change
    rec_is_on_or_off     ${driver2}     off   none
    # end call
    exit_call    ${driver1}
    [Teardown]      run keywords    Close
    ...             AND             exit_driver    ${driver1}    ${driver2}

Small_range_831_832
    [Documentation]     Call recording feature     Pre-condition：set to Default-ON
    [Tags]    small range 831+832 lines
    [Setup]     run keywords    Login_premium_user              # another company user whose rec is on
    ...         AND             switch_to_created_workspace         ${created_workspace}   # 切换到我自己创建的WS
    ...         AND             enter_workspace_settings_page           # 进入settings页面
    ...         AND             expand_during_call_recording            # 展开During Call: Recording设置
    ...         AND             turn_on_during_call_recording           # 打开During Call: Recording设置
    ...         AND             choose_witch_recording_feature      ${opt_out_select}    # set to Default-ON
    ...         AND             Close
    # User A 登录
    ${driver1}   driver_set_up_and_logIn   ${ws3_branding_A_user}        ${switch_workspace_password}
    # another company user登录
    ${driver2}   driver_set_up_and_logIn   ${Expert_User5_username}        ${switch_workspace_password}
    # Pre-condition：set to Default-ON
    # VP: After setting changing, the new call recording should be on immediately.
    Login_site_admin              # another company user whose rec is on
    switch_to_created_workspace         ${created_workspace_branding_3}   # 切换到我自己创建的WS
    enter_workspace_settings_page           # 进入settings页面
    expand_during_call_recording            # 展开During Call: Recording设置
    turn_on_during_call_recording           # 打开During Call: Recording设置
    choose_witch_recording_feature      ${opt_out_select}    # set to Default-ON
    Close
    # MHS owner get incoming call from another company user whose rec is default-on
    ${invite_url}    send_meeting_room_link     ${driver1}    MHS
    user_make_call_via_meeting_link      ${driver2}     ${invite_url}
    user_anwser_call     ${driver1}
    # VP: REC is on, only owner can change it
    which_page_is_currently_on    ${driver1}    ${end_call_button}
    rec_is_on_or_off     ${driver1}     on   can_change
    which_page_is_currently_on    ${driver2}    ${end_call_button}
    rec_is_on_or_off     ${driver2}     on   can_not_change
    # end call
    exit_call    ${driver1}
    [Teardown]      run keywords    Close
    ...             AND             exit_driver    ${driver1}    ${driver2}

Small_range_833
    [Documentation]     call on-call group from contact list
    [Tags]    small range 827 line
    [Setup]     run keywords    Login_site_admin
    ...         AND             switch_to_created_workspace         ${created_workspace_branding_3}   # 切换到我自己创建的WS
    ...         AND             enter_workspace_settings_page           # 进入settings页面
    ...         AND             expand_during_call_recording            # 展开During Call: Recording设置
    ...         AND             turn_on_during_call_recording           # 打开During Call: Recording设置
    ...         AND             choose_witch_recording_feature      ${opt_out_select}    # set to Default-OFF
    ...         AND             Close
    # User A 登录
    ${driver1}   driver_set_up_and_logIn   ${ws3_branding_A_user}        ${switch_workspace_password}
    # Expert 登录
    ${driver2}   driver_set_up_and_logIn   ${ws3_branding_B_user}        ${switch_workspace_password}
    # call on-call group from contact list
    make_call_to_onCall     ${driver1}    ${driver2}    ${Expert_Group_1}
    # VP: REC is on, only expert can change it
    which_page_is_currently_on    ${driver1}    ${end_call_button}
    rec_is_on_or_off     ${driver1}     on   can_not_change
    which_page_is_currently_on    ${driver2}    ${end_call_button}
    rec_is_on_or_off     ${driver2}     on   can_change
    # invite another expert to join as 3PC
    ${driver3}   driver_set_up_and_logIn   ${ws3_branding_C_user}        ${switch_workspace_password}
    which_page_is_currently_on    ${driver1}    ${end_call_button}
    enter_contacts_search_user    ${driver1}     ${ws3_branding_C_username}
    click_user_in_contacts_call   ${driver1}     ${ws3_branding_C_username}
    user_anwser_call    ${driver3}
    # first expert leave call
    leave_call     ${driver2}
    # VP: other participant can not change rec
    which_page_is_currently_on    ${driver3}    ${end_call_button}
    rec_is_on_or_off     ${driver3}     on   can_not_change
    # 结束Call
    exit_call     ${driver1}
    [Teardown]      run keywords    Close
    ...             AND             exit_driver    ${driver1}    ${driver2}  ${driver3}

Small_range_834
    [Documentation]     Call enterprise contact
    [Tags]    small range 834 line
    [Setup]     run keywords    Login_site_admin
    ...         AND             switch_to_created_workspace         ${created_workspace_branding_3}   # 切换到我自己创建的WS
    ...         AND             enter_workspace_settings_page           # 进入settings页面
    ...         AND             expand_during_call_recording            # 展开During Call: Recording设置
    ...         AND             turn_on_during_call_recording           # 打开During Call: Recording设置
    ...         AND             choose_witch_recording_feature      ${opt_out_select}    # set to Default-ON
    ...         AND             Close
    # User A 登录
    ${driver1}   driver_set_up_and_logIn   ${ws3_branding_A_user}        ${switch_workspace_password}
    # Expert 登录
    ${driver2}   driver_set_up_and_logIn   ${site_admin_username}        ${switch_workspace_password}
    # Call enterprise contact
    make_calls_with_who     ${driver1}    ${driver2}    ${site_admin_username}
    # VP: REC is off, only caller can change it
    which_page_is_currently_on    ${driver1}    ${end_call_button}
    rec_is_on_or_off     ${driver1}     on   can_change
    which_page_is_currently_on    ${driver2}    ${end_call_button}
    rec_is_on_or_off     ${driver2}     on   none
    # Change role of giver/receiver
    enter_giver_mode     ${driver1}      none    none     2
    # In mode of Freeze/GHoP/Doc Share
    # VP: only caller can change rec
    enter_FGD_mode     ${driver1}      Document
    rec_is_on_or_off     ${driver1}    on    can_change
    rec_is_on_or_off     ${driver2}    on    can_not_change
    enter_FGD_mode     ${driver1}      Photo
    rec_is_on_or_off     ${driver1}    on    can_change
    rec_is_on_or_off     ${driver2}    on    can_not_change
#    enter_FGD_mode     ${driver2}      Freeze
#    rec_is_on_or_off     ${driver1}    on    can_change
#    rec_is_on_or_off     ${driver2}    on    can_not_change
    # end call
    exit_call    ${driver1}
    [Teardown]      run keywords    Close
    ...             AND             exit_driver    ${driver1}    ${driver2}

Small_range_836
    [Documentation]     Special Recent call	    One user logins on two devices
    [Tags]    small range 836 line
    # User 1 logins app on 2 devices
    # User 1 登录
    ${driver1}   driver_set_up_and_logIn   ${ws3_branding_A_user}        ${switch_workspace_password}
    # User 1再次 登录
    ${driver2}   driver_set_up_and_logIn   ${ws3_branding_A_user}        ${switch_workspace_password}
    # User 2 登录
    ${driver3}   driver_set_up_and_logIn   ${ws3_branding_B_user}        ${switch_workspace_password}
    # User 2 makes a call with user 1
    make_calls_with_who     ${driver3}    ${driver1}    ${ws3_branding_A_user}    no_care
    # User 1-1 answer this call, at that time, User 1-2 auto-ends this call
    which_page_is_currently_on    ${driver1}     ${anwser_call_button}
    which_page_is_currently_on    ${driver2}     ${anwser_call_button}
    user_anwser_call     ${driver1}
    which_page_is_currently_on    ${driver1}     ${invite_user_in_calling}
    which_page_is_currently_on    ${driver2}     ${py_contacts_switch_success}
    # Verify User 1-1 & User 1-2 should have this incoming call record in recent tab.
    exit_call       ${driver1}
    close_call_ending_page    ${driver1}
    switch_to_diffrent_page    ${driver1}   ${py_recents_page}    ${py_recents_switch_success}    ${py_get_number_of_rows}
    ${occurred_time_list_1}   get_recents_page_records_occurred_time    ${driver1}
    close_call_ending_page    ${driver2}
    switch_to_diffrent_page    ${driver2}   ${py_recents_page}    ${py_recents_switch_success}    ${py_get_number_of_rows}
    ${occurred_time_list_2}   get_recents_page_records_occurred_time    ${driver2}
    Should Be Equal    ${occurred_time_list_1}   ${occurred_time_list_2}
    [Teardown]      exit_driver    ${driver1}    ${driver2}    ${driver3}
