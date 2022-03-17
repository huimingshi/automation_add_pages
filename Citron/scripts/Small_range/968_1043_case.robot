*** Settings ***
Library           Selenium2Library
Library           OperatingSystem
Resource          ../../Lib/small_range_resource.robot
Resource          ../../Lib/public.robot

#
#*** Test Cases ***
#Small_range_977
#    [Documentation]     Change product name to text with Chinese character+number+special character
#    [Tags]    small range 977 line
#    # Login_workspaces_admin
#    Login_workspaces_admin
#    enter_workspace_settings_page
#    # Change product name to text with Chinese character+number+special character
#    ${get_value}   modify_workspace_branding_setting
#    Close
#    # 进入到Contacts页面
#    enter_contacts_page
#    # get_background_color
#    get_background_color
