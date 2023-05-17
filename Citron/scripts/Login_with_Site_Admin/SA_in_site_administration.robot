*** Settings ***
Library           Selenium2Library
Library           OperatingSystem
Resource          ../../Lib/login_with_site_admin_resource.robot
Resource          ../../Lib/public.robot


*** Test Cases ***
Site_Admin_In_Site_Administration
    [Documentation]     Site Admin In Site Administration
    [Tags]     Site Admin In Site Administration
    # log in with site admin
    Login_site_admin
    # enter SITE ADMINISTRATION Users page
    enter_site_users
    # Has Workspaces, Site Setting, Dashboard, Users, Calls
    display_five_submenus
    # Workspace field should be drop down menu
    workspace_field_should_be_drop_down_menu
    # Select one workspace from drop down menu
    ${workspace_text}   select_one_workspace_from_drop_down_menu
    # Log out from citron
    log_out_from_citron
    # Re-log in Citron with the same user
    re_log_in_citron
    # the workspace field shoud be the selected one before loging out.
    the_workspace_field_should_be_the_selected_one_before_loging_out    ${workspace_text}
    [Teardown]      run keywords    select_default_workspace   # choose defaultworkspace
    ...             AND         log_out_from_citron  # Log out from citron
    ...             AND         re_log_in_citron     # Re-log in Citron with the same user
    ...             AND         the_workspace_field_should_be_the_selected_one_before_loging_out     ${agents_camera_is_off_WS}   # the workspace field shoud be the selected one before loging out.
    ...             AND         Close