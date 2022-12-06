*** Settings ***
Library           Selenium2Library
Library           OperatingSystem
Resource          ../../Lib/login_with_site_admin_resource.robot
Resource          ../../Lib/public.robot


*** Test Cases ***
New_Site_admin_logs_in_Citron
    [Documentation]    New Site admin logs in Citron
    [Tags]    有bug，https://vipaar.atlassian.net/browse/CITRON-3053     open outlook email    有bug：https://vipaar.atlassian.net/browse/CITRON-3627，已修复
    # log in with crunch site admin
    Login_crunch
    # enter enterprises menu
    enter_enterprises_menu
    # new enterprises
    ${email_before}   ${email}   new_enterprice
    # New Site admin receives the email, clicks link to set password
    fill_password_mailbox
    # close browser
    Close
    # New Site admin logs in Citron
    Login_new_added_user   ${email}
    # Just Only Workspaces, Site Setting.[Dashboard, Users, Calls has been hidden.]
    only_workspaces_site_setting
#    # Has Default workspace
#    has_default_workspace
    # enter site Site Settings page
    enter_site_site_settings
    # Just has Primary Contact
    just_has_primary_contact
    # Edit Site Name, Time Zone, Contact Name, Contact Email & Contact Phone
    ${email_before}    ${email_update}   edit_primary_contact
    # close browser
    Close
    # New Site admin logs in Citron
    Login_new_added_user  ${email}
    # enter site Site Settings page
    enter_site_site_settings
    #  the value is updated value.
    check_primary_contact_updated  ${email_before}  ${email_update}
    [Teardown]    Close