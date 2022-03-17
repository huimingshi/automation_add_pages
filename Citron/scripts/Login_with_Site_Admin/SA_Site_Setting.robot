*** Settings ***
Library           Selenium2Library
Library           OperatingSystem
Resource          ../../Lib/login_with_site_admin_resource.robot
Resource          ../../Lib/public.robot


*** Test Cases ***
Site_Admin_Site_Setting
    [Documentation]    Site Admin Site Setting
    [Tags]    Site Admin Site Setting
    # log in with site admin
    Login_site_admin
    # enter site Site Settings page
    enter_site_site_settings
    # Just only 'Primory contact' tab to shown up
    just_has_primary_contact
    # Modify Site Name, Time Zone, Contact Name, Contact Email & Contact Phone
    ${email_before}    ${email_update}   edit_primary_contact
    [Teardown]    Close
