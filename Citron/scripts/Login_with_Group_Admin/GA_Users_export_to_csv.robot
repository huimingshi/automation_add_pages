*** Settings ***
Library           Selenium2Library
Library           OperatingSystem
Resource          ../../Lib/login_with_group_admin_resource.robot
Resource          ../../Lib/public.robot


*** Test Cases ***
Group_Admin_active_users_tab_export_to_csv
    [Documentation]    Active users tab	Export to CSV
    [Tags]    Active users tab	Export to CSV
    [Setup]   check_file_if_exists_delete     # Check whether there are existing files in the path and delete them if there are
    # log in with group admin
    Login_group_admin
    # enter group users
    enter_group_users
    # enter REPORT VIEW page
    enter_REPORT_VIEW_page
    # Export to CSV
    export_to_CSV
    # Check columns
    check_cloumns_active_users_tab
    [Teardown]    Run Keywords   check_file_if_exists_delete   # Check whether there are existing files in the path and delete them if there are
    ...           AND            Close

Group_Admin_deactivated_users_tab_export_to_csv
    [Documentation]    Deactivated users tab	Export to CSV
    [Tags]    Deactivated users tab	Export to CSV
    [Setup]   check_file_if_exists_delete     # Check whether there are existing files in the path and delete them if there are
    # log in with group admin
    Login_group_admin
    # enter group users
    enter_group_users
    # enter Deactivated Users page
    enter_deactivated_users_page
    # Export to CSV
    export_to_CSV
    # Check columns
    check_cloumns_deactivated_users_tab
    [Teardown]    Run Keywords   check_file_if_exists_delete   # Check whether there are existing files in the path and delete them if there are
    ...           AND            Close