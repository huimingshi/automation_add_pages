*** Settings ***
Library           Selenium2Library
Library           OperatingSystem
Resource          ../../../Lib/public.robot
Resource          ../../../Lib/calls_resource.robot
Resource          ../../../Lib/hodgepodge_resource.robot
Library           call_python_Lib/call_public_lib.py
Library           call_python_Lib/else_public_lib.py
Force Tags        small_range

*** Test Cases ***
Small_range_970_974
    [Documentation]     WS branding   Turn on branding for Workspace WS1
    [Tags]    small range 970-974 lines     call_case
    [Setup]     run keywords    Login_premium_user
    ...         AND             switch_to_created_workspace       ${created_workspace}   # 切换到我自己创建的WS
    ...         AND             enter_workspace_settings_page       # 进入settings页面
    ...         AND             expand_workspace_branding_setting       # 展开Workspace Branding设置
    ...         AND             turn_on_workspace_branding_setting      # 打开Workspace Branding设置
    ...         AND             Close
    # User of WS1 login
    # VP: Toturial screen
    ${driver1}    driver_set_up_and_logIn    ${Expert_User1_username}     ${universal_password}    check_toturial
    # VP: Branding name everywhere use Help Lighning
    ${get_ele_text}    get_ele_text    ${driver1}    ${first_tree_text}
    two_option_is_equal    ${driver1}    ${get_ele_text}     MY HELP LIGHTNING
#    should be equal as strings    ${get_ele_text}     MY HELP LIGHTNING
    # VP: left top Logo loaded HelpLightning logo
    ${get_class_value}    get_ele_class_name    ${driver1}   ${left_top_Logo}   style
    Should be empty     ${get_class_value}
    # VP: Color is Help Lightning blue
    ${css_value}   get_css_value   ${driver1}   ${first_data_background_color}    background-color
    two_option_is_equal   ${driver1}   rgba(160, 220, 238, 1)    ${css_value}
#    should be equal as strings    rgba(160, 220, 238, 1)    ${css_value}
    # VP: Default avator use Help Lighning one
    ${get_class_value}    get_ele_class_name    ${driver1}   ${first_data_img}   src
    should start with    ${get_class_value}     ${default_avatar_src}
    # VP: Call ending screen
    ${driver2}    driver_set_up_and_logIn    ${Expert_User2_username}     ${universal_password}
    make_calls_with_who   ${driver2}   ${driver1}   ${Expert_User1_username}
    exit_call   ${driver2}
    ${get_ele_text}    get_ele_text    ${driver1}    ${end_call_message}
    two_option_is_equal   ${driver1}   ${get_ele_text}     Thank you for using Help Lightning
#    should be equal as strings    ${get_ele_text}     Thank you for using Help Lightning
    [Teardown]      run keywords    Close
    ...             AND             exit_driver
#    ...             AND             exit_driver     ${driver1}    ${driver2}

Small_range_977_993
    [Documentation]     Change product name to text with Chinese character+number+special character
    [Tags]    small range 977_993 lines         call_case
    [Setup]     run keywords    Login_workspaces_admin
    ...         AND             enter_workspace_settings_page           # 进入settings页面
    ...         AND             expand_workspace_branding_setting       # 展开Workspace Branding设置
    ...         AND             turn_on_workspace_branding_setting      # 打开Workspace Branding设置
    # Change product name to text with Chinese character+number+special character
    ${get_value}  ${product_name}   modify_workspace_branding_setting
    Close
    # Workspace admin login，VP: all helplightning blue will be changed to customerized  accent color
    ${driver1}    driver_set_up_and_logIn    ${workspace_admin_username}     ${universal_password}
    ${css_value}   get_css_value   ${driver1}   ${first_data_background_color}   background-color
#    Run Keyword If   '${get_value}'=='#ff9933'    should be equal as strings    rgba(255, 153, 51, 0.2)     ${css_value}
#    ...  ELSE IF  '${get_value}'=='#00ff00'    should be equal as strings    rgba(0, 255, 0, 0.2)     ${css_value}
    Run Keyword If   '${get_value}'=='#ff9933'   two_option_is_equal   ${driver1}      rgba(255, 153, 51, 0.2)     ${css_value}
    ...  ELSE IF  '${get_value}'=='#00ff00'    two_option_is_equal   ${driver1}     rgba(0, 255, 0, 0.2)     ${css_value}

    Comment    Users 页面
    # open Users, inite user, deactived user page	VP: All context with "Help Lightning" is branded, accent color is orange
    switch_to_diffrent_page   ${driver1}   ${py_users_page}    ${py_users_switch_success}    ${py_get_number_of_rows}    switch_tree   2
    sleep    10
    ${css_value}   get_css_value   ${driver1}   ${add_user_xpath}   background-color          # Add User按钮
    check_get_color_correct    ${get_value}   ${css_value}
    ${css_value}   get_css_value   ${driver1}   ${add_device_xpath}   background-color                              # Add Device按钮
    check_get_color_correct    ${get_value}   ${css_value}
    ${css_value}   get_css_value   ${driver1}   ${edit_members_xpath}   background-color                            # Edit Members按钮
    check_get_color_correct    ${get_value}   ${css_value}
    ${css_value}   get_css_value   ${driver1}   ${active_users_report_view}   background-color                      # Add User tab页的Report View按钮
    check_get_color_correct    ${get_value}   ${css_value}
    ${css_value}   get_css_value   ${driver1}   ${invitations_xpath}        color                                   # Invitations tab页面
    check_get_color_correct    ${get_value}   ${css_value}
    ${css_value}   get_css_value   ${driver1}   ${deactivated_users_xpath}   color                                  # Deactivated Users页 tab页面
    check_get_color_correct    ${get_value}   ${css_value}
    ${css_value}   get_css_value   ${driver1}   ${Details_button_xpath}        color                                # Details 按钮
    check_get_color_correct    ${get_value}   ${css_value}
    # 切换到inite user页面
    switch_to_other_tab   ${driver1}   ${invitations_xpath}
    sleep   10
    ${css_value}   get_css_value   ${driver1}   ${active_users_xpath}   color                                       # Active Users tab页面
    check_get_color_correct    ${get_value}   ${css_value}
    ${css_value}   get_css_value   ${driver1}   ${invitations_Share_This_Filter}   background-color                 # Invitations tab页面的Share This Filter按钮
    check_get_color_correct    ${get_value}   ${css_value}
    ${css_value}   get_css_value   ${driver1}   ${invitations_Cancel_All}   background-color                        # Invitations tab页面的Cancel All按钮
    check_get_color_correct    ${get_value}   ${css_value}
    ${css_value}   get_css_value   ${driver1}   ${invitations_Resend_All}   background-color                        # Invitations tab页面的Resend All按钮
    check_get_color_correct    ${get_value}   ${css_value}
    ${css_value}   get_css_value   ${driver1}   ${invitations_Export_to_CSV}   background-color                     # Invitations tab页面的Export to CSV按钮
    check_get_color_correct    ${get_value}   ${css_value}
    # 切换到Deactivated Users页面
    switch_to_other_tab   ${driver1}   ${deactivated_users_xpath}
    ${css_value}   get_css_value   ${driver1}   ${deactivated_users_Share_This_Filter}   background-color          # Invitations tab页面的Share This Filter按钮
    check_get_color_correct    ${get_value}   ${css_value}
    ${css_value}   get_css_value   ${driver1}   ${deactivated_users_Export_to_CSV}   background-color               # Invitations tab页面的Share This Filter按钮
    check_get_color_correct    ${get_value}   ${css_value}
    ${css_value}   get_css_value   ${driver1}   ${Details_button_xpath}        color                                # Details 按钮
    check_get_color_correct    ${get_value}   ${css_value}

    Comment    Groups 页面
    # open groups, create group	VP: All context with "Help Lightning" is branded, accent color is orange
    switch_to_diffrent_page   ${driver1}   ${py_groups_page}    ${py_groups_switch_success}    ${py_get_number_of_rows}
    sleep  10
    ${css_value}   get_css_value   ${driver1}   ${create_group_button}    background-color                           # Groups页面的Create Group按钮
    check_get_color_correct    ${get_value}   ${css_value}
    ${css_value}   get_css_value   ${driver1}   ${groups_report_view}   background-color                            # Groups页面的Report View按钮
    check_get_color_correct    ${get_value}   ${css_value}
    ${css_value}   get_css_value   ${driver1}   ${Details_button_xpath}        color                                # Details 按钮
    check_get_color_correct    ${get_value}   ${css_value}
    ${css_value}   get_css_value   ${driver1}   ${Members_button_xpath}        color                                # Members 按钮
    check_get_color_correct    ${get_value}   ${css_value}
    # create group
    switch_to_other_tab   ${driver1}   ${create_group_button}
    ${css_value}   get_css_value   ${driver1}   ${Create_Group_Group_Type}        color                             # Create New Group页面的Group Type字段
    check_get_color_correct    ${get_value}   ${css_value}
    ${css_value}   get_css_value   ${driver1}   ${Create_Group_Group_Info}        color                             # Create New Group页面的Group Info字段
    check_get_color_correct    ${get_value}   ${css_value}
    ${css_value}   get_css_value   ${driver1}   ${Create_Group_Team_Contacts}        color                          # Create New Group页面的Team Contacts字段
    check_get_color_correct    ${get_value}   ${css_value}
    ${css_value}   get_css_value   ${driver1}   ${Create_Group_Create_Group}   background-color                     # Create New Group页面的Create Group按钮
    check_get_color_correct    ${get_value}   ${css_value}
    ${css_value}   get_css_value   ${driver1}   ${Create_Group_Create_and_Add_Another}   background-color           # Create New Group页面的Create and Add Another按钮
    check_get_color_correct    ${get_value}   ${css_value}
    switch_to_other_tab   ${driver1}   ${Create_Group_Cancel}

    Comment    My Account 页面
    # open My account, Setting of my account	VP: All context with "Help Lightning" is branded, accent color is orange
    switch_to_other_tab   ${driver1}   ${My_Account_button}
    switch_to_other_tab   ${driver1}   ${My_Account_span_xpath}
    sleep   10
    ${css_value}   get_css_value   ${driver1}   ${My_Account_Settings_tab}        color                             # Settings tab页面
    check_get_color_correct    ${get_value}   ${css_value}
    ${css_value}   get_css_value   ${driver1}   ${My_Account_Change_password}        color                          # My Account tab页面的Change password...按钮
    check_get_color_correct    ${get_value}   ${css_value}
    ${css_value}   get_css_value   ${driver1}   ${My_Account_Update}   background-color                             # My Account tab页面的Update按钮
    check_get_color_correct    ${get_value}   ${css_value}
    # Setting of my account
    switch_to_other_tab   ${driver1}   ${My_Account_Settings_tab}
    ${css_value}   get_css_value   ${driver1}   ${My_Account_My_Account}        color                               # My Account tab页面
    check_get_color_correct    ${get_value}   ${css_value}
    ${css_value}   get_css_value   ${driver1}   ${Settings_tab_Allow_access}        color                           # Settings tab页面的Allow access to your Camera and Microphone.按钮
    check_get_color_correct    ${get_value}   ${css_value}
    # Workspace admin logout
    exit_one_driver     ${driver1}

    Comment    Site admin login
    # Site admin login and switch to WS1,VP: All context with "Help Lightning" is branded, accent color is orange, for following sceen
    ${driver2}    driver_set_up_and_logIn    ${site_admin_username}     ${universal_password}
    # Contacts screen
    ${css_value}   get_css_value   ${driver2}   ${Contacts_call_button}   color                                     # Contacts页面的Call按钮
    check_get_color_correct    ${get_value}   ${css_value}
    ${css_value}   get_css_value   ${driver2}   ${Contacts_Send_link_email}   background-color                      # Send My Help Space Invitation按钮
    check_get_color_correct    ${get_value}   ${css_value}

    Comment    Send Meeting link screen
    # Send Meeting link screen
    switch_to_other_tab   ${driver2}   ${Contacts_Send_link_email}          # 进入My Help Space页面
    sleep    10
    ${css_value}   get_css_value   ${driver2}   ${Send_link_email_Cancel}   color                                   # My Help Space页面的Cancel 按钮
    check_get_color_correct    ${get_value}   ${css_value}
    ${css_value}   get_css_value   ${driver2}   ${Send_link_email_Send_Invite}   background-color                   # My Help Space页面的Send Invite 按钮
    check_get_color_correct    ${get_value}   ${css_value}

    Comment   My account
    # My account
    refresh_browser_page    ${driver2}
    switch_to_other_tab   ${driver2}   ${My_Account_button}
    switch_to_other_tab   ${driver2}   ${My_Account_span_xpath}
    sleep   10
    ${css_value}   get_css_value   ${driver2}   ${My_Account_Settings_tab}        color                             # Settings tab页面
    check_get_color_correct    ${get_value}   ${css_value}
    ${css_value}   get_css_value   ${driver2}   ${My_Account_Change_password}        color                          # My Account tab页面的Change password...按钮
    check_get_color_correct    ${get_value}   ${css_value}
    ${css_value}   get_css_value   ${driver2}   ${My_Account_Update}   background-color                             # My Account tab页面的Update按钮
    check_get_color_correct    ${get_value}   ${css_value}
    # Setting of my account
    switch_to_other_tab   ${driver2}   ${My_Account_Settings_tab}
    ${css_value}   get_css_value   ${driver2}   ${My_Account_My_Account}        color                               # My Account tab页面
    check_get_color_correct    ${get_value}   ${css_value}
    ${css_value}   get_css_value   ${driver2}   ${Settings_tab_Allow_access}        color                           # Settings tab页面的Allow access to your Camera and Microphone.按钮
    check_get_color_correct    ${get_value}   ${css_value}

    Comment  Toturial screen
    # Toturial screen
    refresh_browser_page    ${driver2}    no_care
    ${css_value}   get_css_value   ${driver2}   ${Toturial_switch_page}   color                                     # Toturial 页面切换图片
    check_get_color_correct    ${get_value}   ${css_value}
    ${css_value}   get_css_value   ${driver2}   ${Toturial_Let_go}   color                                          # Toturial 页面的Let's go!按钮
    check_get_color_correct    ${get_value}   ${css_value}
    ${get_ele_text}    get_ele_text    ${driver2}    ${Toturial_title}
    check_a_contains_b    ${driver2}    ${get_ele_text}    ${product_name}
    refresh_browser_page    ${driver2}

    Comment  Disclaimer screen
    # Disclaimer screen
    switch_to_settings_page   ${driver2}   # 进入settings页面
    expand_which_setting     ${driver2}     Before Call: Disclaimer   # EXPAND Before Call: Disclaimer
    reset_disclaimer      ${driver2}        # 重置Disclaimer
    sleep  15s
    refresh_browser_page    ${driver2}    no_care       # 刷新页面
    ${css_value}   get_css_value   ${driver2}   ${Disclaimer_accept}   background-color                             # Disclaimer的accept按钮
    check_get_color_correct    ${get_value}   ${css_value}
    user_decline_or_accept_disclaimer    ${driver2}   accept
    refresh_browser_page    ${driver2}

    Comment  Select mode hint in F2F mode
    # Select mode hint in F2F mode
    ${driver3}    driver_set_up_and_logIn    ${personal_user_username}     ${universal_password}
    switch_to_diffrent_page   ${driver2}   ${py_contacts_page}     ${py_contacts_switch_success}    ${py_get_number_of_rows}   switch_tree
    make_calls_with_who     ${driver2}    ${driver3}    ${personal_user_username}       # 进行通话
    sleep   45s
    which_page_is_currently_on    ${driver2}    ${end_call_button}
    ${css_value}   get_css_value   ${driver2}   ${f2f_mode_I_will_give_help}   color                                # f2f模式的I will give help文本信息
    check_get_color_correct    ${get_value}   ${css_value}
    ${css_value}   get_css_value   ${driver2}   ${f2f_mode_I_need_help}   color                                     # f2f模式的I need help文本信息
    check_get_color_correct    ${get_value}   ${css_value}
    ${css_value}   get_css_value   ${driver2}   ${f2f_mode_Close}   color                                           # f2f模式的Close按钮
    check_get_color_correct    ${get_value}   ${css_value}
    ${get_class_value}    get_ele_class_name    ${driver2}   ${end_call_whole_page}   style                         # 通话过程中的背景色
    check_a_contains_b    ${driver2}     ${get_class_value}     ${lime_brand_orange_color}

    Comment  Invite friend screen
    # Invite friend screen
    open_invite_3rd_participant_dialog    ${driver2}   # 打开邀请第三者通话界面
    ${css_value}   get_css_value   ${driver2}   ${invite_contacts_tab}   color                                      # 邀请第三位通话者页面的Contacts tab页面
    check_get_color_correct    ${get_value}   ${css_value}
    ${css_value}   get_css_value   ${driver2}   ${invite_send_invite_tab}   color                                   # 邀请第三位通话者页面的Send Invite tab页面
    check_get_color_correct    ${get_value}   ${css_value}
    ${css_value}   get_css_value   ${driver2}   ${send_invite_tab_send_invite_button}   background-color            # 邀请第三位通话者页面的Send Invite tab页面Send Invite按钮
    check_get_color_correct    ${get_value}   ${css_value}
    exit_call     ${driver3}     # 结束通话

    Comment   User logout
    # User logout	VP: product name string is "Help Lightning", not branded name	VP: App color is Help Lightning blue
    refresh_browser_page    ${driver2}
    logout_citron    ${driver2}
    ${css_value}   get_css_value   ${driver2}   ${Login_page_next_button}   background-color                        # 登录页面的Next按钮
    two_option_is_equal   ${driver2}   rgba(0, 169, 224, 1)     ${css_value}
#    should be equal as strings    rgba(0, 169, 224, 1)     ${css_value}
    [Teardown]      run keywords    Close
    ...             AND             exit_driver
#    ...             AND             exit_driver    ${driver2}    ${driver3}

Small_range_995_996
    [Documentation]     WS branding     Set workspace WS2 accent color to Green, Big Logo 2 & Avatar 2, WS1 to orange, Big Logo 1 & Avatar 1      User A call user B directly
    [Tags]    small range 995-996 lines     call_case
    [Setup]     run keywords    Login_site_admin
    ...         AND             switch_to_created_workspace       ${created_workspace_branding_1}   # 切换到我自己创建的WS
    ...         AND             enter_workspace_settings_page       # 进入settings页面
    ...         AND             close_disable_external_users            # 关闭Disable External Users设置
    ...         AND             expand_workspace_branding_setting       # 展开Workspace Branding设置
    ...         AND             turn_on_workspace_branding_setting      # 打开Workspace Branding设置
    ...         AND             switch_to_created_workspace       ${created_workspace_branding_2}   # 切换到我自己创建的WS
    ...         AND             enter_workspace_settings_page       # 进入settings页面
    ...         AND             close_disable_external_users            # 关闭Disable External Users设置
    ...         AND             expand_workspace_branding_setting       # 展开Workspace Branding设置
    ...         AND             turn_on_workspace_branding_setting      # 打开Workspace Branding设置
    ...         AND             Close
    # --------------------------------------------------------------------------------------------------------- #
    # 此处为case执行的前置条件
    # ${created_workspace_branding_1}的Product Name为“熔岩巨兽”，Accent Color为#ff9933，Big Logo为Logo1，Default Avatar为avatar1
    # ${created_workspace_branding_2}的Product Name为“扭曲树精”，Accent Color为#00ff00，Big Logo为Logo2，Default Avatar为avatar2
    # --------------------------------------------------------------------------------------------------------- #
    # User A登录
    ${driver1}    driver_set_up_and_logIn    ${ws_branding_A_user}     ${universal_password}
    # User B登录
    ${driver2}    driver_set_up_and_logIn    ${ws_branding_B_user}     ${universal_password}
    # User A call user B directly
    make_calls_with_who    ${driver1}   ${driver2}    ${ws_branding_B_user}   no_anwser
    # VP: User A's outgoing call, it shoud show User B's customer  avatar.
    ${get_class_value}    get_ele_class_name    ${driver1}   ${outgoing_Call_avator}   src
    check_a_contains_b    ${driver1}     ${get_class_value}       ${User_B_customer_avatar}
    # User B's incoming call, it should show WS 1's Branding Avatar
    ${get_class_value}    get_ele_class_name    ${driver2}   ${ingoing_Call_avator}   src
    should start with    ${get_class_value}    ${WS_1_Branding_Avatar}
    # 接受Call
    user_anwser_call   ${driver2}
    which_page_is_currently_on    ${driver1}    ${end_call_button}

    # VP: In-call view is WS1's color of orange for user A and B
    ${css_value}   get_css_value   ${driver1}   ${f2f_mode_I_will_give_help}   color                                # f2f模式的I will give help文本信息
    check_get_color_is_orange       ${css_value}
    ${css_value}   get_css_value   ${driver1}   ${f2f_mode_I_need_help}   color                                     # f2f模式的I need help文本信息
    check_get_color_is_orange       ${css_value}
    ${css_value}   get_css_value   ${driver1}   ${f2f_mode_Close}   color                                           # f2f模式的Close按钮
    check_get_color_is_orange       ${css_value}
    ${css_value}   get_css_value   ${driver2}   ${f2f_mode_I_will_give_help}   color                                # f2f模式的I will give help文本信息
    check_get_color_is_orange       ${css_value}
    ${css_value}   get_css_value   ${driver2}   ${f2f_mode_I_need_help}   color                                     # f2f模式的I need help文本信息
    check_get_color_is_orange       ${css_value}
    ${css_value}   get_css_value   ${driver2}   ${f2f_mode_Close}   color                                           # f2f模式的Close按钮
    check_get_color_is_orange       ${css_value}

    # VP: End Call page use WS1's branding name and orange for A and B
    exit_call    ${driver2}
    ${get_ele_text}    get_ele_text    ${driver1}    ${end_call_message}
    two_option_is_equal   ${driver1}   ${get_ele_text}       ${Malphite}
#    should be equal as strings    ${get_ele_text}       ${Malphite}
    ${css_value}   get_css_value   ${driver1}   ${end_call_message}   color
    check_get_color_is_white       ${css_value}
    ${get_ele_text}    get_ele_text    ${driver2}    ${end_call_message}
    two_option_is_equal   ${driver2}   ${get_ele_text}       ${Malphite}
#    should be equal as strings    ${get_ele_text}       ${Malphite}
    ${css_value}   get_css_value   ${driver2}   ${end_call_message}   color
    check_get_color_is_white       ${css_value}

    #1）Accent Color[Orange] for the clouds background color.
    ${get_class_value}    get_ele_class_name    ${driver1}   ${end_call_whole_page}   style                     # 整个页面
    check_a_contains_b    ${driver1}     ${get_class_value}      ${organizer_brand_orange_color}
    ${get_class_value}    get_ele_class_name    ${driver2}   ${end_call_whole_page}   style                     # 整个页面
    check_a_contains_b    ${driver2}     ${get_class_value}      ${organizer_brand_orange_color}

    #2）Use WS 1's Big Logo for the company logo above “Thank You for Using {Brand Name}”.
    ${get_class_value}    get_ele_class_name    ${driver1}   ${end_call_logo}   src
    check_a_contains_b    ${driver1}     ${get_class_value}        ${WS_1_Big_Logo}
    ${get_class_value}    get_ele_class_name    ${driver2}   ${end_call_logo}   src
    check_a_contains_b    ${driver2}     ${get_class_value}        ${WS_1_Big_Logo}
    [Teardown]      run keywords    Close
    ...             AND             exit_driver
#    ...             AND             exit_driver     ${driver1}    ${driver2}

Small_range_997
    [Documentation]     User A call other site user[User B] from personal contact list, other site user has not customer avatar & WS branding = OFF
    [Tags]    small range 997 line      call_case
    [Setup]     run keywords    Login_site_admin
    ...         AND             switch_to_created_workspace       ${created_workspace_branding_1}   # 切换到我自己创建的WS
    ...         AND             enter_workspace_settings_page       # 进入settings页面
    ...         AND             close_disable_external_users        # 关闭Security: Disable External Users配置项
    ...         AND             Close
    # --------------------------------------------------------------------------------------------------------- #
    # 此处为case执行的前置条件
    # ${created_workspace_branding_1}的Product Name为“熔岩巨兽”，Accent Color为#ff9933，Big Logo为Logo1，Default Avatar为avatar1
    # ${created_workspace_branding_2}的Product Name为“扭曲树精”，Accent Color为#00ff00，Big Logo为Logo2，Default Avatar为avatar2
    # --------------------------------------------------------------------------------------------------------- #
    # User A登录
    ${driver1}    driver_set_up_and_logIn    ${ws_branding_A_user}     ${universal_password}
    # User B登录
    ${driver2}    driver_set_up_and_logIn    ${Expert_User5_username}     ${universal_password}
    # User A call other site user[User B] from personal contact list
    make_calls_with_who    ${driver1}   ${driver2}    ${Expert_User5_username}   no_anwser    is_personal
    # VP: User A's outgoing call, it should show Default avatar [Grey 'H' Logo].
    ${get_class_value}    get_ele_class_name    ${driver1}   ${outgoing_Call_avator}   src
    check_a_contains_b    ${driver1}     ${get_class_value}       ${default_avatar_src}
    # User B's incoming call, it should show WS 1's Branding Avatar
    ${get_class_value}    get_ele_class_name    ${driver2}   ${ingoing_Call_avator}   src
    should start with    ${get_class_value}    ${WS_1_Branding_Avatar}
    # 接受Call
    user_anwser_call   ${driver2}
    which_page_is_currently_on    ${driver1}    ${end_call_button}

    # VP: In-call view is WS1's color of orange for user A and B
    ${css_value}   get_css_value   ${driver1}   ${f2f_mode_I_will_give_help}   color                                # f2f模式的I will give help文本信息
    check_get_color_is_orange       ${css_value}
    ${css_value}   get_css_value   ${driver1}   ${f2f_mode_I_need_help}   color                                     # f2f模式的I need help文本信息
    check_get_color_is_orange       ${css_value}
    ${css_value}   get_css_value   ${driver1}   ${f2f_mode_Close}   color                                           # f2f模式的Close按钮
    check_get_color_is_orange       ${css_value}
    ${css_value}   get_css_value   ${driver2}   ${f2f_mode_I_will_give_help}   color                                # f2f模式的I will give help文本信息
    check_get_color_is_orange       ${css_value}
    ${css_value}   get_css_value   ${driver2}   ${f2f_mode_I_need_help}   color                                     # f2f模式的I need help文本信息
    check_get_color_is_orange       ${css_value}
    ${css_value}   get_css_value   ${driver2}   ${f2f_mode_Close}   color                                           # f2f模式的Close按钮
    check_get_color_is_orange       ${css_value}

    # VP: End Call page use WS1's branding name and orange for A and B
    exit_call    ${driver2}
    ${get_ele_text}    get_ele_text    ${driver1}    ${end_call_message}
    two_option_is_equal   ${driver1}    ${get_ele_text}       ${Malphite}
#    should be equal as strings    ${get_ele_text}       ${Malphite}
    ${css_value}   get_css_value   ${driver1}   ${end_call_message}   color
    check_get_color_is_white       ${css_value}
    ${get_ele_text}    get_ele_text    ${driver2}    ${end_call_message}
    two_option_is_equal   ${driver2}    ${get_ele_text}       ${Malphite}
#    should be equal as strings    ${get_ele_text}       ${Malphite}
    ${css_value}   get_css_value   ${driver2}   ${end_call_message}   color
    check_get_color_is_white       ${css_value}

    #1）Accent Color[Orange] for the clouds background color.
    ${get_class_value}    get_ele_class_name    ${driver1}   ${end_call_whole_page}   style                     # 整个页面
    check_a_contains_b    ${driver1}     ${get_class_value}      ${organizer_brand_orange_color}
    ${get_class_value}    get_ele_class_name    ${driver2}   ${end_call_whole_page}   style                     # 整个页面
    check_a_contains_b    ${driver2}     ${get_class_value}      ${organizer_brand_orange_color}

    #2）Use WS 1's Big Logo for the company logo above “Thank You for Using {Brand Name}”.
    ${get_class_value}    get_ele_class_name    ${driver1}   ${end_call_logo}   src
    check_a_contains_b    ${driver1}     ${get_class_value}        ${WS_1_Big_Logo}
    ${get_class_value}    get_ele_class_name    ${driver2}   ${end_call_logo}   src
    check_a_contains_b    ${driver2}     ${get_class_value}        ${WS_1_Big_Logo}
    [Teardown]      run keywords    Close
    ...             AND             exit_driver
#    ...             AND             exit_driver     ${driver1}    ${driver2}

Small_range_998
    [Documentation]     User C switch to WS2	Use A call user C from Team contact
    [Tags]    small range 998 line      call_case
    # --------------------------------------------------------------------------------------------------------- #
    # 此处为case执行的前置条件
    # ${created_workspace_branding_1}的Product Name为“熔岩巨兽”，Accent Color为#ff9933，Big Logo为Logo1，Default Avatar为avatar1
    # ${created_workspace_branding_2}的Product Name为“扭曲树精”，Accent Color为#00ff00，Big Logo为Logo2，Default Avatar为avatar2
    # --------------------------------------------------------------------------------------------------------- #
    # User A登录
    ${driver1}    driver_set_up_and_logIn    ${ws_branding_A_user}     ${universal_password}
    # User C登录
    ${driver2}    driver_set_up_and_logIn    ${ws_branding_C_user}     ${universal_password}
    user_switch_to_second_workspace    ${driver2}    ${WS_branding_setting_WS2}
    # Use A call user C from Team contact
    make_calls_with_who    ${driver1}   ${driver2}    ${ws_branding_C_user}   no_anwser
    # VP: User A's outgoing call, it shoud show WS 1's branding  avatar.
    ${get_class_value}    get_ele_class_name    ${driver1}   ${outgoing_Call_avator}   src
    check_a_contains_b    ${driver1}     ${get_class_value}       ${WS_1_Branding_Avatar}
    # User C's incoming call, it should show WS 1's Branding Avatar
    ${get_class_value}    get_ele_class_name    ${driver2}   ${ingoing_Call_avator}   src
    should start with    ${get_class_value}    ${WS_1_Branding_Avatar}
    # 接受Call
    user_anwser_call   ${driver2}
    which_page_is_currently_on    ${driver1}    ${end_call_button}

    # VP: In-call view is WS1's color of orange for user A and B
    ${css_value}   get_css_value   ${driver1}   ${f2f_mode_I_will_give_help}   color                                # f2f模式的I will give help文本信息
    check_get_color_is_orange       ${css_value}
    ${css_value}   get_css_value   ${driver1}   ${f2f_mode_I_need_help}   color                                     # f2f模式的I need help文本信息
    check_get_color_is_orange       ${css_value}
    ${css_value}   get_css_value   ${driver1}   ${f2f_mode_Close}   color                                           # f2f模式的Close按钮
    check_get_color_is_orange       ${css_value}
    ${css_value}   get_css_value   ${driver2}   ${f2f_mode_I_will_give_help}   color                                # f2f模式的I will give help文本信息
    check_get_color_is_orange       ${css_value}
    ${css_value}   get_css_value   ${driver2}   ${f2f_mode_I_need_help}   color                                     # f2f模式的I need help文本信息
    check_get_color_is_orange       ${css_value}
    ${css_value}   get_css_value   ${driver2}   ${f2f_mode_Close}   color                                           # f2f模式的Close按钮
    check_get_color_is_orange       ${css_value}

    # VP: End Call page use WS1's branding name and orange for A and B
    exit_call    ${driver2}
    ${get_ele_text}    get_ele_text    ${driver1}    ${end_call_message}
    two_option_is_equal   ${driver1}    ${get_ele_text}       ${Malphite}
#    should be equal as strings    ${get_ele_text}       ${Malphite}
    ${css_value}   get_css_value   ${driver1}   ${end_call_message}   color
    check_get_color_is_white       ${css_value}
    ${get_ele_text}    get_ele_text    ${driver2}    ${end_call_message}
    two_option_is_equal   ${driver2}    ${get_ele_text}       ${Malphite}
#    should be equal as strings    ${get_ele_text}       ${Malphite}
    ${css_value}   get_css_value   ${driver2}   ${end_call_message}   color
    check_get_color_is_white       ${css_value}

    #1）Accent Color[Orange] for the clouds background color.
    ${get_class_value}    get_ele_class_name    ${driver1}   ${end_call_whole_page}   style                     # 整个页面
    check_a_contains_b    ${driver1}     ${get_class_value}      ${organizer_brand_orange_color}
    ${get_class_value}    get_ele_class_name    ${driver2}   ${end_call_whole_page}   style                     # 整个页面
    check_a_contains_b    ${driver2}     ${get_class_value}      ${organizer_brand_orange_color}

    #2）Use WS 1's Big Logo for the company logo above “Thank You for Using {Brand Name}”.
    ${get_class_value}    get_ele_class_name    ${driver1}   ${end_call_logo}   src
    check_a_contains_b    ${driver1}     ${get_class_value}        ${WS_1_Big_Logo}
    ${get_class_value}    get_ele_class_name    ${driver2}   ${end_call_logo}   src
    check_a_contains_b    ${driver2}     ${get_class_value}        ${WS_1_Big_Logo}
    [Teardown]      exit_driver
#    [Teardown]      exit_driver     ${driver1}    ${driver2}

Small_range_999
    [Documentation]     User A click B's meeing link
    [Tags]    small range 999 line      call_case
    # --------------------------------------------------------------------------------------------------------- #
    # 此处为case执行的前置条件
    # ${created_workspace_branding_1}的Product Name为“熔岩巨兽”，Accent Color为#ff9933，Big Logo为Logo1，Default Avatar为avatar1
    # ${created_workspace_branding_2}的Product Name为“扭曲树精”，Accent Color为#00ff00，Big Logo为Logo2，Default Avatar为avatar2
    # --------------------------------------------------------------------------------------------------------- #
    # User A登录
    ${driver1}    driver_set_up_and_logIn    ${ws_branding_A_user}     ${universal_password}
    # User B登录
    ${driver2}    driver_set_up_and_logIn    ${ws_branding_B_user}     ${universal_password}
    ${invite_url}     send_meeting_room_link    ${driver2}     OTU
    # User A click B's meeing link
    user_make_call_via_meeting_link      ${driver1}    ${invite_url}
    # 确保建立call，但未接听
    make_sure_enter_call    ${driver1}
    # VP: User A's outgoing call, it shoud show User B's customer  avatar.
    ${get_class_value}    get_ele_class_name    ${driver1}   ${outgoing_Call_avator}   src
    check_a_contains_b    ${driver1}     ${get_class_value}       ${User_B_customer_avatar}
    # User B's incoming call, it should show WS 1's Branding Avatar
    ${get_class_value}    get_ele_class_name    ${driver2}   ${ingoing_Call_avator}   src
    should start with    ${get_class_value}    ${WS_1_Branding_Avatar}
    # 接受Call
    user_anwser_call   ${driver2}
    which_page_is_currently_on    ${driver1}    ${end_call_button}

    # VP: In-call view is WS1's color of orange for user A and B
    ${get_class_value}    get_ele_class_name    ${driver1}   ${end_call_whole_page}   style                         # 通话过程中的背景色
    check_a_contains_b    ${driver1}     ${get_class_value}      ${lime_brand_orange_color}
    ${css_value}   get_css_value   ${driver2}   ${f2f_mode_I_will_give_help}   color                                # f2f模式的I will give help文本信息
    check_get_color_is_orange       ${css_value}
    ${css_value}   get_css_value   ${driver2}   ${f2f_mode_I_need_help}   color                                     # f2f模式的I need help文本信息
    check_get_color_is_orange       ${css_value}
    ${css_value}   get_css_value   ${driver2}   ${f2f_mode_Close}   color                                           # f2f模式的Close按钮
    check_get_color_is_orange       ${css_value}

    # VP: End Call page use WS1's branding name and orange for A and B
    exit_call    ${driver2}
    ${get_ele_text}    get_ele_text    ${driver1}    ${end_call_message}
    two_option_is_equal    ${driver1}   ${get_ele_text}       ${Malphite}
#    should be equal as strings    ${get_ele_text}       ${Malphite}
    ${css_value}   get_css_value   ${driver1}   ${end_call_message}   color
    check_get_color_is_white       ${css_value}
    ${get_ele_text}    get_ele_text    ${driver2}    ${end_call_message}
    two_option_is_equal   ${driver2}    ${get_ele_text}       ${Malphite}
#    should be equal as strings    ${get_ele_text}       ${Malphite}
    ${css_value}   get_css_value   ${driver2}   ${end_call_message}   color
    check_get_color_is_white       ${css_value}

    #1）Accent Color[Orange] for the clouds background color.
    ${get_class_value}    get_ele_class_name    ${driver1}   ${end_call_whole_page}   style                     # 整个页面
    check_a_contains_b    ${driver1}     ${get_class_value}         ${organizer_brand_orange_color}
    ${get_class_value}    get_ele_class_name    ${driver2}   ${end_call_whole_page}   style                     # 整个页面
    check_a_contains_b    ${driver2}     ${get_class_value}         ${organizer_brand_orange_color}

    #2）Use WS 1's Big Logo for the company logo above “Thank You for Using {Brand Name}”.
    ${get_class_value}    get_ele_class_name    ${driver1}   ${end_call_logo}   src
    check_a_contains_b    ${driver1}     ${get_class_value}        ${WS_1_Big_Logo}
    ${get_class_value}    get_ele_class_name    ${driver2}   ${end_call_logo}   src
    check_a_contains_b    ${driver2}     ${get_class_value}        ${WS_1_Big_Logo}
    [Teardown]      exit_driver
#    [Teardown]      exit_driver     ${driver1}    ${driver2}

Small_range_1000_1001
    [Documentation]     Anonyoums click B's meeting link
    [Tags]    small range 1000-1001 lines       call_case
    # --------------------------------------------------------------------------------------------------------- #
    # 此处为case执行的前置条件
    # ${created_workspace_branding_1}的Product Name为“熔岩巨兽”，Accent Color为#ff9933，Big Logo为Logo1，Default Avatar为avatar1
    # ${created_workspace_branding_2}的Product Name为“扭曲树精”，Accent Color为#00ff00，Big Logo为Logo2，Default Avatar为avatar2
    # --------------------------------------------------------------------------------------------------------- #
    # User A登录
    ${driver1}    driver_set_up_and_logIn    ${ws_branding_A_user}     ${universal_password}
    # User B登录
    ${driver2}    driver_set_up_and_logIn    ${ws_branding_B_user}     ${universal_password}
    ${invite_url}     send_meeting_room_link    ${driver2}     OTU
    # Anonyoums click B's meeting link
    ${driver3}    anonymous_open_meeting_link     ${invite_url}
    # 确保call连接成功，但未接听
    make_sure_enter_call   ${driver3}
    # VP: Anonymous's outgoing call, it should show User B's customer  avatar.
    ${get_class_value}    get_ele_class_name    ${driver3}   ${outgoing_Call_avator}   src
    check_a_contains_b    ${driver3}     ${get_class_value}       ${User_B_customer_avatar}
    # User B's incoming call, it should show HL Default Avatar [Grey 'H' Logo]
    ${get_class_value}    get_ele_class_name    ${driver2}   ${ingoing_Call_avator}   src
    should start with    ${get_class_value}    ${default_avatar_src}
    # 接受Call
    user_anwser_call   ${driver2}
    # User A click B's meeing link
    user_make_call_via_meeting_link      ${driver1}    ${invite_url}
    # 确保建立call，但未接听
    make_sure_enter_call    ${driver1}
    # 接听call
    user_anwser_call   ${driver2}   no_direct

    # In-call view for A, B and anonymous is WS1's color of orange
    ${get_class_value}    get_ele_class_name    ${driver1}   ${end_call_whole_page}   style                         # 通话过程中的背景色
    check_a_contains_b    ${driver1}     ${get_class_value}      ${lime_brand_orange_color}
    ${css_value}   get_css_value   ${driver2}   ${f2f_mode_I_will_give_help}   color                                # f2f模式的I will give help文本信息
    check_get_color_is_orange       ${css_value}
    ${css_value}   get_css_value   ${driver2}   ${f2f_mode_I_need_help}   color                                     # f2f模式的I need help文本信息
    check_get_color_is_orange       ${css_value}
    ${css_value}   get_css_value   ${driver2}   ${f2f_mode_Close}   color                                           # f2f模式的Close按钮
    check_get_color_is_orange       ${css_value}
    ${get_class_value}    get_ele_class_name    ${driver3}   ${end_call_whole_page}   style                         # 通话过程中的背景色
    check_a_contains_b    ${driver3}     ${get_class_value}      ${lime_brand_orange_color}

    # VP: End Call page use WS1's branding name and orange for A and Anonymous
    end_call_for_all    ${driver2}
    ${get_ele_text}    get_ele_text    ${driver1}    ${end_call_message}
    two_option_is_equal    ${driver1}    ${get_ele_text}       ${Malphite}
#    should be equal as strings    ${get_ele_text}       ${Malphite}
    ${css_value}   get_css_value   ${driver1}   ${end_call_message}   color
    check_get_color_is_white       ${css_value}
    ${get_ele_text}    get_ele_text    ${driver2}    ${end_call_message}
    two_option_is_equal    ${driver2}    ${get_ele_text}       ${Malphite}
#    should be equal as strings    ${get_ele_text}       ${Malphite}
    ${css_value}   get_css_value   ${driver2}   ${end_call_message}   color
    check_get_color_is_white       ${css_value}
    ${get_ele_text}    get_ele_text    ${driver3}    ${end_call_message}
    two_option_is_equal    ${driver3}    ${get_ele_text}       ${Malphite}
#    should be equal as strings    ${get_ele_text}       ${Malphite}
    ${css_value}   get_css_value   ${driver3}   ${end_call_message}   color
    check_get_color_is_white       ${css_value}

    #1）Accent Color[Orange] for the clouds background color.
    ${get_class_value}    get_ele_class_name    ${driver1}   ${end_call_whole_page}   style                     # 整个页面
    check_a_contains_b    ${driver1}     ${get_class_value}      ${organizer_brand_orange_color}
    ${get_class_value}    get_ele_class_name    ${driver2}   ${end_call_whole_page}   style                     # 整个页面
    check_a_contains_b    ${driver2}     ${get_class_value}      ${organizer_brand_orange_color}
    ${get_class_value}    get_ele_class_name    ${driver3}   ${end_call_whole_page}   style                     # 整个页面
    check_a_contains_b    ${driver3}     ${get_class_value}      ${organizer_brand_orange_color}

    #2）Use WS 1's Big Logo for the company logo above “Thank You for Using {Brand Name}”.
    ${get_class_value}    get_ele_class_name    ${driver1}   ${end_call_logo}   src
    check_a_contains_b    ${driver1}     ${get_class_value}        ${WS_1_Big_Logo}
    ${get_class_value}    get_ele_class_name    ${driver2}   ${end_call_logo}   src
    check_a_contains_b    ${driver2}     ${get_class_value}        ${WS_1_Big_Logo}
    ${get_class_value}    get_ele_class_name    ${driver3}   ${end_call_logo}   src
    check_a_contains_b    ${driver3}     ${get_class_value}        ${WS_1_Big_Logo}
    [Teardown]      exit_driver
#    [Teardown]      exit_driver     ${driver1}    ${driver2}    ${driver3}

Small_range_1002_1004
    [Documentation]     User B send 3PI link    User C switch to WS2    User C click 3PI link to join call
    [Tags]    small range 1002-1004 lines       call_case
    # --------------------------------------------------------------------------------------------------------- #
    # 此处为case执行的前置条件
    # ${created_workspace_branding_1}的Product Name为“熔岩巨兽”，Accent Color为#ff9933，Big Logo为Logo1，Default Avatar为avatar1
    # ${created_workspace_branding_2}的Product Name为“扭曲树精”，Accent Color为#00ff00，Big Logo为Logo2，Default Avatar为avatar2
    # --------------------------------------------------------------------------------------------------------- #
    # User A登录
    ${driver1}    driver_set_up_and_logIn    ${ws_branding_A_user}     ${universal_password}
    # User B登录
    ${driver2}    driver_set_up_and_logIn    ${ws_branding_B_user}     ${universal_password}
    ${invite_url}     send_meeting_room_link    ${driver2}     OTU
    # User A click B's meeing link
    user_make_call_via_meeting_link      ${driver1}    ${invite_url}
    # 确保建立call，但未接听
    make_sure_enter_call    ${driver1}
    # 接听call
    user_anwser_call   ${driver2}
    # User C登录
    ${driver3}    driver_set_up_and_logIn    ${ws_branding_C_user}     ${universal_password}
    user_switch_to_second_workspace    ${driver3}    ${WS_branding_setting_WS2}
    # User B send 3PI link
    which_page_is_currently_on    ${driver2}    ${end_call_button}
    ${invite_url}    send_invite_in_calling_page    ${driver2}
    close_invite_3th_page    ${driver2}
    # User C click 3PI link to join call
    user_make_call_via_meeting_link    ${driver3}     ${invite_url}
    # 确保建立call，但未接听
    make_sure_enter_call    ${driver3}
    # VP: User C's outgoing call, it should show User B's customer Avatar
    ${get_class_value}    get_ele_class_name    ${driver3}   ${outgoing_Call_avator}   src
    check_a_contains_b    ${driver3}     ${get_class_value}       ${User_B_customer_avatar}
    # VP: In-call view (menus, sub-menus) are all WS1's orange for UserC
    user_anwser_call    ${driver2}    no_direct
    switch_to_last_window    ${driver3}
    sleep  10s
    ${get_class_value}    get_ele_class_name    ${driver3}   ${end_call_whole_page}   style                         # 通话过程中的背景色
    check_a_contains_b    ${driver3}     ${get_class_value}      ${lime_brand_orange_color}
    # End call
    end_call_for_all    ${driver2}
    # VP: End Call page use WS1's branding name and orange for A,B and C
    ${get_ele_text}    get_ele_text    ${driver1}    ${end_call_message}
    two_option_is_equal    ${driver1}     ${get_ele_text}       ${Malphite}
#    should be equal as strings    ${get_ele_text}       ${Malphite}
    ${css_value}   get_css_value   ${driver1}   ${end_call_message}   color
    check_get_color_is_white       ${css_value}
    ${get_ele_text}    get_ele_text    ${driver2}    ${end_call_message}
    two_option_is_equal    ${driver2}    ${get_ele_text}       ${Malphite}
#    should be equal as strings    ${get_ele_text}       ${Malphite}
    ${css_value}   get_css_value   ${driver2}   ${end_call_message}   color
    check_get_color_is_white       ${css_value}
    ${get_ele_text}    get_ele_text    ${driver3}    ${end_call_message}
    two_option_is_equal    ${driver3}    ${get_ele_text}       ${Malphite}
#    should be equal as strings    ${get_ele_text}       ${Malphite}
    ${css_value}   get_css_value   ${driver3}   ${end_call_message}   color
    check_get_color_is_white       ${css_value}
    #1）Accent Color[Orange] for the clouds background color.
    ${get_class_value}    get_ele_class_name    ${driver1}   ${end_call_whole_page}   style                     # 整个页面
    check_a_contains_b    ${driver1}     ${get_class_value}      ${organizer_brand_orange_color}
    ${get_class_value}    get_ele_class_name    ${driver2}   ${end_call_whole_page}   style                     # 整个页面
    check_a_contains_b    ${driver2}     ${get_class_value}      ${organizer_brand_orange_color}
    ${get_class_value}    get_ele_class_name    ${driver3}   ${end_call_whole_page}   style                     # 整个页面
    check_a_contains_b    ${driver3}     ${get_class_value}      ${organizer_brand_orange_color}
    #2）Use WS 1's Big Logo for the company logo above “Thank You for Using {Brand Name}”.
    ${get_class_value}    get_ele_class_name    ${driver1}   ${end_call_logo}   src
    check_a_contains_b    ${driver1}     ${get_class_value}        ${WS_1_Big_Logo}
    ${get_class_value}    get_ele_class_name    ${driver2}   ${end_call_logo}   src
    check_a_contains_b    ${driver2}     ${get_class_value}        ${WS_1_Big_Logo}
    ${get_class_value}    get_ele_class_name    ${driver3}   ${end_call_logo}   src
    check_a_contains_b    ${driver3}     ${get_class_value}        ${WS_1_Big_Logo}
    [Teardown]      exit_driver
#    [Teardown]      exit_driver     ${driver1}    ${driver2}    ${driver3}

Small_range_1005_1007
    [Documentation]     User C switch to WS1    User C switch to WS2
    [Tags]    small range 1005-1007 lines       call_case
    # --------------------------------------------------------------------------------------------------------- #
    # 此处为case执行的前置条件
    # ${created_workspace_branding_1}的Product Name为“熔岩巨兽”，Accent Color为#ff9933，Big Logo为Logo1，Default Avatar为avatar1
    # ${created_workspace_branding_2}的Product Name为“扭曲树精”，Accent Color为#00ff00，Big Logo为Logo2，Default Avatar为avatar2
    # --------------------------------------------------------------------------------------------------------- #
    # User C登录
    ${driver1}    driver_set_up_and_logIn    ${ws_branding_C_user}     ${universal_password}
    # User C switch to WS1	User C send otu link [link1]
    ${invite_url_1}     send_meeting_room_link    ${driver1}     OTU
    # User C switch to WS2	User C send otu link [link2]
    user_switch_to_second_workspace    ${driver1}    ${WS_branding_setting_WS2}
    ${invite_url_2}     send_meeting_room_link    ${driver1}     OTU
    # Anonymous click link1 to enter call
    ${driver2}    anonymous_open_meeting_link     ${invite_url_1}
    # 确保call连接成功，但未接听
    make_sure_enter_call   ${driver2}
    # VP: Anonymous's outgoing call, it should show WS 1's branding avatar.
    ${get_class_value}    get_ele_class_name    ${driver2}   ${outgoing_Call_avator}   src
    check_a_contains_b    ${driver2}     ${get_class_value}       ${WS_1_Branding_Avatar}
    #User C's incoming call, it should show HL Default Avatar [Grey 'H' Logo]
    ${get_class_value}    get_ele_class_name    ${driver1}   ${ingoing_Call_avator}   src
    should start with    ${get_class_value}    ${default_avatar_src}
    # VP: in-call view for anonymous is all orange
    user_anwser_call   ${driver1}
    sleep   30s
    ${get_class_value}    get_ele_class_name    ${driver2}   ${end_call_whole_page}   style                         # 通话过程中的背景色
    check_a_contains_b    ${driver2}     ${get_class_value}      ${lime_brand_orange_color}
    # End call
    exit_call    ${driver1}
    # VP: End Call page use WS1's branding name and orange for Anonymous
    ${get_ele_text}    get_ele_text    ${driver1}    ${end_call_message}
    two_option_is_equal    ${driver1}    ${get_ele_text}       ${Malphite}
#    should be equal as strings    ${get_ele_text}       ${Malphite}
    ${css_value}   get_css_value   ${driver1}   ${end_call_message}   color
    check_get_color_is_white       ${css_value}
    ${get_ele_text}    get_ele_text    ${driver2}    ${end_call_message}
    two_option_is_equal    ${driver2}    ${get_ele_text}       ${Malphite}
#    should be equal as strings    ${get_ele_text}       ${Malphite}
    ${css_value}   get_css_value   ${driver2}   ${end_call_message}   color
    check_get_color_is_white       ${css_value}
    #1）Accent Color[Orange] for the clouds background color.
    ${get_class_value}    get_ele_class_name    ${driver1}   ${end_call_whole_page}   style                     # 整个页面
    check_a_contains_b    ${driver1}    ${get_class_value}      ${organizer_brand_orange_color}
    ${get_class_value}    get_ele_class_name    ${driver2}   ${end_call_whole_page}   style                     # 整个页面
    check_a_contains_b    ${driver2}    ${get_class_value}      ${organizer_brand_orange_color}
    #2）Use WS 1's Big Logo for the company logo above “Thank You for Using {Brand Name}”.
    ${get_class_value}    get_ele_class_name    ${driver1}   ${end_call_logo}   src
    check_a_contains_b    ${driver1}    ${get_class_value}        ${WS_1_Big_Logo}
    ${get_class_value}    get_ele_class_name    ${driver2}   ${end_call_logo}   src
    check_a_contains_b    ${driver2}     ${get_class_value}        ${WS_1_Big_Logo}

    # User D登录
    ${driver3}    driver_set_up_and_logIn    ${ws_branding_D_user}     ${universal_password}
    # User D click link1 to enter call
    close_call_ending_page    ${driver1}    #关闭通话结束页面
    user_make_call_via_meeting_link    ${driver3}     ${invite_url_1}
    # 确保建立call，但未接听
    make_sure_enter_call    ${driver3}
    # VP: User D's outgoing call, it should show WS 1's Branding  avatar.
    ${get_class_value}    get_ele_class_name    ${driver3}   ${outgoing_Call_avator}   src
    check_a_contains_b    ${driver3}     ${get_class_value}       ${WS_1_Branding_Avatar}
    #User C's incoming call, it should show WS 2's Branding Avatar
    ${get_class_value}    get_ele_class_name    ${driver1}   ${ingoing_Call_avator}   src
    should start with    ${get_class_value}    ${WS_2_Branding_Avatar}
    # VP: in-call view for user D is all orange
    user_anwser_call   ${driver1}
    sleep   30s
    ${get_class_value}    get_ele_class_name    ${driver3}   ${end_call_whole_page}   style                         # 通话过程中的背景色
    check_a_contains_b    ${driver3}     ${get_class_value}      ${lime_brand_orange_color}
    # End call
    exit_call   ${driver3}
    # VP: End Call page use WS1's branding name and orange for User C and D
    ${get_ele_text}    get_ele_text    ${driver1}    ${end_call_message}
    two_option_is_equal    ${driver1}    ${get_ele_text}       ${Malphite}
#    should be equal as strings    ${get_ele_text}       ${Malphite}
    ${css_value}   get_css_value   ${driver1}   ${end_call_message}   color
    check_get_color_is_white       ${css_value}
    ${get_ele_text}    get_ele_text    ${driver3}    ${end_call_message}
    two_option_is_equal    ${driver3}    ${get_ele_text}       ${Malphite}
#    should be equal as strings    ${get_ele_text}       ${Malphite}
    ${css_value}   get_css_value   ${driver3}   ${end_call_message}   color
    check_get_color_is_white       ${css_value}
    #1）Accent Color[Orange] for the clouds background color.
    ${get_class_value}    get_ele_class_name    ${driver1}   ${end_call_whole_page}   style                     # 整个页面
    check_a_contains_b    ${driver1}     ${get_class_value}      ${organizer_brand_orange_color}
    ${get_class_value}    get_ele_class_name    ${driver3}   ${end_call_whole_page}   style                     # 整个页面
    check_a_contains_b    ${driver3}     ${get_class_value}      ${organizer_brand_orange_color}
    #2）Use WS 1's Big Logo for the company logo above “Thank You for Using {Brand Name}”.
    ${get_class_value}    get_ele_class_name    ${driver1}   ${end_call_logo}   src
    check_a_contains_b    ${driver1}     ${get_class_value}        ${WS_1_Big_Logo}
    ${get_class_value}    get_ele_class_name    ${driver3}   ${end_call_logo}   src
    check_a_contains_b    ${driver3}     ${get_class_value}        ${WS_1_Big_Logo}
    [Teardown]      exit_driver
#    [Teardown]      exit_driver     ${driver1}    ${driver2}    ${driver3}

Small_range_1009
    [Documentation]     Click inactive 3PI link(nobody in call) that call's owner is User B
    [Tags]    small range 1009 line     call_case
    # --------------------------------------------------------------------------------------------------------- #
    # 此处为case执行的前置条件
    # ${created_workspace_branding_1}的Product Name为“熔岩巨兽”，Accent Color为#ff9933，Big Logo为Logo1，Default Avatar为avatar1
    # ${created_workspace_branding_2}的Product Name为“扭曲树精”，Accent Color为#00ff00，Big Logo为Logo2，Default Avatar为avatar2
    # --------------------------------------------------------------------------------------------------------- #
    # User A登录
    ${driver1}    driver_set_up_and_logIn    ${ws_branding_A_user}     ${universal_password}
    # User B登录
    ${driver2}    driver_set_up_and_logIn    ${ws_branding_B_user}     ${universal_password}
    # 进行call
    make_calls_with_who     ${driver2}    ${driver1}   ${ws_branding_A_user}
    # 获取3PI link
    which_page_is_currently_on    ${driver2}    ${end_call_button}
    ${invite_url}    send_invite_in_calling_page     ${driver2}
    # 结束Call
    exit_call    ${driver1}
    # User C登录
    ${driver3}    driver_set_up_and_logIn    ${ws_branding_C_user}     ${universal_password}
    # Click inactive 3PI link(nobody in call) that call's owner is User B
    user_make_call_via_meeting_link     ${driver3}    ${invite_url}
    # 确保建立call，但未接听
    make_sure_enter_call    ${driver3}
    # VP: text and color are branded orange
    ${get_class_value}    get_ele_class_name    ${driver3}   ${end_call_whole_page}   style                     # 整个页面
    check_a_contains_b    ${driver3}     ${get_class_value}      ${organizer_brand_orange_color}
    # Avatar should be User B customer avatar.
    ${get_class_value}    get_ele_class_name    ${driver3}   ${end_call_logo}   src
    check_a_contains_b    ${driver3}     ${get_class_value}        ${WS_1_Big_Logo}
    [Teardown]      exit_driver
#    [Teardown]      exit_driver     ${driver1}    ${driver2}    ${driver3}

Small_range_1010_1017
    [Documentation]     Precondition: Expert Group 1[EG 1] in WS 1. User B is in EG 1.
    [Tags]    small range 1010-1017 lines, 有bug：https://vipaar.atlassian.net/browse/CITRON-3345     call_case
    # --------------------------------------------------------------------------------------------------------- #
    # 此处为case执行的前置条件
    # ${created_workspace_branding_1}的Product Name为“熔岩巨兽”，Accent Color为#ff9933，Big Logo为Logo1，Default Avatar为avatar1
    # ${created_workspace_branding_2}的Product Name为“扭曲树精”，Accent Color为#00ff00，Big Logo为Logo2，Default Avatar为avatar2
    # --------------------------------------------------------------------------------------------------------- #
    # User A登录
    ${driver1}    driver_set_up_and_logIn    ${EG_user_A_user}     ${universal_password}
    # User B登录
    ${driver2}    driver_set_up_and_logIn    ${EG_user_B_user}     ${universal_password}
    # User A directly call EG 1
    make_call_to_onCall     ${driver1}     ${driver2}    ${Expert_Group_1}    no_care
    # VP: User A's outgoing call, it should WS 1's branding avatar calls EG 1[the background of expert logo should be WS 1 branding accent color]
    ${get_class_value}    get_ele_class_name    ${driver1}   ${outgoing_Call_avator}   src
    check_a_contains_b    ${driver1}     ${get_class_value}       ${WS_1_Branding_Avatar}
    ${get_class_value}    get_ele_class_name    ${driver1}   ${end_call_whole_page}   style                     # 整个页面
    check_a_contains_b    ${driver1}     ${get_class_value}      ${lime_brand_orange_color}
    # User B receives this call,VP: User B's incoming call, it should WS 1' s branding avatar
    ${get_class_value}    get_ele_class_name    ${driver2}   ${ingoing_Call_avator}   src
    should start with    ${get_class_value}    ${WS_1_Branding_Avatar}
    # Enter call
    user_anwser_call     ${driver2}
    # VP: In-call view is WS1's color of orange for user A and B
    ${get_class_value}    get_ele_class_name    ${driver1}   ${end_call_whole_page}   style                         # 通话过程中的背景色
    check_a_contains_b    ${driver1}     ${get_class_value}      ${lime_brand_orange_color}
    ${get_class_value}    get_ele_class_name    ${driver2}   ${end_call_whole_page}   style                         # 通话过程中的背景色
    check_a_contains_b    ${driver2}     ${get_class_value}      ${lime_brand_orange_color}
    # End call
    exit_call     ${driver2}
    # VP: End Call page use WS1's branding name and orange for A and B
    ${get_ele_text}    get_ele_text    ${driver1}    ${end_call_message}
    two_option_is_equal    ${driver1}    ${get_ele_text}       ${Malphite}
#    should be equal as strings    ${get_ele_text}       ${Malphite}
    ${css_value}   get_css_value   ${driver1}   ${end_call_message}   color
    check_get_color_is_white       ${css_value}
    ${get_ele_text}    get_ele_text    ${driver2}    ${end_call_message}
    two_option_is_equal    ${driver2}    ${get_ele_text}       ${Malphite}
#    should be equal as strings    ${get_ele_text}       ${Malphite}
    ${css_value}   get_css_value   ${driver2}   ${end_call_message}   color
    check_get_color_is_white       ${css_value}
    # 1）Accent Color[Orange] for the clouds background color.
    ${get_class_value}    get_ele_class_name    ${driver1}   ${end_call_whole_page}   style                     # 整个页面
    check_a_contains_b    ${driver1}     ${get_class_value}      ${organizer_brand_orange_color}
    ${get_class_value}    get_ele_class_name    ${driver2}   ${end_call_whole_page}   style                     # 整个页面
    check_a_contains_b    ${driver2}     ${get_class_value}      ${organizer_brand_orange_color}
    # 2）Use WS 1's Big Logo for the company logo above “Thank You for Using {Brand Name}”.
    ${get_class_value}    get_ele_class_name    ${driver1}   ${end_call_logo}   src
    check_a_contains_b    ${driver1}     ${get_class_value}        ${WS_1_Big_Logo}
    ${get_class_value}    get_ele_class_name    ${driver2}   ${end_call_logo}   src
    check_a_contains_b    ${driver2}     ${get_class_value}        ${WS_1_Big_Logo}
    # Anonymous clicks EG's universal link
    close_call_ending_page    ${driver2}
    ${driver3}    anonymous_open_meeting_link     https://app-stage.helplightning.net.cn/help?enterprise_id=6769&group_id=10995&group_name=Expert_Group_1
    # 确保call连接成功，但未接听
    make_sure_enter_call   ${driver3}
    # VP: Anonymous's outgoing call, it should HL Default Avatar [Grey 'H' Logo] calls EG 1[the background of expert logo should be WS 1 branding accent color]
    ${get_class_value}    get_ele_class_name    ${driver3}   ${outgoing_Call_avator}   src
    check_a_contains_b    ${driver3}     ${get_class_value}       ${default_avatar_src}
#### 此处受bug影响导致fail
#    ${get_class_value}    get_ele_class_name    ${driver3}   ${end_call_whole_page}   style                     # 整个页面
#    check_a_contains_b    ${driver3}     ${get_class_value}      ${lime_brand_orange_color}
    # User B receives this call，VP: User B's incoming call, it should be HL Default Avatar [Grey 'H' Logo].
    ${get_class_value}    get_ele_class_name    ${driver2}   ${ingoing_Call_avator}   src
    check_a_contains_b    ${driver2}     ${get_class_value}       ${default_avatar_src}
    # Enter call，VP: In-call view is WS1's color of orange for Anonymous and User B
    user_anwser_call     ${driver2}
    sleep   10s
    ${get_class_value}    get_ele_class_name    ${driver2}   ${end_call_whole_page}   style                         # 通话过程中的背景色
    check_a_contains_b    ${driver2}     ${get_class_value}      ${lime_brand_orange_color}
    ${get_class_value}    get_ele_class_name    ${driver3}   ${end_call_whole_page}   style                         # 通话过程中的背景色
    check_a_contains_b    ${driver3}     ${get_class_value}      ${lime_brand_orange_color}
    # End call
    exit_call   ${driver3}
    # VP: End Call page use WS1's branding name and orange for Anonymous and User B
    ${get_ele_text}    get_ele_text    ${driver2}    ${end_call_message}
    two_option_is_equal    ${driver2}    ${get_ele_text}       ${Malphite}
#    should be equal as strings    ${get_ele_text}       ${Malphite}
    ${css_value}   get_css_value   ${driver2}   ${end_call_message}   color
    check_get_color_is_white       ${css_value}
    ${get_ele_text}    get_ele_text    ${driver3}    ${end_call_message}
    two_option_is_equal    ${driver3}    ${get_ele_text}       ${Malphite}
#    should be equal as strings    ${get_ele_text}       ${Malphite}
    ${css_value}   get_css_value   ${driver3}   ${end_call_message}   color
    check_get_color_is_white       ${css_value}
    # 1）Accent Color[Orange] for the clouds background color.
    ${get_class_value}    get_ele_class_name    ${driver2}   ${end_call_whole_page}   style                     # 整个页面
    check_a_contains_b    ${driver2}     ${get_class_value}      ${organizer_brand_orange_color}
    ${get_class_value}    get_ele_class_name    ${driver3}   ${end_call_whole_page}   style                     # 整个页面
    check_a_contains_b    ${driver3}     ${get_class_value}      ${organizer_brand_orange_color}
    # 2）Use WS 1's Big Logo for the company logo above “Thank You for Using {Brand Name}”.
    ${get_class_value}    get_ele_class_name    ${driver2}   ${end_call_logo}   src
    check_a_contains_b    ${driver2}     ${get_class_value}        ${WS_1_Big_Logo}
    ${get_class_value}    get_ele_class_name    ${driver3}   ${end_call_logo}   src
    check_a_contains_b    ${driver3}     ${get_class_value}        ${WS_1_Big_Logo}
    [Teardown]      exit_driver
#    [Teardown]      exit_driver     ${driver1}    ${driver2}    ${driver3}

Small_range_1018_1026
    [Documentation]     Change big logo     Change Default avatar
    [Tags]    small range 1018-1026 lines       call_case
    [Setup]     run keywords    Login_site_admin
    ...         AND             switch_to_created_workspace       ${created_workspace_branding_3}   # 切换到我自己创建的WS
    ...         AND             enter_workspace_settings_page           # 进入settings页面
    ...         AND             turn_on_workspace_directory             # 打开Workspace Directory设置
    ...         AND             close_disable_external_users            # 关闭Disable External Users设置
    ...         AND             expand_workspace_branding_setting       # 展开Workspace Branding设置
    ...         AND             turn_on_workspace_branding_setting      # 打开Workspace Branding设置
    ...         AND             click_to_edit_branding_setting          # Click to edit按钮
    # 获取原先的big logo的src
    ${get_big_logo_src_before}    get element attribute   ${big_logo_img}   src
    ${get_big_logo_src_before}   split_src_img   ${get_big_logo_src_before}
    # 获取原先的Default avatar的src
    ${get_default_avatar_src_before}    get element attribute   ${default_avatar_img}   src
    ${get_default_avatar_src_before}     split_src_img    ${get_default_avatar_src_before}
    # Change big logo     Change Default avatar
    change_branding_big_logo                # Change big logo
    change_branding_default_avatat          # Change Default avatar
    # 获取修改后的big logo的src
    ${get_big_logo_src_after}    get element attribute   ${big_logo_img}   src
    ${get_big_logo_src_after}   split_src_img    ${get_big_logo_src_after}
    # 获取修改后的Default avatar的src
    ${get_default_avatar_src_after}    get element attribute   ${default_avatar_img}   src
    ${get_default_avatar_src_after}    split_src_img    ${get_default_avatar_src_after}
    close_branding_setting                  # Close branding设置
    # VP: Top left corner logo is updated
    ${get_class_value}    get element attribute    ${left_top_big_logo}   style
    ${get_class_value}     split_src_img    ${get_class_value}
    should not contain    ${get_big_logo_src_before}     ${get_class_value}
    should contain    ${get_class_value}   ${get_big_logo_src_after}
    ### 登录操作
    Close    # 退出rf启动的driver
    ${driver1}    driver_set_up_and_logIn    ${site_admin_username}    ${universal_password}
    user_switch_to_second_workspace    ${driver1}     ${WS_branding_setting_WS3}
    ${driver2}    driver_set_up_and_logIn    ${ws3_branding_A_user}    ${universal_password}
    ${driver3}    driver_set_up_and_logIn    ${ws3_branding_C_user}    ${universal_password}
    # Team contacts using default avatar	VP: Test avatar is loaded
    ${get_class_value}    get_ele_class_name    ${driver1}   ${second_data_img}   src
    ${get_class_value}     split_src_img    ${get_class_value}
    should not be equal as strings    ${get_default_avatar_src_before}     ${get_class_value}
    two_option_is_equal    ${driver1}    ${get_default_avatar_src_after}     ${get_class_value}
#    should be equal as strings    ${get_default_avatar_src_after}     ${get_class_value}
    # on-call group's avatar in Team	VP: Test avatar is loaded
    ${get_class_value}    get_ele_class_name    ${driver1}   ${first_data_img}   src
    ${get_class_value}     split_src_img    ${get_class_value}
    should not be equal as strings    ${get_default_avatar_src_before}     ${get_class_value}
    two_option_is_equal    ${driver1}    ${get_default_avatar_src_after}     ${get_class_value}
#    should be equal as strings    ${get_default_avatar_src_after}     ${get_class_value}
    # Personal contacts belong to this site who using default avatar	VP: Test avatar is loaded
    switch_to_diffrent_page   ${driver3}   ${py_personal_page}    ${py_personal_switch_success}    ${py_personal_search_result}
    ${get_class_value}    get_ele_class_name    ${driver3}   //div[@id="user-tabs-pane-2"]//div[@class="ag-center-cols-container"]/div[@row-index="0"]//div[@class="AvatarImageRenderer"]//img    src
    ${get_class_value}     split_src_img    ${get_class_value}
    should not be equal as strings    ${get_default_avatar_src_before}     ${get_class_value}
    two_option_is_equal    ${driver3}    ${get_default_avatar_src_after}     ${get_class_value}
#    should be equal as strings    ${get_default_avatar_src_after}     ${get_class_value}
    # Favorite contacts belong to this site	VP: Test avatar is loaded
    switch_to_diffrent_page   ${driver1}   ${py_favorites_page}   ${py_favorites_switch_success}    ${py_get_number_of_rows}
    ${get_class_value}    get_ele_class_name    ${driver1}   ${first_data_img}   src
    ${get_class_value}     split_src_img    ${get_class_value}
    should not be equal as strings    ${get_default_avatar_src_before}     ${get_class_value}
    two_option_is_equal    ${driver1}    ${get_default_avatar_src_after}     ${get_class_value}
#    should be equal as strings    ${get_default_avatar_src_after}     ${get_class_value}
    # Directory list 	VP: Test avatar is loaded
    switch_to_diffrent_page   ${driver1}   ${py_directory_page}     ${py_directory_switch_success}    ${py_get_number_of_rows}
    ${get_class_value}    get_ele_class_name    ${driver1}   ${first_data_img}   src
    ${get_class_value}     split_src_img    ${get_class_value}
    should not be equal as strings    ${get_default_avatar_src_before}     ${get_class_value}
    two_option_is_equal    ${driver1}    ${get_default_avatar_src_after}     ${get_class_value}
#    should be equal as strings    ${get_default_avatar_src_after}     ${get_class_value}
    # Directory list when invite in a call	VP: Test avatar is loaded
    make_calls_with_who   ${driver1}   ${driver2}   ${ws3_branding_A_username}   no_care
    ${get_class_value}    get_ele_class_name    ${driver1}   ${outgoing_Call_avator}   src
    ${get_class_value}     split_src_img    ${get_class_value}
    should not be equal as strings    ${get_default_avatar_src_before}     ${get_class_value}
    two_option_is_equal    ${driver1}    ${get_default_avatar_src_after}     ${get_class_value}
#    should be equal as strings    ${get_default_avatar_src_after}     ${get_class_value}
    switch_to_other_tab     ${driver1}   ${end_button_before_call}    # 提前End Call
    # Recents belong to this workspace	VP: Test avatar is loaded
    switch_to_diffrent_page   ${driver1}   ${py_recents_page}     ${py_recents_switch_success}    ${py_get_number_of_rows}
    ${get_class_value}    get_ele_class_name    ${driver1}   ${first_data_img}   src
    ${get_class_value}     split_src_img    ${get_class_value}
    should not be equal as strings    ${get_default_avatar_src_before}     ${get_class_value}
    two_option_is_equal    ${driver1}    ${get_default_avatar_src_after}     ${get_class_value}
#    should be equal as strings    ${get_default_avatar_src_after}     ${get_class_value}
    # Call team contact and answer  	team contact invite 3rd participant	   View Contact list 	VP: Test avatar is loaded
    switch_to_diffrent_page   ${driver1}   ${py_contacts_page}     ${py_contacts_switch_success}    ${py_get_number_of_rows}
    make_calls_with_who     ${driver1}    ${driver2}     ${ws3_branding_A_username}
    which_page_is_currently_on    ${driver1}    ${end_call_button}
    enter_contacts_search_user     ${driver1}     ${ws3_branding_A_username}
    ${get_class_value}    get_ele_class_name    ${driver1}   ${first_data_img_in_invite_page}   src
    ${get_class_value}     split_src_img    ${get_class_value}
    should not be equal as strings    ${get_default_avatar_src_before}     ${get_class_value}
    two_option_is_equal    ${driver1}    ${get_default_avatar_src_after}     ${get_class_value}
#    should be equal as strings    ${get_default_avatar_src_after}     ${get_class_value}
    exit_call      ${driver2}
    [Teardown]      run keywords    Close
    ...             AND             exit_driver
#    ...             AND             exit_driver     ${driver1}    ${driver2}

Small_range_1027_1030
    [Documentation]     Turn off feature
    [Tags]    small range 1027-1030 lines       call_case
    [Setup]     run keywords    Login_site_admin
    ...         AND             switch_to_created_workspace       ${created_workspace_branding_3}   # 切换到我自己创建的WS
    ...         AND             enter_workspace_settings_page           # 进入settings页面
    ...         AND             turn_on_workspace_directory             # 打开Workspace Directory设置
    ...         AND             close_disable_external_users            # 关闭Disable External Users设置
    ...         AND             expand_workspace_branding_setting       # 展开Workspace Branding设置
    ...         AND             turn_off_workspace_branding_setting     # 关闭Workspace Branding设置
    ...         AND             Close
    # 登录
    ${driver1}    driver_set_up_and_logIn    ${site_admin_username}    ${universal_password}
    user_switch_to_second_workspace    ${driver1}     ${WS_branding_setting_WS3}
    # VP: Branding name everywhere use Help Lighning
    ${get_ele_text}    get_ele_text    ${driver1}    ${first_tree_text}
    two_option_is_equal    ${driver1}    ${get_ele_text}     MY HELP LIGHTNING
#    should be equal as strings    ${get_ele_text}     MY HELP LIGHTNING
    # VP: left top Logo loaded HelpLightning logo
    ${get_class_value}    get_ele_class_name    ${driver1}   ${left_top_Logo}   style
    Should be empty     ${get_class_value}
    # VP: Color is Help Lightning blue
    ${css_value}   get_css_value   ${driver1}   ${first_data_background_color}    background-color
    two_option_is_equal   ${driver1}    rgba(160, 220, 238, 1)    ${css_value}
#    should be equal as strings    rgba(160, 220, 238, 1)    ${css_value}
    # VP: Default avator use Help Lighning one
    ${get_class_value}    get_ele_class_name    ${driver1}   ${first_data_img}   src
    should start with    ${get_class_value}     ${default_avatar_src}
    [Teardown]      run keywords    Close
    ...             AND             exit_driver
#    ...             AND             exit_driver      ${driver1}

Small_range_1031
    [Documentation]    Turn off feature    User B call user A directly
    [Tags]    small range 1031 line     call_case
    # --------------------------------------------------------------------------------------------------------- #
    # 此处为case执行的前置条件
    # ${created_workspace_branding_3}的Workspace Branding设置为关闭状态
    # --------------------------------------------------------------------------------------------------------- #
    # User A登录
    ${driver1}    driver_set_up_and_logIn    ${ws3_branding_A_user}     ${universal_password}
    # User B登录
    ${driver2}    driver_set_up_and_logIn    ${ws3_branding_B_user}     ${universal_password}
    # User B call user A directly
    make_calls_with_who    ${driver2}   ${driver1}    ${ws3_branding_A_user}   no_anwser
    # VP: User B's outgoing call, it should show WS 1 default Avatar Grey 'H'
    ${get_class_value}    get_ele_class_name    ${driver2}   ${outgoing_Call_avator}   src
    check_a_contains_b    ${driver2}     ${get_class_value}       ${default_avatar_src}
    # User A's incoming call, it should show User B's customer Avatar.
    ${get_class_value}    get_ele_class_name    ${driver1}   ${ingoing_Call_avator}   src
    should start with    ${get_class_value}    ${WS3_User_B_customer_avatar}
    # 接受Call
    user_anwser_call   ${driver1}

    # VP: In-call view is WS1's Default color of Blue for user A and B
    ${css_value}   get_css_value   ${driver1}   ${f2f_mode_I_will_give_help}   color                                # f2f模式的I will give help文本信息
    check_get_color_is_default       ${css_value}
    ${css_value}   get_css_value   ${driver1}   ${f2f_mode_I_need_help}   color                                     # f2f模式的I need help文本信息
    check_get_color_is_default       ${css_value}
    ${css_value}   get_css_value   ${driver1}   ${f2f_mode_Close}   color                                           # f2f模式的Close按钮
    check_get_color_is_default       ${css_value}
    ${css_value}   get_css_value   ${driver2}   ${f2f_mode_I_will_give_help}   color                                # f2f模式的I will give help文本信息
    check_get_color_is_default       ${css_value}
    ${css_value}   get_css_value   ${driver2}   ${f2f_mode_I_need_help}   color                                     # f2f模式的I need help文本信息
    check_get_color_is_default       ${css_value}
    ${css_value}   get_css_value   ${driver2}   ${f2f_mode_Close}   color                                           # f2f模式的Close按钮
    check_get_color_is_default       ${css_value}

    # VP: End Call page use WS1's Default name and Blue for A and B
    exit_call    ${driver2}
    ${get_ele_text}    get_ele_text    ${driver1}    ${end_call_message}
    two_option_is_equal    ${driver1}    ${get_ele_text}       ${default_product_name}
#    should be equal as strings    ${get_ele_text}       ${default_product_name}
    ${css_value}   get_css_value   ${driver1}   ${end_call_message}   color
    check_get_color_is_white       ${css_value}
    ${get_ele_text}    get_ele_text    ${driver2}    ${end_call_message}
    two_option_is_equal    ${driver2}    ${get_ele_text}       ${default_product_name}
#    should be equal as strings    ${get_ele_text}       ${default_product_name}
    ${css_value}   get_css_value   ${driver2}   ${end_call_message}   color
    check_get_color_is_white       ${css_value}

    # 1）Default Color[Blue] for the clouds background color.
    ${get_class_value}    get_ele_class_name    ${driver1}   ${end_call_whole_page}   style                     # 整个页面
    check_a_contains_b    ${driver1}     ${get_class_value}      ${organizer_brand_default_color}
    ${get_class_value}    get_ele_class_name    ${driver2}   ${end_call_whole_page}   style                     # 整个页面
    check_a_contains_b    ${driver2}     ${get_class_value}      ${organizer_brand_default_color}

    # 此处受bug导致：  https://vipaar.atlassian.net/browse/CITRON-3377
#    # 2）Use WS 1's Default Logo Grey 'H' for the company logo above “Thank You for Using Helplightning”.
#    ${get_class_value}    get_ele_class_name    ${driver1}   ${end_call_logo}   src
#    two_option_is_equal    ${driver1}    ${get_class_value}    None
##    should be equal as strings    ${get_class_value}    None
#    ${get_class_value}    get_ele_class_name    ${driver2}   ${end_call_logo}   src
#    two_option_is_equal    ${driver2}    ${get_class_value}    None
##    should be equal as strings    ${get_class_value}    None
    [Teardown]      exit_driver
#    [Teardown]      exit_driver     ${driver1}    ${driver2}

Small_range_1032
    [Documentation]     Turn off feature    User B click A's meeing link
    [Tags]    small range 1032 line     call_case
    # --------------------------------------------------------------------------------------------------------- #
    # 此处为case执行的前置条件
    # ${created_workspace_branding_3}的Workspace Branding设置为关闭状态
    # --------------------------------------------------------------------------------------------------------- #
    # User A登录
    ${driver1}    driver_set_up_and_logIn    ${ws3_branding_A_user}     ${universal_password}
    # User B登录
    ${driver2}    driver_set_up_and_logIn    ${ws3_branding_B_user}     ${universal_password}
    ${invite_url}     send_meeting_room_link    ${driver1}     OTU
    # User B click A's meeing link
    user_make_call_via_meeting_link      ${driver2}    ${invite_url}
    # 确保建立call，但未接听
    make_sure_enter_call    ${driver2}
    # VP: User B's outgoing call, it shoud show WS 1 default Avatar Grey 'H'.
    ${get_class_value}    get_ele_class_name    ${driver2}   ${outgoing_Call_avator}   src
    check_a_contains_b    ${driver2}     ${get_class_value}       ${default_avatar_src}
    # User A's incoming call, it should show User B's customer Avatar.
    ${get_class_value}    get_ele_class_name    ${driver1}   ${ingoing_Call_avator}   src
    should start with    ${get_class_value}    ${WS3_User_B_customer_avatar}
    # 接受Call
    user_anwser_call   ${driver1}
    sleep   20s
    which_page_is_currently_on    ${driver1}    ${end_call_button}

    # VP: In-call view is WS1's Default color of Blue for user A and B
    ${get_class_value}    get_ele_class_name    ${driver2}   ${end_call_whole_page}   style                         # 通话过程中的背景色
    check_a_contains_b    ${driver2}     ${get_class_value}      ${lime_brand_default_color_1}
    ${css_value}   get_css_value   ${driver1}   ${f2f_mode_I_will_give_help}   color                                # f2f模式的I will give help文本信息
    check_get_color_is_default       ${css_value}
    ${css_value}   get_css_value   ${driver1}   ${f2f_mode_I_need_help}   color                                     # f2f模式的I need help文本信息
    check_get_color_is_default       ${css_value}
    ${css_value}   get_css_value   ${driver1}   ${f2f_mode_Close}   color                                           # f2f模式的Close按钮
    check_get_color_is_default       ${css_value}

    # VP: End Call page use WS1's Default name and Blue for A and B
    exit_call    ${driver2}
    ${get_ele_text}    get_ele_text    ${driver1}    ${end_call_message}
    two_option_is_equal    ${driver1}    ${get_ele_text}       ${default_product_name}
#    should be equal as strings    ${get_ele_text}       ${default_product_name}
    ${css_value}   get_css_value   ${driver1}   ${end_call_message}   color
    check_get_color_is_white       ${css_value}
    ${get_ele_text}    get_ele_text    ${driver2}    ${end_call_message}
    two_option_is_equal    ${driver2}    ${get_ele_text}       ${default_product_name}
#    should be equal as strings    ${get_ele_text}       ${default_product_name}
    ${css_value}   get_css_value   ${driver2}   ${end_call_message}   color
    check_get_color_is_white       ${css_value}

    # 1）Default Color[Blue] for the clouds background color.
    ${get_class_value}    get_ele_class_name    ${driver1}   ${end_call_whole_page}   style                     # 整个页面
    check_a_contains_b    ${driver1}     ${get_class_value}         ${organizer_brand_default_color}
    ${get_class_value}    get_ele_class_name    ${driver2}   ${end_call_whole_page}   style                     # 整个页面
    check_a_contains_b    ${driver2}     ${get_class_value}         ${organizer_brand_default_color}

    # 此处受bug导致：  https://vipaar.atlassian.net/browse/CITRON-3377
#    # 2）Use WS 1's Default Logo Grey 'H' for the company logo above “Thank You for Using Helplightning”.
#    ${get_class_value}    get_ele_class_name    ${driver1}   ${end_call_logo}   src
#    two_option_is_equal    ${driver1}    ${get_class_value}    None
##    should be equal as strings    ${get_class_value}    None
#    ${get_class_value}    get_ele_class_name    ${driver2}   ${end_call_logo}   src
#    two_option_is_equal    ${driver2}    ${get_class_value}    None
##    should be equal as strings    ${get_class_value}    None
    [Teardown]      exit_driver
#    [Teardown]      exit_driver     ${driver1}    ${driver2}

Small_range_1033_1035
    [Documentation]     Turn off feature    Anonyoums click B's meeting link
    [Tags]    small range 1033-1035 lines       call_case
    # --------------------------------------------------------------------------------------------------------- #
    # 此处为case执行的前置条件
    # ${created_workspace_branding_3}的Workspace Branding设置为关闭状态
    # --------------------------------------------------------------------------------------------------------- #
    # User B登录
    ${driver1}    driver_set_up_and_logIn    ${ws3_branding_B_user}     ${universal_password}
    ${invite_url}     send_meeting_room_link    ${driver1}     OTU
    # Anonyoums click B's meeting link
    ${driver2}    anonymous_open_meeting_link     ${invite_url}
    # 确保call连接成功，但未接听
    make_sure_enter_call   ${driver2}
    # VP: Anonymous's outgoing call, it should show User B's customer  avatar.
    ${get_class_value}    get_ele_class_name    ${driver2}   ${outgoing_Call_avator}   src
    check_a_contains_b    ${driver2}     ${get_class_value}       ${WS3_User_B_customer_avatar}
    # User B's incoming call, it should show HL Default Avatar [Grey 'H' Logo]
    ${get_class_value}    get_ele_class_name    ${driver1}   ${ingoing_Call_avator}   src
    should start with    ${get_class_value}    ${default_avatar_src}
    # 接受Call
    user_anwser_call   ${driver1}

    # In-call view for B and anonymous is WS1's default color of blue
    ${get_class_value}    get_ele_class_name    ${driver2}   ${end_call_whole_page}   style                         # 通话过程中的背景色
    check_a_contains_b    ${driver2}     ${get_class_value}      ${lime_brand_default_color}
    ${css_value}   get_css_value   ${driver1}   ${f2f_mode_I_will_give_help}   color                                # f2f模式的I will give help文本信息
    check_get_color_is_default       ${css_value}
    ${css_value}   get_css_value   ${driver1}   ${f2f_mode_I_need_help}   color                                     # f2f模式的I need help文本信息
    check_get_color_is_default       ${css_value}
    ${css_value}   get_css_value   ${driver1}   ${f2f_mode_Close}   color                                           # f2f模式的Close按钮
    check_get_color_is_default       ${css_value}

    # VP: End Call page use WS1's default name and blue for B and Anonymous
    exit_call    ${driver2}
    ${get_ele_text}    get_ele_text    ${driver1}    ${end_call_message}
    two_option_is_equal    ${driver1}    ${get_ele_text}       ${default_product_name}
#    should be equal as strings    ${get_ele_text}       ${default_product_name}
    ${css_value}   get_css_value   ${driver1}   ${end_call_message}   color
    check_get_color_is_white       ${css_value}
    ${get_ele_text}    get_ele_text    ${driver2}    ${end_call_message}
    two_option_is_equal    ${driver2}    ${get_ele_text}       ${default_product_name}
#    should be equal as strings    ${get_ele_text}       ${default_product_name}
    ${css_value}   get_css_value   ${driver2}   ${end_call_message}   color
    check_get_color_is_white       ${css_value}

    # 1）Accent Color[Blue] for the clouds background color.
    ${get_class_value}    get_ele_class_name    ${driver1}   ${end_call_whole_page}   style                     # 整个页面
    check_a_contains_b    ${driver1}     ${get_class_value}      ${organizer_brand_default_color}
    ${get_class_value}    get_ele_class_name    ${driver2}   ${end_call_whole_page}   style                     # 整个页面
    check_a_contains_b    ${driver2}     ${get_class_value}      ${organizer_brand_default_color}

    # 此处受bug导致：  https://vipaar.atlassian.net/browse/CITRON-3377
#    # 2）Use WS 1's default Logo for the company logo above “Thank You for Using Helplightning”.
#    ${get_class_value}    get_ele_class_name    ${driver1}   ${end_call_logo}   src
#    two_option_is_equal    ${driver1}    ${get_class_value}    None
##    should be equal as strings    ${get_class_value}    None
#    ${get_class_value}    get_ele_class_name    ${driver2}   ${end_call_logo}   src
#    two_option_is_equal    ${driver2}    ${get_class_value}    None
##    should be equal as strings    ${get_class_value}    None
    [Teardown]      exit_driver
#    [Teardown]      exit_driver     ${driver1}    ${driver2}

Small_range_1036_1043
    [Documentation]     Precondition: Expert Group 1[EG 1] in WS 1. User B is in EG 1.
    [Tags]    small range 1036-1043 lines       call_case
    # --------------------------------------------------------------------------------------------------------- #
    # 此处为case执行的前置条件
    # ${created_workspace_branding_3}的Workspace Branding设置为关闭状态
    # --------------------------------------------------------------------------------------------------------- #
    # User A登录
    ${driver1}    driver_set_up_and_logIn    ${ws3_branding_A_user}     ${universal_password}
    # User B登录
    ${driver2}    driver_set_up_and_logIn    ${ws3_branding_B_user}     ${universal_password}
    # User A directly call EG 1
    make_call_to_onCall     ${driver1}     ${driver2}     ${Expert_Group_1}     no_care
    # VP: User A's outgoing call, it should WS 1's default avatar [Grey 'H'] calls EG 1[the background of expert logo should be WS 1 default accent color of Blue]
    ${get_class_value}    get_ele_class_name    ${driver1}   ${outgoing_Call_avator}   src
    check_a_contains_b    ${driver1}     ${get_class_value}       ${default_avatar_src}
    ${get_class_value}    get_ele_class_name    ${driver1}   ${end_call_whole_page}   style                     # 整个页面
    check_a_contains_b    ${driver1}     ${get_class_value}      ${lime_brand_default_color}
    # User B receives this call,VP: User B's incoming call, it should WS 1' s default avatar Grey 'H'
    ${get_class_value}    get_ele_class_name    ${driver2}   ${ingoing_Call_avator}   src
    should start with    ${get_class_value}    ${default_avatar_src}
    # Enter call
    user_anwser_call     ${driver2}
    # VP: In-call view is WS1's default color of Blue for user A and B
    ${get_class_value}    get_ele_class_name    ${driver1}   ${end_call_whole_page}   style                         # 通话过程中的背景色
    check_a_contains_b    ${driver1}     ${get_class_value}      ${lime_brand_default_color}
    ${get_class_value}    get_ele_class_name    ${driver2}   ${end_call_whole_page}   style                         # 通话过程中的背景色
    check_a_contains_b    ${driver2}     ${get_class_value}      ${lime_brand_default_color}
    # End call
    exit_call     ${driver2}
    # VP: End Call page use WS1's default name and Blue for A and B
    ${get_ele_text}    get_ele_text    ${driver1}    ${end_call_message}
    two_option_is_equal    ${driver1}    ${get_ele_text}       ${default_product_name}
#    should be equal as strings    ${get_ele_text}       ${default_product_name}
    ${css_value}   get_css_value   ${driver1}   ${end_call_message}   color
    check_get_color_is_white       ${css_value}
    ${get_ele_text}    get_ele_text    ${driver2}    ${end_call_message}
    two_option_is_equal    ${driver2}    ${get_ele_text}       ${default_product_name}
#    should be equal as strings    ${get_ele_text}       ${default_product_name}
    ${css_value}   get_css_value   ${driver2}   ${end_call_message}   color
    check_get_color_is_white       ${css_value}
    # 1）Accent Color[Blue] for the clouds background color.
    ${get_class_value}    get_ele_class_name    ${driver1}   ${end_call_whole_page}   style                     # 整个页面
    check_a_contains_b    ${driver1}     ${get_class_value}      ${organizer_brand_default_color}
    ${get_class_value}    get_ele_class_name    ${driver2}   ${end_call_whole_page}   style                     # 整个页面
    check_a_contains_b    ${driver2}     ${get_class_value}      ${organizer_brand_default_color}

    # 此处受bug导致：  https://vipaar.atlassian.net/browse/CITRON-3377
#    # 2）Use WS 1's default Logo for the company logo above “Thank You for Using Helplightning”.
#    ${get_class_value}    get_ele_class_name    ${driver1}   ${end_call_logo}   src
#    two_option_is_equal    ${driver1}    ${get_class_value}    None
##    should be equal as strings    ${get_class_value}    None
#    ${get_class_value}    get_ele_class_name    ${driver2}   ${end_call_logo}   src
#    two_option_is_equal    ${driver2}    ${get_class_value}    None
##    should be equal as strings    ${get_class_value}    None
    # Anonymous clicks EG's universal link
    close_call_ending_page    ${driver2}
    ${driver3}    anonymous_open_meeting_link     https://app-stage.helplightning.net.cn/help?enterprise_id=6788&group_id=10997&group_name=Expert_Group_1
    # 确保call连接成功，但未接听
    make_sure_enter_call   ${driver3}
    # VP: Anonymous's outgoing call, it should HL Default Avatar [Grey 'H' Logo] calls EG 1[the background of expert logo should be WS 1 default color Blue]
    ${get_class_value}    get_ele_class_name    ${driver3}   ${outgoing_Call_avator}   src
    check_a_contains_b    ${driver3}     ${get_class_value}       ${default_avatar_src}
    ${get_class_value}    get_ele_class_name    ${driver3}   ${end_call_whole_page}   style                     # 整个页面
    check_a_contains_b    ${driver3}     ${get_class_value}      ${lime_brand_default_color}
    # User B receives this call，VP: User B's incoming call, it should be HL Default Avatar [Grey 'H' Logo].
    ${get_class_value}    get_ele_class_name    ${driver2}   ${ingoing_Call_avator}   src
    check_a_contains_b    ${driver2}     ${get_class_value}       ${default_avatar_src}
    # Enter call，VP: In-call view is WS1's default color of blue for Anonymous and User B
    user_anwser_call     ${driver2}
    sleep   10s
    ${get_class_value}    get_ele_class_name    ${driver2}   ${end_call_whole_page}   style                         # 通话过程中的背景色
    check_a_contains_b    ${driver2}     ${get_class_value}      ${lime_brand_default_color_1}
    ${get_class_value}    get_ele_class_name    ${driver3}   ${end_call_whole_page}   style                         # 通话过程中的背景色
    check_a_contains_b    ${driver3}     ${get_class_value}      ${lime_brand_default_color_1}
    # End call
    exit_call   ${driver3}
    # VP: End Call page use WS1's default name and blue for Anonymous and User B
    ${get_ele_text}    get_ele_text    ${driver2}    ${end_call_message}
    two_option_is_equal    ${driver2}    ${get_ele_text}       ${default_product_name}
#    should be equal as strings    ${get_ele_text}       ${default_product_name}
    ${css_value}   get_css_value   ${driver2}   ${end_call_message}   color
    check_get_color_is_white       ${css_value}
    ${get_ele_text}    get_ele_text    ${driver3}    ${end_call_message}
    two_option_is_equal    ${driver3}    ${get_ele_text}       ${default_product_name}
#    should be equal as strings    ${get_ele_text}       ${default_product_name}
    ${css_value}   get_css_value   ${driver3}   ${end_call_message}   color
    check_get_color_is_white       ${css_value}
    # 1）Accent Color[Blue] for the clouds background color.
    ${get_class_value}    get_ele_class_name    ${driver2}   ${end_call_whole_page}   style                     # 整个页面
    check_a_contains_b    ${driver2}     ${get_class_value}      ${organizer_brand_default_color}
    ${get_class_value}    get_ele_class_name    ${driver3}   ${end_call_whole_page}   style                     # 整个页面
    check_a_contains_b    ${driver3}     ${get_class_value}      ${organizer_brand_default_color}

    # 此处受bug导致：  https://vipaar.atlassian.net/browse/CITRON-3377
#    # 2）Use WS 1's default Logo for the company logo above “Thank You for Using Helplightning”.
#    ${get_class_value}    get_ele_class_name    ${driver2}   ${end_call_logo}   src
#    two_option_is_equal    ${driver2}    ${get_class_value}    None
##    should be equal as strings    ${get_class_value}    None
#    ${get_class_value}    get_ele_class_name    ${driver3}   ${end_call_logo}   src
#    two_option_is_equal    ${driver3}    ${get_class_value}    None
##    should be equal as strings    ${get_class_value}    None
    [Teardown]      exit_driver
#    [Teardown]      exit_driver     ${driver1}    ${driver2}    ${driver3}