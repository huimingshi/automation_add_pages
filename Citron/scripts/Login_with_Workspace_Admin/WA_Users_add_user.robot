*** Settings ***
Library           Selenium2Library
Library           OperatingSystem
Resource          ../../Lib/login_with_workspace_admin_resource.robot
Resource          ../../Lib/public.robot


*** Test Cases ***
Workspace_Admin_only_show_groups_of_this_workspace_when_add_user
    [Documentation]    Shows groups drop down list with all groups of this workspace.
    [Tags]    Shows groups drop down list with all groups of this workspace.
    # log in with another workspaces admin
    Login_another_workspaces_admin
    # enter workspace groups
    enter_workspace_groups
    # get groups groups text
    ${get_groups_groups_list}   get_groups_groups_text
    # enter workspace users
    enter_workspace_users
    # get users groups text
    ${get_users_groups_list}   get_users_groups_text
    # Shows groups drop down list with all groups of this workspace.
    lists_should_be_same  ${get_users_groups_list}   ${get_groups_groups_list}
    # check Role
    check_role_list
    [Teardown]    Close

Workspace_Admin_Migrate_existing_Worksapce_Admin_account_to_other_site
    [Documentation]    Migrate existing Worksapce Admin account to other site
    [Tags]    Migrate existing Worksapce Admin account to other site         open outlook email
    # log in with workspaces admin
    Login_workspaces_admin
    # enter workspace users
    enter_workspace_users
    # add workspace admin
    ${email_before}  add_workspace_user
    # Log in to your mailbox to get the Reset password link and reset your password
    fill_password_mailbox
    # close browser
    Close
    # log in with another workspaces admin
    Login_another_workspaces_admin
    # enter workspace users
    enter_workspace_users
    # add existing workspace admin
    ${email}   add_existing_workspace_admin   ${email_before}
    # warning dialog
    warning_dialog
    # Confirm cancel
    Confirm_cancel
    # Confirm invite
    Confirm_invite    ${email_before}
    # Log in to your mailbox to get the Accept Invitation link and reset your password
    accept_invitation_mailbox
    # close browser
    Close
    # new added user log in
    Login_new_added_user   ${email}
    # close browser
    Close
    # log in with another workspaces admin
    Login_another_workspaces_admin
    # enter workspace users
    enter_workspace_users
    # search user
    search_user_details  ${email}
    # close browser
    Close
    # log in with workspaces admin
    Login_workspaces_admin
    # enter workspace users
    enter_workspace_users
    # search user
    search_user_is_missing   ${email}
    [Teardown]    Close

Workspace_Admin_Migrate_existing_Group_Admin_account_to_other_site
    [Documentation]    Migrate existing Group Admin account to other site
    [Tags]    Migrate existing Group Admin account to other site          open outlook email
    # log in with workspaces admin
    Login_workspaces_admin
    # enter workspace users
    enter_workspace_users
    # add workspace admin
    ${email_before}  add_group_user
    # Log in to your mailbox to get the Reset password link and reset your password
    fill_password_mailbox
    # close browser
    Close
    # log in with another workspaces admin
    Login_another_workspaces_admin
    # enter workspace users
    enter_workspace_users
    # add existing group admin
    ${email}   add_existing_group_admin   ${email_before}
    # warning dialog
    warning_dialog
    # Confirm cancel
    Confirm_cancel
    # Confirm invite
    Confirm_invite    ${email_before}
    # Log in to your mailbox to get the Accept Invitation link and reset your password
    accept_invitation_mailbox
    # close browser
    Close
    # new added user log in
    Login_new_added_user   ${email}
    # close browser
    Close
    # log in with another workspaces admin
    Login_another_workspaces_admin
    # enter workspace users
    enter_workspace_users
    # search user
    search_user_details  ${email}
    # close browser
    Close
    # log in with workspaces admin
    Login_workspaces_admin
    # enter workspace users
    enter_workspace_users
    # search user
    search_user_is_missing   ${email}
    [Teardown]    Close


Workspace_Admin_Migrate_existing_User_account_to_other_site
    [Documentation]    Migrate existing User account to other site
    [Tags]    Migrate existing User account to other site          open outlook email
    # log in with workspaces admin
    Login_workspaces_admin
    # enter workspace users
    enter_workspace_users
    # add workspace admin
    ${email_before}  add_normal_user
    # Log in to your mailbox to get the Reset password link and reset your password
    fill_password_mailbox
    # close browser
    Close
    # log in with another workspaces admin
    Login_another_workspaces_admin
    # enter workspace users
    enter_workspace_users
    # add existing normal user
    ${email}   add_existing_normal_user   ${email_before}
    # warning dialog
    warning_dialog
    # Confirm cancel
    Confirm_cancel
    # Confirm invite
    Confirm_invite    ${email_before}
    # Log in to your mailbox to get the Accept Invitation link and reset your password
    accept_invitation_mailbox
    # close browser
    Close
    # new added user log in
    Login_new_added_user   ${email}
    # close browser
    Close
    # log in with another workspaces admin
    Login_another_workspaces_admin
    # enter workspace users
    enter_workspace_users
    # search user
    search_user_details  ${email}
    # close browser
    Close
    # log in with workspaces admin
    Login_workspaces_admin
    # enter workspace users
    enter_workspace_users
    # search user
    search_user_is_missing   ${email}
    [Teardown]    Close

Workspace_Admin_Choose_Expert_license_type_and_Set_role_as_Group_Admin
    [Documentation]    Choose Expert license type and Set role as Group Admin.
    [Tags]    Choose Expert license type and Set role as Group Admin.
    # log in with workspaces admin
    Login_workspaces_admin
    # enter workspace users
    enter_workspace_users
    # add group user
    ${email}  add_group_user
    [Teardown]    Close

Workspace_Admin_Choose_Expert_license_type_and_Set_role_as_Workspace_Admin
    [Documentation]    Choose Expert license type and Set role as Workspace Admin.
    [Tags]    Choose Expert license type and Set role as Workspace Admin.
    # log in with workspaces admin
    Login_workspaces_admin
    # enter workspace users
    enter_workspace_users
    # add workspace user
    ${email}    add_workspace_user
    [Teardown]    Close

Workspace_Admin_Choose_Team_license_type_and_Set_role_as_user
    [Documentation]    Choose Team license type and Set role as user.
    [Tags]    Choose Team license type and Set role as user.
    # log in with workspaces admin
    Login_workspaces_admin
    # enter workspace users
    enter_workspace_users
    # add normal user
    ${email}    add_normal_team_user
    [Teardown]    Close

Workspace_Admin_You_must_specify_at_least_one_group
    [Documentation]    message "You must specify at least one group” displays.
    [Tags]    message "You must specify at least one group” displays.
    # log in with workspaces admin
    Login_workspaces_admin
    # enter workspace users
    enter_workspace_users
    # add normal user
    ${email}    add_user_clear_group
    [Teardown]    Close