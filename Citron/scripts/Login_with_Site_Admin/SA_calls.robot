*** Settings ***
Library           Selenium2Library
Library           OperatingSystem
Resource          ../../Lib/login_with_site_admin_resource.robot
Resource          ../../Lib/public.robot


*** Test Cases ***
Site_Admin_Click_Share_this_filter_button_And_Select_Export_current_button
    [Documentation]    Click ' Share this filter' button And Select Export current table
    [Tags]    Click ' Share this filter' button And Select Export current table
    [Setup]   run keywords   check_file_if_exists_delete     # Check whether there are existing files in the path and delete them if there are
    ...       AND            Login_workspaces_admin       # log in with Workspace admin
    ...       AND            enter_workspace_workspace_settings     # enter workspace settings
    ...       AND            make_sure_tagging_and_comments_setting_open    # make sure After Call: Tagging and Comments setting is open
    # log in with site admin
    Login_site_admin
    # enter SITE ADMINISTRATION Calls page
    enter_site_calls
    # Click ' Share this filter' button
    calls_share_this_filter
    # Click 'Export Current Table' button
    calls_export_current_table
    # the values of Owner, Owner Email, Participants, workspace, Occurred, End Status, Duration & tags are correct.
    calls_check_cloumns_workspaces_tab
    [Teardown]    Run Keywords    check_file_if_exists_delete   # Check whether there are existing files in the path and delete them if there are
    ...           AND             Close

#Site_Admin_Click_Share_this_filter_button_And_Select_Generate_New_Call_Report
#    [Documentation]    Click ' Share this filter' button And Select Generate New Call Report
#    [Tags]    Click ' Share this filter' button And Select Generate New Call Report
#    [Setup]   delete_zip_and_csv_file     # Check whether there are existing files in the path and delete them if there are
#    # log in with site admin
#    Login_site_admin
#    # enter SITE ADMINISTRATION Calls page
#    enter_site_calls
#    # Click 'Generate New Call Report' button
#    create_new_call_report
#    # the values of Owner, Owner Email, Participants, workspace, Occurred, End Status, Duration & tags are correct.
#    check_zip_report_file_data
#    [Teardown]    Run Keywords   delete_zip_and_csv_file   # Check whether there are existing files in the path and delete them if there are
#    ...           AND            Close

Site_Admin_Calls_select_by_different_conditions
    [Documentation]     Site Admin Calls select by different conditions
    [Tags]     Site Admin Calls select by different conditions
    # log in with site admin
    Login_premium_user
    # enter SITE ADMINISTRATION Calls page
    enter_site_calls
    # Select one of value in 'Page Size'
    select_one_of_value_in_page_size
    # Enter key words in Search field
    enter_key_words_in_search_field
    # Select 'All workspace' in workspace field
    select_all_workspace_in_workspace_field
    [Teardown]    Close

Select_1_workspace_that_has_set_call_tag_And_comment_feature_is_ON_or_OFF
    [Documentation]     Select 1 workspace that has set call tag & comment feature = ON or OFF
    [Tags]     Select 1 workspace that has set call tag & comment feature = ON or OFF
    # log in with site admin
    Login_site_admin
    # enter SITE ADMINISTRATION Calls page
    enter_site_workspace_settings
    # set call tag & comment feature = OFF
    tag_column_should_not_be_shown_up
    # set call tag & comment feature = ON
    tag_column_should_be_shown_up
    [Teardown]    Close

Site_Admin_Sort_records
    [Documentation]     Site Admin Sort records.
    [Tags]     Site Admin Sort records.
    # log in with site admin
    Login_site_admin
    # enter SITE ADMINISTRATION Calls page
    enter_site_calls
    # Sort By owner
    sort_calls_by_different_condition      ${sort_by_owner}   owner_name
    # Sort By owner email
    sort_calls_by_different_condition      ${sort_by_owner_email}   owner_email
    # Sort By participants
    sort_calls_by_different_condition      ${sort_by_participants}  participants
    # Sort By workspace
    sort_calls_by_different_condition      ${sort_by_workspace}     workspaceString
    # Sort By occurred
    sort_calls_by_occurred
    # Sort By end status
    sort_calls_by_different_condition      ${sort_by_end_status}    reasonCallEnded
    # Sort By duration
    sort_calls_by_different_condition      ${sort_by_duration}  callDuration
    # Sort By tags
    sort_calls_by_different_condition      ${sort_by_tags}  tags
    [Teardown]    Close