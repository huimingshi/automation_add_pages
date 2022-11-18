*** Settings ***
Library           Selenium2Library
Library           OperatingSystem
Resource          ../../Lib/login_with_group_admin_resource.robot
Resource          ../../Lib/public.robot


*** Test Cases ***
Only_display_records_from_users_in_the_groups_that_group_admin_manages
    [Documentation]    Only display records from users in the groups that group admin manages
    [Tags]    Only display records from users in the groups that group admin manages
    # log in with group admin
    Login_another_group_admin
    # enter group calls
    enter_group_calls
    # choose last 365 days
    choose_last_365_days
    # Only display records from users in the groups that group admin manages
    only_display_calls_records_from_users
    [Teardown]    Close

Group_Aamin_GA_only_has_multiple_groups
    [Documentation]    GA only has multiple groups
    [Tags]    GA only has multiple groups
    # log in with group admin
    Login_new_added_user    ${workspace_admin_username_two}
    # enter group groups
    enter_group_groups
    # get groups groups text
    ${get_groups_groups_list}   get_groups_groups_text
    # enter group calls
    enter_group_calls
    # get calls groups text
    ${get_calls_groups_list}   get_calls_groups_text
    # Groups drop-down should display with GA’s groups.
    lists_should_be_same  ${get_calls_groups_list}   ${get_groups_groups_list}
    [Teardown]    Close

Group_Aamin_GA_only_has_one_group
    [Documentation]    GA only has one group
    [Tags]    GA only has one group
    # log in with group admin
    Login_new_added_user    ${group_admin_username_one}
    # enter group calls
    enter_group_calls
    # Groups drop down list should be hidden.
    should_be_hidden
    [Teardown]    Close

Group_Admin_calls_list_export
    [Documentation]    Click on Export button
    [Tags]   Click on Export button
    # log in with group admin
    Login_group_admin
    # enter group calls
    enter_group_calls
    # click Export button
    click_export_button
    [Teardown]    Close

#Group_Admin_view_call_details
#    [Documentation]    View call details
#    [Tags]   View call details      有bug：https://vipaar.atlassian.net/browse/CITRON-3626
#    [Setup]   run keywords   Login_workspaces_admin       # log in with Workspace admin
#    ...       AND            enter_workspace_workspace_settings     # enter workspace settings
#    ...       AND            make_sure_tagging_and_comments_setting_open    # make sure After Call: Tagging and Comments setting is open
#    ...       AND            Close    # close browser
#    # log in with group admin
#    Login_group_admin
#    # enter group calls
#    enter_group_calls
#    # choose Last 365 Days
#    choose_last_365_days
#    # Add tag and comments
#    add_tag_and_comments
#    # update tags
#    update_tags
#    # delete tags
#    delete_tags
#    [Teardown]    Close