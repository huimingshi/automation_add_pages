*** Settings ***
Library           Collections
Library           Selenium2Library
Library           DateTime
Library           String
Resource          public.robot
Resource          All_Pages_Xpath/WS_Admin/Calls.robot
Resource          All_Pages_Xpath/WS_Admin/Users.robot
Resource          All_Pages_Xpath/WS_Admin/Workspace_Settings.robot
Resource          All_Pages_Xpath/Normal/Contacts.robot
Resource          All_Pages_Xpath/public_xpath.robot
Library           python_Lib/ui_keywords.py

*** Variables ***
# make calls variables
${less_than_1_min}          20
${more_than_1_min}          60
# for python Library
${py_directory_page}                            Directory                                                                                           # Directory page
${py_users_page}                                Users                                                                                               # Users page
${py_personal_page}                             Personal                                                                                            # Personal page
${py_team_page}                                 Team                                                                                                # Team page
${py_groups_page}                               Groups                                                                                              # Groups page
${py_recents_page}                              Calls                                                                                               # Calls page
${py_favorites_page}                            Favorites                                                                                           # Favorites page
${py_contacts_page}                             Contacts                                                                                            # Contacts page
${py_messages_page}                             Messages                                                                                            # Messages page
${anonymous_user_name}                          Anonymous 1                                                                                         # 通话中显示匿名用户的名字
${py_invite_page}                               invite_page                                                                                         # 通话过程中邀请user的页面
${py_team_search_result}                        //div[@id="user-tabs-pane-1"]//div[@class="ag-center-cols-container"]/div                           # team search result
${py_personal_search_result}                    //div[@id="user-tabs-pane-2"]//div[@class="ag-center-cols-container"]/div                           # personal search result
${py_team_user_search}                          //div[@id="user-tabs-pane-1"]//input[@id="filter-text-box"]                                         # team search input box
${py_personal_user_search}                      //div[@id="user-tabs-pane-2"]//input[@id="filter-text-box"]                                         # personal search input box
${py_input_search}                              //input[@id="filter-text-box"]                                                                      # search entry box
${py_get_number_of_rows}                        //div[@class="ag-center-cols-container"]/div                                                        # Get number of rows
${py_directory_switch_success}                  //a[@id="user-tabs-tab-directory" and @aria-selected="true"]                                        # switch to Directory page successfully
${py_users_switch_success}                      //span[contains(.,"Active Users")]                                                                  # switch to Users page successfully
${py_groups_switch_success}                     //h1[text()="Groups"]                                                                               # switch to Groups page successfully
${py_contacts_switch_success}                   //h1[contains(.,"Contacts")]                                                                        # switch to Contacts page successfully
${py_messages_switch_success}                   //h1[contains(.,"Messages")]                                                                        # switch to Messages page successfully
${py_personal_switch_success}                   //a[@id="user-tabs-tab-personal" and @aria-selected="true"]                                         # switch to Personal page successfully
${py_recents_switch_success}                    //h1[contains(.,"Calls")]                                                                           # switch to Calls page successfully
${py_favorites_switch_success}                  //a[@id="user-tabs-tab-favorites" and @aria-selected="true"]                                        # switch to Favorites page successfully
${login_page_username}                          //input[@autocomplete="username"]                                                                   # 登录页面的输入用户名的xpath
${invite_user_in_calling}                       //div[@class="menus"]//*[@*="#options_menu"]                                                        # 在通话中的页面邀请user的按钮（右上角三个横杠）
${end_call_button}                              //div[@class='InCall']//div[@class='menu']//*[@*='#phone_end_red']                                  # 通话中的结束通话红色按钮
${five_star_high_praise}                        //span[@class="star"]/div[contains(.,"Excellent")]                                                  # 通话结束后的五星好评
${end_call_before_anwser}                       //div[@id="connecting_progress_bar_container"]/button[text()="End"]                                 # 接通Call之前的主动End通话的按钮
${anwser_call_button}                           //button[contains(.,"ANSWER")]                                                                      # ANSWER call 按钮
${tutorial_page_xpaths}                         //div[@class="modal-body"]//div[@class="row"]                                                       # Tutorial页面上的xpath集合
${no_experts_are_available}                     //div[@class="EndCallPage"]//div[text()="No Experts are currently available to take your call."]    # No Experts are currently available to take your call.提示信息
${no_experts_are_available_tips}                //div[@class="AlertContainer"]//div[text()="No Experts are currently available to take your call."]
${contacts_page_send_email}                     //button[text()="Send My Help Space Invitation"]                                                    # Send My Help Space Invitation
${recents_page_tag}                             //div[@class="Recents"]                                                                             # Recents页面的标志
${did_not_answer_your_call}                     //div[contains(.,"didn't answer your call.")]                                                       # didn't answer your call.
${participant_rejected_by_reception_room}       //div[@id="end_call_message" and text()="Participant rejected by reception room."]                  # Participant rejected by reception room
${your_call_was_not_anwsered_in_call}           //div[@class="message" and text()="Your call was not answered."]                                    # Your call was not answered.
${your_call_was_not_anwsered}                   //div[@id="end_call_message" and text()="Your call was not answered."]                              # Your call was not answered.
${declined_your_call}                           //div[@class="message" and text()="Your call was declined." ]                                       # declined your call
${your_call_was_declined}                       //div[@id="end_call_message" and text()="Your call was declined."]                                  # Your call was declined.
${user_is_currently_on_another_call_in_call}    //div[@class="message" and text()="User is currently on another call."]                             # User is currently on another call
${user_is_currently_on_another_call}            //div[@id="end_call_message" and text()="User is currently on another call."]                       # User is currently on another call
${that_user_is_unreachable}                     //div[@class="EndCallPageContent"]//div[contains(.,"That user is unreachable.")]                    # That user is unreachable
${this_call_is_over}                            //div[@id="end_call_message" and text()="This call is over. Please contact the host to invite you to another call."]      # This call is over
${too_many_users_in_a_call}                     //div[@id="end_call_message" and text()="Too many users in a call."]                                # Too many users in a call.
${pleas_do_not_disturb}                         //div[contains(.,"Please Do not disturb")]                                                          # User设置请勿打扰后，call这个user的话会出现这个提示信息：Please Do not disturb
${contact_title_xpath}                          //div[@class="contact-title" and @title="请勿动该账号，自动化测试专用账号"]                               # 显示title
${contact_location_xpath}                       //div[@class="contact-location" and @title="请勿动该账号，自动化测试专用账号"]                            # 显示location
${left_top_Logo}                                //img[@class="banner defaul-logo"]                                                                  # 左上角的Logo
${first_data_img}                               //div[@class="ag-center-cols-container"]/div[@row-index="0"]//div[@class="AvatarImageRenderer"]//img                                   # 首行数据的头像
${second_data_img}                              //div[@class="ag-center-cols-container"]/div[@row-index="1"]//div[@class="AvatarImageRenderer"]//img                                   # 第二行数据的头像
${first_data_img_in_invite_page}                //div[@class="ag-center-cols-container"]/div[@row-index="0" ]/div[@col-id="avatar.url"]//img        # 通话过程中邀请第三位参与通话时的首行数据的头像
${end_call_message}                             //div[@id="end_call_message"]                                                                       # end_call_message
${first_tree_text}                              //span[@class="k-link k-header"]                                                                    # 首层目录树的文本
${first_data_background_color}                  //div[@id="user-tabs-pane-team"]//div[@class="ag-center-cols-container"]/div[1]                     # 首行数据的背景色
${add_user_xpath}                               //button[text()="Add User"]                                                                         # Add User按钮
${edit_members_xpath}                           //button[text()="Edit Members"]                                                                     # Edit Members按钮
${add_device_xpath}                             //button[text()="Add Device"]                                                                       # Add Device按钮
${active_users_xpath}                           //a[@id="user-tabs-tab-1"]//span[text()="Active Users"]                                             # Active Users tab页面
${invitations_xpath}                            //a[@id="user-tabs-tab-2"]//span[text()="Invitations"]                                              # Invitations tab页面
${deactivated_users_xpath}                      //a[@id="user-tabs-tab-3"]//span[text()="Deactivated Users"]                                        # Deactivated Users tab页面
${active_users_report_view}                     //div[@id="user-tabs-pane-1"]//button[text()="Report View"]                                         # Active Users tab页面的Report View按钮
${invitations_Share_This_Filter}                //div[@id="user-tabs-pane-2"]//button[text()="Share This Filter"]                                   # Invitations tab页面的Share This Filter按钮
${invitations_Cancel_All}                       //div[@id="user-tabs-pane-2"]//button[text()="Cancel All"]                                          # Invitations tab页面的Cancel All按钮
${invitations_Resend_All}                       //div[@id="user-tabs-pane-2"]//button[text()="Resend All"]                                          # Invitations tab页面的Resend All按钮
${invitations_Export_to_CSV}                    //div[@id="user-tabs-pane-2"]//button[text()="Export to CSV"]                                       # Invitations tab页面的Export to CSV按钮
${deactivated_users_Share_This_Filter}          //div[@id="user-tabs-pane-3"]//button[text()="Share This Filter"]                                   # Deactivated Users tab页面的Share This Filter按钮
${deactivated_users_Export_to_CSV}              //div[@id="user-tabs-pane-3"]//button[text()="Export to CSV"]                                       # Deactivated Users tab页面的Export to CSV按钮
${Details_button_xpath}                         //button[@class="k-button detailsButton" and text()="Details"]                                      # Details 按钮
${Members_button_xpath}                         //button[@class="k-button detailsButton" and text()="Members"]                                      # Members 按钮
${Personal_tab_xpath}                           //span[contains(.,"Personal")]                                                                      # Personal tab页
${create_group_button}                          //button[contains(.,'Create Group')]                                                                # Create Group button
${groups_report_view}                           //div[@class="Groups"]//button[text()="Report View"]                                                # Groups页面的Report View按钮
${Create_Group_Group_Type}                      //h3[text()="Group Type"]                                                                           # Create New Group页面的Group Type字段
${Create_Group_Group_Info}                      //h3[text()="Group Info"]                                                                           # Create New Group页面的Group Info字段
${Create_Group_Team_Contacts}                   //h3[text()="Team Contacts"]                                                                        # Create New Group页面的Team Contacts字段
${Create_Group_Create_Group}                    //button[@type="submit" and text()="Create Group"]                                                  # Create New Group页面的Create Group按钮
${Create_Group_Create_and_Add_Another}          //button[@type="submit" and text()="Create and Add Another"]                                        # Create New Group页面的Create and Add Another按钮
${Create_Group_Cancel}                          //div[@class="GroupEdit"]//button[text()="Cancel"]                                                  # Create New Group页面的Cancel按钮
${My_Account_button}                            //button[@id="currentAccount"]                                                                      # 右上角我的账号按钮
${My_Account_span_xpath}                        //span[text()="My Account"]                                                                         # My Account按钮
${My_Account_Change_password}                   //button[text()="Change password..."]                                                               # My Account tab页面的Change password...按钮
${My_Account_Update}                            //button[@type="submit" and text()="Update"]                                                        # My Account tab页面的Update按钮
${My_Account_Settings_tab}                      //a[@id="settings-tab-1"]/div[text()="Settings"]                                                    # Settings tab页面
${My_Account_My_Account}                        //a[@id="settings-tab-2"]/div[text()="My Account"]                                                  # My Account tab页面
${Settings_tab_Allow_access}                    //button[text()="Allow access to your Camera and Microphone."]                                      # Settings tab页面的Allow access to your Camera and Microphone.按钮
${Contacts_call_button}                         //button[@class="k-button callButton" and text()="Call"]                                            # Contacts页面的Call按钮
${Contacts_Send_link_email}                     //button[text()="Send My Help Space Invitation"]                                                    # Send My Help Space Invitation按钮
${Send_link_email_Cancel}                       //form[@class="InviteToHelpSpaceView form-horizontal"]//button[text()="Cancel"]                     # My Help Space页面的Cancel 按钮
${Send_link_email_Send_Invite}                  //form[@class="InviteToHelpSpaceView form-horizontal"]//button[text()="Send Invite"]                # My Help Space页面的Send Invite 按钮
${Toturial_switch_page}                         //i[@id="i-0"]                                                                                      # Toturial 页面切换图片
${Toturial_Let_go}                              //button[@id="nextBtn"]                                                                             # Toturial 页面的Let's go!按钮
${Toturial_title}                               //div[@class="Tutorials modal-dialog"]//h1                                                          # Toturial 页面的welcome文本信息
${Disclaimer_accept}                            //div[@class="modal-dialog"]//button[text()="ACCEPT"]                                               # Disclaimer的accept按钮
${invite_contacts_tab}                          //a[@id="inviteDialog-tab-1" and text()="Contacts"]                                                 # 邀请第三位通话者页面的Contacts tab页面
${invite_send_invite_tab}                       //a[@id="inviteDialog-tab-2" and text()="Send Invite"]                                              # 邀请第三位通话者页面的Send Invite tab页面
${send_invite_tab_send_invite_button}           //form[@class="MyHelpSpaceInvite form-horizontal"]//button[text()="Send Invite"]                    # 邀请第三位通话者页面的Send Invite tab页面Send Invite按钮
${f2f_mode_I_will_give_help}                    //span[text()="I will give help"]                                                                   # f2f模式的I will give help文本信息
${f2f_mode_I_need_help}                         //span[text()="I need help"]                                                                        # f2f模式的I need help文本信息
${f2f_mode_Close}                               //div[@class="FirstUserGuide"]//span[text()="Close"]                                                # f2f模式的Close按钮
${Login_page_next_button}                       //button[@type="submit" and text()="Next"]                                                          # 登录页面的Next按钮
${outgoing_Call_avator}                         //div[@id="connecting_avatarImage"]/img                                                             # 直接Call时的头像
${ingoing_Call_avator}                          //div[@id="incoming_avatarImage"]/img                                                               # 接受Call时的头像
${end_call_message}                             //div[@id="end_call_message"]                                                                       # Call结束时的信息
${end_call_logo}                                //div[@id="end_call_company_logo"]/img                                                              # Call结束时的logo展示
${end_call_whole_page}                          //html                                                                                              # Call结束时的整个页面
${end_button_before_call}                       //div[@id="connecting_progress_bar_container"]/button[text()="End"]                                 # End Call按钮
${choose_give_receive_help_mode}                //div[@class="FirstUserGuide"]                                                                      # 通话过程中选择Give或者Receive模式
${open_Menu_Items}                              //h1[text()="Menu Items"]/..//div[@class="react-toggle"]                                            # Settings的Menu Items打开按钮
${exit_call_yes_button}                         //button[text()="Yes"]                                                                              # 退出通话时的Yes按钮
${exit_call_no_button}                          //button[text()="No"]                                                                               # 退出通话时的No按钮




# 不是xpath的变量
${default_avatar_src}                           data:image/png;base64
${organizer_brand_orange_color}                 --organizer-brand-color:#ff9933
${lime_brand_orange_color}                      --lime-brand-color:#ff9933
${lime_brand_green_color}                       --lime-brand-color:#00ff00
${organizer_brand_default_color}                --organizer-brand-color:#00A9E0
${lime_brand_default_color}                     --lime-brand-color:#00a9e0
${lime_brand_default_color_1}                   --lime-brand-color:#00A9E0

*** Keywords ***
enter_group_calls
    # click workspace ADMINISTRATION menu
    click element   ${enter_group_menu}
    sleep  0.5s
    # click Users page menu
    click element   ${enter_calls}
    sleep  3s
    # choose Last 365 Days
    click element  ${occurred_within_choose}
    sleep  0.5s
    click element  ${calls_last_365_days_select}
    sleep  0.5s
    # Wait until the first row shows up
    wait until element is visible    ${first_data_show}    20

enter_calls_menu
    # click Calls page menu
    click element   ${enter_calls}
    sleep  3s
    # choose Last 365 Days
    click element  ${occurred_within_choose}
    sleep  0.5s
    click element  ${calls_last_365_days_select}
    sleep  0.5s
    # Wait until the first row shows up
    wait until element is visible    ${calls_details_button}  20

enter_workspace_calls
    # click workspace ADMINISTRATION menu
    click element   ${enter_workspace_menu}
    sleep  1s
    # click Calls page menu
    click element   ${enter_calls}
    sleep  3s
    # choose Last 365 Days
    click element  ${occurred_within_choose}
    sleep  0.5s
    click element  ${calls_last_365_days_select}
    sleep  0.5s
    # Wait until the first row shows up
    wait until element is visible    ${calls_details_button}  20

enter_workspace_calls_page
    # click workspace ADMINISTRATION menu
    click element   ${enter_workspace_menu}
    sleep  1s
    # click Calls page menu
    click element   ${enter_calls}
    sleep  3s
    # Wait until the first row shows up
    wait until element is visible    ${calls_details_button}  20

enter_workspace_settings_page
    # click workspace ADMINISTRATION page menu
    click element   ${enter_workspace_menu}
    sleep  1s
    # click settings page menu
    click element   ${enter_Workspace_settings}
    sleep  2s
    # Wait until enter page
    FOR   ${i}    IN RANGE   0    10
        ${count}   get element count   ${enter_ws_settings_success}
        Exit For Loop If    '${count}'=='1'
        Run Keyword If      '${count}'=='0'    sleep   2s
        Run Keyword If      '${i}'=='19'    refresh_web_page
    END
    # click settings page menu
    click element   ${enter_Workspace_settings}
    wait until element is visible   ${enter_ws_settings_success}   20

enter_recents_page
    # click normal Recents menu
    click element   ${enter_recents}
    # Wait until the first row shows up
    wait until element is visible   ${first_data_show}   20

get_original_count
    sleep  15s
    ${count_before}   get text  ${calls_get_counts}
    [Return]   ${count_before}

filter_by_participant
    [Arguments]   ${count_before}
    # search by participant
    click element   ${input_search}
    sleep  0.5s
    input text  ${input_search}   请勿动该账号
    sleep  15s
    ${count_after}   get text  ${calls_get_counts}
    should not be equal as integers    ${count_before}    ${count_after}
    FOR   ${i}   IN RANGE  5
        ${participant_name}   get text    xpath=//div[@class="ag-center-cols-container"]//div[@row-index="${i}"]//div[@col-id="participants"]
        should contain   ${participant_name}   请勿动该账号
    END

filter_by_owner_email
    [Arguments]   ${count_before}
    # search by participant
    click element   ${input_search}
    sleep  0.5s
    input text  ${input_search}   ${normal_username_for_calls}
    sleep  15s
    ${count_after}   get text  ${calls_get_counts}
    should not be equal as integers    ${count_before}   ${count_after}
    FOR   ${i}   IN RANGE  10
        ${owner_email_name}   get text    xpath=//div[@class="ag-center-cols-container"]//div[@row-index="${i}"]//div[@col-id="owner_email"]
        should be equal as strings   ${owner_email_name}   ${normal_username_for_calls}
    END

filter_by_groups
    [Arguments]   ${count_before}
    # search by participant
    click element   ${input_search}
    sleep  0.5s
    input text  ${input_search}   auto_default_group
    sleep  15s
    ${count_after}   get text  ${calls_get_counts}
    should not be equal as integers    ${count_before}   ${count_after}
    FOR   ${i}   IN RANGE  10
        ${groups_name}   get text    xpath=//div[@class="ag-center-cols-container"]//div[@row-index="${i}"]//div[@col-id="groupsString"]
        should contain   ${groups_name}   auto_default_group
    END

check_file_if_exists_delete
    # Check whether there are existing files in the path and delete them if there are
    check_file_and_delete   export.csv

delete_zip_and_csv_file
    # delete all download zip file
    delete_zip_file
    # delete all download report.csv file
    check_file_and_delete   report.csv

click_export_button
    # click Export button
    click element   ${export_button}
    sleep  2s

export_current_table
    # click Export button
    click_export_button
    # click Export Current Table button
    click element   ${export_current_table}
    sleep  10s

create_new_call_report
    # click Export button
    click_export_button
    # click Generate New Call Report button
    click element  ${generate_new_call_report}
    wait until element is visible    ${Preparing_Call_Report}
    wait until element is not visible    ${Preparing_Call_Report}   240
    # click
    click element   ${generated_table}
    sleep  10s

check_page_first_owner_is_deleted_user
    [Arguments]    ${witch_field}
    # 检查页面第一条记录的Owner name是Deleted User
    ${get_owner_name}    get text  ${first_data_show}/div[@col-id="${witch_field}"]
    should be equal as strings  ${get_owner_name}   Deleted User

check_export_file_data
    # Read the first line field of the CSV file
    ${first_lines}   read_csv_file_check_cloumns   export.csv
    ${owner_name_get}   get text     ${first_data_show}/div[@col-id="owner_name"]
    ${owner_email_get}   get text     ${first_data_show}/div[@col-id="owner_email"]
    ${participants_count}   get element count     ${first_data_show}//div[@class="cardName"]
    @{participants_list}=    Create List
    FOR   ${i}    IN RANGE   0    ${participants_count}
        ${participants_get}   get text   ${first_data_show}//div[@class="participant"][${i}+1]//div[@class="cardName"]
        append to list   ${participants_list}   ${participants_get}
    END
    ${groupsString_get}   get text     ${first_data_show}/div[@col-id="groupsString"]
    ${reasonCallEnded_get}   get text     ${first_data_show}/div[@col-id="reasonCallEnded"]
    ${callDuration_get}   get text     ${first_data_show}/div[@col-id="callDuration"]
    ${tags_get}   get text     ${first_data_show}/div[@col-id="tags"]
    should be equal as strings  ${first_lines}[0]    ${owner_name_get}
    should be equal as strings  ${first_lines}[1]    ${owner_email_get}
    FOR   ${i}    IN RANGE   0    ${participants_count}
        should contain     ${first_lines}[2]    ${participants_list}[${i}]
    END
    should be equal as strings  ${first_lines}[3]    ${groupsString_get}
    should be equal as strings  ${first_lines}[5]    ${reasonCallEnded_get}
    should be equal as strings  ${first_lines}[6]    ${callDuration_get}
    ${tags_get_new}  string_with_whitespace_removed   ${tags_get}
    should be equal as strings  ${first_lines}[7]    ${tags_get_new}
    [Return]    ${first_lines}[0]    ${first_lines}[1]

check_zip_report_file_data
    # Read the first and second line field of the report.csv file
    ${first_lines}   ${second_lines}  read_zip_file_check_cloumns
    @{title_list}=    Create List   id  started_at  ended_at  tags  comments  groups  participants  dialer  status  duration  workspace  workspace_id
    FOR   ${i}   IN RANGE  0   12
        should be equal as strings    ${first_lines}[${i}]      ${title_list}[${i}]
    END
    should not be empty   ${second_lines}

click_first_line_details
    # click Details button for the first record
    click element   ${calls_details_button}
    sleep  2s

get_all_tags
    # click Details button for the first record
    click_first_line_details
    # delete all tags
    ${count}   get element count   ${delete_tags_button}
    FOR   ${i}   IN RANGE    ${count}
        click element  ${delete_tags_button}
        sleep  0.5s
    END
    # click  Add tags...  input
    click element    ${add_tags_input}
    sleep  1s
    # get all tags to list
    ${count}   get element count    xpath=//div[@class="k-list-scroller"]//li
    @{tags_list}=    Create List
    FOR   ${i}   IN RANGE    ${count}
        ${get_tag}   get text    xpath=//div[@class="k-list-scroller"]//li[${i}+1]
        Append To List    ${tags_list}     ${get_tag}
    END
    log   ${tags_list}
    ${result}   list_contain_another_list   ${tags_list}
    should be equal as strings   ${result}   The two lists partially duplicate data

add_tag_and_comments
    # click Details button for the first record
    click_first_line_details
    # delete all tags
    ${count}   get element count   ${delete_tags_button}
    FOR   ${i}   IN RANGE    ${count}
        click element  ${delete_tags_button}
        sleep  0.5s
    END
    # click SAVE button
    click element   ${tags_save_button}
    wait until element is visible   ${prompt_information}
    wait until element is not visible   ${prompt_information}   20s
    # click  Add tags...  input
    click element    ${add_tags_input}
    sleep  1s
    # Select the first tag
    ${first_tag}   get text    xpath=//div[@class="k-list-scroller"]//li[1]
    click element   xpath=//div[@class="k-list-scroller"]//li[1]
    sleep  0.5s
    # click SAVE button
    click element   ${tags_save_button}
    wait until element is visible   ${prompt_information}
    wait until element is not visible   ${prompt_information}   20s
    # 滑动到底
    swipe_browser_to_bottom
    sleep  0.5s
    # click Add a comment...  input
    click element    ${add_comment_input}
    sleep  0.5s
    # input comment
    ${random}   evaluate    int(time.time()*1000000)   time
    ${comment}   Catenate   SEPARATOR=   comment  ${random}
    input text   ${add_comment_input}     ${comment}
    sleep  1s
    # click SAVE button
    wait until element is enabled  ${comment_save_button}
    click element   ${comment_save_button}
    wait until element is visible   ${prompt_information}
    wait until element is not visible   ${prompt_information}   20s
    # click x button
    click element    ${close_details_button}
    sleep  5s
    # Check whether the tag is added successfully
    ${get_tag}   get text   xpath=//div[@class="ag-center-cols-container"]//div[@row-index="0"]/div[@col-id="tags"]
    should be equal as strings   ${first_tag}  ${get_tag}
    # click Details button for the first record
    wait until element is not visible    ${prompt_information}
    click_first_line_details
    # Check whether the comment is added successfully
    ${ele_count}   get element count    ${comment_content_xpath}
    ${get_comment}  get text   xpath=//div[@class="calllog"]//div[@class="CallLogEntry"][${ele_count}]//p
    should be equal as strings   ${comment}   ${get_comment}

update_tags
    # Gets the text of the first tag
    ${first_tag}   get text     xpath=//ul[@role="listbox"]/li/a/span
    # update tag
    click element   xpath=//span[@class="k-searchbar"]/input
    sleep  1s
    # Select the second tag
    ${second_tag}   get text     xpath=//div[@class="k-list-scroller"]//li[2]
    click element  xpath=//div[@class="k-list-scroller"]//li[2]
    sleep  1s
    # 滑动到底
    swipe_browser_to_bottom
    sleep  0.5s
    # click SAVE button
    click element   ${tags_save_button}
    wait until element is visible   ${prompt_information}
    wait until element is not visible   ${prompt_information}   20s
    # click x button
    click element    ${close_details_button}
    sleep  10s
    # Check whether the tag is added successfully
    ${get_tag}   get text     ${first_data_show}/div[@col-id="tags"]
    should be equal as strings    ${get_tag}     ${first_tag}, ${second_tag}

delete_tags
    # click Details button for the first record
    click_first_line_details
    # delete all tags
    ${count}   get element count   ${delete_tags_button}
    FOR   ${i}   IN RANGE    ${count}
        click element  ${delete_tags_button}
        sleep  0.5s
    END
    # 滑动到底
    swipe_browser_to_bottom
    sleep  0.5s
    # click SAVE button
    click element   ${tags_save_button}
    wait until element is visible   ${prompt_information}
    wait until element is not visible   ${prompt_information}   20s
    # click x button
    click element    ${close_details_button}
    sleep  8s
    # Check whether the tag is deleted successfully
    ${get_tag_second}   get text    ${first_data_show}/div[@col-id="tags"]
    should be empty   ${get_tag_second}

enter_key_words_in_search_field
    [Arguments]   ${search_text}
    # Enter key words in Search field
    click element  ${search_input}
    sleep  0.5s
    input text  ${search_input}   ${search_text}
    sleep  3s
    ${count}   Get Element Count    ${get_number_of_rows}   # Gets how many rows are in the result of the query
    should not be equal as numbers  ${count}  0
    FOR   ${i}   IN RANGE  10
        ${get_owner_text}   get text    xpath=//div[@class="ag-center-cols-container"]/div[@row-index="${i}"]/div[@col-id="groupsString"]
        should contain    ${get_owner_text}    ${search_text}
    END
    clear element text   ${search_input}
    sleep  3s

delete_all_jpg_and_jpeg_picture
    # delete all jpg and jpeg picture
    delete_picture_jpg_file
    delete_picture_jpeg_file

participant_list_should_be_correct
    [Arguments]   ${first_tag_text}
    # click Details button for the first record
    click_first_line_details
    # the Participant list should be correct.
    ${name_1}  get text  xpath=//td[@tabindex="2"]//a
    ${name_2}  get text  xpath=//td[@tabindex="10"]//a
    ${name_3}  get text  xpath=//td[@tabindex="18"]//a
    ${name_4}  get text  xpath=//td[@tabindex="26"]//a
    @{get_name_list}   create list   ${name_1}  ${name_2}  ${name_3}  ${name_4}
    @{name_list}   create list   hlnauto+basic   Huiming.shi.helplightning+personal   Anonymous User   Huiming.shi.helplightning+123456789
    ${result}    compare_two_lists      ${get_name_list}   ${name_list}
    should be equal as strings    ${result}    Two lists are equal

call_tag_and_comment_should_be_correct
    [Arguments]   ${first_tag_text}
    # Call tag & comment should be correct
    ${tag_text}    get text    ${tag_count}
    should be equal as strings   ${first_tag_text}   ${tag_text}
    ${count}  get element count   ${comment_count}
    ${comment}   get text   ${comment_count}
    should be equal as integers   ${count}  1
    should be equal as strings  ${comment}   good_experience
    # Enter call tag
    click element   xpath=//span[@class="k-searchbar"]/input
    sleep  1s
    ${second_tag}   get text     xpath=//div[@class="k-list-scroller"]//li[2]
    click element  xpath=//div[@class="k-list-scroller"]//li[2]
    sleep  1s
    ${count}   get element count   ${tag_count}
    should be equal as integers  ${count}  2
    # Enter comment
    click element   ${add_comment_input}
    sleep  0.5s
    input text   ${add_comment_input}   good_experience
    sleep  0.5s
    click element   xpath=//div[@class="call-info-form-group form-group"]//button[contains(.,'Save')]
    sleep  1s
    ${count}  get element count   ${comment_count}
    should be equal as integers   ${count}  2
    # close details page
    click element  xpath=//div[@class="modal-header"]//span[@aria-hidden="true" and contains(.,'×')]
    sleep  5s
    # Re-open this call record detail page,the updated call tag & comment should be shown up.
    # click Details button for the first record
    click_first_line_details
    ${count}  get element count   ${tag_count}
    should be equal as integers   ${count}  2
    ${count}  get element count   ${comment_count}
    should be equal as integers   ${count}  2

the_event_log_should_be_correct
    # the event log should be correct
    ${count}   get element count   xpath=//h4[contains(.,'Event Log')]/following-sibling::div[1]//table[@class="table table-striped"]//tr
    should be equal as integers   ${count}   1
    ${from}  get text   xpath=//h4[contains(.,'Event Log')]/following-sibling::div[1]//table[@class="table table-striped"]//tr/td[@tabindex="2"]/div
    should be equal as strings   ${from}   Huiming.shi.helplightning+123456789
    ${to}  get text   xpath=//h4[contains(.,'Event Log')]/following-sibling::div[1]//table[@class="table table-striped"]//tr/td[@tabindex="3"]/div
    should be equal as strings   ${to}   Huiming.shi.helplightning+personal
    ${status}  get text   xpath=//h4[contains(.,'Event Log')]/following-sibling::div[1]//table[@class="table table-striped"]//tr/td[@tabindex="5"]/div
    should be equal as strings   ${status}   Accepted

the_screen_capture_list_should_be_correct
    # the Screen capture list should be correct
    ${count}   get element count    ${view_count}
    should be equal as integers    ${count}   3
    # Click thumbnail or view button to view picture
    click element    xpath=//button[contains(.,'View')]
    sleep  2s
    element should be visible   xpath=//h4[contains(.,'View Image')]
    click element   xpath=//h4[contains(.,'View Image')]/..//span[contains(.,'×')]
    sleep  1s
    # download
    click element  xpath=//span[@class="k-icon k-i-more-horizontal"]
    sleep  1s
    click element  xpath=//button[contains(.,'Download')]
    sleep  5s
    ${jpeg_list}  ${exists_tag}  check_jpeg_picture_exists
    should be equal as integers    ${exists_tag}   1
    # clicks on ellipses -> delete menu and confirms OK.
    click element  xpath=//span[@class="k-icon k-i-more-horizontal"]
    sleep  1s
    click element  xpath=//button[contains(.,'Delete')]
    sleep  2s
    click element     ${latest_modified_window_ok_button}
    sleep  2s
    ${count}   get element count    ${view_count}
    should be equal as integers    ${count}   2
    # close details page
    click element  xpath=//div[@class="modal-header"]//span[@aria-hidden="true" and contains(.,'×')]
    sleep  5s
    # Re-open this call detail page, this screen capture should not be shown up.
    # click Details button for the first record
    click_first_line_details
    ${count}   get element count    ${view_count}
    should be equal as integers    ${count}   2

modify_call_tag_from_client
    sleep  2s
    # get the first data which has Details button
    ${call_started_time}   get text   xpath=//button[contains(.,'Details')]/../../../div[@col-id="timeCallStarted"]
    #  click Details button
    click element    xpath=//button[contains(.,'Details')]
    wait until element is visible    ${tags_save_button}
    # delete all tags
    ${count}   get element count   ${delete_tags_button}
    FOR   ${i}   IN RANGE    ${count}
        click element  ${delete_tags_button}
        sleep  0.5s
    END
    # click Add tags... input
    click element    ${add_tags_input}
    sleep  1s
    # Select the third tag
    ${third_tag}   get text    xpath=//div[@class="k-list-scroller"]//li[3]
    click element   xpath=//div[@class="k-list-scroller"]//li[3]
    sleep  0.5s
    # 滑动到底
    swipe_browser_to_bottom
    sleep  0.5s
    # click SAVE button
    click element   ${tags_save_button}
    sleep  1s
    [Return]  ${call_started_time}   ${third_tag}

check_mormal_user_modify_tag_successfully
    [Arguments]  ${call_started_time}   ${third_tag}
    # check mormal user modify tag successfully
    ${get_tag}   get text   xpath=//div[contains(.,'${call_started_time}')]/../div[@col-id="tags"]
    should be equal as strings   ${get_tag}    ${third_tag}

make_sure_tagging_and_comments_setting_open
    sleep  2s
    # make sure After Call: Tagging and Comments setting is open
    ${count}   get element count   ${open_tag_and_comment}
    Run Keyword If   '${count}'=='1'    open_tagging_and_comments_setting

open_tagging_and_comments_setting
    click element   ${open_tag_and_comment}
    sleep  3s   # Waiting for the configuration to take effect

display_as_external_user_in_call_list
    ${text}   get text   xpath=//div[@class="ag-center-cols-container"]/div[1]//div[@class="cardName"]
    should be equal as strings   ${text}    External User

return_modify_pirture_path
    # get modify picture absolute path
    ${modify_picture_path}   get_modify_picture_path
    [Return]  ${modify_picture_path}

return_a_random
    # get a random
    ${random}   evaluate    int(time.time()*1000000)   time
    [Return]    ${random}

users_page_search_deleted_user
    [Arguments]   ${username}
    wait until element is visible   ${search_input}
    click element    ${search_input}
    sleep   0.5s
    input text    ${search_input}     ${username}
    sleep   2s
    wait until element is not visible   ${first_data_show}

contacts_page_search_deleted_user
    [Arguments]   ${username}    ${which_page_input}
    wait until element is visible   ${which_page_input}
    click element    ${which_page_input}
    sleep   0.5s
    input text    ${which_page_input}    ${username}
    sleep   2s
    wait until element is not visible   ${first_data_show}

enter_workspace_users_invitations
    # 进入到Invitations页面
    click element      ${invitations_page}
    sleep  1
    wait until element is visible   ${resend_all_invitation}

enter_workspace_users_deactivated_users
    # 进入到Deactivated Users页面
    click element     ${deactivated_users_page}
    sleep  1
    wait until element is visible    ${export_to_CSV_button}

enter_directory_page
    click element   ${enter_directory_page}
    sleep  2s
    wait until element is visible   ${directory_first_data_show}

recents_page_first_line_has_no_call_button
    # Recents页面的首条记录没有Call按钮
    wait until element is not visible   ${first_data_show}/div[@col-id="0"]//button[text()="Call"]

expand_workspace_branding_setting
    click element   ${workspace_branding}//button[text()="Expand"]
    wait until element is visible  ${workspace_branding}//button[text()="Click to edit"]

turn_on_workspace_branding_setting
    ${ele_count}   get element count    ${workspace_branding}//div[@class="react-toggle"]
    Run Keyword If   '${ele_count}'=='1'   click element   ${workspace_branding}//div[@class="react-toggle"]
    sleep  1s

turn_off_workspace_branding_setting
    ${ele_count}   get element count    ${workspace_branding}//div[@class="react-toggle react-toggle--checked"]
    Run Keyword If   '${ele_count}'=='1'   click element   ${workspace_branding}//div[@class="react-toggle react-toggle--checked"]
    sleep  1s

enter_workspace_branding_setting
    # 点击Click to edit按钮
    click element   ${workspace_branding}//button[text()="Click to edit"]
    wait until element is visible    ${product_name_input}

modify_workspace_branding_setting
    # 点击Click to edit按钮
    enter_workspace_branding_setting
    # 输入Product Name
    Press Key    ${product_name_input}    \\8
    ${random}   evaluate    int(time.time()*1000000)    time
    ${product_name}   Catenate   SEPARATOR=   德玛西亚皇子+-{}()   ${random}
    input text   ${product_name_input}    ${product_name}
    # 输入Accent Color
    ${get_value}    get element attribute   ${accent_color_input}   value
    FOR   ${i}   IN RANGE    6
        Press Key    ${accent_color_input}    \\8
        sleep  0.5s
    END
    Run Keyword If   '${get_value}'=='#ff9933'    input text   ${accent_color_input}    00ff00
    ...  ELSE IF  '${get_value}'=='#00ff00'    input text   ${accent_color_input}    ff9933
    ...  ELSE    input text   ${accent_color_input}    ff9933
    sleep  1s
    ${get_value}    get element attribute   ${accent_color_input}   value
    # 点击保存
    click element    ${save_changes_button}
    wait until element is visible     ${Updated_Business_settings}
    wait until element is not visible     ${Updated_Business_settings}    20s
    [Return]    ${get_value}   ${product_name}

check_get_color_correct
    [Arguments]     ${get_value}    ${css_value}
    Run Keyword If   '${get_value}'=='#ff9933'    should be equal as strings     rgba(255, 153, 51, 1)    ${css_value}
    ...  ELSE IF  '${get_value}'=='#00ff00'    should be equal as strings    rgba(0, 255, 0, 1)     ${css_value}

check_get_color_is_orange
    [Arguments]    ${css_value}
    should be equal as strings     rgba(255, 153, 51, 1)    ${css_value}

check_get_color_is_green
    [Arguments]    ${css_value}
    should be equal as strings     rgba(0, 255, 0, 1)    ${css_value}

check_get_color_is_default
    [Arguments]    ${css_value}
    should be equal as strings     rgba(0, 169, 224, 1)    ${css_value}

check_get_color_is_white
    [Arguments]    ${css_value}
    should be equal as strings     rgba(255, 255, 255, 1)    ${css_value}

click_to_edit_branding_setting
    click element     ${workspace_branding}//button[contains(.,'Click to edit')]
    wait until element is visible      ${close_branding_setting}

change_branding_big_logo
    ${picture_path}   get_modify_picture_path    Logo1.jpg
    wait until element is visible    xpath=//button[text()="Change logo..."]    20
    choose file   ${change_big_logo}   ${picture_path}
    sleep  2s

change_branding_default_avatat
    ${picture_path}   get_modify_picture_path    avatar1.jpg
    wait until element is visible     xpath=//button[text()="Change avatar..."]    20
    choose file   ${change_default_avatar}   ${picture_path}
    sleep  2s

close_branding_setting
    wait until element is not visible     ${message_text}    20s
    click element    ${close_branding_setting}
    sleep   1s

turn_on_workspace_directory
    ${count}   get element count   ${directory_turn_on}
    Run Keyword If   '${count}'=='1'    click element   ${directory_turn_on}
    sleep  2s

expand_during_call_recording
    click element   ${during_call_recording}//button[text()="Expand"]
    wait until element is visible  ${always_on_select}

turn_on_during_call_recording
    ${ele_count}   get element count    ${during_call_recording}//div[@class="react-toggle"]
    Run Keyword If   '${ele_count}'=='1'   click element   ${during_call_recording}//div[@class="react-toggle"]
    sleep  1s

choose_witch_recording_feature
    [Arguments]    ${witch_recording_feature}
    click element   ${witch_recording_feature}
    sleep   1s