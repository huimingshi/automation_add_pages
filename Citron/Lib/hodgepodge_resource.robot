*** Settings ***
Library           Collections
Library           Selenium2Library
Library           DateTime
Library           String
Resource          public.robot
Resource          All_Pages_Xpath/register_page.robot
Resource          All_Pages_Xpath/public_xpath.robot
Resource          All_Pages_Xpath/My_Account.robot
Resource          All_Pages_Xpath/crunch_page.robot
Resource          All_Pages_Xpath/WS_Admin/Users.robot
Resource          All_Pages_Xpath/WS_Admin/Workspace_Settings.robot
Resource          All_Pages_Xpath/Normal/Contacts.robot
Library           python_Lib/ui_keywords.py
Library           python_Lib/obtain_outlook_email_link.py


*** Keywords ***
register_personal
    # register personal
    ${random}  get_random_number
    ${email_before}   Catenate   SEPARATOR=+   ${my_existent_email_name}  ${random}
    ${email}    Catenate   SEPARATOR=   ${email_before}    @outlook.com
    # Full name
    click element   ${full_name}
    sleep  0.5s
    input text  ${full_name}  ${email_before}
    sleep  0.5s
    # Email
    click element   ${fill_email}
    sleep  0.5s
    input text  ${fill_email}   ${email}
    sleep  0.5s
    # Password
    click element   ${fill_password}
    sleep  0.5s
    input text  ${fill_password}   ${public_pass}
    sleep  0.5s
    # agree input
    click element  ${agree_input}
    sleep  0.5s
    # click Create My Help Lightning Account
    click element  ${register_account}
    wait until element is visible     xpath=//span[contains(.,'You have successfully registered with Help Lightning')]
    [Return]   ${email_before}   ${email}

accept_outlook_email
    sleep  20s
    ${email_link}   get_email_link   confirmation_token
    should contain   ${email_link}   ${Citron_web_url}
    # Open another Windows window with this link
    Execute JavaScript    window.open('${email_link}')
    # Switch to the second Windows page
    switch_window_to_second
    wait until element is visible    xpath=//span[contains(.,'Your account is confirmed. You can now start using the app!')]

can_not_see_the_administration
    ${tree_count}  get element count   xpath=//div[@role="tree"]/div
    should be equal as integers   ${tree_count}   1
    ${contacts_page_count}   get element count   ${contacts_page_check}
    should be equal as integers   ${contacts_page_count}   1

check_2_menus
    click element  ${enter_workspace_menu}
    sleep  1s
    ${count}   get element count   ${menus_count}
    should be equal as integers   ${count}   2
    ${menu_text}   get text   xpath=//div[@role="group"]/div[@role="treeitem"][1]/span
    should be equal as strings   ${menu_text}  Workspaces
    ${menu_text}   get text   xpath=//div[@role="group"]/div[@role="treeitem"][2]/span
    should be equal as strings   ${menu_text}  Site Settings

check_5_menus
    click element   ${enter_site_menu}
    sleep  1s
    ${count}   get element count    ${menus_count}
    should be equal as integers   ${count}   5
    ${menu_text}   get text   xpath=//div[@role="group"]/div[@role="treeitem"][1]/span
    should be equal as strings   ${menu_text}  Analytics
    ${menu_text}   get text   xpath=//div[@role="group"]/div[@role="treeitem"][2]/span
    should be equal as strings   ${menu_text}  Workspaces
    ${menu_text}   get text   xpath=//div[@role="group"]/div[@role="treeitem"][3]/span
    should be equal as strings   ${menu_text}  Users
    ${menu_text}   get text   xpath=//div[@role="group"]/div[@role="treeitem"][4]/span
    should be equal as strings   ${menu_text}  Calls
    ${menu_text}   get text   xpath=//div[@role="group"]/div[@role="treeitem"][5]/span
    should be equal as strings   ${menu_text}  Site Settings

enter_workspace_users
    # click workspace ADMINISTRATION page menu
    click element   ${enter_workspace_menu}
    sleep  1s
    # click Users page menu
    click element   ${enter_users}
    sleep  2s
    # Wait until the first row shows up
    wait until element is visible    ${button_add_user}    20
    wait until element is visible    ${first_row_shows_up}    20

enter_workspace_workspace_settings
    # click workspace ADMINISTRATION page menu
    click element   ${enter_workspace_menu}
    sleep  1s
    # click Users page menu
    click element   ${enter_Workspace_settings}
    # Wait until enter page
    wait until element is visible   ${enter_ws_settings_success}    20s

enter_primary_contact
    # enter Primary Contact page
    click element   ${enter_primary_contacts}
    sleep  1s

enter_contact_personal_page
    click element   ${enter_first_menu_tree}
    sleep  2s
    wait until element is visible   ${enter_contacts_page}
    click element   ${enter_contacts_page}
    sleep  3s
    wait until element is visible  ${enter_personal_page}
    click element   ${enter_personal_page}
    sleep  2s

enter_favorites_page
    click element   ${enter_favorites_page}
    sleep  2s

enter_contacts_page
    click element   ${enter_contacts_page}
    sleep  2s

enter_contacts
    click element   ${enter_first_menu_tree}
    sleep  1s
    enter_contacts_page

add_a_normal_user
    [Arguments]  ${username}
    # click ADD USER button
    click_add_user
    # fill basic message
    ${email}   fill_basic_message   ${username}
    # Enter groups
    click element   ${groups_input}
    sleep  1s
    input text   ${groups_input}    default
    sleep  1s
    click element   xpath=//div[@unselectable="on"]//li[1]
    sleep  0.5s
    click element   ${button_ADD}
    sleep  2s
    # Check prompt Information
    wait until element is visible    ${prompt_information}      #  message of Add Success
    wait until element is not visible   ${prompt_information}    20s
    [Return]  ${email}

click_add_user
    # click button of add user
    click element  ${button_add_user}
    sleep  2s
    wait until element is visible   ${submit_and_add_another}

fill_basic_message
    [Arguments]   ${random}
    # Enter email
    click element  ${input_email}
    sleep  1s
    ${email_before}   Catenate   SEPARATOR=+   ${my_existent_email_name}  ${random}
    ${email}    Catenate   SEPARATOR=   ${email_before}    @outlook.com
    input text  ${input_email}    ${email}
    sleep  0.5s
    # Enter name
    click element  ${input_name}
    sleep  1s
    input text   ${input_name}   ${random}
    sleep  0.5s
    # Enter title
    click element   ${title_input}
    sleep  1s
    input text  ${title_input}   ${random}
    sleep  0.5s
    # Enter Location
    click element   ${location_input}
    sleep  1s
    input text  ${location_input}   ${random}
    sleep  0.5s
    [Return]   ${email}

send_forget_password_email
    [Arguments]    ${username}
    # open a driver
    Open Browser    ${citron_website}     ${browser_type}
    Sleep    1s
    Maximize Browser Window
    Sleep    1s
    # enter username
    click element   ${loginname_input}
    sleep  0.5s
    Input Text    ${loginname_input}    ${username}
    Sleep    1s
    # click NEXT button
    Click Button    ${next_button}
    Sleep    1s
    # click Forget Password button
    click element   ${forget_password}
    wait until element is visible   ${send_reset_password_email}
    click element   ${send_reset_password_email}
    wait until element is visible   ${prompt_information}

enter_a_new_password
    sleep  20s
    ${email_link}   get_email_link   Change My Password:
    should contain   ${email_link}   ${Citron_web_url}
    # Open another Windows window
    Execute JavaScript    window.open('${email_link}')
    sleep  2s
    # change Your password
    change_your_password

change_your_password
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

enter_my_account_page
    # click username
    click element   ${current_account_xpath}
    sleep  1s
    # enter My Account page
    click element   xpath=//span[contains(.,'My Account')]
    sleep  1s
    wait until element is visible    xpath=//label[contains(.,'License Type')]

email_and_url_are_readOnly
    # Email fields is read-only.
    ${get_attribute}   get element attribute   xpath=//label[contains(.,'Email')]/..//p   class
    should be equal as strings   ${get_attribute}  form-control-static
    #  My Help Space URL fields is read-only.
    ${get_attribute}   get element attribute   xpath=//label[contains(.,'My Help Space Url')]/..//p   class
    should be equal as strings   ${get_attribute}  form-control-static

dispaly_role_and_its_location
    [Arguments]  ${role_name}
    ${get_role}   get text  xpath=//label[contains(.,'Role')]/..//p
    should be equal as strings  ${get_role}   ${role_name}
    ${get_form}   get text   xpath=//div[@class="form-group"][6]/label
    should be equal as strings  ${get_form}   License Type
    ${get_form}   get text   xpath=//div[@class="form-group"][7]/label
    should be equal as strings  ${get_form}   Role
    ${get_form}   get text   xpath=//div[@class="EmailField form-group"]/label
    should be equal as strings  ${get_form}   Email

display_group_admin_for
    # Display “Group Admin for” with all GA”s groups, read-only.
    ${get_class}   get element attribute   xpath=//ul[@role="listbox"]/../..   class
    should be equal as strings  ${get_class}   k-widget k-multiselect k-header k-state-disabled

get_random_number
    ${random}   evaluate    int(time.time()*1000000)    time
    [Return]   ${random}

change_name_title_location
    [Arguments]   ${name}   ${title}
    # change name
    input text   ${my_account_name}    ${name}
    sleep  0.5s
    # change title
    input text   ${my_account_title}     ${title}
    sleep  0.5s
    # change location
    input text   ${my_account_location}     ${title}
    sleep  0.5s
    # click UPDATE button
    click element   ${my_account_update}
    sleep  1s
    wait until element is visible    ${my_account_update_success_tag}    20s

check_changed_successfully
    [Arguments]   ${name}   ${title}
    # check Name changed successfully
    ${get_attribute}   get element attribute   ${my_account_name}  value
    should be equal as strings   ${name}   ${get_attribute}
    # check Title changed successfully
    ${get_attribute}   get element attribute   ${my_account_title}  value
    should be equal as strings   ${title}   ${get_attribute}
    # check Location changed successfully
    ${get_attribute}   get element attribute   ${my_account_location}  value
    should be equal as strings   ${title}   ${get_attribute}
    wait until element is not visible    ${my_account_update_success_tag}    20s

upload_a_photo
    # Default app icon should display.
    ${get_scr}   get element attribute   ${default_avatar_src}   src
    should start with   ${get_scr}    data:image/png;base64
    # Button "Upload a photo" displays under the avatar.
    # Click on "Upload a photo", and upload a new photo
    ${picture_path}   get_modify_picture_path    picture.jpg
    wait until element is visible    ${upload_avatar}   20
    choose file  ${upload_a_photo}   ${picture_path}
    wait until element is visible    ${my_account_update_success_tag}
    # Button changes to "Change your avatar".
    wait until element is visible    ${change_avatar}
    sleep  0.5s
    # Validate avatar is updated successfully.
    ${get_scr}   get element attribute   ${get_avatar_src}   src
    should start with    ${get_scr}    ${avator_has_picture_src}
    # The underlined hyperlink "Remove my avatar" displays under the button.
    wait until element is visible    ${remove_avatar}

change_your_avatar
    ${get_scr_before}   get element attribute  ${get_avatar_src}    src
    # The button "Change your avatar" displays under the avatar.
    element should be visible    ${change_avatar}
    # The underlined hyperlink "Remove my avatar" displays under the button.
    element should be visible    ${remove_avatar}
    # Click on "Change your avatar", and upload a new photo
    ${modify_picture_path}   get_modify_picture_path
    choose file  ${upload_a_photo}  ${modify_picture_path}
    # Validate avatar is updated successfully
    wait until element is visible    ${my_account_update_success_tag}
    wait until element is not visible    ${my_account_update_success_tag}    20s
    ${get_scr_after}   get element attribute   ${get_avatar_src}   src
    should start with   ${get_scr_after}   ${avator_has_picture_src}
    should not be equal as strings  ${get_scr_before}   ${get_scr_after}

remove_my_avatar
    # 滑动到顶部
    swipe_browser_to_top
    sleep   1s
    click element   ${remove_avatar}
    sleep  1s
    # Warnign dialog displays. Confirm Yes.
    click element   xpath=//button[@class="k-button k-primary ml-4" and text()="Ok"]
    # Validate avatar is removed successfully. Avatar shows the default app icon.
    wait until element is visible    ${my_account_update_success_tag}
    wait until element is not visible    ${my_account_update_success_tag}    20s
    ${get_scr}   get element attribute   ${default_avatar_src}   src
    should start with   ${get_scr}    data:image/png;base64
    # Button changes to "Upload a photo".
    element should be visible   ${upload_avatar}
    # Button "Remove avatar" should not display
    element should not be visible  ${remove_avatar}

remove_avatar_teardown
    ${count}   get element count    ${remove_avatar}
    Run Keyword If   '${count}'=='1'    remove_my_avatar

my_account_change_password
    [Arguments]  ${old_password_str}   ${new_password_str}
    wait until element is not visible    ${my_account_update_success_tag}   20s
    wait until element is not visible    ${update_password_success_tag}   20s
    # click Change password button
    click element   ${change_password}
    wait until element is visible   ${current_password}
    # input Current Password
    click element   ${current_password}
    sleep  0.5s
    input text   ${current_password}   ${old_password_str}
    sleep  0.5s
    # input New Password
    click element   ${new_password}
    sleep  0.5s
    input text   ${new_password}   ${new_password_str}
    sleep  0.5s
    # input Confirm New Password
    click element   ${confirm_password}
    sleep  0.5s
    input text   ${confirm_password}   ${new_password_str}
    sleep  0.5s
    # click  CHANGE PASSWORD button
    click element     xpath=//button[contains(.,'Change Password')]
    wait until element is visible   ${update_password_success_tag}      20s
    wait until element is not visible    ${update_password_success_tag}    20s

primary_contact_modify_message
    [Arguments]    ${random}   ${email}   ${index}
    # Modify workspace name
    click element  ${primary_contact_workspace_name}
    sleep  0.5s
    input text   ${primary_contact_workspace_name}   ${random}
    sleep  0.5s
    # Modify time zone
    click element   ${primary_contact_time_zone}
    sleep  0.5s
    click element    ${primary_contact_time_zone}/option[${index}]
    sleep  0.5s
    # Modify Contact Name
    click element  ${primary_contact_contact_name}
    sleep  0.5s
    input text   ${primary_contact_contact_name}   ${random}
    sleep  0.5s
    # Modify Contact Email
    click element  ${primary_contact_contact_email}
    sleep  0.5s
    input text   ${primary_contact_contact_email}   ${email}
    sleep  0.5s
    # Modify Contact Phone
    click element  ${primary_contact_contact_phone}
    sleep  0.5s
    input text   ${primary_contact_contact_phone}   ${random}
    sleep  0.5s
    # click UPDATE button
    click element    ${primary_contact_update}
    wait until element is visible   ${Updated_Business_settings}
    wait until element is not visible    ${Updated_Business_settings}    20s

option_delete_user_is_selected_or_not
    # expand option delete user
    ${count}  get element count   ${disclaimer_delete_user}//button[contains(.,'Expand')]
    Run Keyword If   '${count}'=='1'   expand_option_delete_user
    # The option 'delete user' is selected or not selected
    FOR   ${i}   IN RANGE  2
        click element    ${disclaimer_delete_user}//div[@class="disclaimer-text"]//div[@class="react-toggle-track"]
        sleep  1s
    END

enter_enterprises_audit_log
    # enter crunch Audit Logs page
    click element    ${audit_log_menu}
    wait until element is visible     ${audit_log_table}//tr[2]    30s
    sleep  3s

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

get_all_logs_in_audit_logs
    # check modify record in crunch is correct
    @{LogList}=    Create List
    FOR   ${i}   IN RANGE   20
        ${get_log}   get text    ${audit_log_table}//tr[${i}+1]/td[5]
        Append To List    ${LogList}    ${get_log}
    END
    log  ${LogList}
    [Return]    ${LogList}

log_in_crunch_is_correct
    [Arguments]    ${expect_log}    ${LogList}
    ${result}  string_in_list_object    ${expect_log}   ${LogList}
    should be equal as strings   ${result}   There is audit logs

Login_with_Cognito_account
    # open browser
    Open Browser    ${citron_website}     ${browser_type}
    Sleep    1s
    # Maximize Browser Window
    Maximize Browser Window
    Sleep    1s
    # enter username
    click element   ${loginname_input}
    sleep  0.5s
    Input Text    ${loginname_input}    ${cognito_login_username}
    Sleep    1s
    # click NEXT
    Click Button    ${next_button}
    # Jump to a new page
    wait until element is visible  ${cognito_username}   20s
    # enter email
    click element   ${cognito_username}
    sleep  0.5s
    input text   ${cognito_username}   ${cognito_login_email}
    sleep  0.5s
    # enter password
    click element   ${cognito_password}
    sleep  0.5s
    input text   ${cognito_password}    ${cognito_login_password}
    sleep  0.5s
    # click Sign In
    click element   ${cognito_sign_in}
    # close bounced
    ${count}    get element count      ${log_in_success_tag}
    Run Keyword If   '${count}'=='1'   click element   ${button_of_popup}
    sleep  1s
    wait until element is visible    ${currentAccount_button}    20s

invite_personal_user
    [Arguments]  ${email_before}   ${email}
    # click ADD USER button
    click_add_user
    # fill basic message
    invite_personmal_basic_info   ${email_before}   ${email}
    # click Add button
    click element   ${button_ADD}
    sleep  2s
    # click INVITE button
    click element   xpath=//button[contains(.,'Invite')]
    sleep  0.5s
    # check message
    wait until element is visible   ${message_text}   5s

invite_personmal_basic_info
    [Arguments]  ${email_before}   ${email}
    # Enter email
    click element  ${input_email}
    sleep  0.5s
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
    # choose group
    click element  ${groups_input}
    sleep  1s
    click element   xpath=//div[@unselectable="on"]//li[1]
    sleep  0.5s

accept_invitation_mailbox
    sleep  20s
    ${email_link}   get_email_link   Accept Invitation:
    should contain   ${email_link}   ${Citron_web_url}
    # Open another Windows window
    Execute JavaScript    window.open('${email_link}')
    sleep  2s
    # Confirm Password
    confirm_my_password

confirm_my_password
    # Switch to the second Windows page
    switch_window_to_second
    sleep  0.5s
    # enter password
    wait until element is visible   ${confirm_password_input}   20s
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

cognito_web_page_sign_up
    [Arguments]  ${email_before}   ${email}
    # open browser
    Open Browser    ${citron_website}     ${browser_type}
    Sleep    1s
    # Maximize Browser Window
    Maximize Browser Window
    Sleep    1s
    # enter username
    click element   ${loginname_input}
    sleep  0.5s
    Input Text    ${loginname_input}    ${email}
    Sleep    1s
    # click NEXT
    Click Button    ${next_button}
    # Jump to a new page
    wait until element is visible   ${cognito_username}   20s
    # click Sign up button
    click element  ${cognito_sign_up}
    wait until element is visible   ${cognito_sign_up_username}
    # fill username
    click element   ${cognito_sign_up_username}
    sleep  0.5s
    input text   ${cognito_sign_up_username}   ${email}
    sleep  0.5s
    # full password
    click element   ${cognito_sign_up_password}
    sleep  0.5s
    input text   ${cognito_sign_up_password}   ${public_pass}
    sleep  0.5s
    # click Sign up button
    click element   ${cognito_sign_up_sign_up}

get_verification_code
    # get Verification Code from email
    sleep  30s
    ${verification_code}   get_email_verification_code
    [Return]   ${verification_code}

comfirm_account
    [Arguments]   ${verification_code}
    # input verification code
    click element    ${cognito_verification_code}
    sleep  0.5s
    input text   ${cognito_verification_code}   ${verification_code}
    sleep  0.5s
    # click Confirm Account button
    click element   ${cognito_confirm_account}
    # check log in successfully
    wait until element is visible    ${currentAccount_button}   20s

set_disclaimer_is_on
    # Set Disclaimer =on
    ${get_status}   get element count    ${disclaimer_delete_user}//div[@class="feature-section-buttons btn-group"]//div[@class="react-toggle react-toggle--checked"]
    Run Keyword If   '${get_status}'=='0'   click element   ${disclaimer_delete_user}//div[@class="feature-section-buttons btn-group"]//div[@class="react-toggle-track"]

set_disclaimer_is_off
    # Set Disclaimer =on
    ${get_status}   get element count    ${disclaimer_delete_user}//div[@class="feature-section-buttons btn-group"]//div[@class="react-toggle"]
    Run Keyword If   '${get_status}'=='0'   click element   ${disclaimer_delete_user}//div[@class="feature-section-buttons btn-group"]//div[@class="react-toggle-track"]

set_delete_user_open
    # 设置delete user为启用状态
    ${get_status}   get element count    ${disclaimer_delete_user}//div[@class="disclaimer-text"]//div[@class="react-toggle react-toggle--checked"]
    Run Keyword If   '${get_status}'=='0'   click element   ${disclaimer_delete_user}//div[@class="disclaimer-text"]//div[@class="react-toggle-track"]

set_delete_user_close
    # 设置delete user为关闭状态
    ${get_status}   get element count    ${disclaimer_delete_user}//div[@class="disclaimer-text"]//div[@class="react-toggle"]
    Run Keyword If   '${get_status}'=='0'   click element   ${disclaimer_delete_user}//div[@class="disclaimer-text"]//div[@class="react-toggle-track"]

fill_available_password
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

set_password_mailbox
    sleep  20s
    ${email_link}   get_email_link   Click here to set your password:
    should contain   ${email_link}   ${Citron_web_url}
    # Open another Windows window
    Execute JavaScript    window.open('${email_link}')
    sleep  2s
    # change My password
    fill_available_password

check_disclaimer_poped_up_or_not
    [Arguments]    ${username}   ${expect_count}
    Open Browser    ${citron_website}     ${browser_type}
    Sleep    1s
    Maximize Browser Window
    # 输入账号
    wait until element is visible   ${loginname_input}
    Input Text    ${loginname_input}    ${username}
    # 点击NEXT
    wait until element is visible   ${next_button}
    Click Button    ${next_button}
    # 输入密码
    wait until element is visible  ${loginpsd_input}
    Input Password    ${loginpsd_input}    ${public_pass}
    # 点击LOG IN
    wait until element is visible   ${login_button}
    Click Button    ${login_button}
    Sleep   15s
    ${count}  get element count  ${accept_button}
    should be equal as strings   ${count}   ${expect_count}

reset_all_accepted_disclaimers
    # Reset All Accepted Disclaimers
    click element   ${reset_all_disclaimers}
    sleep  1s
    # click OK button
    click element   xpath=//button[contains(.,'OK')]
    sleep  1s
    wait until element is not visible    ${prompt_information}   20s

reset_all_accepted_disclaimers_cancel
    # Reset All Accepted Disclaimers
    click element   ${reset_all_disclaimers}
    sleep  1s
    # click OK button
    click element   xpath=//div[@role="dialog"]//button[contains(.,'Cancel')]
    sleep  1s

search_user_details
    [Arguments]   ${email_search}
    # search
    click element    ${search_input}
    sleep  0.5s
    input text   ${search_input}    ${email_search}
    sleep  2s
    click_deatils

click_deatils
    # click DETAILS button
    sleep  2s
    click element  ${button_DETAILS}
    sleep  2s

modify_basic_info
    # upload photo
    ${modify_picture_path}   get_modify_picture_path
    wait until element is visible    ${button_Upload}    20
    Choose file    ${button_Upload}     ${modify_picture_path}
    sleep  0.5s
    wait until element is visible    ${button_Remove}
    sleep  0.5s
    # modify Username
    Press Key    ${username_input}    \\8
    sleep  0.5s
    ${random}   evaluate    int(time.time()*1000000)    time
    ${test_modify_username}   Catenate   SEPARATOR=+   test_modify_username   ${random}
    input text    ${username_input}    ${test_modify_username}
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
    sleep  3s
    [Return]   ${test_modify_username}

check_modify_user_success
    [Arguments]   ${username}
    sleep  4s
    # click DETAILS button
    click_deatils
    element should be visible   ${button_Remove}     # avator下的Remove avatar按钮
    ${username_after_modify}   get element attribute  ${username_input}  value
    should be equal as strings   ${username_after_modify}   ${username}
    ${name_after_modify}   get element attribute  ${name_input}  value
    should be equal as strings   ${name_after_modify}   test_modify_name
    ${title_after_modify}   get element attribute  ${title_input}  value
    should be equal as strings   ${title_after_modify}   test_modify_title
    ${location_after_modify}   get element attribute  ${location_input}  value
    should be equal as strings   ${location_after_modify}   test_modify_location
    click element  ${cancel_button}
    sleep  0.5s

enter_phone_with_country_code
    [Arguments]   ${phone_number}  ${count}  ${cancel_or_confirm}
    # click Mobile Phone
    FOR   ${i}   IN RANGE   2
        Press Key    ${mobile_phone_input}    \\8
    sleep  0.5s
    END
    press key  ${mobile_phone_input}  ${phone_number}
    sleep  2s
    Run Keyword If   '${count}'=='0'    element should not be visible     ${wrong_phone_tag}
    ...  ELSE    element should be visible     ${wrong_phone_tag}
#    ${get_count}   get element count   ${wrong_phone_tag}
#    should be equal as integers   ${get_count}     ${count}
    Run Keyword If   '${cancel_or_confirm}'=='0'     click element    ${cancel_button}
    ...  ELSE    click element    ${update_button}

phone_saved_successfully
    # message appear after click Update User button
    wait until element is visible   ${message_text}

modify_phone_in_crunch_is_correct
    [Arguments]   ${expect_log}
    # check modify record in crunch is correct
    @{LogList}=    Create List
    FOR   ${i}   IN RANGE   20
        ${get_log}   get text    ${audit_log_table}//tr[${i}+1]/td[5]
        Append To List    ${LogList}    ${get_log}
    END
    log  ${LogList}
    ${result}  string_in_list_object   ${expect_log}   ${LogList}
    should be equal as strings  ${result}   There is audit logs

search_personal_contact
    # enter emily citron
    click element   ${personal_search_input}
    sleep  0.5s
    input text   ${personal_search_input}    emily citron
    sleep  1
    # check result of search
    ${count}   get element count  xpath=//div[@class="cardName" and contains(.,'emily citron')]
    should be equal as integers  ${count}   1

add_to_favorite
    [Arguments]   ${user_or_group}
    # enter 1000Users
    click element   ${team_search_input}
    sleep  0.5s
    input text   ${team_search_input}   ${user_or_group}
    sleep  2s
    sleep  2s
    wait until element is visible    ${favorite_button}    20s
    ${get_attribute}  get element attribute   ${favorite_button}     class
    Run Keyword If   '${get_attribute}'=='fal fa-star favoriteIcon star-off'    click element   ${favorite_button}

search_favorite
    [Arguments]   ${user_or_group}   ${count}
    # enter 1000Users
    click element  ${search_input}
    sleep  0.5s
    input text   ${search_input}  ${user_or_group}
    sleep  1
    # check result of search
    ${count}   get element count   ${get_number_of_rows}
    should be equal as integers  ${count}   ${count}

unfavorite_from_favorite_tab
    [Arguments]   ${user_or_group}
    # unfavorite
    wait until element is visible   ${unfavorite_button}
    click element   ${unfavorite_button}
    sleep  2s
    # search favorite
    search_favorite   ${user_or_group}    0

ordered_by_alphabetically
    ${count}   get element count  xpath=//div[@class="tab-content"]/div[1]//div[@class="ag-center-cols-container"]/div
    @{group_list}=   create list
    FOR   ${i}   IN RANGE   ${count}
        ${get_group_name}  get text    xpath=//div[@class="tab-content"]/div[1]//div[@class="ag-center-cols-container"]/div[@row-index="${i}"]//div[@class="cardName"]
        append to list   ${group_list}  ${get_group_name}
    END
    log to console   ${group_list}
    ${sort_group_name}  sort_order_list   ${group_list}
    ${result}  two_lists_are_identical   ${group_list}  ${sort_group_name}
    should be equal as strings    ${result}   The two lists are identical

favorite_on_call_group_from_team_page_or_not
    [Arguments]   ${group_name}
    # enter 1000Users
    click element   ${team_search_input}
    sleep  0.5s
    input text   ${team_search_input}   ${group_name}
    sleep  2s
    # check result of search
    ${count}   get element count   xpath=//div[@class="tab-content"]/div[1]//div[@class="ag-center-cols-container"]/div
    should be equal as integers  ${count}   1
    ${get_attribute_before}  get element attribute   ${favorite_button}     class
    click element   ${favorite_button}
    sleep  1s
    ${get_attribute_after}  get element attribute   ${favorite_button}     class
    should not be equal as strings   ${get_attribute_before}  ${get_attribute_after}

disclaimer_popped_up_automate
    [Arguments]   ${web_url}
    # open brower
    Open Browser    ${web_url}      ${browser_type}
    Sleep    1s
    # The disclaimer should be popped up automate
    wait until element is visible   ${accept_disclaimer}     20s

open_call_center_mode
    ${count}   get element count   ${call_center_mode}//div[@class="react-toggle"]
    Run Keyword If   '${count}'=='1'    click element   ${call_center_mode}//div[@class="react-toggle"]
    sleep  2s

close_call_center_mode
    ${count}   get element count   ${call_center_mode}//div[@class="react-toggle react-toggle--checked"]
    Run Keyword If   '${count}'=='1'   click element    ${call_center_mode}//div[@class="react-toggle react-toggle--checked"]
    sleep  2s

open_disable_external_users
    ${count}   get element count   ${disable_external_users}//div[@class="react-toggle"]
    Run Keyword If   '${count}'=='1'    click element   ${disable_external_users}//div[@class="react-toggle"]
    sleep  2s

close_disable_external_users
    ${count}   get element count   ${disable_external_users}//div[@class="react-toggle react-toggle--checked"]
    Run Keyword If   '${count}'=='1'   click element    ${disable_external_users}//div[@class="react-toggle react-toggle--checked"]
    sleep  2s

open_workspace_directory
    ${count}   get element count    ${workspace_directory}//div[@class="react-toggle"]
    Run Keyword If   '${count}'=='1'    click element   ${workspace_directory}//div[@class="react-toggle"]
    sleep  2s

close_workspace_directory
    ${count}   get element count   ${workspace_directory}//div[@class="react-toggle react-toggle--checked"]
    Run Keyword If   '${count}'=='1'   click element    ${workspace_directory}//div[@class="react-toggle react-toggle--checked"]
    sleep  2s

open_tagging_and_comments
    ${count}   get element count    ${tagging_and_comments}//div[@class="react-toggle"]
    Run Keyword If   '${count}'=='1'    click element   ${tagging_and_comments}//div[@class="react-toggle"]
    sleep  2s

close_tagging_and_comments
    ${count}   get element count   ${tagging_and_comments}//div[@class="react-toggle react-toggle--checked"]
    Run Keyword If   '${count}'=='1'   click element    ${tagging_and_comments}//div[@class="react-toggle react-toggle--checked"]
    sleep  2s

personal_contact_tab_exists
    [Arguments]  ${is_exists}
    ${count}  get element count   xpath=//span[contains(.,'Personal')]
    should be equal as integers   ${count}   ${is_exists}

set_survey_open
    ${count}   get element count   ${switch_survey_close}
    Run Keyword If   '${count}'=='1'   click element   ${switch_survey_close}

set_survey_close
    ${count}   get element count   ${switch_survey_open}
    Run Keyword If   '${count}'=='1'   click element   ${switch_survey_open}

clear_survey_url
    # Expand
    ${count}   get element count   ${survey_expand}
    run keyword if    '${count}'=='1'    click element   ${survey_expand}
    sleep  1s
    # click survey URL
    click element   ${survey_url_text}
    sleep  0.5s
    # clear content
    clear element text   ${survey_url_input}
    sleep  1s
    click element   ${survey_url_input}
    sleep  0.5s
    input text  ${survey_url_input}  1
    sleep  0.5s
    FOR   ${i}   IN RANGE   2
        Press Key    ${survey_url_input}    \\8
    END

set_survey_null
    # clear survey url
    clear_survey_url
    # click save button
    click element    ${survey_url_save}
    sleep  1s
    # Check that the emptying is successful
    wait until element is visible   xpath=//button[text()="Click to set a URL"]    20

set_survey_in_white_list
    # clear survey url
    clear_survey_url
    # Set URL Value is in White List
    input text  ${survey_url_input}     ${while_list_value}
    # click save button
    click element    ${survey_url_save}
    sleep  1s
    ${text}   get text    xpath=//div[@class="survey-options"]/button
    should be equal as strings   ${text}   ${while_list_value}

set_survey_wrong_text
    [Arguments]  ${send_text}
    # clear survey url
    clear_survey_url
    # Set URL Start without https://
    input text  ${survey_url_input}  ${send_text}
    # click save button
    click element    ${survey_url_save}
    wait until element is visible    xpath=//span[contains(.,"Survey URL not supported. Contact support for more information.")]

log_out_from_citron
    # log out
    click element   ${currentAccount_button}
    sleep  1s
    click element   xpath=//i[@class="fa fa-sign-out"]
    sleep  1s

re_log_in_citron_with_cognito
    Input Text    ${loginname_input}     ${cognito_login_username}
    Sleep    1s
    # click NEXT button
    Click Button    ${next_button}
    Sleep    1s
    ${count}  get element count  ${accept_button}
    Run Keyword If   '${count}'=='1'    click element   ${accept_button}
#    sleep  1s
#    Comment    弹框包含"Welcome to Help Lightning!"
#    Wait Until Page Contains    ${log_in_success_tag}   20s

expand_workspaces_switch
    # Expand workspace
    click element   ${expand_workspace_button}
    sleep  1s

switch_to_created_workspace
    [Arguments]     ${witch_created_WS}
    # Expand workspace
    expand_workspaces_switch
    # choose second workspace
    click element   ${witch_created_WS}
    sleep  3
    ${ele_count}     get element count    ${accept_disclaimer}
    Run Keyword If   '${ele_count}'=='1'    click element    ${accept_disclaimer}
    sleep   1s

switch_to_second_workspace
    # Expand workspace
    expand_workspaces_switch
    # choose second workspace team user
    click element   ${Canada_workspace}
    sleep  2
    ${ele_count}     get element count    ${accept_disclaimer}
    Run Keyword If   '${ele_count}'=='1'    click element    ${accept_disclaimer}

switch_to_first_workspace
    # Expand workspace
    click element   ${expand_workspace_button}
    sleep  1s
    click element  xpath=//div[@class="k-list-scroller"]//li[1]
    sleep  2s
    ${ele_count}     get element count    ${accept_disclaimer}
    Run Keyword If   '${ele_count}'=='1'    click element    ${accept_disclaimer}

make_sure_workspaces_call_center_mode_feature
    [Arguments]   ${setting_1}   ${setting_2}
    # enter first workspace workspace setting
    enter_workspace_workspace_settings
    # workspace WS1 has "Disable External Feature"=ON or OFF
    Run Keyword If   '${setting_1}'=='open_feature'    open_call_center_mode
    ...  ELSE IF  '${setting_1}'=='close_feature'    close_call_center_mode
    # switch to second workspace
    switch_to_second_workspace
    # enter second workspace workspace setting
    enter_workspace_workspace_settings
    # workspace WS2 has "Disable External Feature"=ON or OFF
    Run Keyword If   '${setting_2}'=='open_feature'    open_call_center_mode
    ...  ELSE IF  '${setting_2}'=='close_feature'    close_call_center_mode

make_sure_workspaces_setting_external_feature
    [Arguments]   ${setting_1}   ${setting_2}
    # enter first workspace workspace setting
    enter_workspace_workspace_settings
    # workspace WS1 has "Disable External Feature"=ON or OFF
    Run Keyword If   '${setting_1}'=='open_feature'    open_disable_external_users
    ...  ELSE IF  '${setting_1}'=='close_feature'    close_disable_external_users
    # switch to second workspace
    switch_to_second_workspace
    # enter second workspace workspace setting
    enter_workspace_workspace_settings
    # workspace WS2 has "Disable External Feature"=ON or OFF
    Run Keyword If   '${setting_2}'=='open_feature'    open_disable_external_users
    ...  ELSE IF  '${setting_2}'=='close_feature'    close_disable_external_users

make_sure_workspaces_setting_workspace_directory
    [Arguments]   ${setting_1}   ${setting_2}
    # enter first workspace workspace setting
    enter_workspace_workspace_settings
    # workspace WS1 has "Disable External Feature"=ON or OFF
    Run Keyword If   '${setting_1}'=='open_feature'    open_workspace_directory
    ...  ELSE IF  '${setting_1}'=='close_feature'    close_workspace_directory
    # switch to second workspace
    switch_to_second_workspace
    # enter second workspace workspace setting
    enter_workspace_workspace_settings
    # workspace WS2 has "Disable External Feature"=ON or OFF
    Run Keyword If   '${setting_2}'=='open_feature'    open_workspace_directory
    ...  ELSE IF  '${setting_2}'=='close_feature'    close_workspace_directory

make_sure_workspaces_setting_tagging_and_comments
    [Arguments]   ${setting_1}   ${setting_2}
    # enter first workspace workspace setting
    enter_workspace_workspace_settings
    # workspace WS1 has "After Call: Tagging and Comments"=ON or OFF
    Run Keyword If   '${setting_1}'=='open_feature'    open_tagging_and_comments
    ...  ELSE IF  '${setting_1}'=='close_feature'    close_tagging_and_comments
    # switch to second workspace
    switch_to_second_workspace
    # enter second workspace workspace setting
    enter_workspace_workspace_settings
    # workspace WS2 has "After Call: Tagging and Comments"=ON or OFF
    Run Keyword If   '${setting_2}'=='open_feature'    open_tagging_and_comments
    ...  ELSE IF  '${setting_2}'=='close_feature'    close_tagging_and_comments

expand_option_delete_user
    # EXPAND delete user 选项
    click element    ${disclaimer_delete_user}//button[contains(.,'Expand')]
    sleep  1s

open_invitation_message_setting_and_fill_message
    [Arguments]   ${message_content}
    # 点击打开Invitation Message 选项的按钮，弹出会话框
    click element    ${before_call_invitation_message}//div[@class="react-toggle"]
    sleep  1s
    # 输入message
    click element  ${invitation_message_input}
    sleep   0.5s
    input text   ${invitation_message_input}     ${message_content}
    sleep   0.5s
    # 点击OK按钮
    click element    xpath=//button[text()="OK"]
    sleep   1s

expand_option_invitation_message_and_fill_message
    [Arguments]   ${message_content}
    # EXPAND Invitation Message 选项
    click element    ${before_call_invitation_message}//button[contains(.,'Expand')]
    sleep  1s
    # 点击Click to edit按钮
    click element     ${before_call_invitation_message}//button[text()="Click to edit"]
    sleep  1s
    # 清空后输入message
    Press Key     ${invitation_message_input}     \\8
    input text    ${invitation_message_input}     ${message_content}
    # 点击保存按钮
    click element    ${invitation_message_save}
    sleep  2s

fill_invitation_message_content
    [Arguments]   ${message_content}
    ${count}   get element count   ${before_call_invitation_message}//div[@class="react-toggle"]
    Run Keyword If   '${count}'=='1'    open_invitation_message_setting_and_fill_message       ${message_content}
    ...  ELSE IF   '${count}'=='0'      expand_option_invitation_message_and_fill_message      ${message_content}

click_close_invitation_message
    click element     ${before_call_invitation_message}//div[@class="react-toggle react-toggle--checked"]
    sleep   1s

close_invitation_message_set
    # 关闭 Invitation Message 选项
    ${count}    get element count    ${before_call_invitation_message}//div[@class="react-toggle"]
    Run Keyword If   '${count}'=='0'     click_close_invitation_message

#fill_invitation_message
#    [Arguments]   ${message_content}
#    click element     ${before_call_invitation_message}//button[text()="Click to edit"]
#    sleep  1s
#    Press Key     ${invitation_message_input}     \\8
#    input text    ${invitation_message_input}     ${message_content}
#    click element    ${invitation_message_save}
#    sleep  2s

check_invitation_message_correct_from_email
    [Arguments]   ${message_content}
    sleep  25s
    ${result}    get_external_invitation_message     ${message_content}
    should be equal as strings     ${result}     External invitation message is correct

enter_which_call_details
    [Arguments]   ${which_call}
    # 进入哪一行call记录的detail
    wait until element is visible    xpath=//div[@row-index="${which_call}"]//button[contains(text(),"Details")]
    click element   xpath=//div[@row-index="${which_call}"]//button[contains(text(),"Details")]
    wait until element is visible     ${participant_name}    20s

close_call_details
    # 关闭call的details页面
    click element    xpath=//div[@class="modal-content"]//span[text()='×']/..
    wait until element is visible    xpath=//div[@class="ag-center-cols-container"]/div[@row-index="1"]    # 等待第二条数据展示出来

check_details_participant_count
    [Arguments]   ${participants_count}
    element should not be visible    xpath=//table[@class="table table-striped"]//tr[${participants_count}+1]
    ${count}   get element count      ${participant_name}
    should be equal as strings    ${count}   ${participants_count}

check_details_participant_name
    [Arguments]   ${participant_name}
    wait until element is visible    xpath=//table[@class="table table-striped"]//a[text()="${participant_name}"]

check_event_log_deleted_user
    [Arguments]   ${expect_count}
    wait until element is visible    xpath=//table[@class="table table-striped"]//tr/td/div[text()="Deleted User"]
    ${count}    get element count   xpath=//table[@class="table table-striped"]//tr/td/div[text()="Deleted User"]
    should be equal as strings    ${count}    ${expect_count}
