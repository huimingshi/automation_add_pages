*** Settings ***
Library           Selenium2Library
Library           OperatingSystem
Resource          ../../Lib/login_with_workspace_admin_resource.robot
Resource          ../../Lib/public.robot


*** Test Cases ***
Workspace_Admin_deactivated_tab_sort_records
    [Documentation]    Sort records.
    [Tags]    Sort records.
    # log in with workspaces admin
    Login_workspaces_admin
    # enter workspace users
    enter_workspace_users
    # enter Deactivated Users page
    enter_deactivated_users_page
    # Sort records By Email
    sort_list_by_email
    # Sort records By name
    sort_list_by_name
    # Sort records By role
    sort_list_by_role_in_deactive
    [Teardown]    Close

Workspace_Admin_only_display_deactivated_users_under_this_workspace
    [Documentation]     only display deactivated users under this workspace
    [Tags]     only display deactivated users under this workspace
    # log in with workspaces admin
    Login_new_added_user   ${workspace_admin_username_two}
    # enter workspace users
    enter_workspace_users
    # enter Deactivated Users page
    enter_deactivated_users_page
    # only display deactivated users under this workspace
    display_deactivated_users
    [Teardown]    Close