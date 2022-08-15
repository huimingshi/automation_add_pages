*** Settings ***
Library           Selenium2Library
Library           OperatingSystem
Resource          ../../Lib/calls_resource.robot
Resource          ../../Lib/public.robot
Resource          ../../Lib/deletion_of_a_recordings_and_screen_captures_resource.robot
Library           make_a_call_lib.py

*** Test Cases ***
logs_in_Citron_as_Group_admin
    [Documentation]    logs in Citron as Group admin
    [Tags]    Citron 308-314     call_case      有bug：https://vipaar.atlassian.net/browse/CITRON-3546
    [Setup]  delete_all_jpg_and_jpeg_picture
    # Start two drivers and logIn
    ${driver1}   driver_set_up_and_logIn    ${group_admin_username}
    ${driver2}   driver_set_up_and_logIn    ${normal_username_for_calls}
    # Make a call
    contacts_witch_page_make_call   ${driver1}   ${driver2}   ${py_team_page}   ${normal_username_for_calls_name}
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
    ...         AND           Close
    ...         AND           exit_drivers
    ...         AND           exit_drivers   ${driver1}  ${driver2}

logs_in_Citron_as_Normal_User
    [Documentation]    logs in Citron as Normal admin
    [Tags]    Citron 315        call_case      有bug：https://vipaar.atlassian.net/browse/CITRON-3546
    [Setup]  delete_all_jpg_and_jpeg_picture
    # Start two drivers and logIn
    ${driver1}   driver_set_up_and_logIn    ${normal_username_for_calls}
    ${driver2}   driver_set_up_and_logIn    ${normal_username_for_calls_B}
    # Make a call
    contacts_witch_page_make_call   ${driver1}   ${driver2}   ${py_team_page}  ${normal_name_for_calls_B}
    # logs in Citron as Site admin
    Login_normal_for_calls
    # Administration ->Calls
    enter_normal_recents
    # select one call that has Screen Capture
    normal_user_select_one_call_has_screen_capture
    # delete menu is not visible
    delete_menu_is_not_visible
    [Teardown]  Run Keywords  delete_all_jpg_and_jpeg_picture
    ...         AND           Close
    ...         AND           exit_drivers
#    ...         AND           exit_drivers   ${driver1}  ${driver2}

#logs_in_Citron_as_Site_admin
#    [Documentation]    logs in Citron as Site admin
#    [Tags]    Citron 294-300,     有bug，https://vipaar.atlassian.net/browse/CITRON-3191，    Site admin没有delete screen capture 的权限      call_case
#    [Setup]  delete_all_jpg_and_jpeg_picture
#    # Start two drivers and logIn
#    ${driver1}   driver_set_up_and_logIn    ${site_admin_email}
#    ${driver2}   driver_set_up_and_logIn    ${group_admin_email}
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
#    [Teardown]  Run Keywords  delete_all_jpg_and_jpeg_pictur
#    ...         AND           Close
#    ...         AND           exit_drivers
##    ...         AND           exit_drivers   ${driver1}  ${driver2}

logs_in_Citron_as_Workspace_admin
    [Documentation]    logs in Citron as Workspace admin
    [Tags]    Citron 301-307     call_case      有bug：https://vipaar.atlassian.net/browse/CITRON-3546
    [Setup]  delete_all_jpg_and_jpeg_picture
    # Start two drivers and logIn
    ${driver1}   driver_set_up_and_logIn    ${workspace_admin_username}
    ${driver2}   driver_set_up_and_logIn    ${normal_username_for_calls}
    # Make a call
    contacts_witch_page_make_call   ${driver1}   ${driver2}  ${py_team_page}  ${normal_username_for_calls_name}

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
    ...         AND           Close
    ...         AND           exit_drivers
#    ...         AND           exit_drivers   ${driver1}  ${driver2}