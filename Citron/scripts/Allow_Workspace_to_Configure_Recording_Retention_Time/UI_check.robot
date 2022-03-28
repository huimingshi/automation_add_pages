*** Settings ***
Library           Selenium2Library
Library           OperatingSystem
Resource          ../../Lib/allow_workspace_to_configure_recording_retention_time_resource.robot
Resource          ../../Lib/public.robot

*** Test Cases ***
UI_testcase
    [Documentation]    UI check
    [Tags]    UI check
#    [Setup]     restore_the_settings_to_the_initial_value
    # log in with workspaces admin
    Login_workspaces_admin_one
    # enter Workspace Settings page
    enter_workspace_settings_page
    # UI check
    ui_check_test
#    [Teardown]    Close

Enabled_Disabled_Retention_Policy_for_Recordings
    [Documentation]    Enabled Retention Policy for Recordings
    [Tags]    Enabled Retention Policy for Recordings
    # log in with workspaces admin
    Login_workspaces_admin_one
    # enter Workspace Settings page
    enter_workspace_settings_page
    # Enabled Retention Policy for Recordings
    enable_retention_policy_on_off_modified_record_in_crunch
    # close browser
    Close
    # log in with crunch site admin
    Login_crunch
    # enter crunch Audit Logs page
    enter_enterprises_audit_log
    # The message 'User who enabled policy, and date/time of the event.' should be added.
    modify_record_in_crunch_is_correct    User Huiming.shi.helplightning+99998888 (56469) updated Enterprise work_space_for_auto_test_only_one_groups (6258) and enabled feature 'recording_retention_policy'.    User Huiming.shi.helplightning+99998888 (56469) updated Enterprise work_space_for_auto_test_only_one_groups (6258) and disabled feature 'recording_retention_policy'.
    [Teardown]    Close

Click_Edit_button_set_Day_to_1
    [Documentation]    Click Edit button Set Day =1
    [Tags]    Click Edit button Set Day =1
    [Setup]   restore_the_settings_to_the_initial_value
    # log in with workspaces admin
    Login_workspaces_admin_one
    # enter Workspace Settings page
    enter_workspace_settings_page
    # Click Edit button Set Day =1 and =60
    set_RaSC_day_equal_to_1_and_60
    # close browser
    Close
    # log in with crunch site admin
    Login_crunch
    # enter crunch Audit Logs page
    enter_enterprises_audit_log
    # The message 'User who enabled policy, and date/time of the event.' should be added.
    modify_record_in_crunch_is_correct    User Huiming.shi.helplightning+99998888 (56469) updated Enterprise work_space_for_auto_test_only_one_groups (6258) property 'recording_retention_days' to '1'.    User Huiming.shi.helplightning+99998888 (56469) updated Enterprise work_space_for_auto_test_only_one_groups (6258) property 'recording_retention_days' to '60'.
    [Teardown]   Run Keywords   Close
    ...          AND            restore_the_settings_to_the_initial_value

Click_Edit_button_set_Day_to_0_and_366
    [Documentation]    Click Edit button Set Day =1
    [Tags]    Click Edit button Set Day =1
    # log in with workspaces admin
    Login_workspaces_admin_one
    # enter Workspace Settings page
    enter_workspace_settings_page
    # Click Edit button Set Day =1 and =60
    set_day_equal_to_0_and_366
    [Teardown]    Close

Turn_both_Call_Logs_and_Recordings_Screen_Captures_policies_ON
    [Documentation]    Turn both Call Logs and Recordings/Screen Captures policies ON
    [Tags]    Turn both Call Logs and Recordings/Screen Captures policies ON
    [Setup]   restore_the_settings_to_the_initial_value
    # log in with workspaces admin
    Login_workspaces_admin_one
    # enter Workspace Settings page
    enter_workspace_settings_page
    # make sure setting visiable
    make_sure_setting_visiable
    # make sure Retention Policy: Recordings and Screen Captures State text visiable
    make_sure_RaSC_text_visiable
    # Change Recordings/Screen Captures policy to 99 days.
    set_RaSC_day_equal_to_correct  99
    # make sure Retention Policy: Call Logs State text visiable
    make_sure_CL_text_visiable
    # Change Call Logs policy to 1088 days
    set_CL_day_equal_to_correct  1088
    # Open the Recording/Screen Capture policy,the value still is 99.
    check_RaSC_value_correct   99
    # Change Recordings/Screen Captures policy to 365 days.
    set_RaSC_day_equal_to_correct   365
    # Open Call logs policy, the value still is 1088.
    check_CL_value_correct   1088
    # Change Recordings/Screen Captures policy to 1 days.
    set_RaSC_day_equal_to_correct   1
    # close browser
    Close
    # log in with crunch site admin
    Login_crunch
    # enter crunch Audit Logs page
    enter_enterprises_audit_log
    # The message 'User who enabled policy, and date/time of the event.' should be added.
    all_modify_records_in_crunch_is_correct
    [Teardown]    Run Keywords   Close
    ...           AND           restore_the_settings_to_the_initial_value