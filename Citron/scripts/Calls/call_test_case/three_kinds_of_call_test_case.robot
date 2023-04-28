*** Settings ***
Library           Selenium2Library
Library           OperatingSystem
Resource          ../../../Lib/public.robot
Resource          ../../../Lib/calls_resource.robot
Resource          ../../../Lib/hodgepodge_resource.robot
Library           call_python_Lib/call_action_lib_copy.py
Library           call_python_Lib/call_check_lib.py
Library           call_python_Lib/else_public_lib.py
Library           call_python_Lib/login_lib.py
Library           call_python_Lib/finish_call.py

*** Test Cases ***
Make_a_business_call_duration_more_than_1_min
    [Documentation]    Make a business call duration > 1 min
    [Tags]    Make a business call duration > 1 min     call_case    citron 261
    [Setup]  delete_all_jpg_and_jpeg_picture
    # Start two drivers and logIn
    ${driver1}   driver_set_up_and_logIn    ${normal_username_for_calls}
    ${driver2}   driver_set_up_and_logIn    ${normal_username_for_calls_B}
    # make a call
    contacts_witch_page_make_call   ${driver1}   ${driver2}   ${py_team_page}   ${normal_name_for_calls_B}
    exit_call   ${driver1}   ${more_than_1_min}
    [Teardown]  Run Keywords  delete_all_jpg_and_jpeg_picture
    ...         AND           exit_driver