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
    ${driver1}   driver_set_up_and_logIn    ${normal_username_for_calls}
    ${driver2}   driver_set_up_and_logIn    ${normal_username_for_calls_B}
    # make call
    contacts_witch_page_make_call   ${driver2}   ${driver1}   ${py_team_page}    ${normal_username_for_calls_name}
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
    ${driver1}   driver_set_up_and_logIn    ${normal_username_for_calls}
    ${driver2}   driver_set_up_and_logIn    ${normal_username_for_calls_B}
    # make call
    contacts_witch_page_make_call   ${driver2}   ${driver1}   ${py_team_page}    ${normal_username_for_calls_name}
    # 确保进入通话
    make_sure_enter_call      ${driver1}
    # 选择helper，进入giver/helper模式
    enter_giver_mode   ${driver1}    None   None   2   has_dialog   give
    # 进入Document模式，上传PDF      验证It occurs when you aren't the Helper and are sharing a document
    giver_share_a_document     ${driver1}    ${load_test_pdf}
    # 点击Clear Shared Content按钮，回到初始状态      验证It occurs when the share document mode ends.
    click_clear_shared_content      ${driver1}
    # 点击Share a photo按钮        验证It occurs when you aren't the Helper and are sharing a picture
    click_share_a_photo     ${driver1}    ${load_test_jpg}
    [Teardown]   exit_driver

In_call_User_Notifications_9_10_11
    [Documentation]    It occurs when you change from the image mode and it tells for the Helper, tha it return to Help Mode
    [Tags]      In-call User Notifications 9-11 lines       call_case
    # User B log in
    ${driver2}   driver_set_up_and_logIn   ${big_admin_third_WS_username}
    # User C log in
    ${driver3}   driver_set_up_and_logIn   ${switch_workspace_username}
    # User C与User B进行Call
    contacts_witch_page_make_call    ${driver3}   ${driver2}     ${py_team_page}      ${big_admin_third_WS_name}
    make_sure_enter_call    ${driver3}
    # User A log in
    ${driver1}   driver_set_up_and_logIn   ${big_admin_first_WS_username}
    # User C 进入到邀请第三位用户进入call 的页面，并查询User A
    enter_contacts_search_user   ${driver3}   ${big_admin_first_WS_name}
    # 点击查询到的User A
    click_user_in_contacts_call   ${driver3}   ${big_admin_first_WS_name}
    # User A 接收打进来的Call
    user_anwser_call   ${driver1}
    make_sure_enter_call    ${driver1}
    # 进入进入giver/helper模式
    enter_giver_mode     ${driver3}    ${switch_workspace_name}    ${big_admin_third_WS_name}      3
    # 点击Share a photo按钮，上传jpg图片
    click_share_a_photo     ${driver3}    ${load_test_jpg}
    # 点击Clear Shared Content按钮，回到初始状态      验证It occurs when you change from the image mode and it tells for the Helper, tha it return to Help Mode
    click_clear_shared_content      ${driver3}      photo
    # It occurs when you change from the image mode and it tells for the Receiver, that it return to Receive help
    exiting_photo_mode_show       ${driver2}
    # It occurs when you change from the image mode and it tells for Observers, that it return to be an Observer
    exiting_photo_mode_show       ${driver1}
    [Teardown]    exit_driver