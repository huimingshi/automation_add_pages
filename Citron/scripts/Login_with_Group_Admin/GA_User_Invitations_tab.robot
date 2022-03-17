*** Settings ***
Library           Selenium2Library
Library           OperatingSystem
Resource          ../../Lib/login_with_group_admin_resource.robot
Resource          ../../Lib/public.robot


*** Test Cases ***
Group_Admin_Resend_invitation
    [Documentation]    Resend invitation
    [Tags]    Resend invitation
    [Setup]   check_file_if_exists_delete     # Check whether there are existing files in the path and delete them if there are
    # log in with workspaces admin
    Login_workspaces_admin
    # enter workspace users
    enter_workspace_users
    # add normal user
    ${email_before}  add_normal_user
    # close browser
    Close
    # log in with another group admin
    Login_another_group_admin
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
    # enter workspace users invitation page
    enter_invitations_page
    # search invitation by email
    search_invitation_by_email   ${email}
    # Resend invitation
    resend_invitation
    # Export to CSV
    export_to_CSV
    # Check columns
    check_cloumns_invitation_users_tab
    [Teardown]    Run Keywords  check_file_if_exists_delete    # Check whether there are existing files in the path and delete them if there are
    ...           AND           Close

Group_Admin_Cancel_invitation
    [Documentation]    Cancel invitation
    [Tags]    Cancel invitation,open outlook email
    # log in with workspaces admin
    Login_workspaces_admin
    # enter workspace users
    enter_workspace_users
    # add normal user
    ${email_before}  add_normal_user
    # close browser
    Close
    # log in with another group admin
    Login_another_group_admin
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
    # enter workspace users invitation page
    enter_invitations_page
    # search invitation by email
    search_invitation_by_email   ${email}
    # Cancel invitation
    cancel_invitation
    # invitation link in email is not valid
    invitation_mail_not_valid
    [Teardown]    Close

Group_Admin_Resend_All_invitation
    [Documentation]    Resend All invitation
    [Tags]    Resend All invitation
    # log in with workspaces admin
    Login_workspaces_admin
    # enter workspace users
    enter_workspace_users
    # add normal user 1
    ${email_before_1}  add_normal_user
    # add normal user 2
    ${email_before_2}  add_normal_user
    # close browser
    Close
    # log in with another group admin
    Login_another_group_admin
    # enter workspace users
    enter_workspace_users

    # add existing normal user 1
    ${email_1}   add_existing_normal_user   ${email_before_1}
    # warning dialog
    warning_dialog
    # Confirm cancel
    Confirm_cancel
    # Confirm invite
    Confirm_invite    ${email_before_1}
    # add existing normal user 2
    ${email_2}   add_existing_normal_user   ${email_before_2}
    # warning dialog
    warning_dialog
    # Confirm cancel
    Confirm_cancel
    # Confirm invite
    Confirm_invite    ${email_before_2}

    # enter workspace users invitation page
    enter_invitations_page
    # Resend All invitation
    resend_all_invitation
    [Teardown]    Close

Group_Admin_Cancel_All_invitation
    [Documentation]    Cancel All invitation
    [Tags]    Cancel All invitation
    # log in with workspaces admin
    Login_workspaces_admin
    # enter workspace users
    enter_workspace_users
    # add normal user 1
    ${email_before_1}  add_normal_user
    # add normal user 2
    ${email_before_2}  add_normal_user
    # close browser
    Close
    # log in with another group admin
    Login_another_group_admin
    # enter workspace users
    enter_workspace_users

    # add existing normal user 1
    ${email_1}   add_existing_normal_user   ${email_before_1}
    # warning dialog
    warning_dialog
    # Confirm cancel
    Confirm_cancel
    # Confirm invite
    Confirm_invite    ${email_before_1}
    # add existing normal user 2
    ${email_2}   add_existing_normal_user   ${email_before_2}
    # warning dialog
    warning_dialog
    # Confirm cancel
    Confirm_cancel
    # Confirm invite
    Confirm_invite    ${email_before_2}

    # enter workspace users invitation page
    enter_invitations_page
    # Cancel All invitation
    cancel_all_invitation
    [Teardown]    Close
