*** Settings ***
Library           Collections
Library           Selenium2Library
Library           DateTime
Library           String
Resource          public.robot
Resource          All_Pages_Xpath/crunch_page.robot
Resource          All_Pages_Xpath/WS_Admin/Workspace_Settings.robot
Resource          All_Pages_Xpath/public_xpath.robot
Library           python_Lib/ui_keywords.py


*** Keywords ***
enter_workspace_settings_page
    # enter Workspace Settings page
    click element   ${enter_workspace_menu}
    wait until element is visible      ${enter_Workspace_settings}
    click element    ${enter_Workspace_settings}
    wait until element is visible      ${enter_ws_settings_success}     20s

enter_enterprises_audit_log
    # enter crunch Audit Logs page
    click element    ${audit_log_menu}
    FOR   ${i}    IN RANGE   0    125
        ${count}    get element count     ${audit_log_table}//tr[2]
        Exit For Loop If    '${count}'=='1'
        Run Keyword If      '${count}'!='1'    sleep   1s
        Run Keyword If      '${i}'=='25'    refresh_web_page
        Run Keyword If      '${i}'=='50'    refresh_web_page
        Run Keyword If      '${i}'=='75'    refresh_web_page
        Run Keyword If      '${i}'=='100'    refresh_web_page
    END
    wait until element is visible     ${audit_log_table}//tr[2]      20s
    sleep  2s

make_sure_setting_visiable
    # make sure setting visiable
    # 滑动到底
    swipe_browser_to_bottom
    sleep  0.5s

make_sure_RaSC_text_visiable
    # make sure State text visiable
    wait until element is visible     ${RaSC_pre_xpath}//button[contains(.,'Expand')]
    click element   ${RaSC_pre_xpath}//button[contains(.,'Expand')]
    sleep  1s

set_recordings_and_screen_captures_on
    # set Recordings and Screen Captures feature = ON
    ${count}   get element count   ${RaSC_pre_xpath}//div[@class="react-toggle"]
    Run Keyword If   '${count}'=='1'    click element   ${RaSC_switch_button}
    sleep  2s
    ${text}   get text  ${RaSC_pre_xpath}//div[@class="retention-options"]/span[1]
    should be equal as strings    ${text}   ${RaSC_on_status_text}

set_recordings_and_screen_captures_off
    # set Recordings and Screen Captures feature = OFF
    ${count}   get element count   ${RaSC_pre_xpath}//div[@class="react-toggle react-toggle--checked"]
    Run Keyword If   '${count}'=='1'    click element   ${RaSC_switch_button}
    wait until element is visible      ${RaSC_off_status_text_xpath}      20
    sleep   2s

ui_check_test
    # make sure setting visiable
    make_sure_setting_visiable
    # make sure State text visiable
    make_sure_RaSC_text_visiable
    sleep  1s
    # Description is correct
    ${description}   get text    ${RaSC_pre_xpath}//p[@class="feature-description"]
    should be equal as strings   ${description}   You can configure a policy that controls how long Recordings will be retained in Help Lightning. If this feature is on, then Call Recordings older than the specified age will be deleted from our system. If this feature is off, then Call Recordings will be kept for a default period of 60 days.
    # State text (disabled)
    set_recordings_and_screen_captures_off
    refresh_web_page
    # State text (enabled)
    set_recordings_and_screen_captures_on
    # Note text
    ${note_text}    get text    ${RaSC_pre_xpath}//span[@class="retention-note"]
    should be equal as strings   ${note_text}    It may take up to 48 hours for Recordings to be deleted after the policy is enabled.

enable_retention_policy_on_off_modified_record_in_crunch
    # Enabled Retention Policy for Recordings
    # make sure setting visiable
    make_sure_setting_visiable
    # set Recordings and Screen Captures feature = ON
    # make sure State text visiable
    make_sure_RaSC_text_visiable
    # Enabled Disabled Retention Policy for Recordings
    FOR   ${i}   IN RANGE   4
        click element    ${RaSC_switch_button}
        sleep  0.5s
    END

modify_record_in_crunch_is_correct
    [Arguments]   ${expect_on_log}   ${expect_off_log}
    # check modify record in crunch is correct
    @{LogList}=    Create List
    FOR   ${i}   IN RANGE   20
        ${get_log}   get text    ${audit_log_table}//tr[${i}+1]/td[5]
        Append To List    ${LogList}    ${get_log}
    END
    log  ${LogList}
    should contain   ${LogList}    ${expect_on_log}
    should contain   ${LogList}    ${expect_off_log}

set_RaSC_day_equal_to_correct
    # set day equal to a number
    [Arguments]   ${day_number}
    # Click Edit button
    wait until element is visible     ${RaSC_click_to_edit}
    click element    ${RaSC_click_to_edit}
    sleep  1s
    # set day equal to a number
    clear element text   ${RaSC_set_day}
    sleep  0.5s
    click element  ${RaSC_set_day}
    sleep  0.5s
    input text   ${RaSC_set_day}  ${day_number}
    sleep  0.5s
    click element   ${RaSC_save_button}
    sleep  1s

set_RaSC_day_equal_to_1_and_60
    # make sure setting visiable
    make_sure_setting_visiable
    # make sure State text visiable
    make_sure_RaSC_text_visiable
    # set day equal to 1
    set_RaSC_day_equal_to_correct   1
    # set day equal to 60
    set_RaSC_day_equal_to_correct   60

set_RaSC_day_equal_to_error
    # set day equal to a error number
    [Arguments]   ${day_number}   ${error_xpath}
    # set day equal to a error number
    clear element text   ${RaSC_set_day}
    sleep  0.5s
    click element  ${RaSC_set_day}
    sleep  0.5s
    input text  ${RaSC_set_day}  ${day_number}
    sleep  0.5s
    # The save button is not available
    wait until element is visible   ${error_xpath}

set_day_equal_to_0_and_366
    # make sure setting visiable
    make_sure_setting_visiable
    # make sure State text visiable
    make_sure_RaSC_text_visiable
    # Click Edit button
    click element    ${RaSC_click_to_edit}
    sleep  1s
    # set day equal to 0
    set_RaSC_day_equal_to_error   0    xpath=//button[@aria-disabled="Min value is"]
    # set day equal to 60
    set_RaSC_day_equal_to_error  366    xpath=//button[@aria-disabled="Max value is"]

make_sure_CL_text_visiable
    # make sure State text visiable
    click element   ${CL_pre_xpath}//button[contains(.,'Expand')]
    sleep  1s

set_CL_day_equal_to_correct
    # set day equal to a number
    [Arguments]   ${day_number}
    # Click Edit button
    click element    ${CL_click_to_edit}
    sleep  1s
    # set day equal to a number
    clear element text   ${CL_set_day}
    sleep  0.5s
    click element  ${CL_set_day}
    sleep  0.5s
    input text   ${CL_set_day}  ${day_number}
    sleep  0.5s
    click element   ${CL_save_button}
    sleep  1s

check_RaSC_value_correct
    # the RASC value still correct
    [Arguments]   ${day_number}
    click element   ${RaSC_click_to_edit}
    sleep  1s
    ${get_day}   get element attribute   ${RaSC_set_day}  value
    should be equal as strings  ${day_number}  ${get_day}
    click element   ${RaSC_cancel_button}
    sleep  1s

check_CL_value_correct
    # the CL value still correct
    [Arguments]   ${day_number}
    click element   ${CL_click_to_edit}
    sleep  1s
    ${get_day}   get element attribute   ${CL_set_day}  value
    should be equal as strings  ${day_number}  ${get_day}
    click element   ${CL_cancel_button}
    sleep  1s

all_modify_records_in_crunch_is_correct
    # check modify record in crunch is correct
    @{LogList}=    Create List
    FOR   ${i}   IN RANGE   20
        ${get_log}   get text    ${audit_log_table}//tr[${i}+1]/td[5]
        Append To List    ${LogList}    ${get_log}
    END
    log  ${LogList}
#    should contain   ${LogList}   User Huiming.shi.helplightning+99998888 (56469) updated Enterprise work_space_for_auto_test_only_one_groups (6258) property 'recording_retention_days' to '99'.
    should contain   ${LogList}   User Huiming.shi.helplightning+99998888 (56469) updated Enterprise work_space_for_auto_test_only_one_groups (6258) property 'retention_policy_days' to '1088'.
#    should contain   ${LogList}   User Huiming.shi.helplightning+99998888 (56469) updated Enterprise work_space_for_auto_test_only_one_groups (6258) property 'retention_policy_days' to '365'.
#    should contain   ${LogList}   User Huiming.shi.helplightning+99998888 (56469) updated Enterprise work_space_for_auto_test_only_one_groups (6258) property 'recording_retention_days' to '1'.

fill_RaSC_day_for_restore
    # set day equal to a number
    clear element text   ${RaSC_set_day}
    sleep  0.5s
    click element  ${RaSC_set_day}
    sleep  0.5s
    input text   ${RaSC_set_day}  60
    sleep  0.5s
    click element   ${RaSC_save_button}
    sleep  1s

fill_CL_day_for_restore
    # set day equal to a number
    clear element text   ${CL_set_day}
    sleep  0.5s
    click element  ${CL_set_day}
    sleep  0.5s
    input text   ${CL_set_day}  365
    sleep  0.5s
    click element   ${CL_save_button}
    sleep  1s

restore_the_settings_to_the_initial_value
    # Restores the Settings to the initial value
    # log in with workspaces admin
    Login_workspaces_admin_one
    # enter Workspace Settings page
    enter_workspace_settings_page
    # make sure setting visiable
    make_sure_setting_visiable
    # make sure Retention Policy: Recordings and Screen Captures State text visiable
    make_sure_RaSC_text_visiable
    # Click Edit button
    click element    ${RaSC_click_to_edit}
    sleep  1s
    # set day equal to a number
    ${RaSC_value}  get element attribute   ${RaSC_set_day}  value
    Run Keyword If   '${RaSC_value}'=='60'    click element   ${RaSC_cancel_button}
    ...  ELSE IF   '${RaSC_value}'!='60'   fill_RaSC_day_for_restore
    sleep  1s
    # make sure Retention Policy: Call Logs State text visiable
    make_sure_CL_text_visiable
    # Click Edit button
    click element    ${CL_click_to_edit}
    sleep  1s
    # set day equal to a number
    ${CL_value}  get element attribute   ${CL_set_day}  value
    Run Keyword If   '${CL_value}'=='365'    click element   ${RaSC_cancel_button}
    ...  ELSE IF   '${RaSC_value}'!='365'   fill_CL_day_for_restore
    sleep  1s
    # close brower
    Close