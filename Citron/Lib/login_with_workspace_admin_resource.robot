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
enter_workspace_users
    # click workspace ADMINISTRATION page menu
    click element   ${enter_workspace_menu}
    sleep  1s
    # click Users page menu
    click element   ${enter_users}
    sleep  2s
    # Wait until the first row shows up
    wait until element is visible    ${first_row_shows_up}    10

enter_site_users
    # click site ADMINISTRATION page menu
    click element   ${enter_site_menu}
    sleep  1s
    # click Users page menu
    click element   ${enter_users}
    sleep  2s
    # Wait until the first row shows up
    wait until element is visible    ${first_row_shows_up}    10

enter_workspace_groups
    # click workspace ADMINISTRATION page menu
    click element   ${enter_workspace_menu}
    sleep  1s
    # click Users page menu
    click element   ${enter_groups}
    sleep  2s
    # Wait until the first row shows up
    wait until element is visible    ${first_row_shows_up}    10

enter_workspace_analytics
    # click workspace ADMINISTRATION menu
    click element   ${enter_workspace_menu}
    sleep  1s
    # click Users page menu
    click element   ${enter_analytics}
    sleep  2s
    # Wait until Dashboard appear
    wait until element is visible    xpath=//b[contains(.,'Dashboard')]    10

enter_workspace_calls
    # click workspace ADMINISTRATION menu
    click element   ${enter_workspace_menu}
    sleep  1s
    # click Users page menu
    click element   ${enter_calls}
    sleep  3s

click_add_user
    # click button of add user
    click element  ${button_add_user}
    sleep  2s

fill_basic_message
    # Enter email
    click element  ${input_email}
    sleep  1s
    ${random}   evaluate    int(time.time()*1000000)    time
    ${email_before}   Catenate   SEPARATOR=+   ${my_existent_email_name}  ${random}
    ${email}    Catenate   SEPARATOR=   ${email_before}    @outlook.com
    input text  ${input_email}    ${email}
    sleep  0.5s
    # Enter name
    click element  ${input_name}
    sleep  1s
    input text   ${input_name}   ${email_before}
    sleep  0.5s
    # Enter title
    click element   ${title_input}
    sleep  1s
    input text  ${title_input}   ${email_before}
    sleep  0.5s
    # Enter Location
    click element   ${location_input}
    sleep  1s
    input text  ${location_input}   ${email_before}
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
    click element   xpath=//div[@unselectable="on"]//li[2]
    sleep  0.5s
    click element   ${button_ADD}
    sleep  2s
    wait until element is not visible   ${submit_and_add_another}
    [Return]   ${email_before}

add_normal_team_user
    # click ADD USER button
    click_add_user
    # fill basic message
    ${email_before}  fill_basic_message
    # change license type to Team
    click element   ${license_type_select}
    sleep  0.5s
    click element   ${team_license_type}
    sleep  0.5s
    # Enter groups
    click element   ${groups_input}
    sleep  1s
    click element   xpath=//div[@unselectable="on"]//li[2]
    sleep  0.5s
    click element    ${button_ADD}
    sleep  2s
    wait until element is not visible   ${submit_and_add_another}
    [Return]   ${email_before}

add_user_clear_group
    # click ADD USER button
    click_add_user
    # fill basic message
    ${email_before}  fill_basic_message
    # change license type to Team
    click element   ${license_type_select}
    sleep  1s
    click element   ${team_license_type}
    sleep  0.5s
    # Enter groups
    click element   ${groups_input}
    sleep  1s
    click element   xpath=//div[@unselectable="on"]//li[2]
    sleep  1s
    # Clear group
    click element   xpath=//span[@class="k-icon k-i-close"]
    sleep  0.5s
    # click ADD button
    click element     ${button_ADD}
    sleep  1s
    element should be visible   ${no_groups_tips}

search_user_details
    [Arguments]   ${email_search}
    # search
    click element    ${input_search}
    sleep  0.5s
    input text   ${input_search}    ${email_search}
    sleep  2s
    click_deatils

search_user_is_missing
    [Arguments]   ${email_search}
    # search
    click element    ${input_search}
    sleep  0.5s
    input text   ${input_search}    ${email_search}
    sleep  2s
    ${count}   get element count    ${get_number_of_rows}
    should be equal as integers  ${count}   0

click_deatils
    # click DETAILS button
    click element  ${button_DETAILS}
    sleep  2s

modify_basic_info
    # upload photo
    ${modify_picture_path}   get_modify_picture_path
    Choose file    ${button_Upload}     ${modify_picture_path}
    sleep  0.5s
    wait until element is visible    ${button_Remove}
    sleep  0.5s
    # modify Name
    click element   ${name_input}
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
    sleep  3s

check_modify_user_success
    sleep  4s
    # click DETAILS button
    click_deatils
    element should be visible   ${button_Remove}     # avator下的Remove avatar按钮
    ${name_after_modify}   get element attribute  ${name_input}  value
    should be equal as strings   ${name_after_modify}   test_modify_name
    ${title_after_modify}   get element attribute  ${title_input}  value
    should be equal as strings   ${title_after_modify}   test_modify_title
    ${location_after_modify}   get element attribute  ${location_input}  value
    should be equal as strings   ${location_after_modify}   test_modify_location
    click element  ${cancel_button}
    sleep  0.5s

modify_user_groups
    # Add another group and submit
    # click DETAILS button
    click_deatils
    click element   ${groups_add}
    sleep  1s
    click element   xpath=//div[@unselectable="on"]//li[6]
    sleep  1s
    # 滑动到底
    swipe_browser_to_bottom
    sleep  0.5s
    click element   ${update_button}
    sleep  3s
    # Remove group and submit
    # click DETAILS button
    click_deatils
    click element  ${second_groups_delete_button}
    sleep  0.5s
    # 滑动到底
    swipe_browser_to_bottom
    sleep  0.5s
    click element   ${update_button}
    sleep  3s
    # Remove all the groups and submit.
    # click DETAILS button
    click_deatils
    click element  ${first_groups_delete_button}
    sleep  1s
    page should contain element   ${no_groups_tips}
    # 滑动到底
    swipe_browser_to_bottom
    sleep  0.5s
    click element  ${cancel_button}
    sleep  0.5s

send_reset_password
    # click DETAILS button
    click_deatils
    # 滑动到底
    swipe_browser_to_bottom
    sleep  0.5s
    click element   ${send_reset_button}
    sleep  0.5s
    wait until element is visible    xpath=//span[contains(.,'Sent reset password email')]   5s   # Notification of successful email sending
    click element   ${cancel_button}
    sleep  0.5s

setting_password_email
    sleep  20s
    ${email_link}   get_email_link   Change My Password:
    should contain   ${email_link}   https://app-stage.helplightning.net.cn
    # Open another Windows window
    Execute JavaScript    window.open('${email_link}')
    sleep  2s
    # change My password
    change_my_password

fill_password_mailbox
    sleep  20s
    ${email_link}   get_email_link   Click here to set your password:
    should contain   ${email_link}   https://app-stage.helplightning.net.cn
    # Open another Windows window
    Execute JavaScript    window.open('${email_link}')
    sleep  2s
    # change My password
    change_my_password

accept_invitation_mailbox
    sleep  20s
    ${email_link}   get_email_link   Accept Invitation:
    should contain   ${email_link}   https://app-stage.helplightning.net.cn
    # Open another Windows window
    Execute JavaScript    window.open('${email_link}')
    sleep  2s
    # Confirm Password
    confirm_my_password

invitation_mail_not_valid
    sleep  20s
    ${email_link}   get_email_link   Accept Invitation:
    should contain   ${email_link}   https://app-stage.helplightning.net.cn
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
    input text  ${input_passwordConfirm}    ${universal_password}
    sleep  0.5s
    click element   ${chage_passwd_button}
    sleep  0.5s
    wait until element is visible    xpath=//h2[contains(.,'You changed your password successfully.')]    5s
    # Switch to the first Windows page
    switch_window_to_first
    sleep  0.5s

confirm_my_password
    # Switch to the second Windows page
    switch_window_to_second
    sleep  0.5s
    # enter password
    click element  ${confirm_password_input}
    sleep  0.5s
    input text  ${confirm_password_input}   ${universal_password}
    sleep  0.5s
    # click JOIN button
    click element   xpath=//button[contains(.,'Join')]
    sleep  0.5s
    wait until element is visible    xpath=//h2[contains(.,'Congratulations, you are in the')]    5s
    # Switch to the first Windows page
    switch_window_to_first
    sleep  0.5s

change_role_to_workspace_admin
    # click DETAILS button
    click_deatils
    # change role to workspace admin
    click element  ${role_select}
    sleep  0.5s
    click element   ${select_workspace_admin}
    sleep  0.5s
    # 滑动到底
    swipe_browser_to_bottom
    sleep  0.5s
    click element  ${update_button}
    sleep  3s
    # Check whether the role is changed successfully
    ${role_text}   get text  xpath=//div[@class="ag-center-cols-container"]/div[@row-index="0"]/div[5]
    should be equal as strings    ${role_text}   Workspace Admin


change_role_to_group_admin
    # click DETAILS button
    click_deatils
    # change role to group admin
    click element  ${role_select}
    sleep  0.5s
    click element   ${select_group_admin}
    sleep  0.5s
    # 滑动到底
    swipe_browser_to_bottom
    sleep  0.5s
    # choose Group Admin for
    click element   xpath=//input[@placeholder="Groups"]
    sleep  1s
    click element   xpath=//div[@unselectable="on"]//li[2]
    sleep  1s
    click element  ${update_button}
    sleep  3s
    # Check whether the role is changed successfully
    ${role_text}   get text  xpath=//div[@class="ag-center-cols-container"]/div[@row-index="0"]/div[5]
    should be equal as strings    ${role_text}   Group Admin

change_role_to_user
    # click DETAILS button
    click_deatils
    # change role to user
    click element  ${role_select}
    sleep  0.5s
    click element   ${select_user}
    sleep  0.5s
    # 滑动到底
    swipe_browser_to_bottom
    sleep  0.5s
    click element  ${update_button}
    sleep  3s
    # Check whether the role is changed successfully
    ${role_text}   get text  xpath=//div[@class="ag-center-cols-container"]/div[@row-index="0"]/div[5]
    should be equal as strings    ${role_text}   User

change_license_type
    # click DETAILS button
    click_deatils
    # change license type
    click element   ${license_type_select}
    sleep  1s
    click element   ${team_license_type}
    sleep  1s
    # 滑动到底
    swipe_browser_to_bottom
    sleep  0.5s
    click element    ${update_button}
    sleep  3s
    # Check whether the license is changed successfully
    ${license_text}   get text  xpath=//div[@class="ag-center-cols-container"]/div[@row-index="0"]/div[4]//p
    should be equal as strings    ${license_text}   Team

deactivate_user
    # click DETAILS button
    click_deatils
    click element  ${deactivate_user_button}
    sleep  2s
    click element   xpath=//button[@class="k-button k-primary ml-4" and text()="Ok"]
    sleep  2s
    element should not be visible    ${first_line_data}      #this user disappears from Active User tab

reactivate_user
    # click DETAILS button
    click_deatils
    # 滑动到底
    swipe_browser_to_bottom
    sleep  0.5s
    # click Activate User button
    click element  ${activate_user_button}
    sleep  5s
    element should not be visible    ${first_line_data}     #this user disappears from Active User tab

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
    click element   xpath=//div[@unselectable="on"]//li[2]
    sleep  0.5s
    click element   ${button_ADD}
    sleep  0.5s
    # Check prompt Information
    ${information}    Catenate    ${email_before}    was successfully invited.
    wait until element is visible    ${prompt_information}    3s   #  message of Add Success
    ${get_information}   get text   ${prompt_information}
    should be equal as strings    ${information}    ${get_information}
    [Return]   ${email_before}

modify_group_admin_groups
    # Add another group and submit
    # click DETAILS button
    click_deatils
    # 滑动到底
    swipe_browser_to_bottom
    sleep  0.5s
    click element   ${add_second_group}
    sleep  1s
    click element   xpath=//div[@unselectable="on"]//li[6]
    sleep  1s
    click element   ${update_button}
    sleep  3s
    # Remove group and submit
    # click DETAILS button
    click_deatils
    # 滑动到底
    swipe_browser_to_bottom
    sleep  0.5s
    click element  ${second_groups_delete_button}
    sleep  0.5s
    click element   ${update_button}
    sleep  3s
    # Remove all the groups and submit.
    # click DETAILS button
    click_deatils
    # 滑动到底
    swipe_browser_to_bottom
    sleep  0.5s
    click element   xpath=//label[contains(.,'Groups')]/..//span[@aria-label="delete"]
    sleep  1s
    page should contain element   ${no_groups_tips}
    click element   ${cancel_button}
    sleep  0.5s

add_workspace_user
    # click ADD USER button
    click_add_user
    # fill basic message
    ${email_before}  fill_basic_message
    # choose Role
    click element  ${role_select}
    sleep  0.5s
    click element   ${select_workspace_admin}
    sleep  0.5s
    # Enter groups
    click element   ${groups_input}
    sleep  1s
    click element   xpath=//div[@unselectable="on"]//li[2]
    sleep  0.5s
    click element   ${button_ADD}
    sleep  1s
    # Check prompt Information
    ${information}    Catenate    ${email_before}    was successfully invited.
    wait until element is visible    ${prompt_information}    3s   #  message of Add Success
    ${get_information}   get text   ${prompt_information}
    should be equal as strings    ${information}    ${get_information}
    [Return]  ${email_before}

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
    sleep  1s
    click element   xpath=//div[@unselectable="on"]//li[1]
    sleep  0.5s
    click element   ${button_ADD}
    sleep  1s
    [Return]   ${email_before}

add_existing_group_admin
    [Arguments]    ${email_before}
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
    # choose Role
    click element  ${role_select}
    sleep  0.5s
    click element   ${select_group_admin}
    sleep  0.5s
    # choose Group Admin for
    click element   ${group_admin_for_choose}
    sleep  1s
    click element   xpath=//div[@unselectable="on"]//li[1]
    sleep  0.5s
    # Enter groups
    click element   ${groups_input}
    sleep  1s
    click element   xpath=//div[@unselectable="on"]//li[1]
    sleep  0.5s
    click element   ${button_ADD}
    sleep  1s
    [Return]   ${email}

add_existing_workspace_admin
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
    # choose Role
    click element  ${role_select}
    sleep  0.5s
    click element   ${select_workspace_admin}
    sleep  0.5s
    # Enter groups
    click element   ${groups_input}
    sleep  1s
    click element   xpath=//div[@unselectable="on"]//li[1]
    sleep  0.5s
    click element   ${button_ADD}
    sleep  1s
    [Return]   ${email}

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
    click element   xpath=//button[contains(.,'Invite')]
    sleep  0.5s
    # check message
    wait until element is visible   ${message_text}   5s
    ${get_prompt_information}  get text  ${message_text}
    ${information}   catenate    ${count_email}    was successfully invited.
    should be equal as strings   ${get_prompt_information}   ${information}

resend_invitation
    # RESEND invitation
    wait until element is not visible   ${message_text}   20s
    click element   ${resend_invitation}
    sleep  1s
    element should be visible   xpath=//span[contains(.,'Invitation has been sent')]
    element should be visible    ${resend_invitation}

resend_all_invitation
    # RESEND invitation
    click element   ${resend_all_invitation}
    sleep  1s
    element should be visible   xpath=//span[contains(.,'Invitations has been sent')]
    element should be visible    ${resend_invitation}

cancel_invitation
    # RESEND invitation
    click element   ${cancel_invitation}
    sleep  1s
    element should not be visible   ${cancel_invitation}

cancel_all_invitation
    # RESEND invitation
    click element   ${cancel_all_invitation}
    sleep  1s
    click element   xpath=//button[@class="k-button k-primary ml-4" and text()="Ok"]
    sleep  1s
    element should not be visible   ${cancel_invitation}

enter_REPORT_VIEW_page
    # click Report View button
    click element  ${report_view_button}
    wait until element is visible   ${first_data_show}   10

sort_invitations_by_name
    ${count}   get element count   ${get_number_of_rows}
    # sort order by name
    click element  ${sort_by_name}
    sleep  1s
    @{NameList}=    Create List
    FOR   ${i}   IN RANGE  ${count}
        ${get_name_text}   get text    xpath=//div[@class="ag-center-cols-container"]/div[@row-index="${i}"]//div[@class="cardName"]
        Append To List    ${NameList}    ${get_name_text}
    END
    log  ${NameList}
    @{name_list_order}   sort_order_list   ${NameList}
    ${result}   two_lists_are_identical   ${name_list_order}   ${NameList}
    should be equal as strings   ${result}   The two lists are identical
    # Sort in reverse order by name
    click element  ${sort_by_name}
    sleep  1s
    @{NameList}=    Create List
    FOR   ${i}   IN RANGE  ${count}
        ${get_name_text}   get text    xpath=//div[@class="ag-center-cols-container"]/div[@row-index="${i}"]//div[@class="cardName"]
        Append To List    ${NameList}    ${get_name_text}
    END
    log  ${NameList}
    ${name_list_order}   sort_inverted_order_list   ${NameList}
    ${result}   two_lists_are_identical   ${name_list_order}   ${NameList}
    should be equal as strings   ${result}   The two lists are identical

sort_list_by_name
    # sort by name
    click element  ${sort_by_name}
    sleep  1s
    @{NameList}=    Create List
    FOR   ${i}   IN RANGE  10
        ${get_name_text}   get text    xpath=//div[@class="ag-center-cols-container"]/div[@row-index="${i}"]/div[2]
        Append To List    ${NameList}    ${get_name_text}
    END
    log  ${NameList}
    @{name_list_order}   sort_order_list   ${NameList}
    ${result}   two_lists_are_identical   ${name_list_order}   ${NameList}
    should be equal as strings   ${result}   The two lists are identical
    # Sort in reverse order by name
    click element  ${sort_by_name}
    sleep  1s
    @{NameList}=    Create List
    FOR   ${i}   IN RANGE  10
        ${get_name_text}   get text    xpath=//div[@class="ag-center-cols-container"]/div[@row-index="${i}"]/div[2]
        Append To List    ${NameList}    ${get_name_text}
    END
    log  ${NameList}
    ${name_list_order}   sort_inverted_order_list   ${NameList}
    ${result}   two_lists_are_identical   ${name_list_order}   ${NameList}
    should be equal as strings   ${result}   The two lists are identical

sort_invitations_by_email
    ${count}   get element count   ${get_number_of_rows}
    # sort by email
    click element  ${sort_by_email}
    sleep  1s
    @{EmailList}=    Create List
    FOR   ${i}   IN RANGE  ${count}
        ${get_email_text}   get text    xpath=//div[@class="ag-center-cols-container"]/div[@row-index="${i}"]//div[@col-id="email"]
        Append To List    ${EmailList}    ${get_email_text}
    END
    log  ${EmailList}
    ${email_list_order}   sort_order_list   ${EmailList}
    ${result}   two_lists_are_identical   ${email_list_order}   ${EmailList}
    should be equal as strings   ${result}   The two lists are identical
    # Sort in reverse order by email
    click element  ${sort_by_email}
    sleep  1s
    @{EmailList}=    Create List
    FOR   ${i}   IN RANGE  ${count}
        ${get_email_text}   get text    xpath=//div[@class="ag-center-cols-container"]/div[@row-index="${i}"]//div[@col-id="email"]
        Append To List    ${EmailList}    ${get_email_text}
    END
    log  ${EmailList}
    ${email_list_order}   sort_inverted_order_list   ${EmailList}
    ${result}   two_lists_are_identical   ${email_list_order}   ${EmailList}
    should be equal as strings   ${result}   The two lists are identical

sort_list_by_email
    # sort by email
    click element  ${sort_by_email}
    sleep  1s
    @{EmailList}=    Create List
    FOR   ${i}   IN RANGE  10
        ${get_email_text}   get text    xpath=//div[@class="ag-center-cols-container"]/div[@row-index="${i}"]/div[5]
        Append To List    ${EmailList}    ${get_email_text}
    END
    log  ${EmailList}
    ${email_list_order}   sort_order_list   ${EmailList}
    ${result}   two_lists_are_identical   ${email_list_order}   ${EmailList}
    should be equal as strings   ${result}   The two lists are identical
    # Sort in reverse order by email
    click element  ${sort_by_email}
    sleep  1s
    @{EmailList}=    Create List
    FOR   ${i}   IN RANGE  10
        ${get_email_text}   get text    xpath=//div[@class="ag-center-cols-container"]/div[@row-index="${i}"]/div[5]
        Append To List    ${EmailList}    ${get_email_text}
    END
    log  ${EmailList}
    ${email_list_order}   sort_inverted_order_list   ${EmailList}
    ${result}   two_lists_are_identical   ${email_list_order}   ${EmailList}
    should be equal as strings   ${result}   The two lists are identical

sort_list_by_role_in_deactive
    # sort by role
    click element  ${sort_by_role}
    sleep  1s
    @{roleList}=    Create List
    FOR   ${i}   IN RANGE  10
        ${get_role_text}   get text    xpath=//div[@class="ag-center-cols-container"]/div[@row-index="${i}"]/div[6]
        Append To List    ${roleList}    ${get_role_text}
    END
    log  ${roleList}
    ${role_list_order}   sort_order_list   ${roleList}
    ${result}   two_lists_are_identical   ${role_list_order}   ${roleList}
    should be equal as strings   ${result}   The two lists are identical
    # Sort in reverse order by name
    click element  ${sort_by_role}
    sleep  1s
    @{roleList}=    Create List
    FOR   ${i}   IN RANGE  10
        ${get_role_text}   get text    xpath=//div[@class="ag-center-cols-container"]/div[@row-index="${i}"]/div[6]
        Append To List    ${roleList}    ${get_role_text}
    END
    log  ${roleList}
    ${role_list_order}   sort_inverted_order_list   ${roleList}
    ${result}   two_lists_are_identical   ${role_list_order}   ${roleList}
    should be equal as strings   ${result}   The two lists are identical

sort_invitations_by_group
    ${count}   get element count   ${get_number_of_rows}
    # sort by groups
    click element  ${sort_by_groups}
    sleep  1s
    @{groupsList}=    Create List
    FOR   ${i}   IN RANGE  ${count}
        ${get_groups_text}   get text    xpath=//div[@class="ag-center-cols-container"]/div[@row-index="${i}"]//div[@col-id="pods"]
        Append To List    ${groupsList}    ${get_groups_text}
    END
    log  ${groupsList}
    ${groups_list_order}   sort_order_list   ${groupsList}
    ${result}   two_lists_are_identical   ${groups_list_order}   ${groupsList}
    should be equal as strings   ${result}   The two lists are identical
    # Sort in reverse order by name
    click element  ${sort_by_groups}
    sleep  1s
    @{groupsList}=    Create List
    FOR   ${i}   IN RANGE  ${count}
        ${get_groups_text}   get text    xpath=//div[@class="ag-center-cols-container"]/div[@row-index="${i}"]//div[@col-id="pods"]
        Append To List    ${groupsList}    ${get_groups_text}
    END
    log  ${groupsList}
    ${groups_list_order}   sort_inverted_order_list   ${groupsList}
    ${result}   two_lists_are_identical   ${groups_list_order}   ${groupsList}
    should be equal as strings   ${result}   The two lists are identical

sort_invitations_by_timestamp
    ${count}   get element count   ${get_number_of_rows}
    # sort by groups
    click element  ${sort_by_timestamp}
    sleep  1s
    @{timestampList}=    Create List
    FOR   ${i}   IN RANGE  ${count}
        ${get_timestamp_text}   get text    xpath=//div[@class="ag-center-cols-container"]/div[@row-index="${i}"]//div[@col-id="invitationTime"]
        ${get_timestamp_text}  changed_data_to_the_exact_time  ${get_timestamp_text}
        Append To List    ${timestampList}    ${get_timestamp_text}
    END
    log  ${timestampList}
    ${timestamp_list_order}   sort_order_list   ${timestampList}
    ${result}   two_lists_are_identical   ${timestamp_list_order}   ${timestampList}
    should be equal as strings   ${result}   The two lists are identical
    # Sort in reverse order by name
    click element  ${sort_by_timestamp}
    sleep  1s
    @{timestampList}=    Create List
    FOR   ${i}   IN RANGE  ${count}
        ${get_timestamp_text}   get text    xpath=//div[@class="ag-center-cols-container"]/div[@row-index="${i}"]//div[@col-id="invitationTime"]
        ${get_timestamp_text}  changed_data_to_the_exact_time  ${get_timestamp_text}
        Append To List    ${timestampList}    ${get_timestamp_text}
    END
    log  ${timestampList}
    ${timestamp_list_order}   sort_inverted_order_list   ${timestampList}
    ${result}   two_lists_are_identical   ${timestamp_list_order}   ${timestampList}
    should be equal as strings   ${result}   The two lists are identical

search_list_by_name
    # search list by name
    ${get_name_text_first}   get text    ${first_row_shows_up}      # Gets the name value of the first line
    click element   ${input_search}
    sleep  0.5s
    input text  ${input_search}  ${get_name_text_first}
    sleep  5s
    ${count}   Get Element Count    ${get_number_of_rows}   # Gets how many rows are in the result of the query
    should not be equal as numbers  ${count}  0
    FOR   ${i}   IN RANGE  ${count}
        ${get_name_text}   get text    xpath=//div[@class="ag-center-cols-container"]/div[@row-index="${i}"]/div[2]//div[@class="cardName"]
        should contain    ${get_name_text}   ${get_name_text_first}
    END

search_list_by_email
    # search list by email
    ${get_email_text_first}   get text    xpath=//div[@class="ag-center-cols-container"]/div[@row-index="0"]/div[3]     # Gets the name value of the first line
    click element   ${input_search}
    sleep  0.5s
    input text  ${input_search}  ${get_email_text_first}
    sleep  5s
    ${count}   Get Element Count    ${get_number_of_rows}   # Gets how many rows are in the result of the query
    should not be equal as numbers  ${count}  0
    FOR   ${i}   IN RANGE  ${count}
        ${get_email_text}   get text    xpath=//div[@class="ag-center-cols-container"]/div[@row-index="${i}"]/div[3]
        should contain    ${get_email_text}   ${get_email_text_first}
    END

search_list_by_role
    # search list by role
    click element   ${input_search}
    sleep  0.5s
    input text  ${input_search}  User
    wait until element is visible     xpath=//div[@class="ag-center-cols-container"]/div[@row-index="1"]    #等到第二条数据出现
    sleep   1s
    ${count}   Get Element Count    ${get_number_of_rows}   # Gets how many rows are in the result of the query
    should not be equal as numbers  ${count}  0
    FOR   ${i}   IN RANGE  3
        ${get_role_text}   get text    xpath=//div[@class="ag-center-cols-container"]/div[@row-index="${i}"]/div[2]
        should contain    ${get_role_text}    user
    END

enter_edit_members_page
    # enter Edit Members page
    click element   ${edit_members_button}
    wait until element is visible   xpath=//button[@class="k-button includeUserButton"]    5s       # Wait for the Add or remove button to appear

enter_groups_edit_members_page
    # enter Edit Members page
    click element   ${members_button}
    wait until element is visible   xpath=//button[@class="k-button includeUserButton"]    5s       # Wait for the Add or remove button to appear

add_team_user_to_expert_group
    # Add Team user to one expert group
    [Arguments]   ${username}
    click element   ${add_more_users_button}
    sleep  3s
    click element  ${search_users_input}
    input text  ${search_users_input}   ${username}
    sleep  5s
    element should not be visible   xpath=//button[@class="k-button includeUserButton"]     # No user data appears


search_users_in_edit_members
    ${get_name_first_line}   get text   ${first_line_use_name}
    click element  ${search_users_input}
    input text  ${search_users_input}  ${get_name_first_line}
    sleep  4s
    @{name_list}=    Create List
    ${count}   Get Element Count    xpath=//div[@class="modal-content"]//div[@class="ag-center-cols-container"]/div   # Gets how many rows are in the result of the query
    should not be equal as numbers  ${count}  0
    FOR   ${i}   IN RANGE  ${count}
        ${get_name_text}   get text    xpath=//div[@class="modal-content"]//div[@row-index="${i}"]/div[2]//div[@class="cardName"]
        should contain    ${get_name_text}   ${get_name_first_line}
    END
    log  ${name_list}

edit_to_add_users
    # click Add More Users... button
    click element  ${add_more_users_button}
    sleep  3s
    # Search by Hello
    click element  ${search_users_input}
    input text   ${search_users_input}  hello
    sleep  3s
    # Get button text
    ${del_or_add}     get text   ${del_or_add_button}
    Run Keyword If   '${del_or_add}'=='ADD'    if_add_button
    ...  ELSE IF   '${del_or_add}'=='DELETE'    if_del_button

get_all_users_number
    # click Add More Users... button
    click element  ${add_more_users_button}
    sleep  3s
    wait until element is visible   xpath=//button[@class="k-button includeUserButton"]    5s       # Wait for the Add or remove button to appear
    # Get user name
    ${count_users_1}   get element count   xpath=//div[@class="modal-content"]//div[@class="ag-center-cols-container"]/div
    [Return]    ${count_users_1}

get_number_of_all_users
    # Gets the number of all users
    ${count_users_2}   get element count   ${get_number_of_rows}
    [Return]    ${count_users_2}

check_users_in_whole_site
    [Arguments]   ${count_users_1}  ${count_users_2}
    should be equal as integers   ${count_users_1}  ${count_users_2}

if_add_button
    # Click the Add button
    click element   ${del_or_add_button}
    sleep  3s
    ${button_text}     get text   ${del_or_add_button}
    should be equal as strings   ${button_text}   DELETE
    # Click the Delete button
    click element   ${del_or_add_button}
    sleep  1s
    click element   ${ok_button}
    sleep  0.5s
    sleep  3s
    ${button_text}     get text   ${del_or_add_button}
    should be equal as strings   ${button_text}   ADD

if_del_button
    # Click the Delete button
    click element   ${del_or_add_button}
    sleep  1s
    click element   ${ok_button}
    sleep  0.5s
    sleep  3s
    ${button_text}     get text   ${del_or_add_button}
    should be equal as strings   ${button_text}   ADD
    # Click the Add button
    click element   ${del_or_add_button}
    sleep  3s
    ${button_text}     get text   ${del_or_add_button}
    should be equal as strings   ${button_text}   DELETE
    # Click the Delete button
    click element   ${del_or_add_button}
    sleep  1s
    click element   ${ok_button}
    sleep  0.5s
    sleep  3s
    ${button_text}     get text   ${del_or_add_button}
    should be equal as strings   ${button_text}   ADD

enter_deactivated_users_page
    # enter Deactivated Users page
    click element   ${deactivated_users_page}
    wait until element is visible    ${first_data_show}   10

enter_invitations_page
    # Enter Invitations page
    click element   ${invitations_page}
    wait until element is visible    ${first_data_show}   10

enter_active_users_page
    # enter Active Users page
    click element   ${active_users_page}
    wait until element is visible    ${first_data_show}    10

search_deactivated_user
    [Arguments]  ${username}
    # search deactivated user
    click element   ${input_search}
    sleep  0.5s
    input text   ${input_search}  ${username}
    sleep  2s
    element should be visible    ${first_line_data}

search_active_user
    [Arguments]  ${username}
    wait until element is not visible     ${prompt_information}    20s
    # Clear the query box
    Press Key    ${input_search}    \\8
    sleep  0.5s
    # search activated user
    click element   ${input_search}
    sleep  0.5s
    input text   ${input_search}  ${username}
    sleep  2s
    element should be visible    ${first_line_data}
    sleep  1s

user_change_group
    [Arguments]  ${group_name}
    # click Details button
    click_deatils
    wait until element is visible    ${deactivate_user_button}
    # Delete group
    click element   xpath=//label[contains(.,'Groups')]/..//span[@aria-label="delete"]
    sleep  0.5s
    # change another group
    click element   ${add_another_group}
    sleep  1s
    input text    ${add_another_group}    ${group_name}
    sleep  1s
    click element   xpath=//ul[@role="listbox"]/li
    sleep  1s
    # click update details button
    click element   ${update_button}
    sleep  4s

check_user_belongs_to_group
    [Arguments]  ${group_name}
    sleep  1s
    # Check which team the user belongs to
    ${get_group}   get text   xpath=//div[@class="ag-center-cols-container"]/div[1]/div[6]
    should be equal as strings    ${get_group}    ${group_name}

check_visibility_testing
    [Arguments]    ${user_name}
    # Final check
    ${count}  get element count  ${get_number_of_rows}
    should be equal as integers   ${count}   1
    ${get_user_name1}  get text   xpath=//div[@class="ag-center-cols-container"]/div[1]//div[@class="cardName"]
    should be equal as strings   ${get_user_name1}    ${user_name}

check_add_standard_member_group
    [Arguments]  ${group_name}
    # Final check
    ${count}  get element count  ${get_number_of_rows}
    should be equal as integers   ${count}   3
    ${get_group_name}  get text   xpath=//div[@class="ag-center-cols-container"]/div[1]//div[@class="cardName"]
    should be equal as strings  ${get_group_name}  ${group_name}
    ${get_user_name1}  get text   xpath=//div[@class="ag-center-cols-container"]/div[2]//div[@class="cardName"]
    should be equal as strings  ${get_user_name1}    ${third_user_name}
    ${get_user_name2}  get text   xpath=//div[@class="ag-center-cols-container"]/div[3]//div[@class="cardName"]
    should be equal as strings  ${get_user_name2}    ${second_user_name}

check_add_standard_member_group1
    [Arguments]  ${group_name}
    # Final check
    ${count}  get element count  ${get_number_of_rows}
    should be equal as integers   ${count}   3
    ${get_group_name}  get text   xpath=//div[@class="ag-center-cols-container"]/div[1]//div[@class="cardName"]
    should be equal as strings  ${get_group_name}  ${group_name}
    ${get_user_name1}  get text   xpath=//div[@class="ag-center-cols-container"]/div[2]//div[@class="cardName"]
    should be equal as strings  ${get_user_name1}    ${first_user_name}
    ${get_user_name2}  get text   xpath=//div[@class="ag-center-cols-container"]/div[3]//div[@class="cardName"]
    should be equal as strings  ${get_user_name2}    ${third_user_name}

check_add_on_call_group
    # Final check
    element should not be visible   ${get_number_of_rows}

check_add_on_call_group_1
    [Arguments]  ${group_name}
    # Final check
    ${count}  get element count  ${get_number_of_rows}
    should be equal as integers   ${count}   3
    ${get_group_name}  get text   xpath=//div[@class="ag-center-cols-container"]/div[1]//div[@class="cardName"]
    should be equal as strings  ${get_group_name}  ${group_name}
    ${get_user_name1}  get text   xpath=//div[@class="ag-center-cols-container"]/div[2]//div[@class="cardName"]
    should be equal as strings  ${get_user_name1}    ${third_user_name}
    ${get_user_name2}  get text   xpath=//div[@class="ag-center-cols-container"]/div[3]//div[@class="cardName"]
    should be equal as strings  ${get_user_name2}    ${second_user_name}

check_add_on_call_group_2
    [Arguments]  ${group_name}
    # Final check
    ${count}  get element count  ${get_number_of_rows}
    should be equal as integers   ${count}   3
    ${get_group_name}  get text   xpath=//div[@class="ag-center-cols-container"]/div[1]//div[@class="cardName"]
    should be equal as strings  ${get_group_name}  ${group_name}
    ${get_user_name1}  get text   xpath=//div[@class="ag-center-cols-container"]/div[2]//div[@class="cardName"]
    should be equal as strings  ${get_user_name1}    ${first_user_name}
    ${get_user_name2}  get text   xpath=//div[@class="ag-center-cols-container"]/div[3]//div[@class="cardName"]
    should be equal as strings  ${get_user_name2}    ${second_user_name}

check_file_if_exists_delete
    # Check whether there are existing files in the path and delete them if there are
    check_file_and_delete   export.csv

export_to_CSV
    # Export to CSV
    click element    ${export_to_CSV_button}
    sleep  10s

check_cloumns_active_users_tab
    # Read the first line field of the CSV file
    ${first_lines}   read_csv_file_check_cloumns   export.csv
    ${name_get}   get text   xpath=//div[@class="ag-center-cols-container"]/div[@row-index="0"]/div[@col-id="name"]
    ${email_get}   get text   xpath=//div[@class="ag-center-cols-container"]/div[@row-index="0"]/div[@col-id="email"]
    ${license_get}   get text   xpath=//div[@class="ag-center-cols-container"]/div[@row-index="0"]/div[@col-id="license"]
    ${role_get}   get text   xpath=//div[@class="ag-center-cols-container"]/div[@row-index="0"]/div[@col-id="role_name"]
    ${groups_get}   get text   xpath=//div[@class="ag-center-cols-container"]/div[@row-index="0"]/div[@col-id="pods_string"]
    should be equal as strings  ${first_lines}[0]    ${name_get}
    should be equal as strings  ${first_lines}[3]    ${email_get}
    ${license_get}   converts_string_to_lowercase   ${license_get}
    should be equal as strings  ${first_lines}[4]    ${license_get}
    should be equal as strings  ${first_lines}[5]    ${role_get}
    should be equal as strings  ${first_lines}[6]    ${groups_get}

check_cloumns_deactivated_users_tab
    # Read the first line field of the CSV file
    ${first_lines}   read_csv_file_check_cloumns   export.csv
    ${name_get}   get text   xpath=//div[@class="ag-center-cols-container"]/div[@row-index="0"]/div[@col-id="name"]
    ${title_get}   get text   xpath=//div[@class="ag-center-cols-container"]/div[@row-index="0"]/div[@col-id="title"]
    ${location_get}   get text   xpath=//div[@class="ag-center-cols-container"]/div[@row-index="0"]/div[@col-id="location"]
    ${email_get}   get text   xpath=//div[@class="ag-center-cols-container"]/div[@row-index="0"]/div[@col-id="email"]
    ${role_get}   get text   xpath=//div[@class="ag-center-cols-container"]/div[@row-index="0"]/div[@col-id="role_name"]
    should be equal as strings  ${first_lines}[0]    ${name_get}
    should be equal as strings  ${first_lines}[1]    ${title_get}
    should be equal as strings  ${first_lines}[2]    ${location_get}
    should be equal as strings  ${first_lines}[3]    ${email_get}
    should be equal as strings  ${first_lines}[4]    ${role_get}

check_cloumns_invitation_users_tab
    # Read the first line field of the CSV file
    ${first_lines}   read_csv_file_check_cloumns   export.csv
    ${name_get}   get text   xpath=//div[@class="ag-center-cols-container"]/div[@row-index="0"]/div[@col-id="name"]//div[@class="cardName"]
    ${email_get}   get text   xpath=//div[@class="ag-center-cols-container"]/div[@row-index="0"]/div[@col-id="email"]
    ${license_get}   get text   xpath=//div[@class="ag-center-cols-container"]/div[@row-index="0"]/div[@col-id="license"]
    ${groups_get}   get text   xpath=//div[@class="ag-center-cols-container"]/div[@row-index="0"]/div[@col-id="pods"]
    should be equal as strings  ${first_lines}[0]    ${name_get}
    should be equal as strings  ${first_lines}[1]    ${email_get}
    ${license_get}   converts_string_to_lowercase   ${license_get}
    should be equal as strings  ${first_lines}[2]    ${license_get}
    should be equal as strings  ${first_lines}[3]    ${groups_get}

enter_create_new_group_page
    # enter Create New Group page
    click element  ${create_group_button}
    sleep  0.5s
    wait until element is visible   xpath=//h3[contains(.,'Group Type')]    3s

create_standard_member_group
    # enter Create New Group page
    enter_create_new_group_page
    # Enter Group Name
    click element  ${group_name_input}
    sleep  0.5s
    ${random}   evaluate    int(time.time()*1000000)    time
    ${group_name}   Catenate   SEPARATOR=   standard_group   ${random}
    input text  ${group_name_input}    ${group_name}
    sleep  0.5s
    # Enter Description
    click element  ${description_input}
    sleep  0.5s
    input text   ${description_input}   ${group_name}
    sleep  0.5s
    # Choose File
    ${picture_path}   get_modify_picture_path    picture.jpg
    Choose file    ${choose_file}     ${picture_path}
    sleep  0.5s
    # Choose Group Administrators
    wait until element is visible   ${choose_group_admin}   10s
    click element   ${choose_group_admin}
    sleep  1s
    input text   ${choose_group_admin}    ${group_admin_name}
    sleep  2s
    click element   xpath=//li[contains(.,'${group_admin_name}')]
    sleep  1s
    # click CREATE GROUP button
    click_create_group_button
    [Return]   ${group_name}

create_standard_member_group_without_groupAdmin_and_avator
    # enter Create New Group page
    enter_create_new_group_page
    # Enter Group Name
    click element  ${group_name_input}
    sleep  0.5s
    ${random}   evaluate    int(time.time()*1000000)    time
    ${group_name}   Catenate   SEPARATOR=   standard_group   ${random}
    input text  ${group_name_input}    ${group_name}
    sleep  0.5s
    # Enter Description
    click element  ${description_input}
    sleep  0.5s
    input text   ${description_input}   ${group_name}
    sleep  0.5s
    # click CREATE GROUP button
    click_create_group_button
    [Return]   ${group_name}

add_group_admin_user_and_avator
    # Add Group Admin user & avator
    # Choose File
    ${picture_path}   get_modify_picture_path    picture.jpg
    Choose file    ${choose_file}     ${picture_path}
    sleep  0.5s
    # Choose Group Administrators
    click element   ${choose_group_admin}
    sleep  1s
    input text   ${choose_group_admin}    ${group_admin_name}
    sleep  2s
    click element   xpath=//li[contains(.,'${group_admin_name}')]
    sleep  1s
    # click Update Details button
    click element   ${update_details_button}
    sleep  3s
    wait until element is visible    ${first_data_show}
    sleep  2s

check_updated_info_saved
    # check The updated info has been successfully saved.
    # check avator
    ${src_get}  get element attribute   xpath=//input[@accept="image/*"]/../img    src
    should start with  ${src_get}   https://s3.
    # check Group Admin
    ${get_group_name}   get text   xpath=//li[@class="k-button"]/span[1]
    should be equal as strings  ${get_group_name}   ${group_admin_name}

remove_this_group_admin
    # Remove this Group Admin
    click element   xpath=//span[@aria-label="delete"]
    # click Update Details button
    click element   ${update_details_button}
    sleep  3s

check_group_admin_removed
    # check Group Admin successfully removed
    element should not be visible   xpath=//li[@class="k-button"]/span[1]

modify_standard_members_group
    [Arguments]  ${group_name1}   ${group_name2}
    # modify Group Name
    # Clear the query box
    Press Key    ${group_name_input}    \\8
    sleep  0.5s
    click element  ${group_name_input}
    sleep  0.5s
    ${random}   evaluate    int(time.time()*1000000)    time
    ${group_name}   Catenate   SEPARATOR=   standard_group   ${random}
    input text  ${group_name_input}    ${group_name}
    sleep  0.5s
    # modify Description
    # Clear the query box
    Press Key    ${description_input}    \\8
    sleep  0.5s
    click element  ${description_input}
    sleep  0.5s
    input text   ${description_input}   ${group_name}
    sleep  0.5s
    # modify File
    ${modify_picture_path}   get_modify_picture_path
    Choose file    ${choose_file}     ${modify_picture_path}
    sleep  0.5s
    # modify Group Administrators
    click element   xpath=//label[contains(.,'Group Administrators')]/..//span[@aria-label="delete"]
    sleep  1s
    click element   ${choose_group_admin}
    sleep  1s
    input text   ${choose_group_admin}    ${group_admin_name_modify}
    sleep  1s
    click element   xpath=//li[contains(.,'${group_admin_name_modify}')]
    sleep  1s
    # modify Group Visibility
    click element  xpath=//label[contains(.,'Group Visibility')]/..//span[@aria-label="delete"]
    sleep  0.5s
    click element   ${group_visibility_input}
    input text   ${group_visibility_input}   ${group_name1}
    sleep  1s
    click element    xpath=//li[contains(.,'${group_name1}')]
    sleep  1s
    # 滑动到底
    swipe_browser_to_bottom
    sleep  0.5s
    # modify On-Call Group Visibility
    click element  xpath=//label[contains(.,'On-Call Group Visibility')]/..//span[@aria-label="delete"]
    sleep  0.5s
    click element  ${OnCall_group_visibility_input}
    sleep  0.5s
    input text  ${OnCall_group_visibility_input}    ${group_name2}
    sleep  1s
    click element    xpath=//li[contains(.,'${group_name2}')]
    sleep  1s
    # click Update Details button
    click element   ${update_details_button}
    sleep  3s
    [Return]   ${group_name}

group_no_display_under_list
    [Arguments]    ${group_name}
    # enter Create New Group page
    enter_create_new_group_page
    # 滑动到底
    swipe_browser_to_bottom
    sleep  0.5s
    # modify On-Call Group Visibility
    click element  ${OnCall_group_visibility_input}
    sleep  1s
    input text  ${OnCall_group_visibility_input}    ${group_name}
    sleep  1s
    element should not be visible   xpath=//li[contains(.,'${group_name}')]
    [Return]  ${group_name}

create_on_call_group_keyword
    # enter Create New Group page
    enter_create_new_group_page
    # Choose On-Call Group
    click element  xpath=//p[contains(.,'On-Call Group')]/../input
    sleep  0.5s
    # Enter Group Name
    click element  ${group_name_input}
    sleep  0.5s
    ${random}   evaluate    int(time.time()*1000000)    time
    ${group_name}   Catenate   SEPARATOR=   on_call_group   ${random}
    input text  ${group_name_input}    ${group_name}
    sleep  0.5s
    # Enter Description
    click element   ${description_input}
    sleep  0.5s
    input text   ${description_input}   ${group_name}
    sleep  0.5s
    # Choose File
    ${picture_path}   get_modify_picture_path    picture.jpg
    Choose file    ${choose_file}     ${picture_path}
    sleep  0.5s
    # Choose Group Administrators
    wait until element is visible   ${choose_group_admin}   10s
    click element   ${choose_group_admin}
    sleep  1s
    input text   ${choose_group_admin}    ${group_admin_name}
    sleep  1s
    click element   xpath=//li[contains(.,'${group_admin_name}')]
    sleep  1s
    # Enter On-Call Notifications
    click element   ${On_Call_notifications}
    input text    ${On_Call_notifications}    ${On_Call_notifications_email}
    sleep  0.5s
    # 滑动到底
    swipe_browser_to_bottom
    sleep  1s
    [Return]  ${group_name}

click_create_group_button
    # click CREATE GROUP button
    click element   xpath=//div[@class="modal-body"]//button[contains(.,'Create Group')]
    sleep  4s
    # Wait until the first row shows up
    wait until element is visible    ${first_row_shows_up}    10s
    wait until element is not visible   ${prompt_information}   20s

create_on_call_group
    # create On-Call group
    ${group_name}   create_on_call_group_keyword
    # click CREATE GROUP button
    click_create_group_button
    [Return]   ${group_name}

modify_on_call_group
    [Arguments]   ${group_name1}   ${group_name2}
    # modify Group Name
    # Clear the query box
    Press Key    ${group_name_input}    \\8
    sleep  0.5s
    click element  ${group_name_input}
    sleep  0.5s
    ${random}   evaluate    int(time.time()*1000000)    time
    ${group_name}   Catenate   SEPARATOR=   on_call_group   ${random}
    input text  ${group_name_input}    ${group_name}
    sleep  0.5s
    # modify Description
    # Clear the query box
    Press Key    ${description_input}    \\8
    sleep  0.5s
    click element   ${description_input}
    sleep  0.5s
    input text   ${description_input}   ${group_name}
    sleep  0.5s
    # modify File
    ${modify_picture_path}   get_modify_picture_path
    Choose file    ${choose_file}     ${modify_picture_path}
    sleep  0.5s
    # modify Group Administrators
    click element   xpath=//label[contains(.,'Group Administrators')]/..//span[@aria-label="delete"]
    sleep  1s
    click element   ${choose_group_admin}
    sleep  1s
    input text   ${choose_group_admin}    ${group_admin_name_modify}
    sleep  1s
    click element   xpath=//li[contains(.,'${group_admin_name_modify}')]
    sleep  1s
    # modify On-Call Notifications
    # Clear the query box
    Press Key    ${On_Call_notifications}    \\8
    sleep  0.5s
    click element   ${On_Call_notifications}
    input text    ${On_Call_notifications}    ${On_Call_notifications_email_modify}
    sleep  0.5s
    # 滑动到底
    swipe_browser_to_bottom
    sleep  0.5s
    # Choose Member Visibility
    click element  xpath=//input[@id="internal_visibility"]
    sleep  0.5s
    # modify Group Visibility
    click element   ${group_visibility_input}
    sleep  1s
    input text  ${group_visibility_input}   ${group_name1}
    sleep  1s
    click element    xpath=//li[contains(.,'${group_name1}')]
    sleep  1s
    # modify On-Call Group Visibility
    click element  ${OnCall_group_visibility_input}
    sleep  1s
    input text  ${OnCall_group_visibility_input}    ${group_name2}
    sleep  1s
    click element    xpath=//li[contains(.,'${group_name2}')]
    sleep  1s
    # click Update Details button
    click element   ${update_details_button}
    sleep  3s
    [Return]  ${group_name}

create_on_call_group_no_member_visibility
    # create On-Call group
    ${group_name}   create_on_call_group_keyword
    # Don't choose Member Visibility
    click element  xpath=//input[@id="internal_visibility"]
    sleep  0.5s
    # click CREATE GROUP button
    click_create_group_button
    [Return]   ${group_name}

search_group_detail
    [Arguments]   ${group_name}
    # Clear the query box
    Press Key    ${input_search}    \\8
    sleep  0.5s
    # Query group
    click element   ${input_search}
    sleep  0.5s
    input text  ${input_search}  ${group_name}
    sleep  1s
    # Wait until the first row shows up
    wait until element is visible    ${first_row_shows_up}    10
    sleep  5s
    # click DETAILS button
    click_deatils
    sleep  5s

delete_group
    # 滑动到底
    swipe_browser_to_bottom
    sleep  0.5s
    # delete group
    click element  ${delete_group_button}
    sleep  2s
    click element    xpath=//button[@class="k-button k-primary ml-4" and text()="Ok"]
    sleep  2s

#delete_new_group
#    [Arguments]
#    # delete group
#    delete_group
#    # close browser
#    Close

delete_five_new_group
    [Arguments]   ${group_name_1}   ${group_name_2}  ${group_name_3}   ${group_name_4}  ${group_name_5}
    # Search standard member group 1
    search_group_detail    ${group_name_1}
    # delete group
    delete_group
    # Search standard member group 2
    search_group_detail    ${group_name_2}
    # delete group
    delete_group
    # Search standard member group 3
    search_group_detail    ${group_name_3}
    # delete group
    delete_group
    # Search On-Call group 1
    search_group_detail    ${group_name_4}
    # delete group
    delete_group
    # Search On-Call group 2
    search_group_detail    ${group_name_5}
    # delete group
    delete_group

delete_three_new_group
    [Arguments]   ${group_name_1}   ${group_name_2}  ${group_name_3}
    # Search standard member group 1
    search_group_detail    ${group_name_1}
    # delete group
    delete_group
    # Search standard member group 2
    search_group_detail    ${group_name_2}
    # delete group
    delete_group
    # Search standard member group 3
    search_group_detail    ${group_name_3}
    # delete group
    delete_group

fill_group_visibility
    # Enter Group Visibility
    [Arguments]  ${group_name1}   ${group_name2}
    click element   ${group_visibility_input}
    input text  ${group_visibility_input}   ${group_name1}
    sleep  1s
    click element    xpath=//li[contains(.,'${group_name1}')]
    sleep  1s
    # 滑动到底
    swipe_browser_to_bottom
    sleep  1s
    # Enter On-Call Group Visibility
    click element  ${OnCall_group_visibility_input}
    sleep  1s
    input text  ${OnCall_group_visibility_input}    ${group_name2}
    sleep  2s
    click element    xpath=//li[contains(.,'${group_name2}')]
    sleep  1s
    # click Update Details button
    click element   ${update_details_button}
    sleep  2s

fill_only_group_visibility
    # Enter Group Visibility
    [Arguments]  ${group_name}
    click element   ${group_visibility_input}
    input text  ${group_visibility_input}   ${group_name}
    sleep  1s
    click element    xpath=//li[contains(.,'${group_name}')]
    sleep  1s
    # 滑动到底
    swipe_browser_to_bottom
    sleep  0.5s
    # click Update Details button
    click element   ${update_details_button}
    sleep  2s

click_members_of_this_group
    # click Members of this group button
    click element   xpath=//button[contains(.,'Members of this group')]
    sleep  10s
    # check page goes to user home page, filtered with group name and displayed with group members
    element should be visible    ${button_add_user}
    ${count}  get element count    ${get_number_of_rows}
    should not be equal as numbers   ${count}  0
    FOR   ${i}   IN RANGE  ${count}
        ${get_group_name_text}   get text    xpath=//div[@class="ag-center-cols-container"]/div[@row-index="${i}"]/div[@col-id="pods_string"]
        should contain    ${get_group_name_text}   auto_default_group
    END


enter_users_page
    # enter Users page
    click element   ${enter_users}
    sleep  2s
    # Wait until the first row shows up
    wait until element is visible    ${first_row_shows_up}    10

enter_groups_page
    # enter Groups page
    click element   ${enter_groups}
    sleep  2s
    # Wait until the first row shows up
    wait until element is visible    ${first_row_shows_up}    10

search_special_group
    # search group：Group_only_for_test_groups_members
    click element  ${group_list_search}
    sleep  0.5s
    input text   ${group_list_search}  Group_only_for_test_groups_members
    sleep  3s
    click element   ${members_button}
    sleep  3s

group_members_show
    # search group：Group_only_for_test_groups_members
    search_special_group
    # Gets the value of the SRC attribute, and Check if there are heads
    ${src_get}  get element attribute   xpath=//h4[contains(.,'Edit Members of Group')]/../following-sibling::div[1]//div[@class="ag-center-cols-container"]/div[2]//img    src
    should start with  ${src_get}   https://s3.
    # check name,title,location
    element should be visible  xpath=//h4[contains(.,'Edit Members of Group')]/../following-sibling::div[1]//div[@row-index="1"]//div[@title="test_modify_name"]
    element should be visible  xpath=//h4[contains(.,'Edit Members of Group')]/../following-sibling::div[1]//div[@row-index="1"]//div[@title="test_modify_title"]
    element should be visible  xpath=//h4[contains(.,'Edit Members of Group')]/../following-sibling::div[1]//div[@row-index="1"]//div[@title="test_modify_location"]

group_members_search
    # Edit Members of Group search
    # Search with title
    click element   ${edit_members_search}
    input text   ${edit_members_search}  Hinu
    sleep  2s
    ${search_count}  get element count  xpath=//h4[contains(.,'Edit Members of Group')]/../following-sibling::div[1]//div[@class="ag-center-cols-container"]/div
    should be equal as integers  ${search_count}  1
    # Clear the query box
    Press Key    ${edit_members_search}    \\8
    # Search with location
    click element   ${edit_members_search}
    input text   ${edit_members_search}  zoo
    sleep  2s
    ${search_count}  get element count  xpath=//h4[contains(.,'Edit Members of Group')]/../following-sibling::div[1]//div[@class="ag-center-cols-container"]/div
    should be equal as integers  ${search_count}  1

add_mumbers_after_del
    # search group：Group_only_for_test_groups_members
    search_special_group
    # click Add More Users... button
    click element  ${add_more_users_button}
    sleep  2s
    # search users
    click element   ${edit_members_search}
    input text  ${edit_members_search}  citron
    sleep  5s
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
    input text  ${edit_members_search}  citron
    sleep  2s
    # delete users
    click element   xpath=//div[@row-index="0"]//button[contains(.,'Delete')]
    sleep  2s
    element should not be visible   xpath=//div[@row-index="0"]//button[contains(.,'Delete')]

search_groups
    # search groups via general search
    ${get_group_name_first}   get text   ${first_row_shows_up}     # Gets the name value of the first line
    click element   ${group_list_search}
    sleep  0.5s
    input text  ${group_list_search}  ${get_group_name_first}
    sleep  3s
    ${count}   Get Element Count    ${get_number_of_rows}   # Gets how many rows are in the result of the query
    should not be equal as numbers  ${count}  0
    FOR   ${i}   IN RANGE  ${count}
        ${get_group_name_text}   get text    xpath=//div[@class="ag-center-cols-container"]/div[@row-index="${i}"]/div[2]//div[@class="cardName"]
        should contain    ${get_group_name_text}   ${get_group_name_first}
    END

check_cloumns_groups_tab
    # Read the first line field of the CSV file
    ${first_lines}   read_csv_file_check_cloumns   export.csv
    ${group_name_get}   get text   ${first_row_shows_up}
    ${member_visibility_get}   get text   xpath=//div[@class="ag-center-cols-container"]/div[@row-index="0"]/div[3]//span
    ${group_visibility_get}   get text   xpath=//div[@class="ag-center-cols-container"]/div[@row-index="0"]/div[4]
    ${group_administrators_get}   get text   xpath=//div[@class="ag-center-cols-container"]/div[@row-index="0"]/div[5]
    should be equal as strings  ${first_lines}[0]    ${group_name_get}
    ${member_visibility_get}   string_conversion    ${member_visibility_get}
    should be equal as strings  ${first_lines}[1]    ${member_visibility_get}
    should be equal as strings  ${first_lines}[2]    ${group_visibility_get}
    should be equal as strings  ${first_lines}[3]    ${group_administrators_get}

get_dashboard_groups_text
    click element  ${groups_choose}
    sleep  1s
    # Gets a list of group names  on the dashboard page
    ${count}   get element count   xpath=//label[contains(.,'Group')]/following-sibling::select[1]/option
    should not be equal as numbers  ${count}  1
    @{get_dashboard_groups_list}=    Create List
    FOR   ${i}   IN RANGE  1   ${count}
        ${get_group_name_text}   get text    xpath=//label[contains(.,'Group')]/following-sibling::select[1]/option[${i}+1]
        append to list   ${get_dashboard_groups_list}   ${get_group_name_text}
    END
    [Return]   ${get_dashboard_groups_list}

get_users_groups_text
    # click ADD USER button
    click_add_user
    # check groups
    click element   ${groups_input}
    sleep  1s
    ${count}   get element count   xpath=//div[@unselectable="on"]//li
    @{get_users_groups_list}=    Create List
    FOR   ${i}   IN RANGE   ${count}
        ${get_group_name_text}   get text    xpath=//div[@unselectable="on"]//li[${i}+1]
        append to list   ${get_users_groups_list}   ${get_group_name_text}
    END
    # Select a group
    click element   xpath=//div[@unselectable="on"]//li[2]
    sleep  1s
    # clicl CANCEL button
    click element  ${cancel_button}
    sleep  3s
    [Return]   ${get_users_groups_list}


get_groups_groups_text
    # Gets a list of group names  on the groups page
    ${count}   get element count   ${get_number_of_rows}
    @{get_groups_groups_list}=    Create List
    FOR   ${i}   IN RANGE   ${count}
        ${get_group_name_text}   get text    xpath=//div[@class="ag-center-cols-container"]/div[${i}+1]//div[@class="cardName"]
        append to list   ${get_groups_groups_list}   ${get_group_name_text}
    END
    [Return]   ${get_groups_groups_list}

lists_should_be_same
    [Arguments]   ${get_calls_groups_list}   ${get_groups_groups_list}
    ${result}   compare_two_lists   ${get_calls_groups_list}   ${get_groups_groups_list}
    should be equal as strings   ${result}    Two lists are equal

check_role_list
    # click ADD USER button
    click_add_user
    # choose Role
    click element  ${role_select}
    sleep  1s
    # check Role
    ${count}   get element count    xpath=//select[@name="role"]/option
    should be equal as numbers  ${count}  3
    @{groups_role_list}=    Create List    Workspace Admin   Group Admin   User
    @{get_groups_role_list}=    Create List
    FOR   ${i}   IN RANGE   ${count}
        ${get_role_name_text}   get text    xpath=//select[@name="role"]/option[${i}+1]
         append to list   ${get_groups_role_list}   ${get_role_name_text}
    END
    log   ${get_groups_role_list}
    lists_should_be_same  ${get_groups_role_list}   ${groups_role_list}

analytics_choose_one_group_then_clear
    # get Users numbers
    sleep  5s
    ${get_user_numbers}    get text  ${total_users}
    # choose second group
    click element  xpath=//label[contains(.,'Group')]/following-sibling::select
    sleep  1s
    click element   xpath=//label[contains(.,'Group')]/following-sibling::select[1]/option[3]
    sleep  8s
    ${once_get_user_numbers}    get text  ${total_users}
    should not be equal as numbers    ${once_get_user_numbers}  ${get_user_numbers}
    # click choose groups
    click element  ${groups_choose}
    sleep  1s
    # choose All My Groups
    click element   xpath=//label[contains(.,'Group')]/following-sibling::select[1]/option[1]
    sleep  8s
    ${third_get_user_numbers}    get text   ${total_users}
    should be equal as numbers    ${third_get_user_numbers}  ${get_user_numbers}

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
    wait until element is visible    ${ws_calls_first_data_show}      10

choose_last_2_weeks
    # choose Last 365 Days
    click element   ${occurred_within_choose}
    sleep  1s
    click element    xpath=//label[contains(.,'Occurred Within')]/following-sibling::select/option[@value="last_2_weeks"]
    # Wait until first line appear
    wait until element is visible    ${ws_calls_first_data_show}     10

calls_choose_one_group_then_clear
    # get calls numbers
    sleep  30s
    ${get_count_all}    get text     ${calls_get_counts}
    # choose first default group
    click element   xpath=//label[contains(.,'Group')]/following-sibling::select[1]/option[2]
    sleep  30s
    ${get_count_default}    get text     ${calls_get_counts}
    should not be equal as strings  ${get_count_default}   ${get_count_all}
    # click choose groups
    click element  ${groups_choose}
    sleep  1s
    # choose All My Groups
    click element   xpath=//label[contains(.,'Group')]/following-sibling::select[1]/option[1]
    sleep  30s
    ${get_count_all_again}    get text     ${calls_get_counts}
    should be equal as strings    ${get_count_all_again}  ${get_count_all}

click_export_button
    # click EXPORT button
    click element   ${export_button}
    sleep  1s
    ${count}    get element count    xpath=//div[@id="exportToCsvPopover"]//div/button
    should be equal as integers    ${count}   2
    ${first_button_text}   get text   ${export_current_table}
    should be equal as strings   ${first_button_text}    EXPORT CURRENT TABLE
    ${second_button_text}   get text   ${generate_new_call_report}
    should be equal as strings   ${second_button_text}    GENERATE NEW CALL REPORT

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
    ${get_tag}   get text   xpath=//div[@class="ag-center-cols-container"]//div[@row-index="0"]/div[@col-id="tags"]
    should be equal as strings   ${first_tag}  ${get_tag}
    # click Details button for the first record
    click element   ${calls_details_button}
    sleep  2s
    # Check whether the comment is added successfully
    ${get_comment}  get text  xpath=//div[@class="Comments"]/div[1]//div[@class="comment-text row"]
    should be equal as strings   ${comment}   ${get_comment}

update_tags
    # Gets the text of the first tag
    ${first_tag}   get text     xpath=//ul[@role="listbox"]/li/span
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
    ${get_tag}   get text   xpath=//div[@class="ag-center-cols-container"]//div[@row-index="0"]/div[@col-id="tags"]
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
    ${get_tag_second}   get text   xpath=//div[@class="ag-center-cols-container"]//div[@row-index="0"]/div[@col-id="tags"]
    should be empty   ${get_tag_second}

display_deactivated_users
    # check only display deactivated users under this workspace
    # There should only be three records
    ${count}  get element count   ${get_number_of_rows}
    should be equal as integers    ${count}   3
    # Check the first record
    ${first_text}   get text  xpath=//div[@class="ag-center-cols-container"]/div[1]/div[@col-id="name"]
    should be equal as strings    ${first_text}   test_deactive_users@123.com
    # Check the second record
    ${second_text}   get text  xpath=//div[@class="ag-center-cols-container"]/div[2]/div[@col-id="name"]
    should be equal as strings    ${second_text}   test_deactive_users1@123.com
    # Check the third record
    ${third_text}   get text  xpath=//div[@class="ag-center-cols-container"]/div[3]/div[@col-id="name"]
    should be equal as strings    ${third_text}   test_deactive_users2@123.com

gets_groups_when_adding_user
    # Gets the list of team names when adding a user
    ${count}  get element count   xpath=//div[@unselectable="on"]//li
    @{NameList}=    Create List
    FOR   ${i}   IN RANGE  1  ${count}+1
        ${get_name_text}   get text    xpath=//div[@unselectable="on"]//li[${i}]
        Append To List    ${NameList}    ${get_name_text}
    END
    [Return]   ${NameList}

gets_groups_list_when_adding_user
    # click Add User button
    click element  ${button_add_user}
    sleep  2s
    # click Add user to a group.
    click element   ${groups_input}
    sleep  1s
    ${NameList_user}   gets_groups_when_adding_user
    # close page
    click element   ${close_details_button}
    sleep  1s
    [Return]   ${NameList_user}

gets_groups_list_when_adding_group
    # click Add User button
    click element  ${button_add_user}
    sleep  1s
    # click Role for choose
    click element  ${role_select}
    sleep  1s
    # choose Group Admin
    click element   ${select_group_admin}
    sleep  2s
    # click Add user to a group.
    click element   ${groups_input}
    sleep  1s
    ${NameList_group}   gets_groups_when_adding_user
    # close page
    click element   ${close_details_button}
    sleep  1s
    [Return]   ${NameList_group}

gets_groups_list_when_adding_workspace
    # click Add User button
    click element  ${button_add_user}
    sleep  1s
    # click Role for choose
    click element  ${role_select}
    sleep  1s
    # choose Workspace Admin
    click element   ${select_workspace_admin}
    sleep  2s
    # click Add user to a group.
    click element   ${groups_input}
    sleep  1s
    ${NameList_workspace}   gets_groups_when_adding_user
    # close page
    click element   ${close_details_button}
    sleep  1s
    [Return]   ${NameList_workspace}

search_on_call_groups
    # search_on_call_groups
    [Arguments]   ${group_name}
    click element    ${input_search}
    input text   ${input_search}    ${group_name}
    sleep  3s

search_invitation_by_email
    [Arguments]   ${email}
    # search invitation by email
    click element   ${input_search}
    sleep  0.5s
    input text   ${input_search}  ${email}
    wait until element is visible    ${first_data_show}    10s

expand_workspaces_switch
    # Expand workspace
    click element   ${expand_workspace_button}
    sleep  1s

switch_to_another_WS
    [Arguments]   ${witch_created_WS}
    # Expand workspace
    expand_workspaces_switch
    # choose second workspace
    click element   ${witch_created_WS}
    sleep  3
    ${ele_count}     get element count    ${accept_disclaimer}
    Run Keyword If   '${ele_count}'=='1'    click element    ${accept_disclaimer}