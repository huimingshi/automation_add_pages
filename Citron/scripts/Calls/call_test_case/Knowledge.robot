*** Settings ***
Library           Selenium2Library
Library           OperatingSystem
Resource          ../../../Lib/public.robot
Library           call_python_Lib/call_action_lib_copy.py
Resource          ../../../Lib/calls_resource.robot
Library           call_python_Lib/login_lib.py
Library           call_python_Lib/else_public_lib.py
Library           call_python_Lib/knowledge.py


*** Test Cases ***
Knowledge_Scenario_1
    [Documentation]     Admin1 create 'editable by owner only' folder      Scenario 1
    [Tags]    Knowledge
    # Admin1 创建一个public folder
    ${driver_Ad1}   driver_set_up_and_logIn    ${site_admin_username}
    user_switch_to_second_workspace    ${driver_Ad1}    ${Knowledge_WS}
    switch_to_diffrent_page    ${driver_Ad1}    ${py_knowledge_page}    ${py_knowledge_switch_success}    ${py_get_knowledge_rows}
    ${folder_name}    add_knowledge_folder   ${driver_Ad1}   only
    # Admin1 on webapp add files,change settings, delete. Update procedure steps	VP: Can
    add_file_procedure_to_folder    ${driver_Ad1}    ${folder_name}
    back_to_main     ${driver_Ad1}
    ${procedure_name}    add_file_procedure_to_folder    ${driver_Ad1}    ${folder_name}   not_file
    click_which_procedure     ${driver_Ad1}    ${procedure_name}
    update_procedure_step     ${driver_Ad1}
    delete_which_procedure    ${driver_Ad1}    ${procedure_name}
    [Teardown]      run keywords     back_to_main             ${driver_Ad1}
    ...             AND              delete_which_folder      ${driver_Ad1}      ${folder_name}

Knowledge_Scenario_2
    [Documentation]     Admin1 create 'editable by owner only' folder      Scenario 2    scenario 3
    [Tags]    Knowledge    有bug：修改folder的name后，页面未渲染，在update_folder_name_desc和change_location_to_public_folder方法中
    # Admin1 创建一个public folder
    ${driver_Ad1}   driver_set_up_and_logIn    ${site_admin_username}
    user_switch_to_second_workspace    ${driver_Ad1}    ${Knowledge_WS}
    switch_to_diffrent_page    ${driver_Ad1}    ${py_knowledge_page}    ${py_knowledge_switch_success}    ${py_get_knowledge_rows}
    ${folder_name}    add_knowledge_folder   ${driver_Ad1}   only
    ${procedure_name}    add_file_procedure_to_folder    ${driver_Ad1}    ${folder_name}   not_file
    exit_one_driver    ${driver_Ad1}
    # Admin2 on webapp view folder settings   VP: can view
    ${driver_Ad2}   driver_set_up_and_logIn    ${knowledge_WS_admin}
    switch_to_diffrent_page    ${driver_Ad2}    ${py_knowledge_page}    ${py_knowledge_switch_success}    ${py_get_knowledge_rows}
    # Admin2 change settings	VP: can change
    ${new_folder_name}   update_folder_name_desc    ${driver_Ad2}   ${folder_name}
    # Admin2 change location to another public folder	VP: can change to, as sub folder
#    change_location_to_public_folder    ${driver_Ad2}     ${new_folder_name}    ${public_folder}
    change_location_to_public_folder    ${driver_Ad2}     ${folder_name}    ${public_folder}
    # Admin2 on webapp delete	VP: can delete
    click_which_folder    ${driver_Ad2}     ${public_folder}
#    delete_which_folder    ${driver_Ad2}    ${new_folder_name}
    delete_which_folder    ${driver_Ad2}    ${folder_name}

Knowledge_Scenario_3
    [Documentation]     Admin1 create 'editable by owner only' folder      Scenario 4
    [Tags]    Knowledge
    # Admin1 创建一个public folder
    ${driver_Ad1}   driver_set_up_and_logIn    ${site_admin_username}
    user_switch_to_second_workspace    ${driver_Ad1}    ${Knowledge_WS}
    switch_to_diffrent_page    ${driver_Ad1}    ${py_knowledge_page}    ${py_knowledge_switch_success}    ${py_get_knowledge_rows}
    ${folder_name}    add_knowledge_folder   ${driver_Ad1}   only
    exit_one_driver    ${driver_Ad1}
    # Admin2 登录
    ${driver_Ad2}   driver_set_up_and_logIn    ${knowledge_WS_admin}
    switch_to_diffrent_page    ${driver_Ad2}    ${py_knowledge_page}    ${py_knowledge_switch_success}    ${py_get_knowledge_rows}
    # Admin1 or admin2 try to move public folder to private folder	VP: forbidden
    change_location_to_public_folder    ${driver_Ad2}     ${folder_name}     ${private_folder}    private
    [Teardown]    delete_which_folder    ${driver_Ad2}    ${folder_name}

Knowledge_Scenario_4
    [Documentation]     Admin1 create  'editable by all users and admins' folder      Scenario 1
    [Tags]    Knowledge
    # Admin1 创建一个public folder
    ${driver_Ad1}   driver_set_up_and_logIn    ${site_admin_username}
    user_switch_to_second_workspace    ${driver_Ad1}    ${Knowledge_WS}
    switch_to_diffrent_page    ${driver_Ad1}    ${py_knowledge_page}    ${py_knowledge_switch_success}    ${py_get_knowledge_rows}
    ${folder_name}    add_knowledge_folder   ${driver_Ad1}   all
    # Admin1 can do anything to this folder
    # Admin can edit/move/delete/add files in this folder
    ${new_folder_name}    update_folder_name_desc    ${driver_Ad1}    ${folder_name}
    add_file_procedure_to_folder    ${driver_Ad1}    ${folder_name}
    back_to_main     ${driver_Ad1}
    change_location_to_public_folder    ${driver_Ad1}     ${new_folder_name}    ${public_folder}
    click_which_folder    ${driver_Ad1}     ${public_folder}
    delete_which_folder    ${driver_Ad1}    ${new_folder_name}

Knowledge_Scenario_5
    [Documentation]     Admin1 create  'editable by all users and admins' folder      Scenario 2
    [Tags]    Knowledge
    # Admin1 创建一个public folder
    ${driver_Ad1}   driver_set_up_and_logIn    ${site_admin_username}
    user_switch_to_second_workspace    ${driver_Ad1}    ${Knowledge_WS}
    switch_to_diffrent_page    ${driver_Ad1}    ${py_knowledge_page}    ${py_knowledge_switch_success}    ${py_get_knowledge_rows}
    ${folder_name}    add_knowledge_folder   ${driver_Ad1}   all
    exit_one_driver    ${driver_Ad1}
    # Admin2 can do anything to this folder
    # Admin can edit/move/delete/add files in this folder
    ${driver_Ad2}   driver_set_up_and_logIn    ${knowledge_WS_admin}
    switch_to_diffrent_page    ${driver_Ad2}    ${py_knowledge_page}    ${py_knowledge_switch_success}    ${py_get_knowledge_rows}
    ${new_folder_name}    update_folder_name_desc    ${driver_Ad2}    ${folder_name}
     add_file_procedure_to_folder    ${driver_Ad2}    ${folder_name}
    back_to_main     ${driver_Ad2}
    change_location_to_public_folder    ${driver_Ad2}     ${new_folder_name}    ${public_folder}
    click_which_folder    ${driver_Ad2}     ${public_folder}
    delete_which_folder    ${driver_Ad2}    ${new_folder_name}

#Knowledge_Scenario_6
#    [Documentation]     Admin1 create  'editable by all users and admins' folder      Scenario 3
#    [Tags]    Knowledge    有bug：https://vipaar.atlassian.net/browse/CITRON-3805
#    # Admin1 创建两个个public folder
#    ${driver_Ad1}   driver_set_up_and_logIn    ${site_admin_username}
#    user_switch_to_second_workspace    ${driver_Ad1}    ${Knowledge_WS}
#    switch_to_diffrent_page    ${driver_Ad1}    ${py_knowledge_page}    ${py_knowledge_switch_success}    ${py_get_knowledge_rows}
#    ${folder_name}    add_knowledge_folder   ${driver_Ad1}   all
#    ${folder_name_1}    add_knowledge_folder   ${driver_Ad1}   all
#     add_file_procedure_to_folder    ${driver_Ad1}    ${folder_name}
#    back_to_main     ${driver_Ad1}
#    ${procedure_name}    add_file_procedure_to_folder    ${driver_Ad1}    ${folder_name}   not_file
#    back_to_main     ${driver_Ad1}
#    ${procedure_name_1}    add_file_procedure_to_folder    ${driver_Ad1}    ${folder_name_1}   not_file
#    # user1 in same workspace add file to this folder
#    ${driver_u1}   driver_set_up_and_logIn    ${knowledge_u1_user}
#    switch_to_diffrent_page    ${driver_u1}    ${py_knowledge_page}    ${py_knowledge_switch_success}    ${py_get_knowledge_rows}
#    add_file_procedure_to_folder    ${driver_u1}    ${folder_name}
#    # VP: user1 on webapp can move file
#    back_to_main     ${driver_u1}
#    click_which_folder   ${driver_u1}    ${folder_name}
#    change_location_to_public_folder    ${driver_u1}    ${folder_name}    ${public_folder}
#    # VP: user1 on webapp can edit procedure
#    click_which_procedure     ${driver_u1}     ${procedure_name}
#    update_procedure_step     ${driver_u1}
#    # VP: user1 can delete
#    delete which procedure     ${driver_u1}    ${procedure_name}
#    back_to_main     ${driver_u1}
#    delete_which_folder    ${driver_u1}    ${folder_name}
#
#    # user1 add a file
#    add_file_procedure_to_folder    ${driver_u1}    ${folder_name_1}
#    # Admin1 can move it
#    refresh_browser_page    ${driver_Ad1}
#    change_location_to_public_folder    ${driver_Ad1}    ${avatar1_jpg}    ${public_folder}
#    # admin1 can edit procedure
#    back_to_main     ${driver_Ad1}
#    click_which_folder   ${driver_Ad1}    ${folder_name_1}
#    click_which_procedure     ${driver_Ad1}     ${procedure_name_1}
#    update_procedure_step     ${driver_Ad1}
#    # admin1 can delete
#    delete_which_procedure    ${driver_Ad1}    ${procedure_name_1}
#    delete_which_procedure    ${driver_Ad1}    ${avatar1_jpg}
#    back_to_main     ${driver_Ad1}
#    delete_which_folder    ${driver_u1}    ${folder_name_1}

Knowledge_Scenario_7
    [Documentation]     Admin1 create  'editable by all users and admins' folder      Scenario 4
    [Tags]    Knowledge
    # Admin1 创建一个public folder
    ${driver_Ad1}   driver_set_up_and_logIn    ${site_admin_username}
    user_switch_to_second_workspace    ${driver_Ad1}    ${Knowledge_WS}
    switch_to_diffrent_page    ${driver_Ad1}    ${py_knowledge_page}    ${py_knowledge_switch_success}    ${py_get_knowledge_rows}
    ${folder_name}    add_knowledge_folder   ${driver_Ad1}   all
    # user1 add a file
    ${driver_u1}   driver_set_up_and_logIn    ${knowledge_u1_user}
    switch_to_diffrent_page    ${driver_u1}    ${py_knowledge_page}    ${py_knowledge_switch_success}    ${py_get_knowledge_rows}
    add_file_procedure_to_folder     ${driver_u1}    ${folder_name}
    exit_one_driver    ${driver_u1}
    # user2 try to move/delete/edit same file   # VP: forbidden
    ${driver_u2}   driver_set_up_and_logIn    ${knowledge_u2_user}
    switch_to_diffrent_page    ${driver_u2}    ${py_knowledge_page}    ${py_knowledge_switch_success}    ${py_get_knowledge_rows}
    click_which_folder    ${driver_u2}    ${folder_name}
    click_procedure_settings    ${driver_u2}    ${avatar1_jpg}   can_not
    back_to_main     ${driver_u2}
    click_which_folder    ${driver_u2}    ${folder_name}
    delete_which_procedure    ${driver_u2}    ${avatar1_jpg}   can_not
    [Teardown]     delete_which_folder    ${driver_Ad1}   ${folder_name}

Knowledge_Scenario_8
    [Documentation]     Upload knowledge file（mobile and web）
    [Tags]    Knowledge    有bug：https://vipaar.atlassian.net/browse/CITRON-3806
    # Admin2 创建一个public folder
    ${driver_Ad2}   driver_set_up_and_logIn    ${knowledge_WS_admin}
    switch_to_diffrent_page    ${driver_Ad2}    ${py_knowledge_page}    ${py_knowledge_switch_success}    ${py_get_knowledge_rows}
    ${folder_name}    add_knowledge_folder   ${driver_Ad2}   all
    # upload image/pdf/audio/video
    add_file_procedure_to_folder    ${driver_Ad2}    ${folder_name}
    back_to_main     ${driver_Ad2}
    add_file_procedure_to_folder    ${driver_Ad2}    ${folder_name}     ${load_test_pdf}
    back_to_main     ${driver_Ad2}
    add_file_procedure_to_folder    ${driver_Ad2}    ${folder_name}     ${audio_file}
    back_to_main     ${driver_Ad2}
    add_file_procedure_to_folder    ${driver_Ad2}    ${folder_name}     ${video_file}
    # File owner update file details	VP: update successefully
    add_description_to_file   ${driver_Ad2}    ${avatar1_jpg}
    add_description_to_file   ${driver_Ad2}    ${load_test_pdf}
    add_description_to_file   ${driver_Ad2}    ${audio_file}
#    # 受bug影响
#    add_description_to_file   ${driver_Ad2}    ${video_file}
    # user view files	VP: image pdf is opened, audio/video can be played
    click_which_procedure       ${driver_Ad2}    ${avatar1_jpg}
    image_is_opened       ${driver_Ad2}    ${avatar1_jpg}
    [Teardown]      run keywords    back_to_main     ${driver_Ad2}
    ...             AND             delete_which_folder    ${driver_Ad2}   ${folder_name}

Knowledge_Scenario_9
    [Documentation]     Search (webapp)    Sort by (webapp)
    [Tags]    Knowledge
    ${driver_Ad2}   driver_set_up_and_logIn    ${knowledge_WS_admin}
    switch_to_diffrent_page    ${driver_Ad2}    ${py_knowledge_page}    ${py_knowledge_switch_success}    ${py_get_knowledge_rows}
    # Sort by Name
    folder_sort_by    ${driver_Ad2}
    ${folder_name_list_1}   get_current_folders      ${driver_Ad2}
    folder_sort_by    ${driver_Ad2}
    ${folder_name_list_2}   get_current_folders      ${driver_Ad2}
    opposite_of_two_lists   ${folder_name_list_1}    ${folder_name_list_2}
    # Sort by Last Updated
    folder_sort_by    ${driver_Ad2}     last_updated
    ${folder_name_list_3}   get_current_folders      ${driver_Ad2}
    folder_sort_by    ${driver_Ad2}     last_updated
    ${folder_name_list_4}   get_current_folders      ${driver_Ad2}
    opposite_of_two_lists   ${folder_name_list_3}    ${folder_name_list_4}
    # Search (webapp)	click one in results to open it
    search_knowledge    ${driver_Ad2}    Selected_all

Knowledge_Scenario_10
    [Documentation]     Create procedure( web only)
    [Tags]    Knowledge
    ${driver_Ad2}   driver_set_up_and_logIn    ${knowledge_WS_admin}
    switch_to_diffrent_page    ${driver_Ad2}    ${py_knowledge_page}    ${py_knowledge_switch_success}    ${py_get_knowledge_rows}
    ${folder_name}    add_knowledge_folder   ${driver_Ad2}
    # create procesureA with step having text item
    add_file_procedure_to_folder    ${driver_Ad2}    ${folder_name}     not_file
    update_procedure_step    ${driver_Ad2}
    ${text_item}    add_text_to_procedure    ${driver_Ad2}
    # change font size
    change_text_item_size    ${driver_Ad2}    ${text_item}
    # Add other text with bold/italic/underline
    add_question    ${driver_Ad2}
    # Publish procedure
    publish_procedure    ${driver_Ad2}
    # VP: status is "Published" from "Draft"
    check_published_status       ${driver_Ad2}
    [Teardown]      run keywords     back_to_main           ${driver_Ad2}
    ...             AND              delete_which_folder    ${driver_Ad2}    ${folder_name}

