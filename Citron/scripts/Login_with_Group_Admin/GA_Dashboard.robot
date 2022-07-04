*** Settings ***
Library           Selenium2Library
Library           OperatingSystem
Resource          ../../Lib/login_with_group_admin_resource.robot
Resource          ../../Lib/public.robot


*** Test Cases ***
Group_Admin_analytics_shows_groups_drop_down_list
    [Documentation]    Shows groups drop down list with all groups of this workspace.
    [Tags]    有bug，CITRON-3128；已修复
    # log in with group admin
    Login_new_added_user    ${workspace_admin_username_two}
    # enter group groups
    enter_group_groups
    # get groups groups text
    ${get_groups_groups_list}   get_groups_groups_text
    # enter group analytics
    enter_group_analytics
    # get dashboard groups text
    ${get_dashboard_groups_list}   get_dashboard_groups_text
    # Groups drop-down should display with GA’s groups.
    lists_should_be_same  ${get_dashboard_groups_list}   ${get_groups_groups_list}
    [Teardown]    Close

#Group_Admin_analytics_choose_one_group
#    [Documentation]    Choose one group
#    [Tags]    Choose one group     有bug：https://vipaar.atlassian.net/browse/CITRON-3493
#    # log in with group admin
#    Login_new_added_user    ${group_admin_username_two}
#    # enter group analytics
#    enter_group_analytics
#    # Choose one group
#    analytics_choose_one_group
#    [Teardown]    Close

Group_Admin_analytics_groups_drop_down_list_should_be_hidden
    [Documentation]    Groups drop down list should be hidden.
    [Tags]    Groups drop down list should be hidden.
    # log in with group admin
    Login_new_added_user    ${group_admin_username_one}
    # enter workspace analytics
    enter_group_analytics
    # Groups drop down list should be hidden.
    should_be_hidden
    [Teardown]    Close