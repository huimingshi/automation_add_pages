*** Settings ***
Library           Selenium2Library
Library           OperatingSystem
Resource          ../../../Lib/public.robot
Library           call_python_Lib/call_action_lib_copy.py
Resource          ../../../Lib/calls_resource.robot
Library           call_python_Lib/in_call_info.py
Library           call_python_Lib/login_lib.py
Library           call_python_Lib/about_call.py
Library           call_python_Lib/finish_call.py
Library           call_python_Lib/else_public_lib.py
Library           call_python_Lib/call_check_lib.py
Force Tags        call_case


*** Test Cases ***
call_center_Scenario_1
    [Documentation]   Test Point: change role(change receiver)
    [Tags]     Direct Call     call_case
    # User A calls user B. User B answers call.
    ${driver_U1}     driver_set_up_and_logIn     ${center_mode_user1}
    ${driver_U2}     driver_set_up_and_logIn     ${center_mode_user2}
    contacts_witch_page_make_call       ${driver_U1}   ${driver_U2}   ${py_team_page}   ${center_mode_username2}
    make_sure_enter_call                ${driver_U2}
        # VP:1. begin with Collaboration mode.

        # 2. User A is able to start merge.

        # 3.User B is receiver. Receiver’s camera auto-switched to their rear-facing cam.