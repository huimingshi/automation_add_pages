*** Settings ***
Library           Selenium2Library
Library           OperatingSystem
Resource          ../../Lib/calls_resource.robot
Resource          ../../Lib/public.robot

*** Keywords ***
tagging_and_comments_setting_open
    Login_workspaces_admin       # log in with Workspace admin
    enter_workspace_settings_page     # enter workspace settings
    make_sure_tagging_and_comments_setting_open    # make sure After Call: Tagging and Comments setting is open
    Close


*** Test Cases ***
Calls_Export_current_table
    [Documentation]    Export current table
    [Tags]    Export current table    citron 268
#    [Setup]   run keywords   check_file_if_exists_delete     # Check whether there are existing files in the path and delete them if there are
#    ...       AND            Login_workspaces_admin       # log in with Workspace admin
#    ...       AND            enter_workspace_settings_page     # enter workspace settings
#    ...       AND            make_sure_tagging_and_comments_setting_open    # make sure After Call: Tagging and Comments setting is open
    [Setup]   run keywords   check_file_if_exists_delete     # Check whether there are existing files in the path and delete them if there are
    ...       AND            tagging_and_comments_setting_open
    Login_workspaces_admin       # log in with Workspace admin
    enter_workspace_settings_page     # enter workspace settings
    # enter Workspace ADMINISTRATION Calls page
    enter_calls_menu
    # Click 'Export Current Table' button
    export_current_table
    # the values of Owner, Owner Email, Participants, workspace, Occurred, End Status, Duration & tags are correct.
    check_export_file_data
    [Teardown]    Run Keywords  check_file_if_exists_delete   # Check whether there are existing files in the path and delete them if there are
    ...           AND           Close

Call_details
    [Documentation]    Call details
    [Tags]    Call details；    citron 270+271        有bug：https://vipaar.atlassian.net/browse/CITRON-3626，已修复
#    [Setup]   run keywords   Login_workspaces_admin       # log in with Workspace admin
#    ...       AND            enter_workspace_settings_page     # enter workspace settings
#    ...       AND            make_sure_tagging_and_comments_setting_open    # make sure After Call: Tagging and Comments setting is open
#    因为上个case已经做了这个初始化动作了，故这个case不再执行初始化
#    [Setup]   tagging_and_comments_setting_open
    Login_workspaces_admin       # log in with Workspace admin
    enter_workspace_settings_page     # enter workspace settings
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
    [Tags]    Call search   citron 274     有bug：https://vipaar.atlassian.net/browse/CITRON-3626，已修复
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
#    [Setup]   run keywords   Login_workspaces_admin       # log in with Workspace admin
#    ...       AND            enter_workspace_settings_page     # enter workspace settings
#    ...       AND            make_sure_tagging_and_comments_setting_open    # make sure After Call: Tagging and Comments setting is open
#    因为上个case已经做了这个初始化动作了，故这个case不再执行初始化
#    [Setup]   tagging_and_comments_setting_open
    Login_workspaces_admin       # log in with Workspace admin
    enter_workspace_settings_page     # enter workspace settings
    # enter Workspace ADMINISTRATION Calls page
    enter_calls_menu
    # Tag drop down only list tags belong to this company
    get_all_tags
    [Teardown]   Close

Modify_call_tag_from_client_case
    [Documentation]    Modify call tag from client
    [Tags]    Modify call tag from client；    citron 273    有bug：https://vipaar.atlassian.net/browse/CITRON-3626，已修复
#    [Setup]   run keywords   Login_workspaces_admin       # log in with Workspace admin
#    ...       AND            enter_workspace_settings_page     # enter workspace settings
#    ...       AND            make_sure_tagging_and_comments_setting_open    # make sure After Call: Tagging and Comments setting is open
#    ...       AND            Close    # close browser
#    因为上个case已经做了这个初始化动作了，故这个case不再执行初始化
#    [Setup]   tagging_and_comments_setting_open
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