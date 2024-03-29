*** Settings ***
Library           Selenium2Library
Library           OperatingSystem
Resource          ../../Lib/public.robot
Resource          ../../Lib/deletion_of_a_recordings_and_screen_captures_resource.robot
Library           make_a_call_lib.py

*** Test Cases ***
logs_in_Citron_as_Group_admin
    [Documentation]    logs in Citron as Group admin
    [Tags]    logs in Citron as Group admin
    [Setup]  delete_all_jpg_and_jpeg_picture
    # Start two drivers and logIn
    ${driver1}   driver_set_up_and_logIn    ${group_admin_username}           10
    ${driver2}   driver_set_up_and_logIn    ${normal_username_for_calls}      10
    # Make a call
    make_calls_with_who   ${driver1}   ${driver2}   ${normal_username_for_calls}   ${call_time}
    # logs in Citron as Site admin
    Login_group_admin
    # Administration ->Calls
    enter_group_calls
    # select one call that has Screen Capture
    select_one_call_has_screen_capture    ${normal_usernameA_for_calls}
    # click Delete button
    check_delete_screen_capture

    # log in with crunch site admin
    Login_crunch
    # enter crunch Audit Logs page
    enter_enterprises_audit_log
    # User who deleted an Screen Capture should be recorded.
    delete_record_in_crunch_is_correct    User citron_group_admin (56528) deletes incall attachment from Enterprise (auto_default_workspace).
    [Teardown]  Run Keywords  delete_all_jpg_and_jpeg_picture
    ...         AND           exit_drivers   ${driver1}  ${driver2}
    ...         AND           Close

logs_in_Citron_as_Normal_User
    [Documentation]    logs in Citron as Normal admin
    [Tags]    logs in Citron as Normal admin
    [Setup]  delete_all_jpg_and_jpeg_picture
    # Start two drivers and logIn
    ${driver1}   driver_set_up_and_logIn    ${normal_username_for_calls}   10
    ${driver2}   driver_set_up_and_logIn    ${normal_username_for_calls_B}   10
    # Make a call
    make_calls_with_who   ${driver1}   ${driver2}   ${normal_username_for_calls_B}   ${call_time}
    # logs in Citron as Site admin
    Login_normal_for_calls
    # Administration ->Calls
    enter_normal_recents
    # select one call that has Screen Capture
    normal_user_select_one_call_has_screen_capture
    # delete menu is not visible
    delete_menu_is_not_visible
    [Teardown]  Run Keywords  delete_all_jpg_and_jpeg_picture
    ...         AND           exit_drivers   ${driver1}  ${driver2}
    ...         AND           Close

#logs_in_Citron_as_Site_admin
#    [Documentation]    logs in Citron as Site admin
#    [Tags]    logs in Citron as Site admin,有bug，CITRON-3191，Site admin没有delete screen capture 的权限
#    [Setup]  delete_all_jpg_and_jpeg_picture
#    # Start two drivers and logIn
#    ${driver1}   driver_set_up_and_logIn    ${site_admin_email}   10
#    ${driver2}   driver_set_up_and_logIn    ${group_admin_email}   10
#    # Make a call
#    make_calls_with_who   ${driver1}   ${driver2}   ${group_admin_email}   ${call_time}
#    # logs in Citron as Site admin
#    Login_site_admin
#    # Administration ->Calls
#    enter_site_calls
#    # select one call that has Screen Capture
#    select_one_call_has_screen_capture    ${site_admin_email}
#    # click Delete button
#    check_delete_screen_capture
#
#    # log in with crunch site admin
#    Login_crunch
#    # enter crunch Audit Logs page
#    enter_enterprises_audit_log
#    # User who deleted an Screen Capture should be recorded.
#    delete_record_in_crunch_is_correct    User huiming.shi (56404) deletes incall attachment from Enterprise (auto_default_workspace).
#    [Teardown]  Run Keywords  delete_all_jpg_and_jpeg_picture
#    ...         AND           exit_drivers   ${driver1}  ${driver2}
#    ...         AND           Close

logs_in_Citron_as_Workspace_admin
    [Documentation]    logs in Citron as Workspace admin
    [Tags]    logs in Citron as Workspace admin
    [Setup]  delete_all_jpg_and_jpeg_picture
    # Start two drivers and logIn
    ${driver1}   driver_set_up_and_logIn    ${workspace_admin_username}    10
    ${driver2}   driver_set_up_and_logIn    ${normal_username_for_calls}   10
    # Make a call
    make_calls_with_who   ${driver1}   ${driver2}   ${normal_username_for_calls}   ${call_time}

    # logs in Citron as Site admin
    Login_workspaces_admin
    # Administration ->Calls
    enter_workspace_calls
    # select one call that has Screen Capture
    select_one_call_has_screen_capture    ${normal_usernameA_for_calls}
    # click Delete button
    check_delete_screen_capture

    # log in with crunch site admin
    Login_crunch
    # enter crunch Audit Logs page
    enter_enterprises_audit_log
    # User who deleted an Screen Capture should be recorded.
    delete_record_in_crunch_is_correct    User citron (56213) deletes incall attachment from Enterprise (auto_default_workspace).
    [Teardown]  Run Keywords  delete_all_jpg_and_jpeg_picture
    ...         AND           exit_drivers   ${driver1}  ${driver2}
    ...         AND           Close