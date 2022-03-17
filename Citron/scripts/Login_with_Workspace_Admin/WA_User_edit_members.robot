*** Settings ***
Library           Selenium2Library
Library           OperatingSystem
Resource          ../../Lib/login_with_workspace_admin_resource.robot
Resource          ../../Lib/public.robot


*** Test Cases ***
Workspace_Admin_search_users
    [Documentation]    Search users
    [Tags]    Search users
    # log in with workspaces admin
    Login_workspaces_admin
    # enter workspace users
    enter_workspace_users
    # enter edit members page
    enter_edit_members_page
    # search users in edit members
    search_users_in_edit_members
    [Teardown]    Close

Workspace_Admin_add_more_users
    [Documentation]    Add more users
    [Tags]    Add more users
    # log in with workspaces admin
    Login_workspaces_admin
    # enter workspace users
    enter_workspace_users
    # enter edit members page
    enter_edit_members_page
    # add users in edit members page
    edit_to_add_users
    [Teardown]    Close

Workspace_Admin_display_all_the_users_in_the_whole_site
    [Documentation]    Add more users,Display all the users in the whole site
    [Tags]    Citron 195 line
    # log in with site admin
    Login_new_added_user    Huiming.shi.helplightning+site_admin_test@outlook.com
    # enter workspace users
    enter_workspace_users
    # Gets the number of all users
    ${count_users_2}   get_number_of_all_users
    ${var}   Set Variable    ${1}
    ${count_users_2}   Evaluate  ${count_users_2} + ${var}

    # log in with workspaces admin
    Login_new_added_user   Huiming.shi.helplightning+ws_admin_test@outlook.com
    # enter workspace users
    enter_workspace_users
    # enter edit members page
    enter_edit_members_page
    # Gets the number of all users
    ${count_users_1}   get_all_users_number
    # Display all the users in the whole site
    check_users_in_whole_site    ${count_users_1}  ${count_users_2}
    [Teardown]    Close