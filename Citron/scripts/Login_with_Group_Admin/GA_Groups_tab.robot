*** Settings ***
Library           Selenium2Library
Library           OperatingSystem
Resource          ../../Lib/login_with_group_admin_resource.robot
Resource          ../../Lib/public.robot


*** Test Cases ***
Group_Admin_Only_show_the_groups_administered_by_the_GA
    [Documentation]    Only show the groups administered by the GA
    [Tags]    Only show the groups administered by the GA
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
    # enter group groups
    enter_group_groups
    # Only show the groups administered by the GA
    Only_show_the_groups_administered_by_the_GA   ${group_admin_for}
    # add members and delete
    add_mumbers_after_del
    [Teardown]    Close