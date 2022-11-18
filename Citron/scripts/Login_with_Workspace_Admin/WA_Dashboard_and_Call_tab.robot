*** Settings ***
Library           Selenium2Library
Library           OperatingSystem
Resource          ../../Lib/login_with_workspace_admin_resource.robot
Resource          ../../Lib/public.robot


*** Test Cases ***
Workspace_Admin_analytics_shows_groups_drop_down_list
    [Documentation]    Shows groups drop down list with all groups of this workspace.
    [Tags]    Shows groups drop down list with all groups of this workspace.
    # log in with workspaces admin
    Login_new_added_user   ${workspace_admin_username_two}
    # enter workspace groups
    enter_workspace_groups
    # get groups groups text
    ${get_groups_groups_list}   get_groups_groups_text
    # enter workspace analytics
    enter_workspace_analytics
    # get dashboard groups text
    ${get_dashboard_groups_list}   get_dashboard_groups_text
    # Shows groups drop down list with all groups of this workspace.
    lists_should_be_same  ${get_dashboard_groups_list}   ${get_groups_groups_list}
    [Teardown]    Close

Workspace_Admin_analytics_choose_one_group_then_clear
    [Documentation]    Shows groups drop down list with all groups of this workspace.
    [Tags]    Shows groups drop down list with all groups of this workspace.
    # log in with workspaces admin
    Login_new_added_user   ${workspace_admin_username_two}
    # enter workspace analytics
    enter_workspace_analytics
    # Choose one group then clear
    analytics_choose_one_group_then_clear
    [Teardown]    Close

Workspace_Admin_analytics_groups_drop_down_list_should_be_hidden
    [Documentation]    Groups drop down list should be hidden.
    [Tags]    Groups drop down list should be hidden.
    # log in with workspaces admin
    Login_workspaces_admin_one
    # enter workspace analytics
    enter_workspace_analytics
    # Groups drop down list should be hidden.
    should_be_hidden
    [Teardown]    Close

Workspace_Admin_calls_shows_groups_drop_down_list
    [Documentation]    Shows groups drop down list with all groups of this workspace.
    [Tags]    Shows groups drop down list with all groups of this workspace.
    # log in with workspaces admin
    Login_new_added_user   ${workspace_admin_username_two}
    # enter workspace groups
    enter_workspace_groups
    # get groups groups text
    ${get_groups_groups_list}   get_groups_groups_text
    # enter workspace calls
    enter_workspace_calls
    # get dashboard groups text
    ${get_dashboard_groups_list}   get_dashboard_groups_text
    # Shows groups drop down list with all groups of this workspace.
    lists_should_be_same  ${get_dashboard_groups_list}   ${get_groups_groups_list}
    [Teardown]    Close

Workspace_Admin_calls_choose_one_group_then_clear
    [Documentation]    Shows groups drop down list with all groups of this workspace.
    [Tags]    Shows groups drop down list with all groups of this workspace.
    # log in with workspaces admin
    Login_workspaces_admin
    # enter workspace calls
    enter_workspace_calls
    # choose Last 2 weeks
    choose_last_2_weeks
    # Choose one group then clear
    calls_choose_one_group_then_clear
    [Teardown]    Close

Workspace_Admin_calls_groups_drop_down_list_should_be_hidden
    [Documentation]    Groups drop down list should be hidden.
    [Tags]    Groups drop down list should be hidden.
    # log in with workspaces admin
    Login_workspaces_admin_one
    # enter workspace calls
    enter_workspace_calls
    # Groups drop down list should be hidden.
    should_be_hidden
    [Teardown]    Close

Workspace_Admin_calls_list_export
    [Documentation]    Click on Export button
    [Tags]   Click on Export button
    # log in with workspaces admin
    Login_workspaces_admin_one
    # enter workspace calls
    enter_workspace_calls
    # click Export button
    click_export_button
    [Teardown]    Close

#Workspace_Admin_view_call_details
#    [Documentation]    View call details
#    [Tags]   View call details    有bug：https://vipaar.atlassian.net/browse/CITRON-3626
#    # log in with workspaces admin
#    Login_workspaces_admin
#    # enter workspace calls
#    enter_workspace_calls
#    # choose Last 365 Days
#    choose_last_365_days
#    # Add tag and comments
#    add_tag_and_comments
#    # update tags
#    update_tags
#    # delete tags
#    delete_tags
#    [Teardown]    Close