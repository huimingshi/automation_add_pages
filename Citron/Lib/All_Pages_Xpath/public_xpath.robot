*** Variables ***
# outlook email
${input_passwd}                             xpath=//input[@name="password"]                                                                         # password entry box
${input_passwordConfirm}                    xpath=//input[@name="passwordConfirmation"]                                                             # passwordConfirm entry box
${chage_passwd_button}                      xpath=//button[@class="k-button k-primary"]                                                             # Change my password button
${confirm_password_input}                   xpath=//input[@placeholder="Password"]                                                                  # Confirm password input
# 切换WS
${first_WS_xpath}                           xpath=//div[@class="k-list-scroller"]//li[1]                                                            # 切换WS时的第一个WS对应的xpath
# Tutorial
${let_go_button}                            xpath=//button[@id="nextBtn" and contains(.,"Let's go!")]                                               # Let's Go button
${tutorial_next_button}                     xpath=//button[@id="nextBtn" and contains(.,"Next")]                                                    # tutorial next button
${get_started_button}                       xpath=//button[@id="nextBtn" and contains(.,"Get Started!")]                                            # Get Started button
# Declaimer
${erase_my_account}                         xpath=//div[@role="dialog"]//button[text()='Erase My Account']                                          # Erase My Account
${cancel_erase_my_account}                  xpath=//div[@role="dialog"]//button[text()='Cancel']                                                    # Cancel Erase My Account
# all
${get_count_of_team}                        xpath=//div[@id="user-tabs-pane-team"]//div[@class="ag-center-cols-container"]/div                      # Get number of Team
${get_count_of_favorites}                   xpath=//div[@id="user-tabs-pane-favorites"]//div[@class="ag-center-cols-container"]/div                 # Get number of favorites
${get_count_of_personal}                    xpath=//div[@id="user-tabs-pane-personal"]//div[@class="ag-center-cols-container"]/div                  # Get number of personal
${get_count_of_directory}                   xpath=//div[@id="user-tabs-pane-directory"]//div[@class="ag-center-cols-container"]/div                 # Get number of directory
${get_number_of_rows}                       xpath=//div[@class="ag-center-cols-container"]/div                                                      # Get number of rows
${first_row_shows_up}                       xpath=//div[@class="ag-center-cols-container"]/div[@row-index="0"]/div[2]//div[@class="cardName"]       # Wait until the first row shows up
${first_data_show}                          xpath=//div[@class="ag-center-cols-container"]/div[@row-index="0"]                                      # Wait until the first row shows up
${details_button}                           xpath=//button[contains(.,'Details')]                                                                   # Details button
${first_data_Details}                       xpath=//div[@row-index="0"]//button[contains(.,'Details')]                                              # 第一条数据的Details按钮
${close_details_button}                     xpath=//div[@class="modal-header"]//span[contains(.,'×')]                                               # close details button
${report_view_button}                       xpath=//button[contains(.,'Report View')]                                                               # Report View button
${share_this_filter_button}                 xpath=//button[contains(.,'Share This Filter')]                                                         # Share This Filter button
${export_to_CSV_button}                     xpath=//button[contains(.,'Export to CSV')]                                                             # Export to CSV button
${quick_view_button}                        xpath=//button[contains(.,'Quick View')]                                                                # Quick View button
${universal_password}                       *IK<8ik,8ik,                                                                                            # Universal password
${workspace_role_list}                      xpath=//span[@role="listbox"]//i                                                                        # workspace role list
${second_workspace_xpath}                   xpath=//ul[@role="listbox" and @class="k-list k-reset"]/li[2]                                           # second workspace xpath
${expand_workspace_button}                  xpath=//span[@role="listbox"]//i                                                                        # expand workspace button
${WS_E_update_workspace}                    xpath=//div[@class="k-list-scroller"]//li[contains(.,'WS-E update')]                                    # WS-E update workspace
${Canada_workspace}                         xpath=//div[@class="k-list-scroller"]//li[contains(.,'Canada')]                                         # Canada workspace
${created_workspace}                        xpath=//div[@class="k-list-scroller"]//li[contains(.,'Huiming.shi_Added_WS')]                           # 我创建的WS(big_admin)
${created_workspace_branding_1}             xpath=//div[@class="k-list-scroller"]//li[contains(.,'WS_branding_setting_WS1')]                        # 我创建的WS(huiming.shi)
${created_workspace_branding_2}             xpath=//div[@class="k-list-scroller"]//li[contains(.,'WS_branding_setting_WS2')]                        # 我创建的WS(huiming.shi)
${created_workspace_branding_3}             xpath=//div[@class="k-list-scroller"]//li[contains(.,'WS_branding_setting_WS3')]                        # 我创建的WS(huiming.shi)
${avator_has_picture_src}                   https://s3.cn-north-1.amazonaws.com.cn                                                                  # avator's src when has picture
${avator_has_no_picture_src}                https://s3.cn-north-1                                                                                   # avator's src when has no picture
${accept_disclaimer}                        xpath=//button[contains(.,'ACCEPT')]                                                                    # accept disclaimer
${enter_details_tag}                        xpath=//h4[contains(.,'Participants')]                                                                  # enter details tag
${click_on_ellipses}                        xpath=//span[@class="k-icon k-i-more-horizontal"]                                                       # Click on ellipses
${delete_screen_capture}                    xpath=//button[contains(.,'Delete')]                                                                    # delete screen capture
${view_screen_capture}                      xpath=//button[contains(.,'View')]                                                                      # view screen capture
${current_account_xpath}                    xpath=//button[@id="currentAccount"]                                                                    # current account xpath
${message_text}                             xpath=//div[@class="k-notification-content"]/span                                                       # Prompt information
${workspace_settings_tag}                   xpath=//h1[contains(.,'Workspace Settings')]                                                            # Workspace Settings tag
${Slytherin_workspace}                      xpath=//div[@class="k-list-scroller"]//li[contains(.,'Slytherin')]                                      # Slytherin🐍 workspace
${call_button_xpath}                        xpath=//button[contains(.,'Call')]                                                                      # Call button
${first_line_username}                      xpath=//div[@class="ag-center-cols-container"]//div[@row-index="0"]//div[@class="cardName"]             # first line username
${first_line_tagname}                       xpath=//div[@class="ag-center-cols-container"]//div[@row-index="0"]/div[@col-id="tags"]                 # first line tagname
${search_input}                             xpath=//input[@id="filter-text-box"]                                                                    # search input
${second_data_show}                         xpath=//div[@class="ag-center-cols-container"]/div[@row-index="1"]                                      # Wait until the second row shows up
${favorite_or_not}                          xpath=//div[@class="favorite-div"]/i                                                                    # favorite or not favorite
${team_favorite_or_not}                     xpath=//div[@id="user-tabs-pane-team"]//div[@class="favorite-div"]                                      # Team page favorite or not favorite
${personal_favorite_or_not}                 xpath=//div[@id="user-tabs-pane-personal"]//div[@class="favorite-div"]                                  # Personal page favorite or not favorite
${enter_ws_settings_success}                xpath=//div[@class="feature-section"]                                                                   # 切换到WorkSpace Setting页面成功的标志
${ellipsis_menu_div}                        xpath=//div[@class="ellipsis-menu-div"]                                                                 # user右边的省略号
${directory_search_count}                   xpath=//div[@id="user-tabs-pane-directory"]//div[@class="ag-center-cols-container"]/div
${team_search_count}                        xpath=//div[@id="user-tabs-pane-team"]//div[@class="ag-center-cols-container"]/div
${favorites_search_count}                   xpath=//div[@id="user-tabs-pane-favorites"]//div[@class="ag-center-cols-container"]/div
${personal_search_count}                    xpath=//div[@id="user-tabs-pane-personal"]//div[@class="ag-center-cols-container"]/div
${directory_page_id}                        xpath=//div[@id="user-tabs-pane-directory"]
${team_page_id}                             xpath=//div[@id="user-tabs-pane-team"]
${favorites_page_id}                        xpath=//div[@id="user-tabs-pane-favorites"]
${personal_page_id}                         xpath=//div[@id="user-tabs-pane-personal"]
${directory_first_data_show}                xpath=//div[@id="user-tabs-pane-directory"]//div[@class="ag-center-cols-container"]/div[@row-index="0"]
${team_first_data_show}                     xpath=//div[@id="user-tabs-pane-team"]//div[@class="ag-center-cols-container"]/div[@row-index="0"]
${favorites_first_data_show}                xpath=//div[@id="user-tabs-pane-favorites"]//div[@class="ag-center-cols-container"]/div[@row-index="0"]
${personal_first_data_show}                 xpath=//div[@id="user-tabs-pane-personal"]//div[@class="ag-center-cols-container"]/div[@row-index="0"]
${unreachable_class_content}                ag-cell ag-cell-not-inline-editing ag-cell-with-height unreachableText nameDetailsCell ag-cell-value
# menus count
${menus_count}                              xpath=//div[@role="group"]/div[@role="treeitem"]                                                        # count of menus

# forget password
${forget_password}                          xpath=//a[contains(.,'Forgot Password?')]                                                               # Forgot Password? button
${send_reset_password_email}                xpath=//button[contains(.,'Send Reset Password Email')]                                                 # Send Reset Password Email button
${prompt_information}                       xpath=//div[@class="k-notification-content"]                                                            # Prompt information
${chage_passwd_button}                      xpath=//button[@class="k-button k-primary"]                                                             # Change my password button
${input_passwd}                             xpath=//input[@name="password"]                                                                         # password entry box
${input_passwordConfirm}                    xpath=//input[@name="passwordConfirmation"]                                                             # passwordConfirm entry box

# Cognito
${cognito_username}                     xpath=//div[@class="modal-dialog"]/div[2]//input[@id="signInFormUsername"]                                  # Cognito username input
${cognito_password}                     xpath=//div[@class="modal-dialog"]/div[2]//input[@id="signInFormPassword"]                                  # Cognito password input
${cognito_sign_in}                      xpath=//div[@class="modal-dialog"]/div[2]//input[@name="signInSubmitButton"]                                # Cognito Sign in
${cognito_sign_up}                      xpath=//div[@class="modal-dialog"]/div[2]//a[contains(.,'Sign up')]                                         # Cognito Sign up
${cognito_sign_up_username}             xpath=//div[@class="modal-dialog"]/div[1]//input[@placeholder="name@host.com"]                              # Cognito Sign up username input
${cognito_sign_up_password}             xpath=//div[@class="modal-dialog"]/div[1]//input[@placeholder="Password"]                                   # Cognito Sign up password input
${cognito_sign_up_sign_up}              xpath=//div[@class="modal-dialog"]/div[1]//button[contains(.,'Sign up')]                                    # Cognito Sign up Sign up button
${cognito_verification_code}            xpath=//input[@id="verification_code"]                                                                      # verification code input
${cognito_confirm_account}              xpath=//button[contains(.,'Confirm Account')]                                                               # Confirm Account

# 修改的xpath
${latest_modified_window_ok_button}     xpath=//button[@class="k-button k-primary ml-4" and text()="Ok"]                                            # 最近修改成的弹框的OK按钮，之前是alert的，后面修改了

# Citron 网址
${Citron_web_url}                       https://app-stage.helplightning.net.cn                                                                      # Citron的网址

# 左上角显示的logo
${left_top_big_logo}                    xpath=//div[@class="topbar"]/a                                                                              # 左上角显示的logo