*** Settings ***
Library           Selenium2Library
Library           OperatingSystem
Resource          ../../Lib/login_with_site_admin_resource.robot
Resource          ../../Lib/public.robot


*** Test Cases ***
Site_Admin_Dashboard
    [Documentation]     Site Admin Dashboard
    [Tags]     Site Admin Dashboard
    # log in with site admin
    Login_premium_user
    # enter SITE ADMINISTRATION Analytics page
    enter_site_analytics
    # widgets: Calls by Groups, Tag Ranking, Call Volume, Average Time on Call, Completed Calls, Users
    display_six_widgets
#    # Select 1 workspace
#    select_1_workspace   BigAdmin Premium
#    # Select 'All Workspaces'
#    select_all_workspaces
#    # Select a specific WS
#    select_1_workspace   Canada
#    # Select 'All Workspaces'
#    select_all_workspaces
#    # Occurred Within
#    occurred_within
    [Teardown]    Close