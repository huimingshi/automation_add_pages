*** Settings ***
Library           Selenium2Library
Library           OperatingSystem
Resource          ../../../Lib/public.robot
Library           Call_case_which_can_not_load_rf_ib.py

*** Test Cases ***
Calls_filter_by_duration_greater_than_60_test
    [Documentation]    filter by duration (greater than 60)
    [Tags]    filter by duration (greater than 60)
    # log in with workspace admin
    ${driver}   log_in_lib   ${workspace_admin_username}    ${workspace_admin_password}
    # 进入到Calls页面
    enter_calls_page   ${driver}
    # 切换到last_365_days
    switch_last_365_days   ${driver}
    # filter by duration (greater than 60)
    filter_by_duration_greater_than_60_second   ${driver}
    # check result after filter by duration
    ${result}  check_greater_than_60  ${driver}
    [Teardown]   exit_this_driver   ${driver}

Site_Admin_Calls_Select_one_of_value_in_Occurred_Within_field
    [Documentation]    Select one of value in 'Occurred Within' field
    [Tags]    Select one of value in 'Occurred Within' field
    # log in with workspace admin
    ${driver}   log_in_lib    ${site_admin_username}    ${site_admin_password}
    # 进入到Calls页面
    enter_calls_page   ${driver}    3
    # 切换到last_365_days
    switch_last_365_days   ${driver}
    # Select one of value in 'Occurred Within' field
    select_one_of_value   ${driver}
    [Teardown]   exit_this_driver   ${driver}

Calls_Click_call_tag_link_to_filter_call
    [Documentation]    Click call tag link to filter call
    [Tags]    Click call tag link to filter call
    # log in with workspace admin
    ${driver}   log_in_lib    ${workspace_admin_username}    ${workspace_admin_password}
    # make sure After Call: Tagging and Comments status correct
    make_sure_TaC_status_correct   ${driver}   open_TaC
    # 进入到Calls页面
    enter_calls_page   ${driver}    2
    # 切换到last_365_days
    switch_last_365_days   ${driver}
    # filter by tag
    click_call_tag_link_to_filter_call   ${driver}
    # check result after filter by tag
    ${result}  check_filter_by_tag   ${driver}
    [Teardown]   exit_this_driver   ${driver}

Calls_filter_by_dialer
    [Documentation]    filter by dialer
    [Tags]    filter by dialer
    # log in with workspace admin
    ${driver}   log_in_lib   ${workspace_admin_username}    ${workspace_admin_password}
    # 进入到Calls页面
    enter_calls_page   ${driver}    2
    # 切换到last_365_days
    switch_last_365_days   ${driver}
    # filter by dialer/participant
    filter_by_different_fields   ${driver}    1    Huiming.shi.helplightning+123456789    owner_name
    [Teardown]   exit_this_driver   ${driver}

Calls_filter_by_participant
    [Documentation]    filter by participant
    [Tags]    filter by participant
    # log in with workspace admin
    ${driver}   log_in_lib     ${workspace_admin_username}    ${workspace_admin_password}
    # 进入到Calls页面
    enter_calls_page   ${driver}    2
    # 切换到last_365_days
    switch_last_365_days   ${driver}
    # filter by dialer/participant
    filter_by_different_fields   ${driver}    3    Huiming.shi.helplightning+123456789    participants
    [Teardown]   exit_this_driver   ${driver}

Calls_filter_owner_email
    [Documentation]    filter by dialer email
    [Tags]    filter by dialer email
    # log in with workspace admin
    ${driver}     log_in_lib     ${workspace_admin_username}    ${workspace_admin_password}
    # 进入到Calls页面
    enter_calls_page   ${driver}    2
    # 切换到last_365_days
    switch_last_365_days   ${driver}
    # filter by dialer/participant
    filter_by_different_fields   ${driver}    2    Huiming.shi.helplightning+123456789@outlook.com    owner_email
    [Teardown]   exit_this_driver   ${driver}

Calls_filter_groups
    [Documentation]    filter by groups
    [Tags]    filter by groups
    # log in with workspace admin
    ${driver}   log_in_lib     ${workspace_admin_username}    ${workspace_admin_password}
    # 进入到Calls页面
    enter_calls_page   ${driver}    2
    # 切换到last_365_days
    switch_last_365_days   ${driver}
    # filter by dialer/participant
    filter_by_different_fields   ${driver}    4    on-call group 2      groupsString
    [Teardown]   exit_this_driver   ${driver}