*** Settings ***
Library           Selenium2Library
Library           OperatingSystem
Resource          ../../Lib/login_with_group_admin_resource.robot
Resource          ../../Lib/public.robot


*** Test Cases ***
Group_Admin_only_display_deactivated_users_under_GA_group
    [Documentation]    only display deactivated users under GA’s group.
    [Tags]    有bug，CITRON-3146；已修复
    # log in with workspaces admin
    Login_workspaces_admin
    # enter workspace users
    enter_workspace_users
    # Getting the Group Admin for
    ${group_admin_for}    get_group_admin_for
    # close browser
    Close
    # log in with group admin
    Login_group_admin
    # enter group users
    enter_group_users
    # enter Deactivated Users page
    enter_deactivated_users_page
    # only display deactivated users under GA’s group.
    display_deactivated_users   ${group_admin_for}
    [Teardown]  Close