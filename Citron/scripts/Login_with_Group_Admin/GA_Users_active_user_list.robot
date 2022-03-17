*** Settings ***
Library           Selenium2Library
Library           OperatingSystem
Resource          ../../Lib/login_with_group_admin_resource.robot
Resource          ../../Lib/public.robot

*** Test Cases ***
Only_display_users_in_the_groups_that_group_admin_manages
    [Documentation]    Only display users in the groups that group admin manages
    [Tags]    Only display users in the groups that group admin manages
    # log in with group admin
    Login_another_group_admin
    # enter group users
    enter_group_users
    # Only_display_users_in_the_groups_that_group_admin_manages
    check_display_users
    [Teardown]    Close

Group_Admin_modify_normal_user
    [Documentation]    Group Admin Modify mormal user
    [Tags]    有bug，CITRON-3146；已修复      open outlook email
    # log in with group admin
    Login_group_admin
    # enter group users
    enter_group_users
    # add normal user
    ${email_before}    add_normal_user
    # search user
    search_user_details  ${email_before}
    # Modify name,title, location, avatar, phone, and submit form.
    modify_basic_info
    # check modify success
    check_modify_user_success
    # Modify Groups
    modify_user_groups
    # cannot change role
    cannot_change_role
    # cannot change License Type
    cannot_change_license_type
    # Send reset password
    send_reset_password
    # Log in to your mailbox to get the Reset password link and reset your password
    accept_outlook_email
    # Click on Deactivate User
    deactivate_user
    # Enter Deactivated Users tab
    enter_deactivated_users_page
    # search deactivated user
    search_deactivated_user      ${email_before}
    # Reactivate user
    reactivate_user
    # enter Active Users tab
    enter_active_users_page
    # search active user
    search_active_user   ${email_before}
    [Teardown]    Close

Group_Admin_modify_group_admin
    [Documentation]    Group Admin Modify group user
    [Tags]    有bug，CITRON-3146；已修复,open outlook email
    # log in with workspaces admin
    Login_workspaces_admin
    # enter workspace users
    enter_workspace_users
    # add normal user
    ${email_before}    add_group_user
    # Close browser
    Close

    # log in with group admin
    Login_group_admin
    # enter group users
    enter_group_users
    # search user
    search_user_details  ${email_before}
    # Only avatar and Member of field are editable
    only_avatar_is_editable
    # check avatar upload success
    check_avatar_upload_success
    # Modify Groups
    modify_group_admin_groups
    # Send reset password
    send_reset_password
    # Log in to your mailbox to get the Reset password link and reset your password
    accept_outlook_email
    # Click on Deactivate User
    deactivate_user
    # Enter Deactivated Users tab
    enter_deactivated_users_page
    # search deactivated user
    search_deactivated_user      ${email_before}
    # Reactivate user
    reactivate_user
    # enter Active Users tab
    enter_active_users_page
    # search active user
    search_active_user   ${email_before}
    # close browser
    Close

    # Login new added group admin
    Login_new_added_user   ${email_before}
    [Teardown]    Close

#Deactivate_user_button_is_not_visible
#    [Documentation]    Deactivate user button is not visible
#    [Tags]    Citron 90 line，有bug：https://vipaar.atlassian.net/browse/CITRON-3336    ,GA登录后查看自己账号的详细信息，Deactive按钮应该不可见
#    # log in with group admin
#    Login_group_admin
#    # enter group users
#    enter_group_users
#    # search user
#    search_user_details    ${group_admin_username}
#    # Deactivate user button is not visible
#    deactivate_user_button_not_visible
#    [Teardown]  Close

Group_Admin_modify_workspace_admin
    [Documentation]    Group Admin Modify group user
    [Tags]    有bug，CITRON-3146；已修复,open outlook email
    # log in with workspaces admin
    Login_workspaces_admin
    # enter workspace users
    enter_workspace_users
    # add normal user
    ${email_before}    add_workspace_user
    # Close browser
    Close

    # log in with group admin
    Login_group_admin
    # enter group users
    enter_group_users
    # search user
    search_user_details   ${email_before}
    # Only avatar and Member of field are editable
    only_avatar_is_editable
    # check avatar upload success
    check_avatar_upload_success
    # Modify Groups
    modify_group_admin_groups
    # Send reset password
    send_reset_password
    # Log in to your mailbox to get the Reset password link and reset your password
    accept_outlook_email
    # Click on Deactivate User
    deactivate_user
    # Enter Deactivated Users tab
    enter_deactivated_users_page
    # search deactivated user
    search_deactivated_user      ${email_before}
    # Reactivate user
    reactivate_user
    # enter Active Users tab
    enter_active_users_page
    # search active user
    search_active_user   ${email_before}
    [Teardown]    Close

Group_Admin_add_normal_user_Choose_Team_license
    [Documentation]    Group Admin Modify mormal user
    [Tags]    有bug，CITRON-3146；已修复
    # log in with group admin
    Login_group_admin
    # enter group users
    enter_group_users
    # add normal user
    ${email}    add_normal_user_choose_team_license
    # search user
    search_user_details  ${email}
    # Clear group
    clear_group
    [Teardown]    Close