*** Settings ***
Library           Selenium2Library
Library           OperatingSystem
Resource          ../../Lib/login_with_site_admin_resource.robot
Resource          ../../Lib/public.robot


*** Test Cases ***
Site_Admin_Clicks_Export_View_button
    [Documentation]    Clicks Report View button
    [Tags]    Clicks Report View button
    [Setup]   check_file_if_exists_delete     # Check whether there are existing files in the path and delete them if there are
    # log in with site admin
    Login_site_admin
    # enter SITE ADMINISTRATION workspaces page
    enter_site_workspaces
    # List all workspaces for this site.
    list_all_workspaces_for_this_site
    # search workspaces
    search_single_workspaces      work_space_for_auto_test_only_one_groups    1
    # Share this filter button & Export to CSV button to instead of 'Report view' button.
    show_two_button
    # Click ' Share this filter' button
    workspaces_share_this_filter
    # Click 'Export to CSV' button
    workspaces_export_to_csv
    # the values of workspace name, Workspace State & Workspace Administrators are correct.
    workspaces_check_cloumns_workspaces_tab
    [Teardown]    Run Keywords   check_file_if_exists_delete   # Check whether there are existing files in the path and delete them if there are
    ...           AND            Close

Site_Admin_Clicks_Create_Workspace_button
    [Documentation]    Clicks Create Workspace button
    [Tags]    Clicks Create Workspace button
    # log in with site admin
    Login_site_admin
    # enter SITE ADMINISTRATION workspaces page
    enter_site_workspaces
    # Enter the valid values for Worksapce Name & Desciption fields,Clicks 'Create Workspace' button
    ${workspace_name}   confirm_create_workspace
    # the new workspace has been listed in workspace list.
    search_single_workspaces    ${workspace_name}    1
    # Deactivate Workspace
    deactivate_workspace
    # Clicks Cancel button
    ${workspace_name}   cancel_create_workspace
    # the new workspace has not been listed in workspace list.
    search_single_workspaces    ${workspace_name}    0
    # Clicks 'Create and add another' button
    ${workspace_name}   create_and_add_another_workspace
    # the new workspace has not been listed in workspace list.
    search_single_workspaces    ${workspace_name}    1
    # Deactivate Workspace
    deactivate_workspace
    [Teardown]    Close

Site_Admin_Clicks_Add_More_Users_button
    [Documentation]    Clicks Add More Users button
    [Tags]    Clicks Add More Users button
    # log in with group admin
    Login_workspaces_admin_one
    # enter group users
    enter_group_users
    # add normal user
    ${email_before}   ${email}    add_normal_user
    # close browser
    Close
    # log in with site admin
    Login_site_admin
    # enter SITE ADMINISTRATION workspaces page
    enter_site_workspaces
    # Select randomly one workspce
    search_single_workspaces    auto_default_workspace    1
    # Click Details button
    click_workspace_details
    # Click Edit Members button
    click_edit_members_button
    # Clicks Add More Users button
    click_add_more_users_button
    # select some usrs and clicks Add button
    select_a_usrs_and_clicks_add_button   ${email_before}
    # Click Edit Members button
    click_edit_members_button
    # clicks 'Delete' button,clicks 'Cancel' button,clicks 'OK' button
    click_cancel_and_ok_button   ${email_before}
    # Enter key words in Search field
    search_single_user   citron_group_admin
    [Teardown]    Close

Modify_Workspace_Name_And_Description
    [Documentation]    Modify Workspace Name & Description
    [Tags]    Modify Workspace Name & Description
    # log in with site admin
    Login_site_admin
    # enter SITE ADMINISTRATION workspaces page
    enter_site_workspaces
    # Enter the valid values for Worksapce Name & Desciption fields,Clicks 'Create Workspace' button
    ${workspace_name}   confirm_create_workspace
    # the new workspace has been listed in workspace list.
    search_single_workspaces    ${workspace_name}    1
    # Click Details button
    click_workspace_details
    # Modify Workspace Name & Description
    ${workspace_name_modify}   modify_workspace_information
    # the new workspace has been listed in workspace list.
    search_single_workspaces    ${workspace_name_modify}    1
    # Click Details button
    click_workspace_details
    # Check that basic information is successfully modified
    check_workspace_information_successfully_modified   ${workspace_name_modify}
    # Deactivate Workspace
    deactivate_workspace
    [Teardown]    Close

Modify_Workspace_Workspace_Admins_And_Deactivate_Inactive_workspace
    [Documentation]    Modify Workspace Workspace Admins And Deactivate Inactive workspace
    [Tags]    Modify Workspace Workspace Admins And Deactivate Inactive workspace
    # log in with site admin
    Login_site_admin
    # enter SITE ADMINISTRATION workspaces page
    enter_site_workspaces
    # the new workspace has been listed in workspace list.
    search_single_workspaces    WS-C    1
    # Click Details button
    click_workspace_details
    # the listed users should be belonged to this workspace
    listed_belong_to_workspaces
    # Select randomly users
    select_randomly_user
    # clicks 'x' button beside of one user.
    clicks_x_button_beside_of_one_user
    # Clicks 'Deactivate workspace' button and click Cancel
    deactivate_workspace_cancel
    # Click Details button
    click_workspace_details
    # Clicks 'Deactivate workspace' button and click OK
    deactivate_workspace_ok
    # enter SITE ADMINISTRATION Users page
    enter_site_users
    # Navigates to Site Administration -> Users -> details,  In workspace list, there is not 'inactivated' this workspace.
    workspace_should_be_shown_up_or_not   0
    # enter SITE ADMINISTRATION workspaces page
    enter_site_workspaces
    # the new workspace has been listed in workspace list.
    search_single_workspaces    WS-C    1
    # Click Details button
    click_workspace_details
    # Click 'Activate workspace' button
    activate_workspace
    # enter SITE ADMINISTRATION Users page
    enter_site_users
    # Navigates to Site Administration -> Users -> details,  In workspace list, this workspace should be shown up.
    workspace_should_be_shown_up_or_not   1
    [Teardown]    Close

Workspaces_Clicks_Members_button
    [Documentation]    Clicks Members button
    [Tags]    Clicks Members button
    # log in with group admin
    Login_workspaces_admin_one
    # enter group users
    enter_group_users
    # add normal user
    ${email_before}   ${email}    add_normal_user
    # close browser
    Close
    # log in with site admin
    Login_site_admin
    # enter SITE ADMINISTRATION workspaces page
    enter_site_workspaces
    # the new workspace has been listed in workspace list.
    search_single_workspaces    auto_default_workspace    1
    # Click MEMBERS button
    click_workspace_members
    # Clicks Add More Users button
    click_add_more_users_button
    # select some usrs and clicks Add button
    select_a_usrs_and_clicks_add_button    ${email_before}
    # Click MEMBERS button
    click_workspace_members
    # clicks 'Delete' button,clicks 'Cancel' button,clicks 'OK' button
    click_cancel_and_ok_button   ${email_before}
    # Enter key words in Search field
    search_single_user    citron_group_admin
    [Teardown]    Close

