*** Settings ***
Library           Selenium2Library
Library           OperatingSystem
Resource          ../../Lib/login_with_workspace_admin_resource.robot
Resource          ../../Lib/public.robot


*** Test Cases ***
Workspace_Admin_group_members_show_and_search
    [Documentation]    group members show and search
    [Tags]    group members show and search
    # log in with workspaces admin
    Login_workspaces_admin
    # enter workspace groups
    enter_workspace_groups
    # check group members show
    group_members_show
    # check group members search
    group_members_search
    [Teardown]    Close

Workspace_Admin_click_on_add_more_users_button
    [Documentation]    Click on Add More Users button
    [Tags]    Click on Add More Users button
    # log in with workspaces admin
    Login_workspaces_admin
    # enter workspace groups
    enter_workspace_groups
    # add members and delete
    add_mumbers_after_del
    [Teardown]    Close

Workspace_Admin_show_all_the_users_in_this_workspace
    [Documentation]    Click on Add More Users button，show all the users in this workspace
    [Tags]    Citron 231 line
    # log in with workspaces admin
    Login_new_added_user   ${workspace_admin_test_username}
    # 进入users页面
    enter_workspace_users
    # Gets the number of all users
    ${count_users_2}   get_number_of_all_users
    # enter workspace groups
    enter_workspace_groups
    # enter edit members page
    enter_groups_edit_members_page
    # Gets the number of all users
    ${count_users_1}   get_all_users_number
    # Display all the users in the whole site
    check_users_in_whole_site    ${count_users_1}   ${count_users_2}
    [Teardown]    Close

Workspace_Admin_add_team_user_to_one_expert_group
    [Documentation]    Add Team user to one expert group
    [Tags]    Add Team user to one expert group
    # log in with workspaces admin
    Login_workspaces_admin
    # enter workspace groups
    enter_workspace_groups
    # search on-call groups
    search_on_call_groups     on-call group 1
    # enter edit members page
    enter_groups_edit_members_page
    # Add Team user to one expert group
    add_team_user_to_expert_group    Team user cannot be added to expert group
    [Teardown]    Close

Workspace_Admin_groups_search_group
    [Documentation]    Groups - search group
    [Tags]    Groups - search group
    # log in with workspaces admin
    Login_workspaces_admin
    # enter workspace groups
    enter_workspace_groups
    # search groups
    search_groups
    [Teardown]    Close

Workspace_Admin_groups_export_to_csv
    [Documentation]    Groups - export to csv
    [Tags]    Groups - export to csv
    [Setup]   check_file_if_exists_delete     # Check whether there are existing files in the path and delete them if there are
    # log in with workspaces admin
    Login_workspaces_admin
    # enter workspace groups
    enter_workspace_groups
    # enter REPORT VIEW page
    enter_REPORT_VIEW_page
    # Export to CSV
    export_to_CSV
    # Check columns
    check_cloumns_groups_tab
    [Teardown]    Run Keywords    check_file_if_exists_delete   # Check whether there are existing files in the path and delete them if there are
    ...           AND             Close