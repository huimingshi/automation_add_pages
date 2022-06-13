*** Settings ***
Library           Selenium2Library
Library           OperatingSystem
Resource          ../../../Lib/public.robot
Resource          ../../../Lib/calls_resource.robot
Resource          ../../../Lib/hodgepodge_resource.robot
Library           call_python_Lib/call_public_lib.py
Library           call_python_Lib/else_public_lib.py

*** Test Cases ***
Make_a_business_call_between_business_and_personal_user
    [Documentation]    Make a business call duration < 1 min
    [Tags]    Make a business call duration < 1 min      call_case    citron 262
    [Setup]  delete_all_jpg_and_jpeg_picture
    # Start two drivers and logIn
    ${driver1}   driver_set_up_and_logIn    ${normal_username_for_calls}   ${normal_password_for_calls}
    ${driver2}   driver_set_up_and_logIn    ${group_admin_username}   ${group_admin_password}
    # make a call
    contacts_witch_page_make_call   ${driver1}   ${driver2}   ${py_team_page}   ${group_admin_name}
    exit_call   ${driver1}   ${less_than_1_min}
    [Teardown]  Run Keywords  delete_all_jpg_and_jpeg_picture
    ...         AND           exit_driver
#    ...         AND           exit_driver   ${driver1}  ${driver2}

Make_a_business_call_duration_more_than_1_min
    [Documentation]    Make a business call duration > 1 min
    [Tags]    Make a business call duration > 1 min     call_case    citron 261
    [Setup]  delete_all_jpg_and_jpeg_picture
    # Start two drivers and logIn
    ${driver1}   driver_set_up_and_logIn    ${normal_username_for_calls}   ${normal_password_for_calls}
    ${driver2}   driver_set_up_and_logIn    ${normal_username_for_calls_B}   ${normal_password_for_calls_B}
    # make a call
    contacts_witch_page_make_call   ${driver1}   ${driver2}   ${py_team_page}   ${normal_name_for_calls_B}
    exit_call   ${driver1}   ${more_than_1_min}
    [Teardown]  Run Keywords  delete_all_jpg_and_jpeg_picture
    ...         AND           exit_driver
#    ...         AND           exit_driver   ${driver1}  ${driver2}

#Select_randomly_one_call_to_click_Detail_button_that_call_has_anonymous_personal_enterpriseUser_crossEnterprise
#    [Documentation]    Select randomly one call to click 'Detail' button that call has anonymous, personal, enterprise user, cross enterprise
#    [Tags]    Select randomly one call to click 'Detail' button that call has anonymous, personal, enterprise user, cross enterprise
#    [Setup]     run keywords    delete_all_jpg_and_jpeg_picture
#    ...         AND             Login_workspaces_admin      # workspace登录
#    ...         AND             enter_workspace_settings_page   # 进入WS setting页面
#    ...         AND             make_sure_tagging_and_comments_setting_open   # 打开 After Call: Tagging and Comments
#    ...         AND             close_disable_external_users    # 关闭 Security: Disable External Users
#    ...         AND             Close
#    # Start driver and logIn
#    ${driver1}   driver_set_up_and_logIn    ${normal_username_for_calls}   ${normal_password_for_calls}
#    ${driver2}   driver_set_up_and_logIn    ${personal_user_username}    ${personal_user_password}
#    ${driver3}   driver_set_up_and_logIn    ${site_admin_username_auto}   ${site_admin_password_auto}
#    # The four roles call
#    ${driver4}  make_call_between_four_role   ${driver1}  ${driver2}  ${driver3}  ${personal_user_username}
#    # Give a five-star review
#    give_star_rating   ${driver2}  5
#    # Add tags and comments
#    ${first_tag_text}  add_tags_and_comment   ${driver2}
#    # log in with group admin
#    Login_group_admin
#    # enter group calls
#    enter_group_calls
#    # the Participant list should be correct.
#    participant_list_should_be_correct   ${first_tag_text}
#    # Call tag & comment should be correct
#    call_tag_and_comment_should_be_correct   ${first_tag_text}
#    # the event log should be correct
#    the_event_log_should_be_correct
#    # the Screen capture list should be correct
#    the_screen_capture_list_should_be_correct
#    [Teardown]  run keywords   delete_all_jpg_and_jpeg_picture
#    ...         AND            Close
#    ...         AND           exit_driver
##    ...         AND            exit_driver   ${driver1}  ${driver2}  ${driver3}  ${driver4}