*** Settings ***
Library           Selenium2Library
Library           OperatingSystem
Resource          ../../Lib/hodgepodge_resource.robot
Resource          ../../Lib/public.robot

*** Test Cases ***
Register_personal
    [Documentation]    Register personal
    [Tags]    Register personal
    # Open register personal website
    Open_register_personal_website
    # register personal
    ${email_before}   ${email}     register_personal
    # Cicking confirm email link
    accept_outlook_email
    # Login new added user
    Login_new_added_register_personal   ${email}
    [Teardown]    Close

Premium_Enterprise_User_Can_login_but_not_see_the_Administration
    [Documentation]    Premium/Enterprise User Can login but not see the Administration
    [Tags]    Premium/Enterprise User Can login but not see the Administration
    # Login Premium/Enterprise User
    Login_normal_for_calls
    # can_not_see_the_Administration
    can_not_see_the_administration
    [Teardown]    Close

SSO_Login_with_Cognito_account
    [Documentation]    Login with Cognito account[xiaoyan.yan+cognito@helplightning.com,emily.huang+cognito@helplightning.com/Abc12345]
    [Tags]    Login with Cognito account[xiaoyan.yan+cognito@helplightning.com,emily.huang+cognito@helplightning.com/Abc12345]
    # Login with Cognito account
    Login_with_Cognito_account
    # Log out from citron
    log_out_from_citron
    # Re-log in Citron with cognito_web_page_sign_up
    re_log_in_citron_with_cognito
    [Teardown]    Close

Check_this_account_has_how_many_menus
    [Documentation]    If this account just has one workspace, If this account has 2 or more workspaces
    [Tags]    If this account just has one workspace, If this account has 2 or more workspaces
    # Login just one workspace SiteAdmin
    Login_new_added_user    ${site_admin_name_one_workspace}
    # the Site administration just has 2 menus: Workspace & Site Setting
    check_2_menus
    # login Site Admin
    Login_site_admin
    # the Site Administation has Dashboard, workspaces, Calls, Users & Site Setting
    check_5_menus
    [Teardown]    Close

Forgot_password
    [Documentation]    Forgot password
    [Tags]    Citron  25 line
    # log in with workspaces admin
    Login_workspaces_admin
    # enter workspace users
    enter_workspace_users
    # add normal user
    ${random}   get_random_number
    ${email}    add_a_normal_user   ${random}
    # send Forget Password email
    send_forget_password_email   ${email}
    # Enter a new password
    enter_a_new_password
    # Login new added normal user
    Login_new_added_user   ${email}
    [Teardown]    Close

My_Account_When_enterprise_admin_logins
    [Documentation]    My Account When enterprise admin logins
    [Tags]    Citron  37-44 lines - 40
    # log in with Site admin
    Login_site_admin
    # enter My Account page
    enter_my_account_page
    # Email and My Help Space URL fields are read-only.
    email_and_url_are_readOnly
    # Display Role with Site Administrator, read-only under License Type and above Email
    dispaly_role_and_its_location    Site Admin
    # Change name, title and location
    ${random}   get_random_number
    change_name_title_location   ${random}  ${random}
    # Check Change name, title and location successfully
    check_changed_successfully   ${random}  ${random}
    # Upload a photo
    upload_a_photo
    # Change your avatar
    change_your_avatar
    # Remove my avatar
    remove_my_avatar
    # Change password
    my_account_change_password   ${site_admin_password}    ${public_password_change}
    [Teardown]    run keywords    remove_avatar_teardown
    ...           AND             change_name_title_location   huiming.shi    huiming.shi    # Restore name, title and location to the initial value
    ...           AND             my_account_change_password   ${public_password_change}    ${site_admin_password}     # Restore password to the initial value
    ...           AND             Close

My_Account_When_GA_logins
    [Documentation]    My Account When GA logins
    [Tags]    Citron  37-44 lines - 39
    # log in with Group admin
    Login_group_admin
    # enter My Account page
    enter_my_account_page
    # Email and My Help Space URL fields are read-only.
    email_and_url_are_readOnly
    # Display Role with Site Administrator, read-only under License Type and above Email
    dispaly_role_and_its_location    Group Admin
    # Display “Group Admin for” with all GA”s groups, read-only.
    display_group_admin_for
    # Change name, title and location
    ${random}   get_random_number
    change_name_title_location   ${random}   ${random}
    # Check Change name, title and location successfully
    check_changed_successfully   ${random}   ${random}
    # Upload a photo
    upload_a_photo
    # Change your avatar
    change_your_avatar
    # Remove my avatar
    remove_my_avatar
    # Change password
    my_account_change_password   ${public_pass}    ${public_password_change}
    [Teardown]    run keywords    remove_avatar_teardown
    ...           AND             change_name_title_location    citron_group_admin    请勿动该账号，自动化测试专用  # Restore name, title and location to the initial value
    ...           AND             my_account_change_password   ${public_password_change}    ${public_pass}     # Restore password to the initial value
    ...           AND             Close

Business_Setting_login_with_Workspace_admin_Primary_Contact
    [Documentation]    Business Setting (login with Workspace admin),Primary Contact
    [Tags]    Business Setting (login with Workspace admin),Primary Contact
    # log in with workspaces admin
    Login_workspaces_admin
    # enter workspace users
    enter_workspace_workspace_settings
    # enter Primary Contact page
    enter_primary_contact
    # get a random number
    ${random}  get_random_number
    # Modify workspace name, time zone, Contact Name, Contact Email, Contact Phone
    primary_contact_modify_message   ${random}   Huiming.shi.helplightning+qwer@outlook.com   1
    [Teardown]    run keywords    primary_contact_modify_message    auto_default_workspace   Huiming.shi.helplightning@outlook.com    2     # Restore message to the initial value
    ...           AND             Close

Business_Setting_login_with_Workspace_admin_Delete_Users_that_Decline_the_Disclaimer
    [Documentation]    Business Setting (login with Workspace admin),Delete Users that Decline the Disclaimer
    [Tags]    Business Setting (login with Workspace admin),Delete Users that Decline the Disclaimer
    # log in with workspaces admin
    Login_workspaces_admin
    # enter workspace users
    enter_workspace_workspace_settings
    # The option 'delete user' is selected or not
    option_delete_user_is_selected_or_not
    # log in with crunch site admin
    Login_crunch
    # enter crunch Audit Logs page
    enter_enterprises_audit_log
    # verify_option_delete_user_recorded_in_audit_log
    modify_record_in_crunch_is_correct   User citron (56213) updated Enterprise auto_default_workspace (2799) property 'delete_users_upon_declination_of_disclaimer' to 'true'.    User citron (56213) updated Enterprise auto_default_workspace (2799) property 'delete_users_upon_declination_of_disclaimer' to 'false'.
    [Teardown]    Close

SSO_Invite_an_account_into_Cognito_enterprise
    [Documentation]    SSO	Invite an account into Cognito enterprise
    [Tags]    Citron 53 line
    # Open register personal website
    Open_register_personal_website
    # register personal
    ${email_before}   ${email}   register_personal
    # Cicking confirm email link
    accept_outlook_email

    # Login with Cognito account
    Login_with_Cognito_account
    # enter workspace users
    enter_workspace_users
    # invite personal user
    invite_personal_user  ${email_before}   ${email}
    # Log in to your mailbox to get the Accept Invitation link and reset your password
    accept_invitation_mailbox

    # Navigate to Cognito web page,	Click Sign up button
    cognito_web_page_sign_up  ${email_before}   ${email}
    # get Verification Code from email
    ${verification_code}  get_verification_code
    # Comfirm Account
    comfirm_account   ${verification_code}
    [Teardown]    Close

Modify_disclaimer_Set_Disclaimer_on_No_click_Reset_button
    [Documentation]    Business Setting (login with Workspace admin),Modify disclaimer,Set Disclaimer =on,No click Reset button
    [Tags]    Business Setting (login with Workspace admin),Modify disclaimer,Set Disclaimer =on,No click Reset button
    # log in with normal user
    Login_normal_for_calls
    # log in with workspaces admin
    Login_workspaces_admin
    # enter workspace users
    enter_workspace_workspace_settings
    # EXPAND
    expand_option_delete_user
    # Set Disclaimer =on
    set_disclaimer_is_on
    # User who has accepted the declaimer before logs in App	The disclaimer should not be popped up automate
    check_disclaimer_poped_up_or_not    ${normal_username_for_calls}    0
    [Teardown]    Close

Modify_disclaimer_Set_Disclaimer_on_click_Reset_button
    [Documentation]    Business Setting (login with Workspace admin),Modify disclaimer,Set Disclaimer =on,click Reset button
    [Tags]    Business Setting (login with Workspace admin),Modify disclaimer,Set Disclaimer =on,click Reset button
    # log in with normal user
    Login_normal_for_calls
    # log in with workspaces admin
    Login_workspaces_admin
    # enter workspace users
    enter_workspace_workspace_settings
    # EXPAND
    expand_option_delete_user
    # Set Disclaimer =on
    set_disclaimer_is_on
    # Reset All Accepted Disclaimers
    reset_all_accepted_disclaimers
    # User who has accepted the declaimer before logs in App	The disclaimer should not be popped up automate
    check_disclaimer_poped_up_or_not    ${normal_username_for_calls}   1
    [Teardown]    Close

Modify_disclaimer_Set_Disclaimer_off
    [Documentation]    Business Setting (login with Workspace admin),Modify disclaimer,Set Disclaimer =off
    [Tags]    Business Setting (login with Workspace admin),Modify disclaimer,Set Disclaimer =off
    # log in with workspaces admin
    Login_workspaces_admin
    # enter workspace users
    enter_workspace_workspace_settings
    # EXPAND
    expand_option_delete_user
    # Set Disclaimer =off
    set_disclaimer_is_off
    # User who has accepted the declaimer before logs in App	The disclaimer should not be popped up automate
    check_disclaimer_poped_up_or_not    ${normal_username_for_calls}    0
    [Teardown]    Close

Modify_disclaimer_click_Reset_button
    [Documentation]    Business Setting (login with Workspace admin),Modify disclaimer,Set Disclaimer =on,click Reset button then cancel
    [Tags]    Business Setting (login with Workspace admin),Modify disclaimer,Set Disclaimer =on,click Reset button then cancel
    [Setup]   run keywords   Login_normal_for_calls   # log in with normal user
    ...       AND            Close    # close browser
    # log in with workspaces admin
    Login_workspaces_admin
    # enter workspace users
    enter_workspace_workspace_settings
    # EXPAND
    expand_option_delete_user
    # Set Disclaimer =on
    set_disclaimer_is_on
    # Reset All Accepted Disclaimers then cancel
    reset_all_accepted_disclaimers
    # User who has accepted the declaimer before logs in App	The disclaimer should not be popped up automate
    check_disclaimer_poped_up_or_not    ${normal_username_for_calls}   1
    [Teardown]    Close

Modify_disclaimer_click_Reset_button_cancel
    [Documentation]    Business Setting (login with Workspace admin),Modify disclaimer,Set Disclaimer =on,click Reset button then cancel
    [Tags]    Business Setting (login with Workspace admin),Modify disclaimer,Set Disclaimer =on,click Reset button then cancel
    [Setup]   run keywords   Login_normal_for_calls   # log in with normal user
    ...       AND            Close    # close browser
    # log in with workspaces admin
    Login_workspaces_admin
    # enter workspace users
    enter_workspace_workspace_settings
    # EXPAND
    expand_option_delete_user
    # Set Disclaimer =on
    set_disclaimer_is_on
    # Reset All Accepted Disclaimers then cancel
    reset_all_accepted_disclaimers_cancel
    # User who has accepted the declaimer before logs in App	The disclaimer should not be popped up automate
    check_disclaimer_poped_up_or_not    ${normal_username_for_calls}   0
    [Teardown]    Close

Allow_Users_to_Enter_their_Mobile_Number
    [Documentation]    Allow Users to Enter their Mobile Number
    [Tags]    Citron 45-48 lines
    # log in with workspaces admin
    Login_workspaces_admin
    # enter workspace users
    enter_workspace_users
    # add normal user
    ${random}   get_random_number
    ${email}    add_a_normal_user    ${random}
    # search user
    search_user_details  ${email}
    # Enter the wrong phone number with correct country code
    enter_phone_with_country_code   8612345678911    1    0
    # click DETAILS button
    click_deatils
    # Enter the correct phone number with wrong country code
    enter_phone_with_country_code   1115951747996    1    0
    # click DETAILS button
    click_deatils
    # Enter the valid phone number with country code
    enter_phone_with_country_code   8615951747996    0    1
    # the Phone number should be successfully saved
    phone_saved_successfully

    # log in with crunch site admin
    Login_crunch
    # enter crunch Audit Logs page
    enter_enterprises_audit_log
    # verify_option_delete_user_recorded_in_audit_log
    modify_phone_in_crunch_is_correct     +8615951747996
    [Teardown]    Close

Search_Personal_Contacts
    [Documentation]    Search Personal Contacts
    [Tags]    Search Personal Contacts
    [Setup]     run keywords    Login_premium_user    # log in with Premium User
    ...         AND             enter_workspace_workspace_settings   # enter workspace settings page
    ...         AND             close_disable_external_users    # close Security: Disable External Users setting
    # enter Contacts Personal page
    enter_contact_personal_page
    # Search Personal Contacts
    search_personal_contact
    [Teardown]    Close

Favorite_Filter_onCall_group_AND_unfavorite_onCall_group_from_favorite_tab
    [Documentation]    Favorite Filter on-call group AND unfavorite on-call group from favorite tab
    [Tags]    Favorite Filter on-call group AND unfavorite on-call group from favorite tab
    # log in with Premium User
    Login_premium_user
    # favorite on-call group from team page
    add_to_favorite    On-call group update
    # enter Favorites page
    enter_favorites_page
    # Filter_contact
    search_favorite  On-call group update   1
    # unfavorite on-call group from favorite tab
    unfavorite_from_favorite_tab    On-call group update
    [Teardown]    Close

Favorite_Filter_contact_AND_unfavorite_contact_from_favorite_tab
    [Documentation]    Favorite Filter contact AND unfavorite contact from favorite tab
    [Tags]    Favorite Filter contact AND unfavorite contact from favorite tab
    # log in with Premium User
    Login_premium_user
    # favorite on-call group from team page
    add_to_favorite   Big UserGroup_00000023
    # enter Favorites page
    enter_favorites_page
    # Filter_contact
    search_favorite  Big UserGroup_00000023    1
    # unfavorite on-call group from favorite tab
    unfavorite_from_favorite_tab   Big UserGroup_00000023
    [Teardown]    Close

favorite_onCall_group_from_team_page_AND_unfavorite_onCall_group_from_team_page
    [Documentation]    favorite on-call group from team page AND unfavorite on-call group from team page
    [Tags]    favorite on-call group from team page AND unfavorite on-call group from team page
    # log in with Premium User
    Login_premium_user
    # ordered by alphabetically
    ordered_by_alphabetically
    # favorite on-call group from team page or unfavorite
    favorite_on_call_group_from_team_page_or_not    On-call group update
    [Teardown]    Close

#Anonymous_clicks_Users_meeting_room_link_who_has_accepted_the_declaimer_before_logs_in_App
#    [Documentation]    Anonymous clicks User's meeting room link who has accepted the declaimer before logs in App
#    [Tags]    Citron 74     Anonymous clicks User's meeting room link who has accepted the declaimer before logs in App    有bug：https://vipaar.atlassian.net/browse/CITRON-3492
#    [Setup]   run keywords    Login_normal_for_calls   # log in with normal user
#    ...       AND             Close    # close browser
#    # log in with workspaces admin
#    Login_workspaces_admin
#    # enter workspace users
#    enter_workspace_workspace_settings
#    # EXPAND
#    expand_option_delete_user
#    # Set Disclaimer =on
#    set_disclaimer_is_on
#    # Reset All Accepted Disclaimers then cancel
#    reset_all_accepted_disclaimers
#    # The disclaimer should be popped up automate
#    disclaimer_popped_up_automate    https://app-stage.helplightning.net.cn/meet/Huiming.shi.helplightning+1234567891
#    [Teardown]    Close

Anonymous_clicks_Users_expert_universal_link_who_has_accepted_the_declaimer_before_logs_in_App
    [Documentation]    Anonymous clicks User's expert universal link who has accepted the declaimer before logs in App
    [Tags]    Citron 76       Anonymous clicks User's expert universal link who has accepted the declaimer before logs in App
    # log in with workspaces admin
    Login_workspaces_admin
    # enter workspace settings
    enter_workspace_workspace_settings
    # EXPAND
    expand_option_delete_user
    # Set Disclaimer =on
    set_disclaimer_is_on
    # Reset All Accepted Disclaimers then cancel
    reset_all_accepted_disclaimers
    # The disclaimer should be popped up automate
    disclaimer_popped_up_automate    https://app-stage.helplightning.net.cn/help?enterprise_id=2799&group_id=5475&group_name=on-call+group+1
    [Teardown]    Close

Modify_Disable_external_Users
    [Documentation]    Modify Disable external Users
    [Tags]    Citron 67 line
    # log in with workspaces admin
    Login_workspaces_admin
    # enter workspace settings
    enter_workspace_workspace_settings
    # close disable external users
    close_disable_external_users
    # enter Contacts page
    enter_contacts
    # 刷新页面
    refresh_web_page
    # the Personal User Contacts tab still be exists
    personal_contact_tab_exists   1
    # enter workspace users
    enter_workspace_workspace_settings
    # Modify Disable external Users open
    open_disable_external_users
    # enter Contacts page
    enter_contacts
    # 刷新页面
    refresh_web_page
    # the Personal User Contacts tab will be removed
    personal_contact_tab_exists   0
    [Teardown]    Close

#Set_Survey_ON_and_set_URL_Starts_with_https_but_not_in_White_list
#    [Documentation]    Set Survey on  Set URL Starts with https://, but not in White list  VP: Should not be saved
#    [Tags]    有bug，CITRON-3218，未修复
#    # log in with workspaces admin
#    Login_workspaces_admin
#    # enter workspace users
#    enter_workspace_workspace_settings
#    # Set Survey open
#    set_survey_open
#    # Set Survey URL Start without https
#    set_survey_wrong_text    https://this is not a url
#    [Teardown]   Close

Set_Survey_ON_and_set_URL_Start_without_https
    [Documentation]    Set Survey on  Set URL Start without https://  VP: Should not be saved
    [Tags]    Set Survey on  Set URL Start without https://  VP: Should not be saved
    # log in with workspaces admin
    Login_workspaces_admin
    # enter workspace users
    enter_workspace_workspace_settings
    # Set Survey open
    set_survey_open
    # Set Survey URL Start without https
    set_survey_wrong_text     www.baidu.com
    [Teardown]   Close