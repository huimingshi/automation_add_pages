*** Settings ***
Library           Selenium2Library
Library           OperatingSystem
Resource          ../../Lib/login_with_site_admin_resource.robot
Resource          ../../Lib/public.robot


*** Test Cases ***
Site_Admin_Add_users_do_not_select_workspace
    [Documentation]     Add Users Don't select workspace
    [Tags]     Add Users Don't select workspace      open outlook email
    # log in with site admin
    Login_site_admin
    # enter SITE ADMINISTRATION Users page
    enter_site_users
    # Add Users Don't select workspace
    ${email_before}   ${email}     add_normal_user_without_workspaces
    # The user is listed in Active Users tab.
    search_new_added_user    ${email}
    # receives the email, clicks link to set password
    fill_password_mailbox
    # close browser
    Close
    # New added user logs in Citron
    Login_new_added_user   ${email}
    # close browser
    Close
    # log in with site admin
    Login_site_admin
    # enter SITE ADMINISTRATION Users page
    enter_site_users
    # The user is listed in Active Users tab.
    search_new_added_user    ${email}
    # click DETAILS button
    click_user_details
    # Add workspace for user
    add_workspace_for_user
    # close browser
    Close
    # this new user can successfully login Citron
    Login_new_added_user   ${email}
    # the workspace is correct.
    the_workspace_is_correct
    [Teardown]    Close

Site_Admin_Add_users_select_one_workspace
    [Documentation]     Add Users Select one of workspace
    [Tags]     Add Users Select one of workspace       open outlook email
    # log in with site admin
    Login_site_admin
    switch_to_created_workspace    ${auto_default_workspace_xpath}
    # enter SITE ADMINISTRATION Users page
    enter_site_users
    # Select one of workspace
    ${email_before}   ${email}  add_normal_user_select_one_workspaces
    # Click this workspace
    select_a_worksapce_and_click_at_add   ${email_before}   ${email}
    # Click 'Cancel' button then Click 'ADD' button
    cancel_then_add_user
    # receives the email, clicks link to set password
    fill_password_mailbox
    # close browser
    Close
    # this new user can successfully login Citron
    Login_new_added_user   ${email}
    # the workspace is correct.
    the_workspace_is_correct
    [Teardown]    Close

Site_Admin_Add_users_Click_Submit_and_Add_another_button
    [Documentation]     Add Users Click 'Submit and Add another' button
    [Tags]     Add Users Click 'Submit and Add another' button       open outlook email
    # log in with site admin
    Login_site_admin
    switch_to_created_workspace    ${auto_default_workspace_xpath}
    # enter SITE ADMINISTRATION Users page
    enter_site_users
    # Add Users Select one of workspace And Click 'Submit and Add another' button
    ${email_before}   ${email}     add_normal_user_click_submit_and_add_another_button
    # The Email, Name, Title, Location, Mobile Phone should be blank.
    field_content_is_empty
    # receives the email, clicks link to set password
    fill_password_mailbox
    # close browser
    Close
    # this new user can successfully login Citron
    Login_new_added_user   ${email}
    # the workspace is correct.
    the_workspace_is_correct
    [Teardown]    Close

Site_Admin_Click_Share_this_filter_button
    [Documentation]    Click ' Share this filter' button
    [Tags]    Click ' Share this filter' button
    [Setup]   check_file_if_exists_delete     # Check whether there are existing files in the path and delete them if there are
    # log in with site admin
    Login_site_admin
    # enter SITE ADMINISTRATION Users page
    enter_site_users
    # Share this filter button & Export to CSV button to instead of 'Report view' button.
    show_three_button
    # Click 'Export to CSV' button
    users_share_this_filter
    # Click 'Export Current Table' button
    users_export_to_csv
    # the values of name, Title, Location, Email, License, Role Workspace, Most Recent Call, Last Active & Created at are correct.
    users_check_cloumns_workspaces_tab
    [Teardown]    Run Keywords   check_file_if_exists_delete   # Check whether there are existing files in the path and delete them if there are
    ...           AND            Close

Site_Admin_Select_randomly_one_User
    [Documentation]     Select randomly one User
    [Tags]     Select randomly one User     open outlook email
    # log in with site admin
    Login_site_admin
    switch_to_created_workspace    ${auto_default_workspace_xpath}
    # enter SITE ADMINISTRATION Users page
    enter_site_users
    # Add Users Select one of workspace And Click 'Add' button
    ${email_before}   ${email}     add_normal_user_select_one_workspaces_confirm
    # The user is listed in Active Users tab.
    search_new_added_user    ${email}
    # Click Upload a photo button
    upload_a_photo   ${email_before}
    # Modify License Type, Username, Name, Title, Location, Mobile Phone, Role
    ${username}   modify_user_basic_info
    # Select one workspace and Click this workspace
    select_a_worksapce_and_click_at_details
    # Click Change avatar button if this user has an exist avatar
    change_avatar_then_remove  ${email_before}
    # Click 'Cancel' button then Click 'Update User' button
    cancel_then_update_user
    # Click 'Send Reset Password email' button
    send_reset_password_email
    # Log in to your mailbox to get the Reset password link and reset your password
    setting_password_email
    # close browser
    Close
    # this new user can successfully login Citron
    Login_new_added_user   ${email}
    # the workspace is correct.
    the_workspace_is_correct
    [Teardown]    Close

Site_Admin_Select_randomly_one_User_Click_Deactivate_User_button
    [Documentation]     Select randomly one User And Click Deactivate User button
    [Tags]     Select randomly one User And Click Deactivate User button
    # log in with site admin
    Login_site_admin
    # enter SITE ADMINISTRATION Users page
    enter_site_users
    # Add Users Select one of workspace And Click 'Add' button
    ${email_before}   ${email}     add_normal_user_select_one_workspaces_confirm
    # The user is listed in Active Users tab.
    search_new_added_user    ${email}
    # Click Deactivate User button
    deactivate_user
    # Select Deactivated Users tab
    select_deactivated_users   ${email}
    [Teardown]    Close
