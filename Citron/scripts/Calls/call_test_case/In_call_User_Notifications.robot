*** Settings ***
Library           Selenium2Library
Library           OperatingSystem
Resource          ../../../Lib/public.robot
Resource          ../../../Lib/calls_resource.robot
Resource          ../../../Lib/hodgepodge_resource.robot
Resource          ../../../Lib/All_Pages_Xpath/Normal/load_file.robot
Library           call_python_Lib/call_public_lib.py
Library           call_python_Lib/else_public_lib.py
Library           call_python_Lib/login_lib.py
Library           call_python_Lib/contacts_page.py
Library           call_python_Lib/recents_page.py
Library           call_python_Lib/my_account.py
Library           call_python_Lib/finish_call.py
Library           call_python_Lib/about_call.py
Force Tags        In-call User Notifications

*** Test Cases ***
In_call_User_Notifications_3467
    [Documentation]    It occurs when you are the Helper and are sharing a document
    [Tags]      In-call User Notifications 3-7 lines       call_case
    # log in
    ${driver1}   driver_set_up_and_logIn    ${notifications_user01}
    ${driver2}   driver_set_up_and_logIn    ${notifications_user02}
    # make call
    contacts_witch_page_make_call   ${driver2}   ${driver1}   ${py_team_page}    ${notifications_username01}
    # 确保进入通话
    make_sure_enter_call      ${driver1}
    # 选择helper，进入giver/helper模式
    enter_giver_mode   ${driver1}    None   None   2   has_dialog   help
    # 点击右侧红色按钮，选择document，上传pdf     验证It occurs when you are the Helper and are sharing a document
    helper_load_document    ${driver1}     ${load_test_pdf}
    # 点击Clear Shared Content按钮，回到初始状态      验证It occurs when the share document mode ends.
    click_clear_shared_content      ${driver1}
    # 点击Share a photo按钮        验证It occurs when you are the Helper and are sharing a picture
    click_share_a_photo     ${driver1}     ${load_test_jpg}
    [Teardown]   exit_driver

In_call_User_Notifications_3568
    [Documentation]    It occurs when you aren't the Helper and are sharing a document
    [Tags]      In-call User Notifications 3-8 lines       call_case
    # log in
    ${driver1}   driver_set_up_and_logIn    ${notifications_user01}
    ${driver2}   driver_set_up_and_logIn    ${notifications_user02}
    # make call
    contacts_witch_page_make_call   ${driver2}   ${driver1}   ${py_team_page}    ${notifications_username01}
    # 确保进入通话
    make_sure_enter_call      ${driver1}
    # 选择giver，进入giver/helper模式
    enter_giver_mode   ${driver1}    None   None   2   has_dialog   give
    # 进入Document模式，上传PDF      验证It occurs when you aren't the Helper and are sharing a document
    giver_share_a_document     ${driver1}    ${load_test_pdf}
    # 点击Clear Shared Content按钮，回到初始状态      验证It occurs when the share document mode ends.
    click_clear_shared_content      ${driver1}
    # 点击Share a photo按钮        验证It occurs when you aren't the Helper and are sharing a picture
    click_share_a_photo     ${driver1}    ${load_test_jpg}
    [Teardown]   exit_driver

In_call_User_Notifications_9_10_11_31_32
    [Documentation]    It occurs when you change from the image mode and it tells for the Helper, tha it return to Help Mode
    [Tags]      In-call User Notifications 9-32 lines       call_case
    # User B log in
    ${driver2}   driver_set_up_and_logIn   ${notifications_user03}
    # User C log in
    ${driver3}   driver_set_up_and_logIn   ${notifications_user04}
    # User C与User B进行Call
    contacts_witch_page_make_call    ${driver3}   ${driver2}     ${py_team_page}      ${notifications_username03}
    make_sure_enter_call    ${driver3}
    # User A log in
    ${driver1}   driver_set_up_and_logIn   ${notifications_user05}
    # User C 进入到邀请第三位用户进入call 的页面，并查询User A
    enter_contacts_search_user   ${driver3}   ${notifications_username05}
    # 点击查询到的User A
    click_user_in_contacts_call   ${driver3}   ${notifications_username05}
    # 验证It occurs when invite participant to join a call	Your invite to %1$s was sent successfully
    your_invite_to_was_sent_successfully    ${driver3}    ${notifications_username05}
    # User A 接收打进来的Call
    user_anwser_call   ${driver1}
    # 验证It occurs when invitee receive the invitation	%1$s has accepted your call
    has_accepted_your_call    ${driver3}
    make_sure_enter_call    ${driver1}
    # 进入进入giver/helper模式
    enter_giver_mode     ${driver3}    ${notifications_username04}    ${notifications_username03}      3
    # 点击Share a photo按钮，上传jpg图片
    click_share_a_photo     ${driver3}    ${load_test_jpg}
    # 点击Clear Shared Content按钮，回到初始状态      验证It occurs when you change from the image mode and it tells for the Helper, tha it return to Help Mode
    click_clear_shared_content      ${driver3}      photo
    # It occurs when you change from the image mode and it tells for the Receiver, that it return to Receive help
    exiting_photo_mode_show       ${driver2}
    # It occurs when you change from the image mode and it tells for Observers, that it return to be an Observer
    exiting_photo_mode_show       ${driver1}
    [Teardown]    exit_driver

In_call_User_Notifications_18_20
    [Documentation]    When a participant joins the call in cooperation mode
    [Tags]      In-call User Notifications 18-20 lines       call_case
    # User B log in
    ${driver2}   driver_set_up_and_logIn   ${notifications_user03}
    # User C log in
    ${driver3}   driver_set_up_and_logIn   ${notifications_user04}
    # User C与User B进行Call
    contacts_witch_page_make_call    ${driver3}   ${driver2}     ${py_team_page}      ${notifications_username03}
    make_sure_enter_call    ${driver3}
    # 进入Giver/Helper模式
    enter_giver_mode      ${driver3}     none    none     2
    # User A log in
    ${driver1}   driver_set_up_and_logIn   ${notifications_user05}
    # User C 进入到邀请第三位用户进入call，获取link
    ${invite_url}    send_invite_in_calling_page   ${driver3}
    close_invite_3th_page     ${driver3}
    # User A点击link进入call
    user_make_call_via_meeting_link    ${driver1}   ${invite_url}    no_check
    # 验证When a participant joins the call in cooperation mode	%1$s has joined as obeserver
    has_joined_as_obeserver    ${driver3}    ${notifications_username05}
    # User A 结束call
    exit_call   ${driver1}   no_check
    # 验证When a participant leaves the call.	%1$s has left the session
    has_left_the_session    ${driver3}    ${notifications_username05}
    [Teardown]    exit_driver

In_call_User_Notifications_24_25_54_55
    [Documentation]    When user switches its role to Help Giver
    [Tags]      In-call User Notifications 24-55 lines       call_case
    # User B log in
    ${driver2}   driver_set_up_and_logIn   ${notifications_user01}
    # User C log in
    ${driver3}   driver_set_up_and_logIn   ${notifications_user02}
    # User C与User B进行Call
    contacts_witch_page_make_call    ${driver3}   ${driver2}     ${py_team_page}      ${notifications_username01}
    make_sure_enter_call     ${driver2}
    make_sure_enter_call     ${driver3}
    # 验证Call recording started	       %1$s has enabled recording for this call.
    make_show_recording_settings    ${driver3}
    click_do_not_record     ${driver3}    ${notifications_username02}
    # 验证Call recording stopped	       %1$s has turned off recording for this call.
    make_show_recording_settings    ${driver3}
    click_record_this_session     ${driver3}    ${notifications_username02}
    # 进入Giver/Helper模式
    enter_giver_mode      ${driver3}     none    none     2
    # 验证When user switches its role to Help Giver in audio mode	     Now Giving Help.
    now_which_help     ${driver2}
    # 验证When user switches its role to Help Receiver in audio mode	     Now Receiving Help.
    now_which_help     ${driver3}    giving
    [Teardown]    exit_driver

In_call_User_Notifications_12_13_14_15_16
    [Documentation]    When user switches its role to Help Giver
    [Tags]      In-call User Notifications 12-16 lines       call_case
    # User B log in
    ${driver2}   driver_set_up_and_logIn   ${notifications_user01}
    # User C log in
    ${driver3}   driver_set_up_and_logIn   ${notifications_user02}
    # User C与User B进行Call
    contacts_witch_page_make_call    ${driver3}   ${driver2}     ${py_team_page}      ${notifications_username01}     accept    video
    make_sure_enter_call     ${driver2}
    make_sure_enter_call     ${driver3}
    # 等待摄像头加载成功
    sleep   15
    # 进入Giver/Helper模式
    enter_giver_mode      ${driver3}     none    none     2
    # 进入Freeze模式
    image_is_frozen    ${driver3}
    # 验证It occurs when the Image is frozen and the user is not a Helper	Task field frozen.
    the_task_field_is_frozen    ${driver3}
    # 验证It occurs when the Image is frozen and the user is a Helper	Task field frozen.
    the_task_field_is_frozen    ${driver2}
    # 进入video模式
    image_is_unfrozen    ${driver3}
    # 验证It occurs when the image is unfrozen and the user is a Helper	Task field unfrozen.
    the_task_field_is_unfrozen    ${driver2}
    # 验证It occurs when the image is unfrozen and the user is not a Helper	Task field unfrozen.
    the_task_field_is_unfrozen    ${driver3}
    # 验证It occurs when you change from the image freeze mode	Task field unfrozen.
    the_task_field_is_unfrozen    ${driver3}
    [Teardown]    exit_driver

