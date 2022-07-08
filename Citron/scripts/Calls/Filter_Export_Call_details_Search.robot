*** Settings ***
Library           Selenium2Library
Library           OperatingSystem
Resource          ../../Lib/calls_resource.robot
Resource          ../../Lib/public.robot


*** Test Cases ***
Calls_Export_current_table
    [Documentation]    Export current table
    [Tags]    Export current table    citron 268
    [Setup]   run keywords   check_file_if_exists_delete     # Check whether there are existing files in the path and delete them if there are
    ...       AND            Login_workspaces_admin       # log in with Workspace admin
    ...       AND            enter_workspace_settings_page     # enter workspace settings
    ...       AND            make_sure_tagging_and_comments_setting_open    # make sure After Call: Tagging and Comments setting is open
    # enter Workspace ADMINISTRATION Calls page
    enter_calls_menu
    # Click 'Export Current Table' button
    export_current_table
    # the values of Owner, Owner Email, Participants, workspace, Occurred, End Status, Duration & tags are correct.
    check_export_file_data
    [Teardown]    Run Keywords  check_file_if_exists_delete   # Check whether there are existing files in the path and delete them if there are
    ...           AND           Close

Calls_Create_new_call_report
    [Documentation]    Create new call report
    [Tags]    Create new call report     citron 269
    [Setup]   delete_zip_and_csv_file     # Check whether there are existing files in the path and delete them if there are
    # log in with Workspace admin
    Login_workspaces_admin
    # enter Workspace ADMINISTRATION Calls page
    enter_workspace_calls
    # Click 'Generate New Call Report' button
    create_new_call_report
    # the call report can be seen. And the columns are correct.(Id, Started_at, Ended_at, tags, comments, groups, Participants, dialer, status, duration)
    check_zip_report_file_data
    [Teardown]    Run Keywords   delete_zip_and_csv_file   # Check whether there are existing files in the path and delete them if there are
    ...           AND            Close

Call_details
    [Documentation]    Call details
    [Tags]    Call details；    citron 270+271
    [Setup]   run keywords   Login_workspaces_admin       # log in with Workspace admin
    ...       AND            enter_workspace_settings_page     # enter workspace settings
    ...       AND            make_sure_tagging_and_comments_setting_open    # make sure After Call: Tagging and Comments setting is open
    # enter Workspace ADMINISTRATION Calls page
    enter_calls_menu
    # Add tag and comments
    add_tag_and_comments
    # update tags
    update_tags
    # delete tags
    delete_tags
    [Teardown]   Close

Call_search
    [Documentation]    Call search
    [Tags]    Call search   citron 274
    # log in with Workspace admin
    Login_workspaces_admin
    # enter Workspace ADMINISTRATION Calls page
    enter_workspace_calls
    # search
    enter_key_words_in_search_field      default
    [Teardown]   Close

Call_Tag_drop_down_only_list_tags_belong_to_this_company
    [Documentation]    Tag drop down only list tags belong to this company
    [Tags]    Tag drop down only list tags belong to this company     citron 272
    [Setup]   run keywords   Login_workspaces_admin       # log in with Workspace admin
    ...       AND            enter_workspace_settings_page     # enter workspace settings
    ...       AND            make_sure_tagging_and_comments_setting_open    # make sure After Call: Tagging and Comments setting is open
    # enter Workspace ADMINISTRATION Calls page
    enter_calls_menu
    # Tag drop down only list tags belong to this company
    get_all_tags
    [Teardown]   Close

Modify_call_tag_from_client_case
    [Documentation]    Modify call tag from client
    [Tags]    Modify call tag from client；    citron 273
    [Setup]   run keywords   Login_workspaces_admin       # log in with Workspace admin
    ...       AND            enter_workspace_settings_page     # enter workspace settings
    ...       AND            make_sure_tagging_and_comments_setting_open    # make sure After Call: Tagging and Comments setting is open
    ...       AND            Close    # close browser
    # log in with normal user
    Login_normal_for_calls
    # enter Recents page
    enter_recents_page
    # modify call tag from client (normal user modify from web)
    ${call_started_time}   ${third_tag}    modify_call_tag_from_client
    # log in with Workspace admin
    Login_workspaces_admin
    # enter Workspace ADMINISTRATION Calls page
    enter_workspace_calls
    # check mormal user modify tag successfully
    check_mormal_user_modify_tag_successfully   ${call_started_time}   ${third_tag}
    [Teardown]   Close