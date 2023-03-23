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
Library           call_python_Lib/contacts_page.py
Force Tags        call_case


*** Test Cases ***
MHS_call_Scenario_1
    [Documentation]      Key Point: Anonymous can not be promote to co-host; can not turn off co-host for 2pc call
    [Tags]     MHS Call
    # Precondition: TU1, EU2, U3 are in the same enterprise A.  TU1 clicks on EU2’s mhs link. EU2 answers call.
    ${driver_U1}     driver_set_up_and_logIn     ${Team_User1_username}
    ${driver_U2}     driver_set_up_and_logIn     ${center_mode_user2}
    contacts_witch_page_make_call       ${driver_U1}   ${driver_U2}   ${py_team_page}   ${center_mode_username2}    audio='Video'
    make_sure_enter_call                ${driver_U2}