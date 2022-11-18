*** Settings ***
Library           Collections
Library           Selenium2Library
Library           DateTime
Library           String
Resource          public.robot
Resource          All_Pages_Xpath/SITE_Admin/Analytics.robot
Resource          All_Pages_Xpath/SITE_Admin/Calls.robot
Resource          All_Pages_Xpath/SITE_Admin/Site_Settings.robot
Resource          All_Pages_Xpath/SITE_Admin/Users.robot
Resource          All_Pages_Xpath/SITE_Admin/Workspaces.robot
Resource          All_Pages_Xpath/WS_Admin/Workspace_Settings.robot
Resource          All_Pages_Xpath/public_xpath.robot
Resource          All_Pages_Xpath/crunch_page.robot
Library           python_Lib/ui_keywords.py
Library           python_Lib/obtain_outlook_email_link.py



*** Keywords ***
enter_enterprises_menu
    # enter crunch enterprises menu
    click element  ${Enterprises_menu}
    wait until element is visible   ${new_enterprice_button}

enter_group_users
    # click groups ADMINISTRATION page menu
    click element   ${enter_group_menu}
    sleep  0.5s
    # click Users page menu
    click element   ${enter_users}
    # Wait until the first row shows up
    wait until element is visible    ${button_add_user}
    wait until element is visible    ${first_row_shows_up}    20

new_enterprice
    # new enterprice
    sleep   5s
    wait until element is enabled  ${new_enterprice_button}
    click element   ${new_enterprice_button}
    sleep  0.5s
    ${random}   evaluate    int(time.time()*1000000)    time
    ${email_before}   Catenate   SEPARATOR=+   ${my_existent_email_name}  ${random}
    ${email}    Catenate   SEPARATOR=   ${email_before}    @outlook.com
    # input enterprice name
    click element  ${enterprice_name_input}
    sleep  0.5s
    input text  ${enterprice_name_input}   ${email_before}
    sleep  0.5s
    # input contact name
    click element  ${contact_name_input}
    sleep  0.5s
    input text  ${contact_name_input}  ${email_before}
    sleep  0.5s
    # input contact email
    click element  ${contact_email_input}
    sleep  0.5s
    input text  ${contact_email_input}  ${email}
    sleep  0.5s
    # select Plan
    click element   ${plan_select}
    sleep  0.5s
    click element   ${select_enterprise}
    sleep  0.5s
    # click Register button
    click element  ${register_button}
    wait until element is visible    xpath=//strong[contains(.,'Site successfully created')]
    [Return]    ${email_before}   ${email}

fill_password_mailbox
    sleep  20s
    ${email_link}   get_email_link   Click here to set your password:
    should contain   ${email_link}   ${Citron_web_url}
    # Open another Windows window
    Execute JavaScript    window.open('${email_link}')
    sleep  10s
    # change My password
    change_my_password

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

only_workspaces_site_setting
    #  Just Only Workspaces, Site Setting.[Dashboard, Users, Calls has been hidden.]
    # enter site administration menu
    click element   ${enter_first_menu_tree}
    sleep  0.5s
    # enter site workspaces page
    click element   ${enter_workspaces}
    ${count}  get element count   xpath=//div[@role="group"]/div[@role="treeitem"]
    should be equal as integers  ${count}  2
    ${get_menu}  get text  xpath=//div[@role="group"]/div[@role="treeitem"][1]
    should be equal as strings  ${get_menu}  Workspaces
    ${get_menu}  get text  xpath=//div[@role="group"]/div[@role="treeitem"][2]
    should be equal as strings  ${get_menu}  Site Settings

enter_site_workspaces
    # enter SITE ADMINISTRATION Workspaces page
    click element   ${enter_site_menu}
    sleep  1s
    # click Users page menu
    click element   ${enter_workspaces}
    # Wait until the first row shows up
    wait until element is visible    ${create_workspace_button}    20
    wait until element is visible    ${first_data_show}    20

enter_site_users
    # enter SITE ADMINISTRATION Users page
    click element   ${enter_site_menu}
    sleep  0.5s
    # click Users page menu
    click element   ${enter_users}
    # Wait until the first row shows up
    wait until element is visible    ${button_add_user}    20
    wait until element is visible    ${first_data_show}    20

enter_site_analytics
    # enter SITE ADMINISTRATION Users page
    click element   ${enter_site_menu}
    sleep  0.5s
    # click Users page menu
    click element   ${enter_analytics}
    sleep  1s
    # Wait until Dashboard appear
    wait until element is visible    xpath=//b[contains(.,'Dashboard')]    20

enter_workspace_workspace_settings
    # click workspace ADMINISTRATION page menu
    click element   ${enter_workspace_menu}
    sleep  1s
    # click Users page menu
    click element   ${enter_Workspace_settings}
    # Wait until enter page
    wait until element is visible   ${enter_ws_settings_success}    20
    sleep  2s

enter_site_calls
    # enter SITE ADMINISTRATION Users page
    click element   ${enter_site_menu}
    sleep  0.5s
    # click Calls page menu
    click element   ${enter_calls}
    sleep  1s
    # choose Last 365 Days
    wait until element is visible    ${occurred_within_choose}    20s
    click element  ${occurred_within_choose}
    sleep  0.5s
    click element  ${calls_last_365_days_select}
    sleep  0.5s
    # Wait until the first row shows up
    wait until element is visible    ${first_data_show}    20

enter_site_site_settings
    # enter site administration menu
    click element    xpath=//span[text()="SITE ADMINISTRATION"]
    sleep  0.5s
    # enter site  Site Setting page
    click element   ${enter_Site_settings}
    wait until element is visible   xpath=//span[contains(.,'Primary Contact')]    20

enter_site_workspace_settings
    # enter workspace administration menu
    click element   ${enter_workspace_menu}
    sleep  0.5s
    # enter site  Site Setting page
    click element   ${enter_Workspace_settings}
    wait until element is visible   ${workspace_settings_tag}   20
    sleep   3s

has_default_workspace
    # Has Default workspace
    ${count}   get element count   ${get_number_of_rows}
    should be equal as integers   ${count}  1

just_has_primary_contact
    # Just has Primary Contact
    ${count}   get element count   xpath=//div[@id="enterprise-tabs"]//span
    should be equal as integers   ${count}   1
    ${text}    get text   xpath=//div[@id="enterprise-tabs"]//span
    should be equal as strings   ${text}    Primary Contact

edit_primary_contact
    # Edit Site Name, Time Zone, Contact Name, Contact Email & Contact Phone
    # modify Site Name
    ${random}   evaluate    int(time.time()*1000000)    time
    ${email_before}   Catenate   SEPARATOR=+   ${my_existent_email_name}  ${random}
    ${email}    Catenate   SEPARATOR=   ${email_before}    @outlook.com
    wait until element is visible     ${site_name_input}    20s
    Press Key    ${site_name_input}   \\8
    sleep  0.5s
    input text   ${site_name_input}    ${email_before}
    sleep  0.5s
    # modify Time Zone
    click element  ${time_zone_select}
    sleep  1s
    click element   xpath=//option[contains(.,'(GMT-11:00) Niue')]
    sleep  0.5s
    # modify Contact Name
    Press Key    ${contact_name_input1}  \\8
    sleep  0.5s
    input text   ${contact_name_input1}    ${email_before}
    sleep  0.5s
    # modify Contact Email
    Press Key    ${contact_email_input1}     \\8
    sleep  0.5s
    input text   ${contact_email_input1}     ${email}
    sleep  0.5s
    # modify Contact Phone
    click element  ${contact_phone_input}
    sleep  0.5s
    input text   ${contact_phone_input}    15951747996
    sleep  0.5s
    # click UPDATE button
    click element  ${update_settings_button}
    wait until element is visible   xpath=//span[contains(.,'Updated Business settings')]
    sleep  1s
    [Return]   ${email_before}   ${email}

check_primary_contact_updated
    #  the value is updated value.
    [Arguments]  ${email_before}   ${email}
    wait until element is visible    ${site_name_input}     20s
    ${get_text}   get element attribute  ${site_name_input}  value
    should be equal as strings   ${get_text}   ${email_before}
    ${get_text}   get element attribute  ${contact_name_input1}  value
    should be equal as strings   ${get_text}   ${email_before}
    ${get_text}   get element attribute  ${contact_email_input1}  value
    should be equal as strings   ${get_text}   ${email}
    ${get_text}   get element attribute  ${contact_phone_input}  value
    should be equal as strings   ${get_text}   15951747996

list_all_workspaces_for_this_site
    # List all workspaces for this site.
    ${count}  get element count   ${get_number_of_rows}
    should not be equal as integers   ${count}  0

search_single_workspaces
    # Enter key values in Search field
    [Arguments]    ${workspaces_name}   ${expect_count}
    wait until element is visible  ${search_input}
    click element   ${search_input}
    sleep  0.5s
    input text  ${search_input}    ${workspaces_name}
    sleep  2s
    ${count}  get element count   ${get_number_of_rows}
    should be equal as integers  ${count}   ${expect_count}

deactivate_workspace
    # Deactivate Workspace
    click element  ${details_button}
    sleep  1s
    # Clicks 'Deactivate workspace' button
    deactivate_workspace_ok

click_export_view_button
    # Clicks Export View button
    click element   ${report_view_button}
    sleep  0.5s

show_three_button
    # Clicks Export View button
    click_export_view_button
    # Share this filter button & Export to CSV button to instead of 'Report view' button.
    ${count}   get element count    xpath=//button[@class="k-button k-primary pull-right action-button"]
    should be equal as integers   ${count}  3
    element should be visible    ${share_this_filter_button}
    element should be visible    ${export_to_CSV_button}
    element should be visible    ${quick_view_button}

share_this_filter
    # click Share This Filter button
    click element   ${share_this_filter_button}
    sleep  0.5s
    ${get_link}     get element attribute   xpath=//p[contains(.,'Link to Filter')]/..//input    value
    # Open another window
    Execute JavaScript    window.open('${get_link}')
    sleep  5s
    # Switch to the second Windows page
    switch_window_to_second
    sleep  0.5s
    click element  ${button_of_popup}
    sleep  0.5s

workspaces_share_this_filter
    # click Share This Filter button
    share_this_filter
    # this searched result workspace list should be shown up in the new tab
    element should be visible   ${create_workspace_button}
    ${count}  get element count   ${get_number_of_rows}
    should not be equal as strings   ${count}  0
    # Switch to the first Windows page
    switch_window_to_first
    sleep  0.5s

users_share_this_filter
    # click Share This Filter button
    share_this_filter
    # this searched result workspace list should be shown up in the new tab
    element should be visible   ${button_add_user}
    wait until element is visible    ${first_data_show}   20
    ${count}  get element count   ${get_number_of_rows}
    should not be equal as strings   ${count}  0
    # Switch to the first Windows page
    switch_window_to_first
    sleep  0.5s

calls_share_this_filter
    # click Share This Filter button
    share_this_filter
    # this searched result workspace list should be shown up in the new tab
    element should be visible    xpath=//label[contains(.,'Occurred Within')]
    wait until element is visible    ${first_data_show}   20
    ${count}  get element count   ${get_number_of_rows}
    should not be equal as strings   ${count}  0
    # Switch to the first Windows page
    switch_window_to_first
    sleep  0.5s

check_file_if_exists_delete
    # Check whether there are existing files in the path and delete them if there are
    check_file_and_delete  export.csv

export_to_csv
    # Click 'Export to CSV' button
    click element   ${export_to_CSV_button}
    sleep  10s

workspaces_export_to_csv
    # Click 'Export to CSV' button
    export_to_csv

users_export_to_csv
    # Click 'Export to CSV' button
    export_to_csv

calls_export_current_table
    # Click 'Export Current Table' button
    click element   ${export_button}
    sleep  1s
    click element    ${export_current_table_button}
    sleep  10s

calls_generate_new_call_report
    # click 'Generate New Call Report' button
    click element   ${export_button}
    sleep  1s
    click element    ${generate_new_call_report_button}
    sleep  10s

workspaces_check_cloumns_workspaces_tab
    # Read the first line field of the CSV file
    ${first_lines}   read_csv_file_check_cloumns  export.csv
    ${name_get}   get text   ${first_data_show}/div[@col-id="name"]
    ${state_get}   get text   ${first_data_show}/div[@col-id="activeText"]
    ${administration_get}   get text   ${first_data_show}/div[@col-id="admins_string"]
    should be equal as strings  ${first_lines}[0]    ${name_get}
    should be equal as strings  ${first_lines}[1]    ${state_get}
    should be equal as strings  ${first_lines}[2]    ${administration_get}

users_check_cloumns_workspaces_tab
    # Read the first line field of the CSV file
    ${first_lines}   read_csv_file_check_cloumns  export.csv
    ${name_get}   get text   ${first_data_show}/div[@col-id="name"]
    ${title_get}   get text   ${first_data_show}/div[@col-id="title"]
    ${location_get}   get text   ${first_data_show}/div[@col-id="location"]
    ${email_get}   get text   ${first_data_show}/div[@col-id="email"]
    ${license_get}   get text   ${first_data_show}/div[@col-id="license"]
    ${role_name_get}   get text   ${first_data_show}/div[@col-id="role_name"]
    ${pods_string_get}   get text   ${first_data_show}/div[@col-id="pods_string"]
    should be equal as strings  ${first_lines}[0]    ${name_get}
    should be equal as strings  ${first_lines}[1]    ${title_get}
    should be equal as strings  ${first_lines}[2]    ${location_get}
    should be equal as strings  ${first_lines}[3]    ${email_get}
    ${license_get}  converts_string_to_lowercase    ${license_get}
    should be equal as strings  ${first_lines}[4]    ${license_get}
    should be equal as strings  ${first_lines}[5]    ${role_name_get}
    should be equal as strings  ${first_lines}[6]    ${pods_string_get}

calls_check_cloumns_workspaces_tab
    # Read the first line field of the CSV file
    ${first_lines}   read_csv_file_check_cloumns   export.csv
    ${owner_name_get}   get text   ${first_data_show}/div[@col-id="owner_name"]
    ${owner_email_get}   get text   ${first_data_show}/div[@col-id="owner_email"]
    ${participants_get}   get text   ${first_data_show}/div[@col-id="participants"]//div[@class="cardName"]
    ${workspaceString_get}   get text   ${first_data_show}/div[@col-id="workspaceString"]
    ${reasonCallEnded_get}   get text   ${first_data_show}/div[@col-id="reasonCallEnded"]
    ${callDuration_get}   get text   ${first_data_show}/div[@col-id="callDuration"]
    ${tags_get}   get text   ${first_data_show}/div[@col-id="tags"]
    should be equal as strings  ${first_lines}[0]    ${owner_name_get}
    should be equal as strings  ${first_lines}[1]    ${owner_email_get}
    should contain  ${first_lines}[2]    ${participants_get}
    should be equal as strings  ${first_lines}[3]    ${workspaceString_get}
    should be equal as strings  ${first_lines}[5]    ${reasonCallEnded_get}
    should be equal as strings  ${first_lines}[6]    ${callDuration_get}
    ${tags_get_new}  string_with_whitespace_removed   ${tags_get}
    should be equal as strings  ${first_lines}[7]    ${tags_get_new}

click_create_workspace_button
    # click Create Workspace button
    click element   ${create_workspace_button}
    wait until element is visible    ${workspace_add_another_button}

enter_valid_workspaces
    # input Workspace Name
    ${random}   evaluate    int(time.time()*1000000)    time
    ${workspace_name}   Catenate   SEPARATOR=   workspace_name   ${random}
    click element  ${workspace_name_input}
    sleep  0.5s
    input text  ${workspace_name_input}  ${workspace_name}
    sleep  0.5s
    # input Description
    click element  ${workspace_description_input}
    sleep  0.5s
    input text  ${workspace_description_input}  ${workspace_name}
    sleep  0.5s
    [Return]  ${workspace_name}

modify_workspace_information
    # Modify Workspace Name & Description
    # modify Workspace Name
    ${random}   evaluate    int(time.time()*1000000)    time
    ${workspace_name}   Catenate   SEPARATOR=   workspace_name   ${random}
    Press Key    ${workspace_name_input}   \\8
    sleep  0.5s
    input text   ${workspace_name_input}    ${workspace_name}
    sleep  0.5s
    # modify Description
    Press Key    ${workspace_description_input}   \\8
    sleep  0.5s
    input text   ${workspace_description_input}    ${workspace_name}
    sleep  0.5s
    # click Update Details button
    click element  ${workspace_update_details_button}
    wait until element is visible    xpath=//span[contains(.,'Updated details successfully')]
    sleep  2s
    [Return]  ${workspace_name}

check_workspace_information_successfully_modified
    [Arguments]   ${workspace_name}
    # Check that basic information is successfully modified
    ${get_workspace_name}  get element attribute   ${workspace_name_input}   value
    should be equal as strings   ${get_workspace_name}  ${workspace_name}
    ${get_description}  get text   ${workspace_description_input}
    should be equal as strings   ${get_description}   ${workspace_name}
    # click Cancel button
    click element  ${workspace_cancel_button}
    sleep  1s

confirm_create_workspace
    # click Create Workspace button
    click_create_workspace_button
    # Enter the valid values for Worksapce Name & Desciption fields
    ${workspace_name}  enter_valid_workspaces
    # click Create Workspace button
    click element  ${workspace_create_button}
    ${prompt information}   Catenate    ${workspace_name}    was successfully created.
    wait until element is visible   xpath=//span[contains(.,'${prompt information}')]
    wait until element is not visible    xpath=//span[contains(.,'${prompt information}')]   20s
    [Return]   ${workspace_name}

cancel_create_workspace
    # click Create Workspace button
    click_create_workspace_button
    # Enter the valid values for Worksapce Name & Desciption fields
    ${workspace_name}  enter_valid_workspaces
    # click Cancel button
    click element  ${workspace_cancel_button}
    sleep  0.5s
    [Return]   ${workspace_name}

create_and_add_another_workspace
    # click Create Workspace button
    click_create_workspace_button
    # Enter the valid values for Worksapce Name & Desciption fields
    ${workspace_name}  enter_valid_workspaces
    # click Create Workspace button
    click element  ${workspace_add_another_button}
    ${prompt information}   Catenate    ${workspace_name}    was successfully created.
    wait until element is visible   xpath=//span[contains(.,'${prompt information}')]
    # the Workspace Name & Description are blank in Create new workspace window.
    ${value}   get element attribute   ${workspace_name_input}  value
    should be empty   ${value}
    ${value}   get element attribute   ${workspace_description_input}  value
    should be empty   ${value}
    # click Cancel button
    click element  ${workspace_cancel_button}
    sleep  1s
    [Return]   ${workspace_name}

click_workspace_details
    # Clicks Details button
    wait until element is visible    ${details_button}
    click element     ${details_button}
    sleep  1s
    wait until element is visible   ${edit_members_button}

click_user_details
    # Clicks Details button
    wait until element is visible    ${details_button}
    click element     ${details_button}
    sleep  1s
    wait until element is visible    ${send_reset_password_email}

click_workspace_members
    # Clicks Members button
    click element     ${list_edit_members_button}
    sleep  1s
    wait until element is visible   xpath=//h4[contains(.,'Edit Members of')]

click_edit_members_button
    # Click Edit Members button
    click element   ${edit_members_button}
    sleep  0.5s

click_add_more_users_button
    # Clicks Add More Users button
    click element   ${add_more_users_button}
    sleep  0.5s

select_a_usrs_and_clicks_add_button
    [Arguments]   ${email}
    # select a user
    click element  ${edit_members_search_input}
    sleep  0.5s
    input text  ${edit_members_search_input}    ${email}
    sleep  5s
    ${count}  get element count   ${edit_members_add_button}
    should be equal as integers  ${count}   1
    # add users
    click element   ${edit_members_add_button}
    sleep  3s
    ${count}  get element count   ${edit_members_delete_button}
    should be equal as integers  ${count}   1
    # close Add More Users... page
    click element   xpath=//div[@class="Members"]/../../div[1]//span[contains(.,'×')]
    sleep  1s

click_cancel_and_ok_button
    [Arguments]  ${email}
    # select the newly added user
    click element  ${edit_members_search_input}
    sleep  0.5s
    input text  ${edit_members_search_input}    ${email}
    sleep  5s
    ${count}  get element count   ${edit_members_delete_button}
    should be equal as integers  ${count}   1

    # click 'DELETE' button
    click element   ${edit_members_delete_button}
    sleep  1s
    # Clicks 'CANCEL' button
    click element   xpath=//div[@class="modal-footer"]//button[contains(.,'Cancel')]
    sleep  2s
    ${count}  get element count   ${edit_members_delete_button}
    should be equal as integers  ${count}   1

    # click 'DELETE' button
    click element   ${edit_members_delete_button}
    sleep  1s
    # Clicks 'OK' button
    click element   xpath=//div[@class="modal-footer"]//button[contains(.,'OK')]
    sleep  3s
    ${count}  get element count    ${first_data_show}
    should be equal as integers  ${count}   1

search_single_user
    [Arguments]   ${user_name}
    # Enter key words in Search field
    Press Key    ${edit_members_search_input}   \\8
    sleep  0.5s
    input text  ${edit_members_search_input}   ${user_name}
    sleep  3s
    ${count}   get element count  xpath=//div[@row-index="0"]//div[@class="cardName" and contains(.,'${user_name}')]
    should be equal as integers   ${count}  1

search_new_added_user
    [Arguments]   ${user_name}
    # Enter key words in Search field
    input text   ${search_input}  ${user_name}
    sleep  3s
    ${count}   get element count   ${get_number_of_rows}
    should be equal as integers   ${count}  1

click_add_user
    # click button of add user
    click element  ${button_add_user}
    sleep  1s
    wait until element is visible   ${add_another_input}

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
    [Return]   ${email_before}   ${email}

add_normal_user
    # click ADD USER button
    click_add_user
    # fill basic message
    ${email_before}   ${email}   fill_basic_message
    # Enter groups
    click element  ${groups_input}
    sleep  1s
    click element   xpath=//div[@unselectable="on"]//li[1]
    sleep  0.5s
    click element   ${button_ADD}
    sleep  1s
    [Return]   ${email_before}   ${email}

add_normal_user_without_workspaces
    # click ADD USER button
    click_add_user
    # fill basic message
    ${email_before}   ${email}    fill_basic_message
    # click ADD button
    click element   ${button_ADD}
    sleep  1s
    # Check prompt Information
    ${information}    Catenate    ${email_before}    ${was_successfully_invited}
    wait until element is visible    ${prompt_information}    3s   #  message of Add Success
    ${get_information}   get text   ${prompt_information}
    should be equal as strings    ${information}    ${get_information}
    wait until element is not visible    ${prompt_information}   20s
    [Return]   ${email_before}   ${email}

add_normal_user_select_one_workspaces
    # click ADD USER button
    click_add_user
    # fill basic message
    ${email_before}   ${email}    fill_basic_message
    # Add workspace for user
    click element  ${workspaces_input}
    sleep  1s
    input text   ${workspaces_input}   auto_default_workspace
    sleep  1s
    click element   xpath=//ul[@role='listbox']/li[1]
    sleep  0.5s
    [Return]   ${email_before}   ${email}

add_normal_user_select_one_workspaces_cancel
    # Enter basic information
    ${email_before}   ${email}  add_normal_user_select_one_workspaces
    # click CANCEl button
    click element   ${cancel_add_user_button}
    sleep  1s

add_normal_user_select_one_workspaces_confirm
    # Enter basic information
    ${email_before}   ${email}  add_normal_user_select_one_workspaces
    # click ADD button
    click element   ${button_ADD}
    sleep  1s
    # Check prompt Information
    ${information}    Catenate    ${email_before}    ${was_successfully_invited}
    wait until element is visible    ${prompt_information}    3s   #  message of Add Success
    ${get_information}   get text   ${prompt_information}
    should be equal as strings    ${information}    ${get_information}
    wait until element is not visible    ${prompt_information}    20s
    [Return]   ${email_before}   ${email}

add_normal_user_click_submit_and_add_another_button
    # Enter basic information
    ${email_before}   ${email}  add_normal_user_select_one_workspaces
    # click Submit and Add another button
    click element   ${add_another_input}
    sleep  1s
    # Check prompt Information
    ${information}    Catenate    ${email_before}    ${was_successfully_invited}
    wait until element is visible    ${prompt_information}    3s   #  message of Add Success
    ${get_information}   get text   ${prompt_information}
    should be equal as strings    ${information}    ${get_information}
    wait until element is not visible    ${prompt_information}   20s
    [Return]   ${email_before}   ${email}

add_workspace_for_user
    # Add workspace for user
    click element  ${workspaces_input}
    sleep  1s
    input text   ${workspaces_input}   auto_default_workspace
    sleep  1s
    click element   xpath=//ul[@role='listbox']/li[1]
    sleep  1s
    # click Update User button
    click element  ${update_user_button}
    sleep  1s

listed_belong_to_workspaces
    # Display number of users
    click element  xpath=//input[@role="listbox"]
    ${count}   get element count   xpath=//ul[@role="listbox" and @class="k-list k-reset"]/li
    should be equal as integers  ${count}  3
    sleep  1s

select_randomly_user
    # Select randomly users
    click element   xpath=//ul[@role="listbox" and @class="k-list k-reset"]/li[3]
    sleep  1s
    ${count}   get element count   xpath=//ul[@class="k-reset" and @role="listbox"]/li
    should be equal as integers   ${count}   2

clicks_x_button_beside_of_one_user
    # clicks 'x' button beside of one user.
    click element   xpath=//ul[@class="k-reset" and @role="listbox"]/li[2]/span[@aria-label="delete"]
    sleep  0.5s
    ${count}   get element count   xpath=//ul[@class="k-reset" and @role="listbox"]/li
    should be equal as integers   ${count}   1

deactivate_workspace_cancel
    # Clicks 'Deactivate workspace' button
    click element   ${deactivate_workspace_button}
    sleep  1s
    # Leave alert and get its message.
    ${count}   get element count   xpath=//div[text()="Are you sure you want to deactivate this workspace?"]
    should be equal as integers   ${count}   1
    sleep  1s
    # Cancel alert
    click element    xpath=//button[@class="k-button" and text()="Cancel"]
    sleep  1s
    # Close the bounced
    click element   xpath=//div[@class="modal-header"]//span[contains(.,'×')]
    sleep  1s

deactivate_workspace_ok
    # Clicks 'Deactivate workspace' button
    click element   ${deactivate_workspace_button}
    sleep  1s
    # OK
    click element    ${latest_modified_window_ok_button}
    sleep  1s
    wait until element is visible  xpath=//span[contains(.,'Workspace has been deactivated')]
    sleep  5s
    # the workspace State of this workspace is changed to 'Inactive' in the list.
    ${status}   get text   xpath=//div[@row-index="0"]//div[@col-id="activeText"]
    should be equal as strings   ${status}   Inactive

workspace_should_be_shown_up_or_not
    [Arguments]    ${count}
    # click ADD USER
    click element   ${button_add_user}
    sleep  1s
    # Navigates to Site Administration -> Users -> details,  In workspace list, there is not 'inactivated' this workspace.
    click element  ${workspaces_input}
    sleep  0.5s
    input text   ${workspaces_input}  WS-C
    sleep  0.5s
    ${get_count}   get element count   xpath=//ul[@role="listbox" and @class="k-list k-reset"]/li
    should be equal as strings   ${get_count}   ${count}
    # Close the bounced
    click element   ${close_details_button}
    sleep  0.5s

activate_workspace
    # Click 'Activate workspace'
    click element   ${activate_workspace_button}
    sleep  0.5s
    wait until element is visible    xpath=//span[contains(.,'Workspace has been activated')]
    sleep  5s
    # the workspace State of this workspace is changed to 'Active' in the list.
    ${status}   get text   xpath=//div[@row-index="0"]//div[@col-id="activeText"]
    should be equal as strings   ${status}   Active

the_workspace_is_correct
    # the workspace is correct.
    ${get_text}  get text  xpath=//div[@class="workspace-dropdown-container"]
    should be equal as strings  ${get_text}   auto_default_workspace

field_content_is_empty
    # The Email, Name, Title, Location, Mobile Phone should be blank.
    ${get_email}   get element attribute   ${input_email}   value
    should be empty    ${get_email}
    ${get_name}   get element attribute   ${input_name}    value
    should be empty    ${get_name}
    ${get_title}   get element attribute   ${title_input}    value
    should be empty    ${get_title}
    ${get_location}   get element attribute   ${location_input}    value
    should be empty    ${get_location}

upload_a_photo
    [Arguments]   ${count_email}
    # click DETAILS button
    click_user_details
    # upload photo
    ${picture_path}   get_modify_picture_path     picture.jpg
    wait until element is visible    ${upload_avator_button_xpath}    20
    Choose file    ${upload_photo_button}    ${picture_path}
    sleep  0.5s
    wait until element is visible    ${remove_avatar_button}
    sleep  0.5s
    # check message
    wait until element is visible   ${message_text}   5s
    ${get_prompt_information}  get text  ${message_text}
    ${information}   catenate    ${count_email}    was successfully updated
    should be equal as strings   ${get_prompt_information}   ${information}
    sleep  1s
    wait until element is not visible  ${message_text}    20s

modify_user_basic_info
    # Modify License Type, Username, Name, Title, Location, Mobile Phone, Role
    wait until element is not visible    ${prompt_information}    20s
    # modify License Type
    click element   xpath=//div[@class="form-group"]//span[@role="listbox"]/span[@class="k-select"]
    sleep  0.5s
    click element   ${team_license_type}
    sleep  0.5s
    ${random}   evaluate    int(time.time()*1000000)    time
    ${username}   Catenate   SEPARATOR=+   ${my_existent_email_name}  ${random}
    # modify Name
    click element  ${input_name}
    sleep  0.5s
    input text   ${input_name}   ${username}
    sleep  0.5s
    # modify Title
    click element  ${title_input}
    sleep  0.5s
    input text   ${title_input}   ${username}
    sleep  0.5s
    # modify Location
    click element  ${location_input}
    sleep  0.5s
    input text   ${location_input}   ${username}
    sleep  0.5s
    # modify Role
    click element  ${role_select}
    sleep  0.5s
    click element   ${select_site_admin}
    sleep  0.5s
    # 滑动到底
    swipe_browser_to_bottom
    sleep  0.5s
    # click Update User button
    click element    ${update_user_button}
    sleep  3s
    wait until element is not visible  ${update_user_button}  20s
    wait until element is not visible    ${prompt_information}    20s
    [Return]    ${username}

select_a_worksapce_and_click_at_details
    wait until element is not visible    ${prompt_information}    20s
    # click DETAILS button
    click_user_details
    # Click this workspace
    click element   xpath=//li[@role="option"]//span[contains(.,'auto_default_workspace')]
    sleep  2s
    wait until element is not visible   ${message_text}   20s
    element should be visible   xpath=//h4[@class="modal-title"]/b[contains(.,'User Details - auto_default_workspace Workspace')]
    ${get_value}  get element attribute     ${details_pre_xpath}//label[contains(.,'Email')]/../div    class
    should contain   ${get_value}   read-only
    # upload photo
    ${picture_path}   get_modify_picture_path    picture.jpg
    wait until element is visible     ${details_pre_xpath}//button[contains(.,'Upload a photo...')]       20
    Choose file     ${details_pre_xpath}//input[@type="file"]    ${picture_path}
    sleep  3s
    wait until element is not visible    ${prompt_information}    20s

select_a_worksapce_and_click_at_add
    [Arguments]  ${email_before}   ${email}
    # Click this workspace
    click element   xpath=//li[@role="option"]//span[contains(.,'auto_default_workspace')]
    sleep  1s
    wait until element is visible   ${message_text}
    ${get_message}   get text   ${message_text}
    ${information}   catenate    ${email_before}    ${was_successfully_invited}
    should be equal as strings    ${get_message}   ${information}
    wait until element is not visible   ${message_text}   20s
    element should be visible   xpath=//h4[@class="modal-title"]/b[contains(.,'Add User - auto_default_workspace Workspace')]
    ${get_value}  get element attribute     ${add_pre_xpath}//input[@placeholder="Email"]    value
    should be equal as strings   ${get_value}   ${email}
    ${get_value}  get element attribute     ${add_pre_xpath}//input[@placeholder="Name"]    value
    should be equal as strings   ${get_value}   ${email_before}

change_avatar_then_remove
    [Arguments]  ${count_email}
    # Change avatar then Remove avatar
    wait until element is not visible    ${prompt_information}    20s
    # Gets the id of the image on the file server
    ${before_modify_avatar}  get element attribute    ${details_pre_xpath}//img[@class="avatar-preview"]    src
    # change avatar
    ${modify_picture_path}   get_modify_picture_path
    wait until element is visible    ${details_pre_xpath}//button[contains(.,"Change avatar...")]      20
    Choose file    ${details_pre_xpath}//input[@type="file"]     ${modify_picture_path}
    # check message
    wait until element is visible   ${message_text}   5s
    ${get_prompt_information}  get text  ${message_text}
    ${information}   catenate    ${count_email}    was successfully updated
    should be equal as strings   ${get_prompt_information}   ${information}
    sleep  1s
    wait until element is not visible  ${message_text}   20s
    # Gets the id of the image on the file server again
    ${after_modify_avatar}  get element attribute   ${details_pre_xpath}//img[@class="avatar-preview"]    src
    should not be equal as strings   ${modify_picture_path}   ${after_modify_avatar}
    sleep  0.5s
    # Click Remove avatar button
    click element   ${details_pre_xpath}//button[contains(.,"Remove avatar")]
    sleep  1s
    click element   ${latest_modified_window_ok_button}
    sleep  1s
    ${get_avatar}   get element attribute   ${default_avatar}   src
    should start with   ${get_avatar}    data:image/png;base64

cancel_then_add_user
    wait until element is not visible  ${message_text}   20s
    # Click 'Cancel' button
    click element    ${add_pre_xpath}//button[contains(.,'Cancel')]
    sleep  1s
    ${count}   get element count   ${add_another_input}
    should be equal as integers  ${count}  1
    # Enter Title, Location, Phone, License type, Role, Group. and Click 'Add' button
    # Click this workspace
    click element   xpath=//li[@role="option"]//span[contains(.,'auto_default_workspace')]
    sleep  2s
    wait until element is not visible  ${message_text}   20s
    # modify Name
    ${random}   evaluate    int(time.time()*1000000)    time
    ${username}   Catenate   SEPARATOR=+   ${my_existent_email_name}  ${random}
    click element    ${add_pre_xpath}//input[@placeholder="Title"]
    sleep  0.5s
    input text    ${add_pre_xpath}//input[@placeholder="Title"]   ${username}
    sleep  0.5s
    # Enter Title
    click element    ${add_pre_xpath}//input[@placeholder="Title"]
    sleep  0.5s
    input text     ${add_pre_xpath}//input[@placeholder="Title"]   ${username}
    sleep  0.5s
    # Enter Location
    click element    ${add_pre_xpath}//input[@placeholder="Location"]
    sleep  0.5s
    input text     ${add_pre_xpath}//input[@placeholder="Location"]   ${username}
    sleep  0.5s
    # Enter License type
    click element    ${add_pre_xpath}//span[@role="listbox"]/span[@class="k-select"]
    sleep  0.5s
    click element    ${team_license_type}
    sleep  0.5s
    # Enter Group
    click element   ${add_pre_xpath}//span[@class="k-searchbar"]/input
    sleep  0.5s
    input text     ${add_pre_xpath}//span[@class="k-searchbar"]/input   autogroup+sje
    sleep  1s
    click element   xpath=//div[@unselectable="on"]//ul[@role='listbox']/li[1]
    sleep  0.5s
    # click 'ADD' button
    click element    ${add_pre_xpath}//button[contains(.,'Add')][2]
    # check message
    wait until element is visible   ${message_text}   5s
    ${get_prompt_information}  get text  ${message_text}
    should contain      ${get_prompt_information}   ${was_successfully_invited}
    sleep  1s
    wait until element is not visible  ${message_text}   20s

cancel_then_update_user
    wait until element is not visible  ${message_text}   20s
    # Click 'Cancel' button
    click element    ${details_pre_xpath}//button[contains(.,'Cancel')]
    sleep  1s
    ${count}   get element count   ${deactivate_user_button}
    should be equal as integers  ${count}  1
    # Enter Title, Location, Phone, License type, Role, Group then Click 'Update User' button
    # Click this workspace
    click element   xpath=//li[@role="option"]//span[contains(.,'auto_default_workspace')]
    sleep  2s
    wait until element is not visible  ${message_text}   20s
    # modify Username
    ${random}   evaluate    int(time.time()*1000000)    time
    ${username}   Catenate   SEPARATOR=+   ${my_existent_email_name}  ${random}
    click element    ${details_pre_xpath}//input[@placeholder="Title"]
    sleep  0.5s
    input text    ${details_pre_xpath}//input[@placeholder="Title"]   ${username}
    sleep  0.5s
    # Enter Title
    click element    ${details_pre_xpath}//input[@placeholder="Title"]
    sleep  0.5s
    input text     ${details_pre_xpath}//input[@placeholder="Title"]   ${username}
    sleep  0.5s
    # Enter Location
    click element    ${details_pre_xpath}//input[@placeholder="Location"]
    sleep  0.5s
    input text     ${details_pre_xpath}//input[@placeholder="Location"]   ${username}
    sleep  0.5s
    # Enter License type
    click element    ${details_pre_xpath}//span[@role="listbox"]/span[@class="k-select"]
    sleep  0.5s
    click element   ${expert_license_type}
    sleep  0.5s
    # Enter Role
    click element   ${details_pre_xpath}//select[@name="role"]
    sleep  0.5s
    click element   ${details_pre_xpath}//select[@name="role"]/option[contains(.,'Group Admin')]
    sleep  0.5s
    # Enter Group
    click element   ${details_pre_xpath}//span[@class="k-searchbar"]/input
    sleep  0.5s
    input text     ${details_pre_xpath}//span[@class="k-searchbar"]/input   auto_default_group
    sleep  2s
    click element   xpath=//div[@unselectable="on"]//ul[@role='listbox']/li[1]
    sleep  1s
    # click 'UPDATE USER' button
    click element   ${details_pre_xpath}//button[contains(.,'Update User')]
    # check message
    wait until element is visible   ${message_text}   5s
    ${get_prompt_information}  get text  ${message_text}
    should contain      ${get_prompt_information}   was successfully updated
    sleep  1s
    wait until element is not visible  ${message_text}   20s

send_reset_password_email
    # Click 'Send Reset Password email' button
    click element  ${send_reset_password_email}
    sleep   5s
    wait until element is not visible    ${prompt_information}    20s

setting_password_email
    sleep  20s
    ${email_link}   get_email_link   Change My Password:
    should contain   ${email_link}     ${Citron_web_url}
    # Open another Windows window
    Execute JavaScript    window.open('${email_link}')
    sleep  2s
    # change My password
    change_my_password

deactivate_user
    # click DETAILS button
    click_user_details
    # Click Deactivate User button
    sleep  1s
    click element   ${deactivate_user_button}
    sleep  1s
    # Leave alert and get its message.
    ${count}   get element count     xpath=//div[text()="Are you sure you want to deactivate this user?"]
    should be equal as strings   ${count}    1
    # Cancel alert
    click element    xpath=//button[@class="k-button" and text()="Cancel"]
    sleep  2s
    # Click Deactivate User button
    click element   ${deactivate_user_button}
    sleep  1s
    # click OK
    click element    xpath=//button[text()="Ok"]
    wait until element is visible    ${message_text}
    ${message}  get text    ${message_text}
    should be equal as strings  ${message}    Account has been deactivated
    wait until element is not visible    ${message_text}    20s

enter_deactivated_users_page
    # enter Deactivated Users page
    wait until element is visible   ${deactivated_users_page}
    click element   ${deactivated_users_page}
    wait until element is visible    ${first_data_show}   20

select_deactivated_users
    [Arguments]   ${email}
    # enter Deactivated Users page
    enter_deactivated_users_page
    # Select Deactivated Users
    click element  ${search_input}
    sleep  0.5s
    input text  ${search_input}  ${email}
    sleep  3s
    ${count}   get element count  ${get_number_of_rows}
    should be equal as integers   ${count}   1

display_five_submenus
    # Has Workspaces, Site Setting, Dashboard, Users, Calls
    ${count}   get element count   xpath=//div[@role="tree"]/div[3]//div[@role="treeitem"]
    should be equal as integers   ${count}    5
    # Check out the five submenus
    @{submenus_list}=    Create List    Analytics  Workspaces  Users  Calls  Site Settings
    FOR   ${i}   IN RANGE   ${count}
        ${get_text}   get text    xpath=//div[@role="tree"]/div[3]//div[@role="treeitem"][${i}+1]
        should be equal as strings   ${get_text}    ${submenus_list}[${i}]
    END

workspace_field_should_be_drop_down_menu
    # Workspace field should be drop down menu
    click element    ${workspace_role_list}
    sleep  1s
    ${count}  get element count    xpath=//ul[@role="listbox" and @class="k-list k-reset"]/li
    should not be equal as numbers   ${count}   0

select_one_workspace_from_drop_down_menu
    # Select one workspace from drop down menu
    ${workspace_text}  get text   ${second_workspace_xpath}
    click element    ${second_workspace_xpath}
    sleep  2s
    # Gets the text of the workspace
    ${header_get}    get text   xpath=//div[@id="k-panelbar-item-default-.1"]/span
    # Joining together
    ${workspace_text_after}  converts_string_to_uppercase   ${workspace_text}
    ${information}    Catenate    ${workspace_text_after}   ADMINISTRATION
    should be equal as strings    ${information}   ${header_get}
    [Return]   ${workspace_text}

select_default_workspace
    # Workspace field should be drop down menu
    click element    ${workspace_role_list}
    sleep  1s
    # Select default workspace
    click element    xpath=//ul[@role="listbox" and @class="k-list k-reset"]/li[1]
    sleep  2s

log_out_from_citron
    # log out
    click element   xpath=//button[@id="currentAccount"]
    sleep  1s
    click element   xpath=//i[@class="fa fa-sign-out"]
    sleep  1s

re_log_in_citron
    # 输入账号
    wait until element is visible   ${loginname_input}
    Input Text    ${loginname_input}    ${site_admin_username}
    # 点击NEXT
    wait until element is visible    ${next_button}
    Click Button    ${next_button}
    # 输入密码
    wait until element is visible   ${loginpsd_input}
    Input Password    ${loginpsd_input}    ${site_admin_password}
    Sleep    1s
    # 点击LOG IN
    wait until element is visible   ${login_button}
    Click Button    ${login_button}
    Sleep    2s
    ${count}  get element count  ${accept_button}
    Run Keyword If   '${count}'=='1'    click element   ${accept_button}
    sleep  1s
    Comment    弹框包含"Welcome to Help Lightning!"
    Wait Until Page Contains    ${log_in_success_tag}     20
    sleep  1s
    # close popup
    Click Button    ${button_of_popup}
    sleep    1s

the_workspace_field_should_be_the_selected_one_before_loging_out
    [Arguments]   ${workspace_text}
    # the workspace field shoud be the selected one before loging out.
    ${workspace_text_get}  get text   xpath=//span[@class="k-input"]/span/span
    should be equal as strings   ${workspace_text_get}   ${workspace_text}

display_six_widgets
    FOR   ${i}    IN RANGE   0    5
        sleep  15s
        ${count}   get element count   xpath=//div[@id="MainDashboardTab"]//th[@class="DashboardWidgetTitle"]
        Exit For Loop If    '${count}'=='6'
        Run Keyword If      '${count}'!='6'    sleep   1s
        Run Keyword If      '${i}'=='4'     should be equal as numbers    ${count}    6
    END
    # Check out the six widgets
    @{widgets_list}=    Create List    Call Volume   Average Time on Call   Completed Calls   Users   Calls by Group    Tag Rankings
    FOR   ${one}   IN  @{widgets_list}
        element should be visible    xpath=//th[contains(.,'${one}')]
    END

select_1_workspace
    [Arguments]   ${workspace_name}
    # Completed Calls data for all workspaces
    ${completed_calls_count_all}   get text   ${number_of_completed_calls}
    ${total_users_count_all}   get text    ${number_of_total_users}
    # Select 1 workspace
    click element   ${workspace_select_box}
    sleep  1s
    click element    xpath=//option[contains(.,'${workspace_name}')]
    sleep  15s
    # All feilds will be changed according to this workspace.
    ${completed_calls_count_a}   get text   ${number_of_completed_calls}
    ${total_users_count_a}   get text    ${number_of_total_users}
    should not be equal as strings   ${completed_calls_count_all}   ${completed_calls_count_a}
    should not be equal as strings   ${total_users_count_all}   ${total_users_count_a}
    # Calls by Group & Tag Rankings hasn't [Workspace name]
    ${count}  get element count   ${number_of_calls_by_group}
    FOR   ${i}   IN RANGE   ${count}
        ${get_text}   get text    ${number_of_calls_by_group}
        should not contain   ${get_text}   :
    END
    ${count}  get element count    ${number_of_tag_rankings}
    FOR   ${i}   IN RANGE   ${count}
        ${get_text}   get text     ${number_of_tag_rankings}
        should not contain   ${get_text}   :
    END

select_all_workspaces
    # Select 'All Workspaces'
    click element   ${workspace_select_box}
    sleep  1s
    click element    xpath=//option[contains(.,'All Workspaces')]
    sleep  15s
    # Calls by Group & Tag Rankings hasn't [Workspace name]
    ${count}  get element count   ${number_of_calls_by_group}
    FOR   ${i}   IN RANGE   ${count}
        ${get_text}   get text   ${number_of_calls_by_group}
        should contain   ${get_text}   default
    END
    ${count}  get element count    ${number_of_tag_rankings}
    FOR   ${i}   IN RANGE   ${count}
        ${get_text}   get text     ${number_of_tag_rankings}
        should contain   ${get_text}   :
    END

occurred_within
    # get The date range before Select one of value form drop menu
    ${time_before_1}  get text   xpath=//div[@class="DashboardWidget col-md-6"]//span[@class="ToolTip"][1]
    ${time_before_2}  get text   xpath=//div[@class="DashboardWidget col-md-6"]//span[@class="ToolTip"][2]
    # get all the widgets on the dashboard report before Select one of value form drop menu
    ${completed_calls_count_before}   get text   ${number_of_completed_calls}
    # Select one of value form drop menu
    click element   xpath=//option[contains(.,'Today')]/..
    sleep  1s
    click element   xpath=//option[contains(.,'Today')]
    sleep  15s
    # get The date range after Select one of value form drop menu
    ${time_after_1}  get text   xpath=//div[@class="DashboardWidget col-md-6"]//span[@class="ToolTip"][1]
    ${time_after_2}  get text   xpath=//div[@class="DashboardWidget col-md-6"]//span[@class="ToolTip"][2]
    should not be equal as strings   ${time_before_1}   ${time_after_1}
    should not be equal as strings   ${time_before_2}   ${time_after_2}
    # get all the widgets on the dashboard report after Select one of value form drop menu
    ${completed_calls_count_after}   get text   ${number_of_completed_calls}
    should not be equal as strings  ${completed_calls_count_after}   ${completed_calls_count_before}

select_one_of_value_in_occurred_within_field
    # Select one of value in 'Occurred Within' field
    clear element text   ${occurred_input}
    sleep  0.5s
    ${system_type}   get_system_type
    Assign Id To Element       ${occurred_input}       time1
    Execute Javascript    window.document.getElementById('time1').value='11/12/2021'
    sleep  0.5s
    ${count}  get element count  ${get_number_of_rows}
    should be equal as integers    ${count}   4

select_one_of_value_in_page_size
    sleep  10s
    ${count_before}  get text   xpath=//span[@ref="lbLastRowOnPage"]
    should be equal as integers  ${count_before}  100
    # Select one of value in 'Page Size'
    click element  xpath=//select[@id="pagination-size"]
    sleep  1s
    click element  xpath=//option[@value="250"]
    sleep  10s
    ${count_after}  get text   xpath=//span[@ref="lbLastRowOnPage"]
    should be equal as integers  ${count_after}  250
    # reset
    click element  xpath=//select[@id="pagination-size"]
    sleep  1s
    click element  xpath=//option[@value="100"]
    sleep  3s

enter_key_words_in_search_field
    # Enter key words in Search field
    click element  ${search_input}
    sleep  0.5s
    input text  ${search_input}   @outlook.com
    sleep  3s
    ${count}   Get Element Count    ${get_number_of_rows}   # Gets how many rows are in the result of the query
    should not be equal as numbers  ${count}  0
    FOR   ${i}   IN RANGE  10
        ${get_owner_text}   get text    xpath=//div[@class="ag-center-cols-container"]/div[@row-index="${i}"]/div[@col-id="owner_email"]
        should contain    ${get_owner_text}    @outlook.com
    END
    clear element text   ${search_input}
    sleep  3s

select_all_workspace_in_workspace_field
    # choose Last 2 Weeks
    click element  xpath=//label[contains(.,'Occurred Within')]/../select[@id="occured-within"]
    sleep  0.5s
    click element  xpath=//option[contains(.,'Last 2 Weeks')]
    sleep  0.5s
    # Wait until the first row shows up
    wait until element is visible    ${first_data_show}    20
    sleep  10s
    ${count_before}  get text   ${calls_get_counts}
    # Select 'All workspace' in workspace field
    click element   xpath=//label[contains(.,'Workspace')]/..//select[@id="occured-within"]
    sleep  0.5s
    click element   xpath=//option[contains(.,'All Workspaces')]
    sleep  40s
    ${count_after}  get text   ${calls_get_counts}
    should not be equal as integers   ${count_before}  ${count_after}

sort_calls_by_different_condition
    [Arguments]    ${sort_xpath}    ${col_id}
    # sort order by Owner
    click element   ${sort_xpath}
    sleep  1s
    @{OwnerList}=    Create List
#    ${count}   get element count   ${get_number_of_rows}
    FOR   ${i}   IN RANGE    10
        wait until element is visible   xpath=//div[@row-index="${i}"]/div[@col-id="${col_id}"]
        ${get_owner_text}   get text    xpath=//div[@row-index="${i}"]/div[@col-id="${col_id}"]
        Append To List    ${OwnerList}    ${get_owner_text}
    END
    log  ${OwnerList}
    @{owner_list_order}   sort_order_list   ${OwnerList}
    ${result}   two_lists_are_identical   ${owner_list_order}   ${OwnerList}
    should be equal as strings   ${result}   The two lists are identical
    # Sort in reverse order by name
    click element  ${sort_xpath}
    sleep  1s
    @{OwnerList}=    Create List
    FOR   ${i}   IN RANGE    10
        ${get_owner_text}   get text    xpath=//div[@row-index="${i}"]/div[@col-id="${col_id}"]
        Append To List    ${OwnerList}    ${get_owner_text}
    END
    log  ${OwnerList}
    ${owner_list_order}   sort_inverted_order_list   ${OwnerList}
    ${result}   two_lists_are_identical   ${owner_list_order}   ${OwnerList}
    should be equal as strings   ${result}   The two lists are identical

sort_calls_by_occurred
    # sort order by Owner
    click element    ${sort_by_occurred}
    sleep  1s
    @{OccurredList}=    Create List
#    ${count}   get element count   ${get_number_of_rows}
    FOR   ${i}   IN RANGE  10
        ${get_occurred_text}   get text    xpath=//div[@row-index="${i}"]/div[@col-id="timeCallStarted"]
        ${get_occurred_text}   changed_data_to_the_exact_time   ${get_occurred_text}
        Append To List    ${OccurredList}    ${get_occurred_text}
    END
    log  ${OccurredList}
    @{occurred_list_order}   sort_order_list   ${OccurredList}
    ${result}   two_lists_are_identical   ${occurred_list_order}   ${OccurredList}
    should be equal as strings   ${result}   The two lists are identical
    # Sort in reverse order by name
    click element    ${sort_by_occurred}
    sleep  1s
    @{OccurredList}=    Create List
    FOR   ${i}   IN RANGE  10
        ${get_occurred_text}   get text    xpath=//div[@row-index="${i}"]/div[@col-id="timeCallStarted"]
        ${get_occurred_text}   changed_data_to_the_exact_time   ${get_occurred_text}
        Append To List    ${OccurredList}    ${get_occurred_text}
    END
    log  ${OccurredList}
    ${occurred_list_order}   sort_inverted_order_list   ${OccurredList}
    ${result}   two_lists_are_identical   ${occurred_list_order}   ${OccurredList}
    should be equal as strings   ${result}   The two lists are identical

delete_zip_and_csv_file
    # delete all download zip file
    delete_zip_file
    # delete all download report.csv file
    check_file_and_delete   report.csv

click_export_button
    # click Export button
    click element   ${export_button}
    sleep  2s

create_new_call_report
    # click Export button
    click_export_button
    # click Generate New Call Report button
    click element  ${generate_new_call_report_button}
    wait until element is visible   ${Preparing_Call_Report}
    wait until element is not visible   ${Preparing_Call_Report}    240
    # click
    click element   ${generated_table}
    sleep  10s

check_zip_report_file_data
    # Read the first and second line field of the report.csv file
    ${first_lines}   ${second_lines}  read_zip_file_check_cloumns
    @{title_list}=    Create List   id  started_at  ended_at  tags  comments  groups  participants  dialer  status  duration  workspace  workspace_id
    FOR   ${i}   IN RANGE  0   12
        should be equal as strings    ${first_lines}[${i}]      ${title_list}[${i}]
    END
    should not be empty   ${second_lines}

set_call_tag_comment_on
    # set call tag & comment feature = ON
    click element   ${off_status_xpath}
    sleep  1s

set_call_tag_comment_off
    # set call tag & comment feature = OFF
    click element  ${on_status_xpath}
    sleep  1s

tag_column_should_not_be_shown_up
    # set call tag & comment feature = OFF
    ${on_status}    get element count   ${on_status_xpath}
    Run Keyword If   '${on_status}'=='0'    log to console   The current state is off
    ...  ELSE IF   '${on_status}'=='1'   set_call_tag_comment_off
    sleep  2s
    # enter calls page
    click element   ${enter_calls}
    sleep  2s
    refresh_web_page
    sleep  2s
    element should not be visible   ${tags_column}
    # back to workspace settings page
    click element   ${enter_Workspace_settings}
    wait until element is visible   ${workspace_settings_tag}    20
    sleep  3s

tag_column_should_be_shown_up
    # set call tag & comment feature = ON
    ${off_status}    get element count   ${off_status_xpath}
    Run Keyword If   '${off_status}'=='0'    log to console   The current state is on
    ...  ELSE IF   '${off_status}'=='1'    set_call_tag_comment_on
    sleep  2s
    # enter calls page
    click element   ${enter_calls}
    sleep  2s
    refresh_web_page
    sleep  2s
    element should be visible   ${tags_column}

make_sure_tagging_and_comments_setting_open
    sleep  2s
    # make sure After Call: Tagging and Comments setting is open
    ${count}   get element count   ${open_tag_and_comment}
    Run Keyword If   '${count}'=='1'    open_tagging_and_comments_setting

open_tagging_and_comments_setting
    click element   ${open_tag_and_comment}
    sleep  3s   # Waiting for the configuration to take effect












test_get_driver
    ${driver}    get driver
    [Return]   ${driver}