*** Settings ***
Resource          ../../../Lib/hodgepodge_resource.robot
Resource          ../../../Lib/calls_resource.robot

*** Keywords ***
who_login_keyword
    [Arguments]   ${who_login}
    Run Keyword If   '${who_login}'=='workspaces_admin'   Login_workspaces_admin    # log in with workspace admin
    ...  ELSE IF     '${who_login}'=='premium_user'       Login_premium_user        # log in with premium admin
    ...  ELSE IF     '${who_login}'=='site_admin'         Login_site_admin          # log in with Site Admin

set_survey_close_setUp
    Login_workspaces_admin      # log in with workspaces admin
    enter_workspace_workspace_settings      # enter workspace users
    set_survey_close        # Set Survey close
    Close       # close browser

set_survey_open_and_in_white_list
    Login_workspaces_admin      # log in with workspaces admin
    enter_workspace_workspace_settings      # enter workspace users
    set_survey_open        # Set Survey open
    set_survey_in_white_list        # Set Survey URL Value is in White List
    Close       # close browser

set_survey_open_and_null
    Login_workspaces_admin      # log in with workspaces admin
    enter_workspace_workspace_settings      # enter workspace users
    set_survey_open        # Set Survey open
    set_survey_null        # Set Survey URL=Null
    Close       # close browser

ws_open_directory
    [Arguments]     ${who_login}     ${switch_ws}=    ${which_ws}=
    who_login_keyword    ${who_login}
    Run Keyword If   '${switch_ws}'=='switch_to_2'       switch_to_second_workspace    # 切换到Canada这个WS
    ...  ELSE IF     '${switch_ws}'=='switch_to_other'      switch_to_created_workspace      ${which_ws}      # 进入Huiming.shi_Added_WS这个WS
    enter_workspace_settings_page   # enter workspace settings page
    open_workspace_directory    # Switch "Workspace Directory" on
    Close    # close browser

disable_external_users_setUp
    [Arguments]    ${who_login}     ${action}
    who_login_keyword    ${who_login}
    enter_workspace_settings_page   # enter workspace settings page
    Run Keyword If   '${action}'=='close'   close_disable_external_users       # Switch "Disable External Feature" off from citron for a specific workspace
    ...  ELSE IF     '${action}'=='open'    open_disable_external_users        # Switch "Disable External Feature" on from citron for a specific workspace
    Close    # close browser

turn_on_workspace_directory_setUp
    [Arguments]    ${who_login}
    who_login_keyword    ${who_login}
    enter_workspace_settings_page           # 进入settings页面
    turn_on_workspace_directory             # 打开Workspace Directory设置

fill_invitation_message_content_setUp
    [Arguments]    ${who_login}    ${content}     ${witch_WS}=${auto_default_workspace_xpath}
    who_login_keyword    ${who_login}
    switch_to_created_workspace     ${witch_WS}
    enter_workspace_settings_page       # 进入settings页面
    fill_invitation_message_content     ${content}     # 填写信息
    Close

set_call_center_mode_setUp
    [Arguments]    ${who_login}     ${action}=close     ${switch_ws}=    ${which_ws}=
    who_login_keyword    ${who_login}         # log in with site admin
    Run Keyword If   '${switch_ws}'=='switch_to_2'          switch_to_second_workspace    # 切换到Canada这个WS
    ...  ELSE IF     '${switch_ws}'=='switch_to_other'      switch_to_created_workspace      ${which_ws}      # 进入Huiming.shi_Added_WS这个WS
    enter_workspace_workspace_settings        # enter first workspace workspace setting
    Run Keyword If   '${action}'=='close'   close_call_center_mode       # workspace WS1 has "Disable External Feature"=OFF
    ...  ELSE IF     '${action}'=='open'    open_call_center_mode        # workspace WS1 has "Disable External Feature"=ON
    Close

close_invitation_message_set_setUp
    [Arguments]     ${who_login}    ${witch_WS}=${auto_default_workspace_xpath}
    who_login_keyword    ${who_login}
    switch_to_created_workspace     ${witch_WS}
    enter_workspace_settings_page       # 进入settings页面
    close_invitation_message_set        # 关闭Before Call: Invitation Message配置项
    Close

set_disclaimer_is_on_and_delete_user_close
    [Arguments]     ${who_login}
    who_login_keyword    ${who_login}
    Login_workspaces_admin            # log in with workspace admin
    enter_workspace_settings_page     # 进入settings页面
    expand_option_delete_user         # EXPAND delete user 选项
    set_disclaimer_is_on              # 设置Disclaimer为open状态
    set_delete_user_close             # 设置delete user为close状态
    Close

set_always_on_select
    [Arguments]      ${status}='always_on'
    Login_site_admin
    switch_to_created_workspace         ${created_workspace_branding_3}   # 切换到我自己创建的WS
    enter_workspace_settings_page           # 进入settings页面
    expand_during_call_recording            # 展开During Call: Recording设置
    turn_on_during_call_recording           # 打开During Call: Recording设置
    Run Keyword If   '${status}'=='always_on'    choose_witch_recording_feature      ${always_on_select}    # set to always record
    ...  ELSE IF     '${status}'=='opt_in'       choose_witch_recording_feature      ${opt_in_select}    # set to Default-OFF
    ...  ELSE IF     '${status}'=='opt_out'      choose_witch_recording_feature     ${opt_out_select}    # set to Default-ON
    Close

make_sure_two_ws_external_feature
    [Arguments]    ${first_action}    ${second_action}
    Login_premium_user   # log in with premium admin
    make_sure_workspaces_setting_external_feature      ${first_action}    ${second_action}          # workspace WS1 has "Disable External Feature"=ON; workspace WS2 has "Disable External Feature"=OFF;
    Close

make_sure_two_ws_directory_feature
    [Arguments]    ${first_action}    ${second_action}
    Login_premium_user   # log in with premium admin
    make_sure_workspaces_setting_workspace_directory      ${first_action}    ${second_action}          # workspace WS1 has "Workspace Directory"=ON; workspace WS2 has "Workspace Directory"=OFF;
    Close

make_sure_two_ws_call_center_mode_feature
    [Arguments]    ${first_action}    ${second_action}
    Login_premium_user   # log in with premium admin
    make_sure_workspaces_call_center_mode_feature       ${first_action}    ${second_action}          # workspace WS1 has "Call Center Mode"=OFF; workspace WS2 has "Call Center Mode"=OFF;
    Close

make_sure_two_ws_tagging_and_comments_feature
    [Arguments]    ${first_action}    ${second_action}    ${first_WS}=${close_call_center_mode_WS}      ${second_WS}=${close_call_center_mode_WS1}
    Login_site_admin   # log in with premium admin
    switch_to_created_workspace    ${first_WS}
    # enter first workspace workspace setting
    enter_workspace_workspace_settings
    # workspace WS1 has "After Call: Tagging and Comments"=ON or OFF
    Run Keyword If   '${first_action}'=='open_feature'    open_tagging_and_comments
    ...  ELSE IF  '${first_action}'=='close_feature'    close_tagging_and_comments
    # switch to second workspace
    switch_to_created_workspace     ${second_WS}
    # enter second workspace workspace setting
    enter_workspace_workspace_settings
    # workspace WS2 has "After Call: Tagging and Comments"=ON or OFF
    Run Keyword If   '${second_action}'=='open_feature'    open_tagging_and_comments
    ...  ELSE IF  '${second_action}'=='close_feature'    close_tagging_and_comments
    Close