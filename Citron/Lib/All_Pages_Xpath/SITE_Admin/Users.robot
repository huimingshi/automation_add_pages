*** Variables ***
# user
${button_add_user}                      xpath=//button[contains(.,'Add User')]                                                      # add user button
${input_email}                          xpath=//input[@name="email"]                                                                # email entry box
${my_existent_email_name}               Huiming.shi.helplightning                                                                   # My existent email
${input_name}                           xpath=//input[@placeholder="Name"]                                                          # name entry box
${groups_input}                         xpath=//input[@placeholder="Groups"]                                                        # groups entry box
${title_input}                          xpath=//input[@placeholder="Title"]                                                         # Title entry box
${location_input}                       xpath=//input[@placeholder="Location"]                                                      # Location entry box
${button_ADD}                           xpath=//div[@class="form-group"]//button[contains(text(),"Add")][2]                         # ADD button
${group_admin_for_choose}               xpath=//label[contains(.,'Group Admin for')]/../div//input                                  # Group Admin for choose
${confirm_invite_button}                xpath=//button[contains(.,'Invite')]                                                        # Please confirm---INVITE button
${prompt_information}                   xpath=//div[@class="k-notification-content"]                                                # Description Added or modified successfully
${confirm_text}                         xpath=//p[@class="confirm-text"]                                                            # warning dialog confirm-text
${message_text}                         xpath=//div[@class="k-notification-content"]/span                                           # Prompt information
${workspaces_input}                     xpath=//input[@placeholder="Workspaces"]                                                    # Workspaces input
${add_another_input}                    xpath=//button[contains(.,'Submit and Add Another')]                                        # Submit and Add Another button
${send_reset_password_email}            xpath=//button[contains(.,'Send Reset Password Email')]                                     # Send Reset Password Email button
${update_user_button}                   xpath=//button[contains(.,'Update User')]                                                   # Update User button
${cancel_add_user_button}               xpath=//div[@class="UserInvite"]//button[contains(.,'Cancel')]                              # Cancel button
${upload_photo_button}                  xpath=//input[@type="file"]                                                                 # Upload a photo button
${upload_avator_button_xpath}           xpath=//button[contains(.,'Upload a photo...')]                                             # Upload a photo... button
${remove_avatar_button}                 xpath=//button[contains(.,"Remove avatar")]                                                 # Remove avatar button
${license_type_select}                  xpath=//span[@role="listbox"]/span[@class="k-select"]                                       # license type select button
${team_license_type}                    xpath=//div[@class='k-list-scroller']//div[@class='Content']//b[contains(.,'Team')]         # team license type
${expert_license_type}                  xpath=//div[@class='k-list-scroller']//div[@class='Content']//b[contains(.,'Expert')]       # Expert license type
${username_input}                       xpath=//input[@placeholder="Username"]                                                      # Username input
${role_select}                          xpath=//select[@name="role"]                                                                # select Role
${select_site_admin}                    xpath=//option[contains(.,'Site Admin')]                                                    # select Site Admin
${workspace_again_input}                xpath=//label[contains(.,'Workspaces')]/..//input                                           # Choose Workspaces again
${avatar_preview}                       xpath=//img[@class="avatar-preview"]                                                        # avatar preview img
${default_avatar}                       xpath=//img[@class="avatar-preview-default"]                                                # There is no avatar
${deactivate_user_button}               xpath=//button[contains(.,"Deactivate User")]                                               # Deactivate User button
${details_pre_xpath}                    xpath=//b[contains(.,'User Details - auto_default_workspace Workspace')]/../../..           # The pre-xpath for the second User Details page
${add_pre_xpath}                        xpath=//b[contains(.,'Add User - auto_default_workspace Workspace')]/../../..               # The pre-xpath for the second Add User page
${user_details_button}                  xpath=//button[contains(.,'Details')]                                                       # Details button
${button_Upload}                        xpath=//input[@type="file"]                                                                 # Upload a photo
${button_Remove}                        xpath=//button[contains(.,"Remove avatar")]                                                 # Remove avatar button
${add_WS_xpath}                         xpath=//span[@class="k-searchbar"]                                                          # 添加WS的按钮
${was_successfully_invited}             was successfully invited.                                                                   # was successfully invited.提示信息
# Deactivated Users page
${deactivated_users_page}               xpath=//span[contains(.,'Deactivated Users')]                                               # Deactivated Users page
