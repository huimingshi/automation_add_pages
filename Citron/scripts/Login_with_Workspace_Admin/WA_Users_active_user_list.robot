*** Settings ***
Library           Selenium2Library
Library           OperatingSystem
Resource          ../../Lib/login_with_workspace_admin_resource.robot
Resource          ../../Lib/public.robot


*** Test Cases ***
Workspace_Admin_modify_normal_user
    [Documentation]    Modify mormal user
    [Tags]    有bug，CITRON-2993，修改License不生效        open outlook email
    # log in with workspaces admin
    Login_workspaces_admin
    # enter workspace users
    enter_workspace_users
    # add normal user
    ${email_before}    add_normal_user
    # search user
    search_user_details  ${email_before}
    # Modify name, username, title, location, avatar, phone, and submit form.
    modify_basic_info
    # check modify success
    check_modify_user_success
    # Modify Groups
    modify_user_groups
    # Change role to workspace admin
    change_role_to_workspace_admin
    # Change role to group admin
    change_role_to_group_admin
    # Send reset password
    send_reset_password
    # Log in to your mailbox to get the Reset password link and reset your password
    setting_password_email
#    # Change License Type
#    change_license_type
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

Workspace_Admin_modify_group_admin
    [Documentation]    Modify group user
    [Tags]    有bug，CITRON-2993，修改License不生效        open outlook email
    # log in with workspaces admin
    Login_workspaces_admin
    # enter workspace users
    enter_workspace_users
    # add group user
    ${email_before}    add_group_user
    # search user
    search_user_details  ${email_before}
    # Modify name, username, title, location, avatar, phone, and submit form.
    modify_basic_info
    # check modify success
    check_modify_user_success
    # Modify Groups
    modify_group_admin_groups
    # Change role to user
    change_role_to_user
    # Change role to workspace admin
    change_role_to_workspace_admin
    # Send reset password
    send_reset_password
    # Log in to your mailbox to get the Reset password link and reset your password
    setting_password_email
#    # Change License Type
#    change_license_type
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

Workspace_Admin_modify_workspace_admin
    [Documentation]    Modify workspace user
    [Tags]    有bug，CITRON-2993，修改License不生效        open outlook email
    # log in with workspaces admin
    Login_workspaces_admin
    # enter workspace users
    enter_workspace_users
    # add workspace user
    ${email_before}    add_workspace_user
    # search user
    search_user_details  ${email_before}
    # Modify name, username, title, location, avatar, phone, and submit form.
    modify_basic_info
    # check modify success
    check_modify_user_success
    # Modify Groups
    modify_group_admin_groups
    # Change role to user
    change_role_to_user
    # Change role to group admin
    change_role_to_group_admin
    # Send reset password
    send_reset_password
    # Log in to your mailbox to get the Reset password link and reset your password
    setting_password_email
#    # Change License Type
#    change_license_type
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

Workspace_Admin_group_should_only_list_all_the_groups_of_this_workspace
    [Documentation]    Group should only list all the groups of this workspace.
    [Tags]    Group should only list all the groups of this workspace.
    # log in with workspaces admin
    Login_new_added_user   ${workspace_admin_username_auto}
    # enter workspace groups
    enter_workspace_groups
    # get groups groups text
    ${get_groups_groups_list}   get_groups_groups_text
    # enter workspace users
    enter_workspace_users
    # Gets the groups name when adding a User
    ${NameList_user}   gets_groups_list_when_adding_user
    # Group should only list all the groups of this workspace when adding user
    lists_should_be_same  ${get_groups_groups_list}   ${NameList_user}
    # Gets the groups name when adding a Group Admin
    ${NameList_group}   gets_groups_list_when_adding_group
    # Group should only list all the groups of this workspace  when adding group
    lists_should_be_same  ${get_groups_groups_list}   ${NameList_group}
    # Gets the groups name when adding a Workspace Admin
    ${NameList_workspace}   gets_groups_list_when_adding_workspace
    # Group should only list all the groups of this workspace  when adding workspace
    lists_should_be_same  ${get_groups_groups_list}   ${NameList_workspace}
    [Teardown]    Close

Workspace_Admin_search_records
    [Documentation]    Modify workspace user
    [Tags]    Modify workspace user
    # log in with workspaces admin
    Login_workspaces_admin
    # enter workspace users
    enter_workspace_users
    # search records
    # search by name
    search_list_by_name
    # search by email
    search_list_by_email
    # search by role
    search_list_by_role
    [Teardown]    Close