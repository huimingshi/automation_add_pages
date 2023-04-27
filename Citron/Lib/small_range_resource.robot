*** Settings ***
Library           Collections
Library           Selenium2Library
Library           DateTime
Library           String
Resource          public.robot
Resource          All_Pages_Xpath/public_xpath.robot
Resource          All_Pages_Xpath/My_Account.robot
Resource          All_Pages_Xpath/crunch_page.robot
Resource          All_Pages_Xpath/SITE_Admin/Users.robot
Resource          All_Pages_Xpath/WS_Admin/Groups.robot
Resource          All_Pages_Xpath/WS_Admin/Users.robot
Resource          All_Pages_Xpath/WS_Admin/Workspace_Settings.robot
Resource          All_Pages_Xpath/Normal/Contacts.robot
Resource          All_Pages_Xpath/Normal/Recents.robot
Library           python_Lib/ui_keywords.py
Library           python_Lib/obtain_outlook_email_link.py


*** Keywords ***
user_login_citron_without_close_tutorial
    [Arguments]  ${username}
    # 登录系统
    Login    ${username}    ${public_pass}
    FOR   ${i}    IN RANGE   0    8
        ${count}   get element count   ${accept_button}
        Run Keyword If    '${count}'=='1'    click element   ${accept_button}
        Exit For Loop If    '${count}'=='1'
        Run Keyword If   '${count}'=='0'    sleep   1s
    END
    # 等待Torturial弹框出现弹框
    wait until element is visible    ${button_of_popup}     20

user_login_citron_without_accept_disclaimer
    [Arguments]  ${username}
    # 登录系统
    Login    ${username}    ${public_pass}
    sleep    1s

login_page_without_user_info
    # login page without user's info
    ${get_value}    get element attribute   ${loginname_input}   value
    should be empty   ${get_value}

erased_user_re_login
    [Arguments]    ${user_email}
    # User A relogs in, VP: Alert hasn't User A account
    # 输入用户名
    click element   ${loginname_input}
    sleep  0.5s
    input text   ${loginname_input}   ${user_email}
    sleep  0.5s
    # Next
    click element   xpath=//button[@type="submit" and text()='Next']
    wait until element is visible   ${loginpsd_input}
    # 输入密码
    click element   ${loginpsd_input}
    sleep  0.5s
    input text   ${loginpsd_input}   ${universal_password}
    sleep  0.5s
    # 点击Log In
    click element  xpath=//button[@type="submit" and text()='Log In']
    wait until element is visible   xpath=//span[text()='Authentication Failed']

check_appear_disclaimer
    # 检查是否出现Disclaimer
    wait until element is visible   ${accept_button}

click_decline_disclaimer
    # DECLINE disclaimer
    click element   xpath=//button[text()='DECLINE']
    sleep   2s

click_accept_disclaimer
    # ACCEPT disclaimer
    click element   xpath=//button[text()='ACCEPT']
    sleep   2s

close_tutorial
    # 关闭导航页面
    Wait Until Page Contains    ${log_in_success_tag}
    click element    ${button_of_popup}
    sleep   1s

users_successfully_login
    # User should successfully log in App.
    wait until element is visible   ${currentAccount_button}     20s

user_login_without_disclaimer
    sleep  2s
    # User auto-logs in App without Disclaimer window.
    ${count}    get element count   ${accept_button}
    should be equal as strings   ${count}   0

alert_appear_after_click_decline_disclaimer
    # 点击DECLINE disclaimer之后会出现确认框
    element should be visible    ${erase_my_account}
    element should be visible    ${cancel_erase_my_account}
    element should be visible    xpath=//p[text()="This will erase all my personal data."]

alert_appear_after_click_erase_my_account
    # 点击Erase My Account之后会出现确认框
    element should be visible    ${erase_my_account}
    element should be visible    ${cancel_erase_my_account}
    element should be visible    xpath=//p[text()="Are you sure you want to continue? Your account and your personal data will be erased. This cannot be undone."]

cancel_erase_my_account
    # 点击Cancel
    click element  ${cancel_erase_my_account}
    sleep   2s

confirm_erase_my_account
    # 点击Erase My Account
    click element  ${erase_my_account}
    sleep   2s

refresh_browser_tutorial
    Execute JavaScript    window.location.reload()
    sleep  5s
    Wait Until Page Contains    ${log_in_success_tag}    20
    wait until element is visible   ${let_go_button}    20

click_next_until_last_page
    # click Let's ge button
    click element   ${let_go_button}
    sleep  1s
    # click Next button
    FOR   ${i}   IN RANGE   3
        click element  ${tutorial_next_button}
        sleep  1s
    END
    # until the last page
    element should be visible   ${get_started_button}

last_page_click_get_started
    # Clicks 'Next' button until the last page
    click_next_until_last_page
    # Last page	Clicks 'Get Started' button
    click element      ${get_started_button}
    wait until page does not contain   ${log_in_success_tag}    20
    sleep   5s

log_out_from_citron
    # log out
    wait until element is visible  ${current_account_xpath}
    click element   ${current_account_xpath}
    sleep  1s
    click element   xpath=//i[@class="fa fa-sign-out"]
    sleep  1s

re_log_in_citron
    [Arguments]   ${username}
    # 输入账号
    Input Text    ${loginname_input}    ${username}
    Sleep    1s
    # 点击NEXT
    Click Button    ${next_button}
    Sleep    1s
    Input Password    ${loginpsd_input}    ${public_pass}
    Sleep    1s
    # 点击LOG IN
    Click Button    ${login_button}
    Sleep    4s
    ${count}  get element count  ${accept_button}
    Run Keyword If   '${count}'=='1'    click element   ${accept_button}
    sleep  3s

no_tutorial
    # there is no tutorial
    wait until page does not contain      ${log_in_success_tag}    20

re_log_in_citron_no_tutorial
    [Arguments]   ${username}
    # re log in citron
    re_log_in_citron  ${username}
    # there is no tutorial
    no_tutorial

open_citron_without_password
    [Arguments]    ${username}
    Open Browser    ${citron_website}     ${browser_type}
    Sleep    1s
    Maximize Browser Window
    Sleep    1s
    # 输入账号
    Input Text    ${loginname_input}    ${username}
    Sleep    1s
    # 点击NEXT
    Click Button    ${next_button}
    Sleep    1s

send_reset_password_email
    # click Forget Password button
    click element   ${forget_password}
    wait until element is visible   ${send_reset_password_email}
    click element   ${send_reset_password_email}
    wait until element is visible   ${prompt_information}

change_my_password
    # Switch to the second Windows page
    switch_window_to_second
    sleep  0.5s
    #  enter password
    click element  ${input_passwd}
    sleep  0.5s
    input text  ${input_passwd}   abcdefh1
    sleep  0.5s
    # confirm password
    click element  ${input_passwordConfirm}
    sleep  0.5
    input text  ${input_passwordConfirm}   abcdefh1
    sleep  0.5s
    click element   ${chage_passwd_button}
    sleep  0.5s
    wait until element is visible     ${prompt_information}
    ${text}   get text   ${prompt_information}
    should be equal as strings   ${text}   Your password must be at least 8 characters, include a number, an uppercase letter, and a lowercase letter

enter_a_wrong_password
    sleep  20s
    ${email_link}   get_email_link   Change My Password:
    should contain   ${email_link}    ${Citron_web_url}
    # Open another Windows window
    Execute JavaScript    window.open('${email_link}')
    sleep  2s
    # 7 lowercase letters & 1 number
    change_my_password

enter_my_account_page
    click element   ${current_account_xpath}
    sleep  1s
    click element   xpath=//span[contains(.,'My Account')]
    wait until element is visible   xpath=//label[contains(.,'Mobile Phone')]

check_my_account_elements_location
    ${text}   get text   xpath=//div[@class="MyAccountTab content"]//input[@value="helplightning"]/../div[1]
    should be equal as strings   ${text}    Name
    ${text}   get text   xpath=//div[@class="MyAccountTab content"]//input[@value="helplightning"]/../div[2]
    should be equal as strings   ${text}    Title
    ${text}   get text   xpath=//div[@class="MyAccountTab content"]//input[@value="helplightning"]/../div[3]
    should be equal as strings   ${text}    Location
    ${text}   get text   xpath=//div[@class="MyAccountTab content"]//input[@value="helplightning"]/../div[4]
    should be equal as strings   ${text}    Mobile Phone

get_random_number
    ${random}   evaluate    int(time.time()*1000000)    time
    [Return]   ${random}

update_my_account_fields
    ${random}  get_random_number
    # update Name
    input text   ${my_account_name_input}   ${random}
    sleep  0.5s
    # update Title
    input text   ${my_account_title_input}  ${random}
    sleep  0.5s
    # update Location
    input text   ${my_account_location_input}   ${random}
    sleep  0.5s
    [Return]   ${random}

enter_phone_with_country_code
    [Arguments]   ${phone_number}   ${count}   ${cancel_or_confirm}
    # click Mobile Phone
    clear element text   ${mobile_phone_input}
    sleep  0.5s
    FOR   ${i}   IN RANGE   2
        Press Key    ${mobile_phone_input}    \\8
    sleep  0.5s
    END
    press key    ${mobile_phone_input}    ${phone_number}
    sleep  1s
    Run Keyword If   '${count}'=='1'    element should be visible    ${wrong_phone_tag}
    ...  ELSE IF  '${count}'=='0'    element should not be visible      ${wrong_phone_tag}
    Run Keyword If   '${cancel_or_confirm}'=='confirm'     click element    ${my_account_update_button}

my_account_fields_saved_successfully
    [Arguments]   ${random}
    # message appear after click Update User button
    wait until element is visible   ${message_text}
    ${text}   get text   ${message_text}
    should be equal as strings   ${text}   Updated settings sucessfully
    # others fields without Phone modify successfully
    ${get_attribute}   get element attribute   ${my_account_name_input}  value
    should be equal as strings   ${random}   ${get_attribute}
    ${get_attribute}   get element attribute   ${my_account_title_input}  value
    should be equal as strings   ${random}   ${get_attribute}
    ${get_attribute}   get element attribute   ${my_account_location_input}  value
    should be equal as strings   ${random}   ${get_attribute}

enter_enterprises_audit_log
    # enter crunch Audit Logs page
    click element    ${audit_log_menu}
    wait until element is visible     ${audit_log_table}//tr[2]     20s
    sleep  2s

enter_workspace_settings_page
    # click workspace ADMINISTRATION page menu
    click element   ${enter_workspace_menu}
    sleep  1s
    # click Settings page menu
    click element  ${enter_Workspace_settings}
    sleep  2s
    # Wait until enter page
    wait until element is visible   ${enter_ws_settings_success}    20

enter_workspace_groups_page
    # click workspace ADMINISTRATION page menu
    click element   ${enter_workspace_menu}
    sleep  1s
    # click Groups page menu
    click element  ${enter_groups}
    # Wait until enter page
    wait until element is visible   ${switch_to_groups_success}
    wait until element is visible   ${second_data_show}

enter_workspace_users_page
    # click workspace ADMINISTRATION page menu
    click element   ${enter_workspace_menu}
    sleep  1s
    # click Users page menu
    click element  ${enter_users}
    sleep  2s
    # Wait until enter page
    wait until element is visible   ${first_line_username}

enter_site_users_page
    # click SITE ADMINISTRATION page menu
    click element   ${enter_site_menu}
    sleep  1s
    # click Users page menu
    click element  ${enter_users}
    sleep  2s
    # Wait until enter page
    wait until element is visible   ${first_line_username}

enter_users_deactive_user
    # 进入Deactive User页面
    click element    xpath=//span[text()="Deactivated Users"]
    sleep  4s

enter_users_invitations
    # 进入Invitations页面
    click element    xpath=//span[text()="Invitations"]
    sleep  4s

turn_on_user_directory
    ${count}  get element count   ${directory_turn_on}
    Run Keyword If   '${count}'=='1'    click element   ${directory_switch_button}
    sleep  2s

turn_off_user_directory
    ${count}  get element count   ${directory_turn_off}
    Run Keyword If   '${count}'=='1'    click element   ${directory_switch_button}
    sleep  2s

show_the_directory_tab_on_the_dock
    [Arguments]    ${expect_count}
    ${count}   get element count    ${enter_directory_page}
    should be equal as integers    ${count}   ${expect_count}

expand_workspaces_switch
    # Expand workspace
    click element   ${expand_workspace_button}
    sleep  2s

show_first_workspace_name
    # VP: App show first workspace name of workspace options
    ${workspace_text_1}   get text   xpath=//span[@role="listbox"]//i/../span
    # Expand workspace
    expand_workspaces_switch
    ${workspace_text_2}   get text    ${first_WS_xpath}
    should be equal as strings  ${workspace_text_1}  ${workspace_text_2}
    # Expand workspace
    expand_workspaces_switch

make_user_belong_to_three_WS
    [Arguments]   ${second_WS}   ${third_WS}
    ### 使得user属于三个WS
    click element    ${add_WS_xpath}
    sleep  1s
    # 添加第二个WS
    click element   xpath=//ul[@role="listbox"]/li[contains(.,"${second_WS}")]
    # 再点击
    click element    ${add_WS_xpath}
    sleep  1s
    # 添加第二个WS
    click element   xpath=//ul[@role="listbox"]/li[contains(.,"${third_WS}")]
    # Update User
    click element    ${update_user_button}
    wait until element is visible      ${message_text}

all_WS_show_in_option_list
    [Arguments]     ${WS_count}
    # Expand workspace
    expand_workspaces_switch
    # VP: WS1, WS2 and WS3 still show in the option list, even disclaimer is declined
    ${option_count}   get element count    xpath=//div[@class="k-list-scroller"]//li
    should be equal as strings   ${option_count}   ${WS_count}
    # 获取具体的WS
    @{WSList}=    Create List
    FOR   ${i}   IN RANGE   ${option_count}
        ${get_WS_text}   get text    xpath=//div[@unselectable="on"]//li[${i}+1]
        Append To List    ${WSList}    ${get_WS_text}
    END
    [Return]     ${WSList}

switch_to_third_workspace
    # Expand workspace
    expand_workspaces_switch
    # choose third workspace
    click element   ${Slytherin_workspace}
    sleep  3
    element should be visible   xpath=//div[@class="workspace-dropdown-container"]//span[contains(.,"Slytherin ")]
    ${ele_count}     get element count    ${accept_disclaimer}
    Run Keyword If   '${ele_count}'=='1'    click element    ${accept_disclaimer}

switch_to_second_workspace
    # Expand workspace
    expand_workspaces_switch
    # choose second workspace
    click element   ${Canada_workspace}
    sleep  3
    element should be visible   xpath=//div[@class="workspace-dropdown-container"]//span[contains(.,"Canada")]
    ${ele_count}     get element count    ${accept_disclaimer}
    Run Keyword If   '${ele_count}'=='1'    click element    ${accept_disclaimer}

switch_to_created_workspace
    [Arguments]   ${witch_created_WS}
    # Expand workspace
    expand_workspaces_switch
    # choose second workspace
    click element   ${witch_created_WS}
    sleep  3
    ${ele_count}     get element count    ${accept_disclaimer}
    Run Keyword If   '${ele_count}'=='1'    click element    ${accept_disclaimer}

switch_to_first_workspace
    # Expand workspace
    click element   ${expand_workspace_button}
    sleep  1s
    click element  ${first_WS_xpath}
    sleep  3
    ${ele_count}     get element count    ${accept_disclaimer}
    Run Keyword If   '${ele_count}'=='1'    click element    ${accept_disclaimer}

switch_workspace_check_user
    [Arguments]   ${first_line_user_xpath}
    # first workspace data list
    ${text_1}   get text    ${first_line_user_xpath}
    # switch to second workspace
    switch_to_second_workspace
    sleep   3s
    wait until element is visible   ${ellipsis_menu_div}
    # second workspace data list
    ${text_2}   get text   ${first_line_user_xpath}
    should not be equal as strings   ${text_1}   ${text_2}
    # back to first workspace
    back_to_first_workspace

switch_workspace_check_recents_list
    # first workspace team user
    ${text_1}   get text    ${recents_first_call}
    # switch to second workspace
    switch_to_second_workspace
    sleep   5s
    wait until element is visible   ${recents_first_call}     20
    # second workspace team user
    ${text_2}   get text   ${recents_first_call}
    should not be equal as strings   ${text_1}   ${text_2}

back_to_first_workspace
    # Expand workspace
    click element   ${expand_workspace_button}
    sleep  1s
    click element  ${first_WS_xpath}
    sleep  3s
    wait until element is visible   ${ellipsis_menu_div}

enter_contacts_page
    # enter first mune
    click element    ${enter_first_menu_tree}
    sleep  1s
    # click Contacts page
    click element   ${enter_contacts_page}
    sleep   3s
    wait until element is visible     ${team_first_data_show}

enter_personal_contact_page
    # enter Personal contact page
    click element    ${enter_personal_page}
    sleep  3s
    wait until element is visible   ${personal_first_data_show}

enter_favorites_page
    # enter favorite page
    wait until element is visible   ${enter_favorites_page}
    click element   ${enter_favorites_page}
    sleep  4s

enter_recents_page
    # enter recents page
    wait until element is visible   ${enter_recents}
    click element   ${enter_recents}
    sleep  2s
    wait until element is visible   ${second_data_show}

back_to_directory_page
    # enter Contacts page
    enter_contacts_page
    # enter directory page
    wait until element is visible   ${enter_directory_page}
    click element   ${enter_directory_page}
    sleep  2s
    wait until element is visible   ${directory_first_data_show}

switch_workspace_check_directory
    # first workspace data list
    @{NameList_A}=    Create List
    FOR   ${i}   IN RANGE  1   11
        ${get_name_text}   get text    ${directory_page_id}//div[@row-index="${i}"]//div[@class="cardName"]
        Append To List    ${NameList_A}    ${get_name_text}
    END
    log to console   ${NameList_A}
    # switch to second workspace
    switch_to_second_workspace
    sleep   3s
    wait until element is visible   ${directory_first_data_show}
    # second workspace data list
    @{NameList_B}=    Create List
    FOR   ${i}   IN RANGE  1   11
        ${get_name_text}   get text    ${directory_page_id}//div[@row-index="${i}"]//div[@class="cardName"]
        Append To List    ${NameList_B}    ${get_name_text}
    END
    log to console   ${NameList_B}
    ${result}   two lists are identical  ${NameList_A}   ${NameList_B}
    should be equal as strings   ${result}   The two lists are not exactly the same

open_disable_external_users
    ${count}   get element count   ${disable_external_users}//div[@class="react-toggle"]
    Run Keyword If   '${count}'=='1'    click element   ${disable_external_users}//div[@class="react-toggle-track"]
    sleep  2s

close_disable_external_users
    ${count}   get element count   ${disable_external_users}//div[@class="react-toggle react-toggle--checked"]
    Run Keyword If   '${count}'=='1'   click element    ${disable_external_users}//div[@class="react-toggle-track"]
    sleep  2s

make_sure_workspaces_disable_external_feature
    [Arguments]   ${setting_1}   ${setting_2}
    # enter first workspace workspace setting
    enter_workspace_settings_page
    # workspace WS1 has "Disable External Feature"=ON or OFF
    Run Keyword If   '${setting_1}'=='open_feature'    open_disable_external_users
    ...  ELSE IF  '${setting_1}'=='close_feature'    close_disable_external_users
    # switch to second workspace
    switch_to_second_workspace
    # enter second workspace workspace setting
    enter_workspace_settings_page
    # workspace WS2 has "Disable External Feature"=ON or OFF
    Run Keyword If   '${setting_2}'=='open_feature'    open_disable_external_users
    ...  ELSE IF  '${setting_2}'=='close_feature'    close_disable_external_users
    # back to first workspace
    switch_to_first_workspace

external_user_is_invisible
    # search
    click element    ${search_input}
    sleep  0.5s
    input text  ${search_input}   Huiming.shi.helplightning+1635818847082899
    sleep  2s
    # check result
    ${count}    get element count    ${get_count_of_favorites}
    should be equal as integers    ${count}    0

external_call_record_is_invisible
    # get record list
    @{record_list}=    Create List
    ${count}  get element count   ${get_number_of_rows}
    FOR   ${i}   IN RANGE   ${count}
        ${get_name_text}   get text    xpath=//div[@class="ag-center-cols-container"]/div[@row-index="${i}"]//div[@class="cardName"]
        Append To List    ${record_list}    ${get_name_text}
    END
    log to console   ${record_list}
    # check
    list should not contain value    ${record_list}    ${normal_username_for_calls_name}

enter_directory_page
#    # enter first menu tree
#    click element   ${enter_first_menu_tree}
    # enter Directory page
    wait until element is visible   ${enter_directory_page}
    click element   ${enter_directory_page}
    sleep   5s
    wait until element is visible   ${second_data_show}

page_search
    [Arguments]   ${search_text}   ${search_result}
    clear element text  ${search_input}
    sleep  0.5s
    wait until element is not visible   ${prompt_information}    20s
    click element  ${search_input}
    sleep  0.5s
    input text   ${search_input}   ${search_text}
    sleep  5s
    ${count}   get element count   ${get_number_of_rows}
    should be equal as integers   ${count}    ${search_result}

team_page_search
    [Arguments]   ${search_text}   ${search_result}
    clear element text  ${team_search_input}
    sleep  0.5s
    click element  ${team_search_input}
    sleep  0.5s
    input text   ${team_search_input}   ${search_text}
    sleep  5s
    ${count}   get element count   ${team_search_count}
    should be equal as integers   ${count}    ${search_result}

favorites_page_search
    [Arguments]   ${search_text}   ${search_result}
    clear element text  ${favorites_search_input}
    sleep  0.5s
    click element  ${favorites_search_input}
    sleep  0.5s
    input text   ${favorites_search_input}   ${search_text}
    sleep  5s
    ${count}   get element count   ${favorites_search_count}
    should be equal as integers   ${count}    ${search_result}

directory_page_search
    [Arguments]   ${search_text}   ${search_result}
    clear element text  ${directory_search_input}
    sleep  0.5s
    click element  ${directory_search_input}
    sleep  0.5s
    input text   ${directory_search_input}   ${search_text}
    sleep  5s
    ${count}   get element count   ${directory_search_count}
    should be equal as integers   ${count}    ${search_result}

personal_page_search
    [Arguments]   ${search_text}   ${search_result}
    clear element text  ${personal_search_input}
    sleep  0.5s
    click element  ${personal_search_input}
    sleep  0.5s
    input text   ${personal_search_input}   ${search_text}
    sleep  5s
    ${count}   get element count   ${personal_search_count}
    should be equal as integers   ${count}    ${search_result}

#team_page_search
#    [Arguments]   ${search_text}   ${search_result}
#    click element   ${team_search_input}
#    sleep  0.5s
#    input text   ${team_search_input}   ${search_text}
#    sleep  3s
#    ${count}   get element count     ${team_search_result}
#    should be equal as integers   ${count}    ${search_result}

#personal_page_search
#    [Arguments]   ${search_text}   ${search_result}
#    click element   ${personal_search_input}
#    sleep  0.5s
#    input text   ${personal_search_input}   ${search_text}
#    sleep  3s
#    ${count}   get element count    ${personal_search_result}
#    should be equal as integers   ${count}    ${search_result}

click_Users_user_details
    # click Details button
    click element  ${user_details_button}
    wait until element is visible   ${update_user_button}

directory_search_with_name_title_location
    # Search with name
    directory_page_search     hlnauto+apple4  1
    # Search with title
    clear element text   ${directory_search_input}
    sleep  0.5s
    directory_page_search   fruit man4  1
    # Search with location
    clear element text   ${directory_search_input}
    sleep  0.5s
    directory_page_search   vb  1
    # Title and location should show under user's name if contact has title or location.
    ${text}   get text   ${directory_page_id}//div[@class="cardName"]
    should contain   ${text}   hlnauto+apple4
    ${text}   get text   ${directory_page_id}//div[@class="text-muted cardSub"][1]
    should be equal as strings   ${text}   fruit man4
    ${text}   get text   ${directory_page_id}//div[@class="text-muted cardSub"][2]
    should be equal as strings   ${text}   vb

Unfavorite_the_contact_in_favorite_tab
    # make sure user is unfavorite
    ${attribute}   get element attribute   ${favorite_or_not}    class
    Run Keyword If   '${attribute}'=='fas fa-star favoriteIcon star-on'    click element    ${favorite_or_not}
    sleep  1s
    # Favorite one contact
    click element   ${favorite_or_not}
    sleep  1s
    # enter Favorites page
    click element  ${enter_favorites_page}
    sleep  2s
    wait until element is visible   ${favorites_first_data_show}
    # search result after favorite
    favorites_page_search   hlnauto+apple4   1

Unfavorite_the_contact_in_Directory_view
    # enter Directory page
    click element  ${enter_directory_page}
    sleep  2s
    wait until element is visible   ${directory_first_data_show}
    # search favorite user
    directory_page_search   hlnauto+apple4   1
    # unfavorite contact
    click element    ${favorite_or_not}
    sleep  1s
    # check result after unfavorite
    clear element text   ${directory_search_input}
    sleep  0.5s
    directory_page_search   hlnauto+apple4   1
    ${attribute}   get element attribute   ${favorite_or_not}    class
    should be equal as strings  ${attribute}     fal fa-star favoriteIcon star-off

team_search_with_name_title_location
    # Search with name
    team_page_search   hlnauto+mao4cd  1
    # Search with title
    clear element text  ${team_search_input}
    sleep  0.5s
    team_page_search   vv c    1
    # Search with location
    clear element text  ${team_search_input}
    sleep  0.5s
    team_page_search   dd f    1

personal_search_with_name_title_location
    # enter personal page
    click element  ${enter_personal_page}
    sleep  3s
    # Search with name
    personal_page_search   ${hlnauto_p1}  1
    # Search with title
    clear element text  ${personal_search_input}
    sleep  0.5s
    personal_page_search   Dolphin    1
    # Search with location
    clear element text  ${personal_search_input}
    sleep  0.5s
    personal_page_search   Sea    1

favorite_search_with_name_title_location
    # Search with name
    favorites_page_search   ${hlnauto_p1}  1
    # Search with title
    clear element text  ${favorites_search_input}
    sleep  0.5s
    favorites_page_search   Dolphin    1
    # Search with location
    clear element text  ${favorites_search_input}
    sleep  0.5s
    favorites_page_search   Sea    1

check_three_field_position
    ${text}   get text   xpath=//div[@class="cardName" and @title="${normal_username_for_calls_name}"]
    should be equal as strings   ${text}    ${normal_username_for_calls_name}
    ${text}   get text   xpath=//div[@class="cardName" and @title="${normal_username_for_calls_name}"]/../div[2]
    should be equal as strings   ${text}    请勿动该账号，自动化测试专用账号
    ${text}   get text   xpath=//div[@class="cardName" and @title="${normal_username_for_calls_name}"]/../div[3]
    should be equal as strings   ${text}    请勿动该账号，自动化测试专用账号

click_add_user
    # click button of add user
    click element  ${button_add_user}
    sleep  2s

fill_basic_message
    [Arguments]  ${random}
    # Enter email
    click element  ${input_email}
    sleep  1s
    ${email_before}   Catenate   SEPARATOR=+   ${my_existent_email_name}  ${random}
    ${email}    Catenate   SEPARATOR=   ${email_before}    @outlook.com
    input text  ${input_email}    ${email}
    sleep  0.5s
    # Enter name
    click element  ${name_input}
    sleep  1s
    input text   ${name_input}   ${random}
    sleep  0.5s
    # Enter title
    click element   ${title_input}
    sleep  1s
    input text  ${title_input}   ${random}
    sleep  0.5s
    # Enter Location
    click element   ${location_input}
    sleep  1s
    input text  ${location_input}   ${random}
    sleep  0.5s
    [Return]    ${email}

add_normal_user
    [Arguments]  ${username}
    # click ADD USER button
    click_add_user
    # fill basic message
    ${email}   fill_basic_message   ${username}
    # Enter groups
    click element   ${groups_input}
    sleep  1s
    click element   xpath=//div[@unselectable="on"]//li[1]
    sleep  0.5s
    click element   ${button_ADD}
    sleep  1s
    # Check prompt Information
    wait until element is visible    ${prompt_information}      #  message of Add Success
    wait until element is not visible   ${prompt_information}    20s
    [Return]  ${email}

get_user_info
    [Arguments]   ${username}    ${expect_src}
    ${username}   evaluate   str(${username})
    # get avator
    ${get_avator}  get element attribute   ${team_first_data_show}//img   src
    should start with   ${get_avator}   ${expect_src}
    # get name
    ${get_name}  get text  ${team_first_data_show}//div[@class="cardName"]
    should contain   ${get_name}   ${username}

modify_user_name_avator
    [Arguments]   ${username_new}
    # click Details button
    click_Users_user_details
    # modify user name & Avatar
    # upload Avatar
    ${modify_picture_path}   get_modify_picture_path
    wait until element is visible    ${upload_avatar_button}      20
    Choose file    ${button_Upload}     ${modify_picture_path}
    sleep  0.5s
    wait until element is visible    ${button_Remove}
    sleep  0.5s
    # modify Name
    Press Key    ${name_input}    \\8
    sleep  0.5s
    input text    ${name_input}    ${username_new}
    sleep  0.5s
    # click Update User
    click element   ${update_user_button}
    wait until element is visible    ${prompt_information}    3s
    wait until element is not visible   ${prompt_information}    20s

check_one_user_unreachable_in_team
    [Arguments]   ${reachable}
    ${class_attribute}   get element attribute     ${team_search_result}/div[@col-id="name"]    class
    Run Keyword If   '${reachable}'=='unreachable'    should be equal as strings    ${class_attribute}    ${unreachable_class_content}
    ...  ELSE IF  '${reachable}'=='reachable'    should be equal as strings    ${class_attribute}      ag-cell ag-cell-not-inline-editing ag-cell-with-height ag-cell-value

check_one_user_unreachable
    [Arguments]   ${reachable}
    ${class_attribute}   get element attribute     ${favorites_search_result}/div[@col-id="name"]    class
    Run Keyword If   '${reachable}'=='unreachable'    should be equal as strings    ${class_attribute}    ${unreachable_class_content}
    ...  ELSE IF  '${reachable}'=='reachable'    should be equal as strings    ${class_attribute}      ag-cell ag-cell-not-inline-editing ag-cell-with-height ag-cell-value

add_to_favorite_from_all_page
    ${get_attribute}  get element attribute   ${favorite_or_not}     class
    Run Keyword If   '${get_attribute}'=='fal fa-star favoriteIcon star-off'    click element   ${favorite_or_not}

unfavorite_user_from_all_pages
    # 在所有页面进行unfavorite或者favorite操作
    sleep   2s
    click element   ${favorite_or_not}

unfavorite_user_from_team_page
    # 在Team页面进行unfavorite或者favorite操作
    sleep   2s
    click element   ${team_favorite_or_not}

unfavorite_user_from_personal_page
    # 在Personal页面进行unfavorite或者favorite操作
    sleep   2s
    click element   ${personal_favorite_or_not}

click_send_invite_button
    [Arguments]   ${send_or_not}
    # 点击悬浮框
    wait until element is visible   ${ellipsis_menu_button}
    mouse over  ${ellipsis_menu_button}    # 鼠标悬浮
    sleep  2s
    # 点击取消或者确认发送
    Run Keyword If   '${send_or_not}'=='send_invite'   click element     ${invite_after_ellipsis}
#    ...  ELSE IF     '${send_or_not}'=='cancel'    click element    ${cancel_send_invite_button}

get_send_invite_email
    # 从邮箱获取发送的邮件
    ${email_link}   get_email_link    Accept Invitation
    # 判断邮箱是否正确
    should contain    ${email_link}   ${Citron_web_url}/meet/link
    [Return]   ${email_link}

set_disclaimer_is_on
    # Set Disclaimer =on
    ${get_status}   get element count    ${disclaimer_delete_user}//div[@class="feature-section-buttons btn-group"]//div[@class="react-toggle react-toggle--checked"]
    Run Keyword If   '${get_status}'=='0'   click element   ${disclaimer_delete_user}//div[@class="feature-section-buttons btn-group"]//div[@class="react-toggle-track"]

reset_all_accepted_disclaimers
    # Reset All Accepted Disclaimers
    click element   ${reset_all_disclaimers}
    wait until element is visible    ${reset_all_accepted_disclaimers_ok}
    click element   ${reset_all_accepted_disclaimers_ok}
    wait until element is visible   xpath=//span[text()='Reset All Accepted Disclaimers']
    wait until element is not visible   xpath=//span[text()='Reset All Accepted Disclaimers']    20s

expand_option_delete_user
    # EXPAND delete user 选项
    click element    ${disclaimer_delete_user}//button[contains(.,'Expand')]
    sleep  1s

set_delete_user_open
    # 设置delete user为启用状态
    ${get_status}   get element count    ${disclaimer_delete_user}//div[@class="disclaimer-text"]//div[@class="react-toggle react-toggle--checked"]
    Run Keyword If   '${get_status}'=='0'   click element   ${disclaimer_delete_user}//div[@class="disclaimer-text"]//div[@class="react-toggle-track"]

set_delete_user_close
    # 设置delete user为关闭状态
    ${get_status}   get element count    ${disclaimer_delete_user}//div[@class="disclaimer-text"]//div[@class="react-toggle"]
    Run Keyword If   '${get_status}'=='0'   click element   ${disclaimer_delete_user}//div[@class="disclaimer-text"]//div[@class="react-toggle-track"]

fill_password_mailbox
    sleep  20s
    ${email_link}   get_email_link   Click here to set your password:
    should contain   ${email_link}   ${Citron_web_url}
    # Open another Windows window
    Execute JavaScript    window.open('${email_link}')
    sleep  2s
    # change My password
    fill_available_password

fill_available_password
    # Switch to the second Windows page
    switch_window_to_second
    sleep  0.5s
    #  enter password
    click element  ${input_passwd}
    sleep  0.5s
    input text  ${input_passwd}   ${universal_password}
    sleep  0.5s
    # confirm password
    click element  ${input_passwordConfirm}
    sleep  0.5
    input text  ${input_passwordConfirm}    ${universal_password}
    sleep  0.5s
    click element   ${chage_passwd_button}
    sleep  0.5s
    wait until element is visible    xpath=//h2[contains(.,'You changed your password successfully.')]    5s
    # Switch to the first Windows page
    switch_window_to_first
    sleep  0.5s

get_all_logs_in_audit_logs
    # check modify record in crunch is correct
    @{LogList}=    Create List
    FOR   ${i}   IN RANGE   20
        ${get_log}   get text    ${audit_log_table}//tr[${i}+1]/td[5]
        Append To List    ${LogList}    ${get_log}
    END
    log  ${LogList}
    [Return]    ${LogList}

log_in_crunch_is_correct
    [Arguments]    ${expect_log}    ${LogList}
    ${result}  string_in_list_object    ${expect_log}   ${LogList}
    should be equal as strings   ${result}   There is audit logs

enter_create_new_group_page
    # enter Create New Group page
    click element  ${create_group_button}
    sleep  0.5s
    wait until element is visible   xpath=//h3[contains(.,'Group Type')]    3s

admin_add_on_call_group_keyword
    # Choose On-Call Group
    click element  xpath=//p[contains(.,'On-Call Group')]/../input
    sleep  0.5s
    # Enter Group Name
    click element  ${group_name_input}
    sleep  0.5s
    ${random}    get_random_number
    ${group_name}   Catenate   SEPARATOR=   on_call_group   ${random}
    input text   ${group_name_input}    ${group_name}
    sleep  0.5s
    # Enter Description
    click element    ${description_input}
    sleep  0.5s
    input text    ${description_input}   ${group_name}
    sleep  0.5s
    # 滑动到底
    swipe_browser_to_bottom
    sleep  1s
    [Return]   ${group_name}

group_operate_end_tag
    # Wait until the second row shows up
    wait until element is visible    ${first_data_show}     20
    wait until element is not visible   ${prompt_information}   20s

click_create_group_button
    # click CREATE GROUP button
    click element   xpath=//div[@class="modal-body"]//button[contains(.,'Create Group')]
    # Wait until the second row shows up
    group_operate_end_tag

admin_add_on_call_group
    # enter Create New Group page
    enter_create_new_group_page
    # 输入创建on-call group 的信息
    ${group_name}   admin_add_on_call_group_keyword
    # 点击创建group的按钮
    click_create_group_button
    [Return]   ${group_name}

click_group_details
    # 点击Details按钮，进入group-details页面
    click element   ${group_details_button}
    wait until element is visible    xpath=//h3[@class="section-header" and text()="Group Type"]
    sleep  2s

modify_group_on_call_group_visibility
    [Arguments]   ${on_call_group_name}
    # 点击Details按钮，进入group-details页面
    click_group_details
    # 检查是否需要删除原有的group
    ${ele_count}  get element count  xpath=//label[text()="On-Call Group Visibility"]/..//span[@class="k-icon k-i-close"]
    FOR   ${i}   IN RANGE   ${ele_count}
        click element    xpath=//label[text()="On-Call Group Visibility"]/..//span[@class="k-icon k-i-close"]
        sleep   1s
    END
    # 修改 group 的On-Call Group Visibility
    wait until element is visible    ${OnCall_group_visibility_input}
    click element   ${OnCall_group_visibility_input}
    sleep  1s
    input text   ${OnCall_group_visibility_input}    ${on_call_group_name}
    sleep  1s
    click element   xpath=//li[contains(.,'${on_call_group_name}')]
    sleep  1s
    # click Update Details button
    click element   xpath=//div[@class="modal-body"]//button[contains(.,'Update Details')]
    # Wait until the second row shows up
    group_operate_end_tag

delete_someone_group
    # 点击Details按钮，进入group-details页面
    click_group_details
    # 删除某个group
    click element    xpath=//div[@class="modal-body"]//button[contains(.,'Delete Group')]
    sleep  2s
    click element   xpath=//button[@class="k-button k-primary ml-4" and text()="Ok"]
    sleep  2s
    # 等待提示信息消失
    wait until element is not visible   ${prompt_information}   20s

your_count_has_been_deactived
    # 出现提示：Your account has been deactivated. Please contact your administrator.
    wait until element is visible    xpath=//span[text()="Your account has been deactivated. Please contact your administrator."]
    element should be visible    xpath=//a[contains(.,'Forgot Password?')]