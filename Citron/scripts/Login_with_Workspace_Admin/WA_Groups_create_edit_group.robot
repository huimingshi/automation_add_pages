*** Settings ***
Library           Selenium2Library
Library           OperatingSystem
Resource          ../../Lib/login_with_workspace_admin_resource.robot
Resource          ../../Lib/public.robot


*** Test Cases ***
Workspace_Admin_create_standard_member_group_test
    [Documentation]    choose standard member group
    [Tags]    choose standard member group,   Citron 219+221 line
    # log in with workspaces admin
    Login_workspaces_admin
    # enter workspace groups
    enter_workspace_groups
    # Create three groups
    # create standard member group 1
    ${group_name_1}   create_standard_member_group
    # create standard member group 2
    ${group_name_2}   create_standard_member_group
    # create standard member group 3
    ${group_name_3}   create_standard_member_group
    # create On Call group 1
    ${group_name_4}   create_on_call_group
    # create On Call group 2
    ${group_name_5}   create_on_call_group
    # Search standard member group 1
    search_group_detail    ${group_name_1}
    # Make connections between groups
    fill_group_visibility    ${group_name_2}    ${group_name_4}
    # Enter Users page
    enter_users_page
    # Three users are first associated with the group
    # search user 1
    search_active_user   ${first_user_username}
    # modify group
    user_change_group   ${group_name_1}
    # search user 2
    search_active_user   ${second_user_username}
    # modify group
    user_change_group   ${group_name_1}
    # search user 3
    search_active_user   ${third_user_username}
    # modify group
    user_change_group   ${group_name_2}
    # close browser
    Close

    # log in with first user
    Login_new_added_user   ${first_user_username}
    # Check
    check_add_standard_member_group   ${group_name_4}
    # close browser
    Close

    # log in with second user
    Login_new_added_user   ${second_user_username}
    # Check
    check_add_standard_member_group1    ${group_name_4}
    # close browser
    Close

    # log in with workspaces admin
    Login_workspaces_admin
    # enter workspace groups
    enter_workspace_groups
    # Search standard member group 1
    search_group_detail    ${group_name_1}
    # modify_standard_members_group
    ${group_name_1_modify}   modify_standard_members_group    ${group_name_3}   ${group_name_5}
    # Enter Users page
    enter_users_page
    # third user is first associated with the group
    # search user 3
    search_active_user   ${third_user_username}
    # modify group
    user_change_group   ${group_name_3}
    # close browser
    Close

    # log in with first user
    Login_new_added_user   ${first_user_username}
    # Check
    check_add_standard_member_group   ${group_name_5}
    # close browser
    Close

    # log in with second user
    Login_new_added_user   ${second_user_username}
    # Check
    check_add_standard_member_group1    ${group_name_5}
    [Teardown]    Close

Workspace_Admin_create_on_call_group_test
    [Documentation]    choose on-call group
    [Tags]    choose on-call group,   Citron 220+222 line
    # log in with workspaces admin
    Login_workspaces_admin
    # enter workspace groups
    enter_workspace_groups
    # create On-Call group 1
    ${group_name_1}   create_on_call_group_no_member_visibility
    # create On-Call group 2
    ${group_name_2}   create_on_call_group_no_member_visibility
    # create standard member group 1
    ${group_name_3}   create_standard_member_group
    # Enter Users page
    enter_users_page
    # two users are first associated with the On-Call group
    # search user 1
    search_active_user   ${first_user_username}
    # Add group
    user_change_group   ${group_name_1}
    # search user 2
    search_active_user   ${second_user_username}
    # Add group
    user_change_group   ${group_name_1}
    # close browser
    Close

    # log in with first user
    Login_new_added_user   ${first_user_username}
    # Check
    check_add_on_call_group
    # close browser
    Close

    # log in with second user
    Login_new_added_user   ${second_user_username}
    # Check
    check_add_on_call_group
    # close browser
    Close

    # log in with workspaces admin
    Login_workspaces_admin
    # enter workspace groups
    enter_workspace_groups
    # Search standard member group 1
    search_group_detail    ${group_name_1}
    # modify_on_call_group
    ${group_name_1_modify}   modify_on_call_group   ${group_name3}   ${group_name2}
    # Enter Users page
    enter_users_page
    # Three users are first associated with the group
    # search user 2
    search_active_user   ${second_user_username}
    # modify group
    user_change_group   ${group_name_3}
    # search user 3
    search_active_user   ${third_user_username}
    # modify group
    user_change_group   ${group_name_1_modify}
    # close browser
    Close

    # log in with first user
    Login_new_added_user   ${first_user_username}
    # Check
    check_add_on_call_group_1   ${group_name2}
    # close browser
    Close

    # log in with third user
    Login_new_added_user   ${third_user_username}
    # Check
    check_add_on_call_group_2   ${group_name2}
    [Teardown]    Close

Workspace_Admin_Group_Visible_visibility_testing
    [Documentation]    Group Visible visibility testing (members in this group can see members in added group)
    [Tags]    Group Visible visibility testing (members in this group can see members in added group),   Citron 223 line
    # log in with workspaces admin
    Login_workspaces_admin
    # enter workspace groups
    enter_workspace_groups
    # Create three groups
    # create standard member group 1
    ${group_name_1}   create_standard_member_group
    # create standard member group 2
    ${group_name_2}   create_standard_member_group
    # create standard member group 3
    ${group_name_3}   create_standard_member_group
    # Search standard member group 1
    search_group_detail    ${group_name_1}
    # Make connections between groups
    fill_only_group_visibility    ${group_name_2}
    # Search standard member group 2
    search_group_detail    ${group_name_2}
    # Make connections between groups
    fill_only_group_visibility    ${group_name_3}
    # Enter Users page
    enter_users_page
    # Three users are first associated with the group
    # search user 1
    search_active_user   ${first_user_username}
    # modify group
    user_change_group   ${group_name_1}
    # search user 2
    search_active_user   ${second_user_username}
    # modify group
    user_change_group   ${group_name_2}
    # search user 3
    search_active_user   ${third_user_username}
    # modify group
    user_change_group   ${group_name_3}
    # close browser
    Close

    # log in with first user
    Login_new_added_user   ${first_user_username}
    # Check
    check_visibility_testing    ${second_user_name}
    # close browser
    Close

    # log in with second user
    Login_new_added_user   ${second_user_username}
    # Check
    check_visibility_testing    ${third_user_name}
    # close browser
    Close

    # log in with third user
    Login_new_added_user   ${third_user_username}
    # Check
    check_add_on_call_group
    [Teardown]  Close

Workspace_Admin_Click_on_member_of_this_group_link
    [Documentation]    Click on member of this group link
    [Tags]    有bug，CITRON-3147；目前已修复,   Citron 224 line
    # log in with workspaces admin
    Login_workspaces_admin
    # enter workspace groups
    enter_workspace_groups
    # Search auto_default_group
    search_group_detail    auto_default_group
    # click Members of this group button
    click_members_of_this_group
    [Teardown]  Close

Workspace_Admin_Add_Group_Admin_user_and_avator
    [Documentation]    Add Group Admin user & avator
    [Tags]    Add Group Admin user & avator,   Citron 225 line
    # log in with workspaces admin
    Login_workspaces_admin
    # enter workspace groups
    enter_workspace_groups
    # create standard member group
    ${group_name}   create_standard_member_group_without_groupAdmin_and_avator
    # Search standard member group
    search_group_detail    ${group_name}
    # Add Group Admin user & avator
    add_group_admin_user_and_avator
    # Search standard member group
    search_group_detail    ${group_name}
    # check The updated info has been successfully saved.
    check_updated_info_saved
    # Remove this Group Admin
    remove_this_group_admin
    # Search standard member group
    search_group_detail    ${group_name}
    # check Group Admin successfully removed
    check_group_admin_removed
    [Teardown]  Close

#Workspace_Admin_delete_Standard_member_group
#    [Documentation]    Delete Standard member group
#    [Tags]    Citron 226 line，有bug：https://vipaar.atlassian.net/browse/CITRON-3337，删除user所属的standard member group后，user未自动添加到default group
#    # log in with workspaces admin
#    Login_workspaces_admin
#    # enter workspace groups
#    enter_workspace_groups
#    # create standard member group
#    ${group_name}   create_standard_member_group
#    # Enter Users page
#    enter_users_page
#    # This user is first associated with the group
#    # search user 1
#    search_active_user   ${first_user_username}
#    # modify group
#    user_change_group   ${group_name}
#    # Check which team the first user belongs to
#    check_user_belongs_to_group   ${group_name}
#    # Enter Groups page
#    enter_groups_page
#    # Search standard member group
#    search_group_detail    ${group_name}
#    # Delete Standard member group
#    delete_group
#    # Enter Users page
#    enter_users_page
#    # search user 1
#    search_active_user   ${first_user_username}
#    # Check which team the first user belongs to
#    check_user_belongs_to_group   default
#    [Teardown]  Close

Workspace_Admin_delete_On_call_group
    [Documentation]    Delete On-call group
    [Tags]    Delete On-call group,   Citron 227 line
    # log in with workspaces admin
    Login_workspaces_admin
    # enter workspace groups
    enter_workspace_groups
    # create On-call group
    ${group_name}   create_on_call_group
    # Search On-call group
    search_group_detail    ${group_name}
    # Delete On-call group
    delete_group
    # validate this group will not be displayed under on-call group list.
    group_no_display_under_list   ${group_name}
    [Teardown]  Close