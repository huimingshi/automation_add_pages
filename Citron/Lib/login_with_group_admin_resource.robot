*** Settings ***
Library           Collections
Library           Selenium2Library
Library           DateTime
Library           String
Resource          public.robot
Resource          All_Pages_Xpath/WS_Admin/Analytics.robot
Resource          All_Pages_Xpath/WS_Admin/Calls.robot
Resource          All_Pages_Xpath/WS_Admin/Groups.robot
Resource          All_Pages_Xpath/WS_Admin/Users.robot
Resource          All_Pages_Xpath/WS_Admin/Workspace_Settings.robot
Resource          All_Pages_Xpath/public_xpath.robot
Library           python_Lib/ui_keywords.py
Library           python_Lib/obtain_outlook_email_link.py



*** Keywords ***
enter_group_users
    # click groups ADMINISTRATION page menu
    click element   ${enter_group_menu}
    sleep  0.5s
    # click Users page menu
    click element   ${enter_users}
    # Wait until the first row shows up
    wait until element is visible    ${button_add_user}
    wait until element is visible    ${first_row_shows_up}    10

enter_workspace_users
    # click workspace ADMINISTRATION page menu
    click element   ${enter_workspace_menu}
    sleep  0.5s
    # click Users page menu
    click element   ${enter_users}
    # Wait until the first row shows up
    wait until element is visible    ${button_add_user}
    wait until element is visible    ${first_row_shows_up}    10

enter_group_groups
    # click workspace ADMINISTRATION page menu
    click element   ${enter_group_menu}
    sleep  0.5s
    # click Users page menu
    click element   ${enter_groups}
    # Wait until the first row shows up
    wait until element is visible    ${switch_to_groups_success}
    wait until element is visible    ${first_row_shows_up}    10

enter_invitations_page
    # Enter Invitations page
    click element   ${invitations_page}
    wait until element is visible    ${first_data_show}   10

enter_group_analytics
    # click workspace ADMINISTRATION menu
    click element   ${enter_group_menu}
    sleep  0.5s
    # click Users page menu
    click element   ${enter_analytics}
    # Wait until Dashboard appear
    wait until element is visible    xpath=//b[contains(.,'Dashboard')]    10

enter_group_calls
    # click workspace ADMINISTRATION menu
    click element   ${enter_group_menu}
    sleep  0.5s
    # click Users page menu
    click element   ${enter_calls}
    sleep  3s

click_add_user
    # click button of add user
    wait until element is not visible  ${message_text}   20s
    click element  ${button_add_user}
    sleep  1s

enter_workspace_workspace_settings
    # click workspace ADMINISTRATION page menu
    click element   ${enter_workspace_menu}
    sleep  1s
    # click Users page menu
    click element   ${enter_Workspace_settings}
    # Wait until enter page
    wait until element is visible   ${enter_ws_settings_success}    20s
    sleep  2s

fill_basic_message
    # Enter email
    click element  ${input_email}
    sleep  0.5s
    ${random}   evaluate    int(time.time()*1000000)    time
    ${email_before}   Catenate   SEPARATOR=+   ${my_existent_email_name}  ${random}
    ${email}    Catenate   SEPARATOR=   ${email_before}    @outlook.com
    input text  ${input_email}    ${email}
    sleep  0.5s
    # Enter name
    click element  ${input_name}
    sleep  0.5s
    input text   ${input_name}   ${email_before}
    sleep  0.5s
    # Enter title
    click element   ${title_input}
    sleep  0.5s
    input text  ${title_input}   ${email_before}
    sleep  0.5s
    # Enter Location
    click element   ${location_input}
    sleep  0.5s
    input text  ${location_input}   ${email_before}
    sleep  0.5s
    [Return]   ${email_before}

fill_basic_message_choose_team_license
    # Enter email
    click element  ${input_email}
    sleep  0.5s
    ${random}   evaluate    int(time.time()*1000000)    time
    ${email_before}   Catenate   SEPARATOR=+   ${my_existent_email_name}  ${random}
    ${email}    Catenate   SEPARATOR=   ${email_before}    @outlook.com
    input text  ${input_email}    ${email}
    sleep  0.5s
    # Enter name
    click element  ${input_name}
    sleep  0.5s
    input text   ${input_name}   ${email_before}
    sleep  0.5s
    # Enter title
    click element   ${title_input}
    sleep  0.5s
    input text  ${title_input}   ${email_before}
    sleep  0.5s
    # Enter Location
    click element   ${location_input}
    sleep  0.5s
    input text  ${location_input}   ${email_before}
    sleep  0.5s
    # choose team license type
    click element   ${license_type_select}
    sleep  1s
    click element   ${team_license_type}
    sleep  0.5s
    [Return]   ${email_before}

add_normal_user
    # click ADD USER button
    click_add_user
    # fill basic message
    ${email_before}  fill_basic_message
    # Enter groups
    click element  ${groups_input}
    sleep  1s
    click element   xpath=//div[@unselectable="on"]//li[1]
    sleep  0.5s
    click element   ${button_ADD}
    sleep  1s
    [Return]   ${email_before}

add_normal_user_choose_team_license
    # click ADD USER button
    click_add_user
    # fill basic message
    ${email_before}  fill_basic_message_choose_team_license
    # Enter groups
    click element  ${groups_input}
    sleep  1s
    click element    xpath=//div[@unselectable="on"]//span[text()="auto_default_group"]
    sleep  0.5s
    click element   ${button_ADD}
    sleep  1s
    [Return]   ${email_before}

capture_complete_email
    # Construct the completed mailbox
    [Arguments]   ${email_before}
    ${email}    Catenate   SEPARATOR=   ${email_before}    @outlook.com
    [Return]   ${email}

add_existing_normal_user
    [Arguments]   ${email_before}
    # click ADD USER button
    click_add_user
    # Enter email
    click element  ${input_email}
    sleep  0.5s
    ${email}    capture_complete_email   ${email_before}
    input text  ${input_email}    ${email}
    sleep  0.5s
    # Enter name
    click element  ${input_name}
    sleep  0.5s
    input text   ${input_name}   ${email_before}
    sleep  0.5s
    # Enter title
    click element   ${title_input}
    sleep  0.5s
    input text  ${title_input}   ${email_before}
    sleep  0.5s
    # Enter Location
    click element   ${location_input}
    sleep  0.5s
    input text  ${location_input}   ${email_before}
    sleep  0.5s
    # Enter groups
    click element  ${groups_input}
    sleep  2s
    click element   xpath=//div[@unselectable="on"]//li[1]
    sleep  0.5s
    click element   ${button_ADD}
    sleep  1s
    [Return]   ${email_before}

search_user_details
    [Arguments]   ${email_search}
    # search
    wait until element is visible   ${input_search}
    click element    ${input_search}
    sleep  0.5s
    input text   ${input_search}    ${email_search}
    sleep  2s
    click_deatils

click_deatils
    # click DETAILS button
    click element  ${button_DETAILS}
    wait until element is visible    xpath=//b[contains(.,'User Details')]
    sleep  1s

modify_basic_info
    # upload photo
    ${modify_picture_path}   get_modify_picture_path
    wait until element is visible    ${upload_avatar_button}    10s
    Choose file    ${button_Upload}     ${modify_picture_path}
    sleep  0.5s
    wait until element is visible    ${button_Remove}
    sleep  0.5s
    # modify Name
    Press Key    ${name_input}    \\8
    sleep  0.5s
    input text    ${name_input}    test_modify_name
    sleep  0.5s
    # modify Title
    click element   ${title_input}
    sleep  0.5s
    input text    ${title_input}    test_modify_title
    sleep  0.5s
    # modify Location
    click element   ${location_input}
    sleep  0.5s
    input text    ${location_input}    test_modify_location
    sleep  0.5s
    # click Update User
    click element   ${update_button}
    sleep  0.5s
    wait until element is not visible   ${prompt_information}    20s

only_avatar_is_editable
    # upload photo
    ${modify_picture_path}   get_modify_picture_path
    wait until element is visible    ${upload_avatar_button}    10s
    Choose file    ${button_Upload}     ${modify_picture_path}
    sleep  0.5s
    wait until element is visible    ${button_Remove}
    sleep  0.5s
    # cannot change License Type
    ${attribute}  get element attribute   ${role_select}    disabled
    should be equal as strings  ${attribute}  true
    # Username can not be changed
    ${username_atribute}  get element attribute   ${username_input}  disabled
    should be equal as strings   ${username_atribute}  true
    # Name can not be changed
    ${name_atribute}  get element attribute   ${name_input}  disabled
    should be equal as strings   ${name_atribute}   true
    # title can not be changed
    ${title_atribute}  get element attribute   ${title_input}  disabled
    should be equal as strings   ${title_atribute}   true
    # location can not be changed
    ${location_atribute}  get element attribute   ${location_input}  disabled
    should be equal as strings   ${location_atribute}   true
    # mobile can not be changed
    ${mobile_atribute}  get element attribute   ${mobile_input}  disabled
    should be equal as strings   ${mobile_atribute}   true
    # role can not be changed
    ${role_atribute}  get element attribute   ${role_select}  disabled
    should be equal as strings   ${role_atribute}   true
    # 滑动到底
    swipe_browser_to_bottom
    sleep  0.5s
    # click Update User
    click element   ${update_button}
    sleep  1s
    wait until element is not visible    ${prompt_information}   20s
    [Return]

check_avatar_upload_success
    # click DETAILS button
    click element  ${button_DETAILS}
    sleep  0.5s
    element should be visible   ${Remove_avatar_button}     # avator下的Remove avatar按钮
    click element  ${cancel_button}
    sleep  0.5s

check_modify_user_success
    sleep  4s
    # click DETAILS button
    click element  ${button_DETAILS}
    sleep  0.5s
    element should be visible   ${Remove_avatar_button}   # avator下的Remove avatar按钮
    ${name_after_modify}   get element attribute  ${name_input}  value
    should be equal as strings   ${name_after_modify}   test_modify_name
    ${title_after_modify}   get element attribute  ${title_input}  value
    should be equal as strings   ${title_after_modify}   test_modify_title
    ${location_after_modify}   get element attribute  ${location_input}  value
    should be equal as strings   ${location_after_modify}   test_modify_location
    click element  ${cancel_button}
    sleep  0.5s

clear_group
    # Clear group, click send button
    # 滑动到底
    swipe_browser_to_bottom
    sleep  0.5s
    # Clear group
    click element  ${first_groups_delete_button}
    sleep  1s
    page should contain element   ${no_groups_tips}

modify_user_groups
    # Add another group and submit
    # click DETAILS button
    click element  ${button_DETAILS}
    sleep  0.5s
    click element   ${groups_add}
    sleep  1s
    click element   xpath=//div[@unselectable="on"]//li[6]
    sleep  1s
    # 滑动到底
    swipe_browser_to_bottom
    sleep  0.5s
    click element   ${update_button}
    wait until element is not visible  ${prompt_information}   20s
    # Remove group and submit
    # click DETAILS button
    click element  ${button_DETAILS}
    sleep  1s
    click element  ${second_groups_delete_button}
    sleep  0.5s
    # 滑动到底
    swipe_browser_to_bottom
    sleep  0.5s
    click element   ${update_button}
    wait until element is not visible    ${prompt_information}   20s
    # Remove all the groups and submit.
    # click DETAILS button
    click element  ${button_DETAILS}
    sleep  1s
    click element  ${first_groups_delete_button}
    sleep  1s
    page should contain element   ${no_groups_tips}
    # 滑动到底
    swipe_browser_to_bottom
    sleep  0.5s
    click element  ${cancel_button}
    sleep  0.5s

cannot_change_role
    # click DETAILS button
    click element  ${button_DETAILS}
    sleep  0.5s
    # role can not be changed
    ${role_atribute}  get element attribute   ${role_select}  disabled
    should be equal as strings   ${role_atribute}   true
    # click CANCEL button
    click element  ${cancel_button}
    sleep  0.5s

cannot_change_license_type
    # click DETAILS button
    click element  ${button_DETAILS}
    sleep  2s
    # cannot change License Type
    ${attribute}  get element attribute   ${role_select}    disabled
    should be equal as strings  ${attribute}  true
    # click CANCEL button
    click element  ${cancel_button}
    sleep  0.5s

send_reset_password
    # click DETAILS button
    click element  ${button_DETAILS}
    sleep  0.5s
    # 滑动到底
    swipe_browser_to_bottom
    sleep  0.5s
    click element   ${send_reset_button}
    sleep  0.5s
    wait until element is visible    xpath=//span[contains(.,'Sent reset password email')]   5s   # Notification of successful email sending
    click element   ${cancel_button}
    sleep  0.5s

change_my_password
    # Switch to the second Windows page
    switch_window_to_second
    sleep  0.5s
    #  enter password
    click element  ${input_passwd}
    sleep  0.5s
    input text  ${input_passwd}   ${universal_password}
    sleep  0.5s
    # confirm password
    click element  ${input_passwordConfirm}
    sleep  0.5
    input text  ${input_passwordConfirm}   ${universal_password}
    sleep  0.5s
    click element   ${chage_passwd_button}
    sleep  0.5s
    wait until element is visible    xpath=//h2[contains(.,'You changed your password successfully.')]    5s
    # Switch to the first Windows page
    switch_window_to_first
    sleep  0.5s

accept_outlook_email
    sleep  20s
    ${email_link}   get_email_link   Change My Password:
    should contain   ${email_link}   ${Citron_web_url}
    # Open another Windows window
    Execute JavaScript    window.open('${email_link}')
    sleep  2s
    # change My password
    change_my_password

deactivate_user
    # click DETAILS button
    click element  ${button_DETAILS}
    sleep  0.5s
    click element  ${deactivate_user_button}
    sleep  2s
    click element   ${latest_modified_window_ok_button}
    sleep  2s
    element should not be visible    ${first_line_data}      #this user disappears from Active User tab

enter_deactivated_users_page
    # enter Deactivated Users page
    click element   ${deactivated_users_page}
    wait until element is visible    ${first_data_show}    10
    sleep  1s

search_deactivated_user
    [Arguments]  ${username}
    # search deactivated user
    click element   ${input_search}
    sleep  0.5s
    input text   ${input_search}  ${username}
    sleep  2s
    element should be visible    ${first_line_data}

reactivate_user
    # click DETAILS button
    click element  ${button_DETAILS}
    sleep  0.5s
    # 滑动到底
    swipe_browser_to_bottom
    sleep  0.5s
    # click Activate User button
    click element  ${activate_user_button}
    sleep  2s
    element should not be visible    ${first_line_data}     #this user disappears from Active User tab

enter_active_users_page
    # enter Active Users page
    click element   ${active_users_page}
    wait until element is visible    ${first_data_show}     10

search_active_user
    [Arguments]  ${username}
    # Clear the query box
    Press Key    ${input_search}    \\8\
    sleep  0.5s
    # search deactivated user
    click element   ${input_search}
    sleep  0.5s
    input text   ${input_search}  ${username}
    sleep  2s
    element should be visible    ${first_line_data}

add_group_user
    # click ADD USER button
    click_add_user
    # fill basic message
    ${email_before}  fill_basic_message
    # choose Role
    click element  ${role_select}
    sleep  0.5s
    click element   ${select_group_admin}
    sleep  0.5s
    # choose Group Admin for
    click element   ${group_admin_for_choose}
    sleep  1s
    click element   xpath=//div[@unselectable="on"]//li[2]
    sleep  0.5s
    # Enter groups
    click element   ${groups_input}
    sleep  1s
    input text    ${groups_input}   auto_default_group
    sleep  1s
    click element   xpath=//div[@unselectable="on"]//li[1]
    sleep  0.5s
    click element   ${button_ADD}
    sleep  0.5s
    # Check prompt Information
    ${information}    Catenate    ${email_before}    was successfully invited.
    wait until element is visible    ${prompt_information}    3s   #  message of Add Success
    ${get_information}   get text   ${prompt_information}
    should be equal as strings    ${information}    ${get_information}
    wait until element is not visible  ${prompt_information}  20s
    [Return]   ${email_before}

add_workspace_user
    # click ADD USER button
    click_add_user
    # fill basic message
    ${email_before}  fill_basic_message
    # choose Role
    click element  ${role_select}
    sleep  1s
    click element   ${select_workspace_admin}
    sleep  0.5s
    # Enter groups
    click element   ${groups_input}
    sleep  1s
    input text   ${groups_input}   auto_default_group
    sleep  1s
    click element   xpath=//div[@unselectable="on"]//li[1]
    sleep  1s
    click element   ${button_ADD}
    sleep  0.5s
    # Check prompt Information
    ${information}    Catenate    ${email_before}    was successfully invited.
    wait until element is visible    ${prompt_information}    3s   #  message of Add Success
    ${get_information}   get text   ${prompt_information}
    should be equal as strings    ${information}    ${get_information}
    wait until element is not visible   ${prompt_information}   20s
    [Return]  ${email_before}

modify_group_admin_groups
    # Add another group and submit
    # click DETAILS button
    click element  ${button_DETAILS}
    sleep  0.5s
    # 滑动到底
    swipe_browser_to_bottom
    sleep  0.5s
    click element   ${add_second_group}
    sleep  1s
    click element   xpath=//div[@unselectable="on"]//li[6]
    sleep  1s
    click element   ${update_button}
    wait until element is not visible   ${prompt_information}   20s
    # Remove group and submit
    # click DETAILS button
    click element  ${button_DETAILS}
    sleep  1s
    # 滑动到底
    swipe_browser_to_bottom
    sleep  0.5s
    click element  ${second_groups_delete_button}
    sleep  0.5s
    click element   ${update_button}
    wait until element is not visible   ${prompt_information}  20s
    # Remove all the groups and submit.
    # click DETAILS button
    click element  ${button_DETAILS}
    sleep  1s
    # 滑动到底
    swipe_browser_to_bottom
    sleep  0.5s
    click element   xpath=//label[contains(.,'Groups')]/..//span[@aria-label="delete"]
    sleep  1s
    page should contain element   ${no_groups_tips}
    click element   ${cancel_button}
    sleep  0.5s

deactivate_user_button_not_visible
    # Deactivate user button is not visible
    element should not be visible  ${deactivate_user_button}

get_group_admin_for
    # search Group Admin
    search_user_details   ${group_admin_username}
    # Getting count of the Group Admin for
    ${count}  get element count   xpath=//label[contains(.,'Group Admin for')]/..//ul[@class="k-reset"]/li
    @{group_admin_for}=    Create List
    # Getting the Group Admin for
    FOR   ${i}   IN RANGE  0   ${count}
        ${group_name}   get text    xpath=//label[contains(.,'Group Admin for')]/..//ul[@class="k-reset"]/li[${i}+1]/span[1]
        append to list   ${group_admin_for}   ${group_name}
    END
    [Return]   ${group_admin_for}

display_deactivated_users
    [Arguments]    ${group_admin_for}
    # Get number of rows
    ${count}   get element count    xpath=//div[@class="ag-center-cols-container"]/div
    FOR   ${i}   IN RANGE  ${count}
        # click DETAILS button
        click element    xpath=//div[@class="ag-center-cols-container"]/div[${i}+1]//button[contains(.,'Details')]
        sleep  1s
        # Getting the group name
        ${group_name}    get text    xpath=//label[contains(.,'Groups')]/..//li[@class="k-button"]/span[1]
        should contain     ${group_admin_for}    ${group_name}
        # click CANCEL button
        click element   ${cancel_button}
        sleep  2s
    END

check_file_if_exists_delete
    # Check whether there are existing files in the path and delete them if there are
    check_file_and_delete   export.csv

enter_REPORT_VIEW_page
    # click Report View button
    click element  ${report_view_button}
    wait until element is visible    ${first_data_show}   10

export_to_CSV
    # Export to CSV
    click element    ${export_to_CSV_button}
    sleep  10s

check_cloumns_active_users_tab
    # Read the first line field of the CSV file
    ${first_lines}   read_csv_file_check_cloumns  export.csv
    ${name_get}   get text    ${first_data_show}/div[@col-id="name"]
    ${email_get}   get text    ${first_data_show}/div[@col-id="email"]
    ${license_get}   get text    ${first_data_show}/div[@col-id="license"]
    ${role_get}   get text    ${first_data_show}/div[@col-id="role_name"]
    ${groups_get}   get text    ${first_data_show}/div[@col-id="pods_string"]
    should be equal as strings  ${first_lines}[0]    ${name_get}
    should be equal as strings  ${first_lines}[3]    ${email_get}
    ${license_get}   converts_string_to_lowercase   ${license_get}
    should be equal as strings  ${first_lines}[4]    ${license_get}
    should be equal as strings  ${first_lines}[5]    ${role_get}
    should be equal as strings  ${first_lines}[6]    ${groups_get}

check_cloumns_deactivated_users_tab
    # Read the first line field of the CSV file
    ${first_lines}   read_csv_file_check_cloumns  export.csv
    ${name_get}   get text    ${first_data_show}/div[@col-id="name"]
    ${title_get}   get text    ${first_data_show}/div[@col-id="title"]
    ${location_get}   get text    ${first_data_show}/div[@col-id="location"]
    ${email_get}   get text    ${first_data_show}/div[@col-id="email"]
    ${role_get}   get text    ${first_data_show}/div[@col-id="role_name"]
    should be equal as strings  ${first_lines}[0]    ${name_get}
    should be equal as strings  ${first_lines}[1]    ${title_get}
    should be equal as strings  ${first_lines}[2]    ${location_get}
    should be equal as strings  ${first_lines}[3]    ${email_get}
    should be equal as strings  ${first_lines}[4]    ${role_get}

Only_show_the_groups_administered_by_the_GA
    [Arguments]    ${group_admin_for}
    # Get number of rows
    ${count}   get element count     ${get_number_of_rows}
    FOR   ${i}   IN RANGE  ${count}
        # Getting the group name
        ${group_name}    get text    xpath=//div[@class="ag-center-cols-container"]/div[${i}+1]//div[@col-id="name"]//div[@class="cardName"]
        should contain     ${group_admin_for}    ${group_name}
        sleep  0.1s
    END

search_special_group
    # search group：Group_only_for_test_groups_members
    click element  ${group_list_search}
    sleep  1s
    input text   ${group_list_search}   auto_default_group
    sleep  3s
    click element   ${members_button}
    sleep  3s

add_mumbers_after_del
    # search group：Group_only_for_test_groups_members
    search_special_group
    # click Add More Users... button
    click element  ${add_more_users_button}
    sleep  2s
    # search users
    click element   ${edit_members_search}
    input text  ${edit_members_search}    hlnauto+maomwu
    sleep  2s
    # add users
    click element  xpath=//div[@row-index="0"]//button[contains(.,'Add')]
    sleep  2s
    # close Add More Users... page
    click element   ${close_details_button}
    sleep  1s
    # click MEMBERS button
    click element   ${members_button}
    sleep  3s
    # search users
    click element   ${edit_members_search}
    input text  ${edit_members_search}  hlnauto+maomwu
    sleep  2s
    # delete users
    click element   xpath=//div[@row-index="0"]//button[contains(.,'Delete')]
    sleep  2s
    element should not be visible   xpath=//div[@row-index="0"]//button[contains(.,'Delete')]

get_groups_groups_text
    # Gets a list of group names  on the groups page
    ${count}   get element count   ${get_number_of_rows}
    should not be equal as numbers  ${count}  1
    @{get_groups_groups_list}=    Create List
    FOR   ${i}   IN RANGE   ${count}
        ${get_group_name_text}   get text    xpath=//div[@class="ag-center-cols-container"]/div[${i}+1]//div[@class="cardName"]
        append to list   ${get_groups_groups_list}   ${get_group_name_text}
    END
    [Return]   ${get_groups_groups_list}

get_dashboard_groups_text
    click element  ${groups_choose}
    sleep  1s
    # Gets a list of group names  on the dashboard page
    ${count}   get element count   xpath=//label[contains(.,'Group')]/following-sibling::select[1]/option
    should not be equal as numbers  ${count}  1
    @{get_dashboard_groups_list}=    Create List
    FOR   ${i}   IN RANGE  2   ${count}+1
        ${get_group_name_text}   get text    xpath=//label[contains(.,'Group')]/following-sibling::select[1]/option[${i}]
        append to list   ${get_dashboard_groups_list}   ${get_group_name_text}
    END
    [Return]   ${get_dashboard_groups_list}

get_calls_groups_text
    click element  ${groups_choose}
    sleep  1s
    # Gets a list of group names  on the dashboard page
    ${count}   get element count   xpath=//label[contains(.,'Group')]/following-sibling::select[1]/option
    should not be equal as numbers  ${count}  1
    @{get_calls_groups_list}=    Create List
    FOR   ${i}   IN RANGE  1   ${count}
        ${get_group_name_text}   get text    xpath=//label[contains(.,'Group')]/following-sibling::select[1]/option[${i}+1]
        append to list   ${get_calls_groups_list}   ${get_group_name_text}
    END
    [Return]   ${get_calls_groups_list}

analytics_choose_one_group
    # get Users numbers
    sleep  5s
    ${get_user_numbers}    get text  ${total_users}
    # choose second group
    click element   ${groups_choose}
    sleep  1s
    click element   xpath=//label[contains(.,'Group')]/following-sibling::select[1]/option[3]
    sleep  8s
    ${once_get_user_numbers}    get text  ${total_users}
    should not be equal as numbers    ${once_get_user_numbers}  ${get_user_numbers}

calls_choose_one_group
    # get Users numbers
    sleep  5s
    ${get_calls_numbers}    get text  ${calls_get_counts}
    # choose second group
    click element   ${groups_choose}
    sleep  1s
    click element   xpath=//label[contains(.,'Group')]/following-sibling::select[1]/option[3]
    sleep  30s
    ${once_get_calls_numbers}    get text   ${calls_get_counts}
    should not be equal as numbers    ${once_get_calls_numbers}   ${get_calls_numbers}

should_be_hidden
    # Groups drop down list should be hidden.
    element should not be visible   ${groups_choose}

choose_last_365_days
    # choose Last 365 Days
    click element   ${occurred_within_choose}
    sleep  1s
    ${count}   get element count   xpath=//label[contains(.,'Occurred Within')]/following-sibling::select/option
    click element    xpath=//label[contains(.,'Occurred Within')]/following-sibling::select/option[${count}]
    # Wait until first line appear
    wait until element is visible    xpath=//div[@class="ag-center-cols-container"]/div[@row-index="0"]/div[1]      10

lists_should_be_same
    [Arguments]   ${get_calls_groups_list}   ${get_groups_groups_list}
    ${result}   compare_two_lists   ${get_calls_groups_list}   ${get_groups_groups_list}
    should be equal as strings   ${result}    Two lists are equal

only_display_calls_records_from_users
    # Only display records from users in the groups that group admin manages
    FOR   ${i}   IN RANGE    10
        ${get_owner_name}   get text   xpath=//div[@class="ag-center-cols-container"]/div[@row-index="0"]/div[@col-id="owner_name"]
        should be equal as strings   ${get_owner_name}   Huiming.shi.helplightning+123456789
    END

click_export_button
    # click EXPORT button
    click element   ${export_button}
    sleep  1s
    ${count}    get element count    xpath=//div[@id="exportToCsvPopover"]//div/button
    should be equal as integers    ${count}   2
    ${button_text}   get text   ${export_current_table}
    should be equal as strings   ${button_text}    EXPORT CURRENT TABLE
    ${button_text}   get text   ${generate_table}
    should contain  ${button_text}    GENERATED

add_tag_and_comments
    # click Details button for the first record
    click element   ${calls_details_button}
    sleep  2s
    # delete all tags
    ${count}   get element count   ${delete_tags_button}
    FOR   ${i}   IN RANGE    ${count}
        click element  ${delete_tags_button}
        sleep  0.5s
    END
    # click  Add tags...  input
    click element    ${add_tags_input}
    sleep  1s
    # Select the first tag
    ${first_tag}   get text    xpath=//div[@class="k-list-scroller"]//li[1]
    click element   xpath=//div[@class="k-list-scroller"]//li[1]
    sleep  0.5s
    # click Add a comment...  input
    click element    ${add_comment_input}
    sleep  0.5s
    # input comment
    ${random}   evaluate    int(time.time()*1000000)   time
    ${comment}   Catenate   SEPARATOR=   comment  ${random}
    input text   ${add_comment_input}     ${comment}
    # 滑动到底
    swipe_browser_to_bottom
    sleep  0.5s
    # click SAVE button
    click element   ${details_save_button}
    sleep  1s
    # click x button
    click element    ${close_details_button}
    sleep  5s
    # Check whether the tag is added successfully
    ${get_tag}   get text   ${first_line_tagname}
    should be equal as strings   ${first_tag}  ${get_tag}
    # click Details button for the first record
    click element   ${calls_details_button}
    sleep  2s
    # Check whether the comment is added successfully
    ${get_comment}  get text  xpath=//div[@class="Comments"]/div[1]//div[@class="comment-text row"]
    should be equal as strings   ${comment}   ${get_comment}

update_tags
    # Gets the text of the first tag
    ${first_tag}   get text     xpath=//ul[@role="listbox"]/li/a
    # update tag
    click element   xpath=//span[@class="k-searchbar"]/input
    sleep  1s
    # Select the second tag
    ${second_tag}   get text     xpath=//div[@class="k-list-scroller"]//li[2]
    click element  xpath=//div[@class="k-list-scroller"]//li[2]
    sleep  1s
    # 滑动到底
    swipe_browser_to_bottom
    sleep  0.5s
    # click SAVE button
    click element   ${details_save_button}
    sleep  1s
    # click x button
    click element    ${close_details_button}
    sleep  5s
    # Check whether the tag is added successfully
    ${get_tag}   get text   ${first_line_tagname}
    should be equal as strings    ${get_tag}     ${first_tag}, ${second_tag}

delete_tags
    # click Details button for the first record
    click element   ${calls_details_button}
    sleep  2s
    # delete all tags
    ${count}   get element count   ${delete_tags_button}
    FOR   ${i}   IN RANGE    ${count}
        click element  ${delete_tags_button}
        sleep  0.5s
    END
    # 滑动到底
    swipe_browser_to_bottom
    sleep  0.5s
    # click SAVE button
    click element   ${details_save_button}
    sleep  1s
    # click x button
    click element    ${close_details_button}
    sleep  5s
    # Check whether the tag is deleted successfully
    ${get_tag_second}   get text   ${first_line_tagname}
    should be empty   ${get_tag_second}

warning_dialog
    # Check the warning dialog
    element should be visible    ${confirm_text}
    ${warning_text}  get text   ${confirm_text}
    should be equal as strings   ${warning_text}   This user already belongs to another site. Would you like to invite them to migrate their account to your site?

Confirm_cancel
    # click CANCEL button
    click element   xpath=//p[@class="confirm-text"]/../..//button[contains(.,'Cancel')]
    sleep  0.5s

Confirm_invite
    [Arguments]   ${count_email}
    # click ADD button
    click element   ${button_ADD}
    sleep  1s
    # click INVITE button
    click element    ${confirm_invite_button}
    sleep  0.5s
    # check message
    wait until element is visible   ${message_text}   5s
    ${get_prompt_information}  get text  ${message_text}
    ${information}   catenate    ${count_email}    was successfully invited.
    should be equal as strings   ${get_prompt_information}   ${information}
    wait until element is not visible   ${prompt_information}  20s

resend_invitation
    # RESEND invitation
    wait until element is not visible   ${message_text}     20s
    sleep  1s
    click element   ${resend_invitation}
    sleep  1s
    element should be visible   ${Invitation_has_been_sent}    10s
    element should be visible    ${resend_invitation}

resend_all_invitation
    # RESEND invitation
    wait until element is not visible   ${message_text}     20s
    sleep  1s
    click element   ${resend_all_invitation}
    sleep  1s
    element should be visible   ${Invitations_has_been_sent}    10s
    element should be visible    ${resend_invitation}

cancel_invitation
    # RESEND invitation
    wait until element is not visible   ${message_text}     20s
    sleep  1s
    click element   ${cancel_invitation}
    sleep  1s
    element should not be visible   ${cancel_invitation}

cancel_all_invitation
    # RESEND invitation
    wait until element is not visible   ${message_text}     20s
    sleep  1s
    click element   ${cancel_all_invitation}
    sleep  1s
    click element    ${latest_modified_window_ok_button}
    sleep  1s
    element should not be visible   ${cancel_invitation}

search_invitation_by_email
    [Arguments]   ${email}
    # search invitation by email
    click element   ${input_search}
    sleep  0.5s
    input text   ${input_search}  ${email}
    wait until element is visible    ${first_data_show}    5s

invitation_mail_not_valid
    sleep  20s
    ${email_link}   get_email_link   Accept Invitation:
    should contain   ${email_link}   ${Citron_web_url}
    # Open another Windows window
    Execute JavaScript    window.open('${email_link}')
    sleep  2s
    # Switch to the second Windows page
    switch_window_to_second
    sleep  0.5s
    # This invitation no longer exists
    element should be visible   xpath=//span[contains(.,'This invitation no longer exists. It has either been previously accepted or revoked by a site administrator. Please try to login using the application, or contact your administrator for a separate invitation. Thank you.')]
    # Switch to the first Windows page
    switch_window_to_first
    sleep  0.5s

check_cloumns_invitation_users_tab
    # Read the first line field of the CSV file
    ${first_lines}   read_csv_file_check_cloumns  export.csv
    ${name_get}   get text   ${first_data_show}/div[@col-id="name"]//div[@class="cardName"]
    ${email_get}   get text   ${first_data_show}/div[@col-id="email"]
    ${license_get}   get text   ${first_data_show}/div[@col-id="license"]
    ${groups_get}   get text   ${first_data_show}/div[@col-id="pods"]
    should be equal as strings  ${first_lines}[0]    ${name_get}
    should be equal as strings  ${first_lines}[1]    ${email_get}
    ${license_get}   converts_string_to_lowercase   ${license_get}
    should be equal as strings  ${first_lines}[2]    ${license_get}
    should be equal as strings  ${first_lines}[3]    ${groups_get}

check_display_users
    # Get the list data count
    ${count}   get element count    xpath=//div[@class="ag-center-cols-container"]//div[@col-id="pods_string"]
    # Loop through the group name
    FOR   ${i}   IN RANGE    ${count}
        ${group_name}   get text    xpath=//div[@class="ag-center-cols-container"]//div[@row-index="${i}"]//div[@col-id="pods_string"]
        should be equal as strings   ${group_name}  default
    END

make_sure_tagging_and_comments_setting_open
    sleep  2s
    # make sure After Call: Tagging and Comments setting is open
    ${count}   get element count   ${open_tag_and_comment}
    Run Keyword If   '${count}'=='1'    open_tagging_and_comments_setting

open_tagging_and_comments_setting
    click element   ${open_tag_and_comment}
    sleep  3s   # Waiting for the configuration to take effect