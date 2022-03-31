*** Variables ***
# add user
${button_add_user}                      xpath=//button[contains(.,'Add User')]                                                  # add user button
${input_email}                          xpath=//input[@name="email"]                                                            # email entry box
${my_existent_email_name}               Huiming.shi.helplightning                                                               # My existent email
${input_name}                           xpath=//input[@name="name"]                                                             # name entry box
${groups_input}                         xpath=//input[@placeholder="Groups"]                                                    # groups entry box
${button_ADD}                           xpath=//div[@class="form-group"]//button[contains(text(),"Add")][2]                     # ADD button
${group_admin_for_choose}               xpath=//label[contains(.,'Group Admin for')]/../div//input                              # Group Admin for choose
${confirm_invite_button}                xpath=//button[contains(.,'Invite')]                                                    # Please confirm---INVITE button
${prompt_information}                   xpath=//div[@class="k-notification-content"]                                            # Description Added or modified successfully
${confirm_text}                         xpath=//p[@class="confirm-text"]                                                        # warning dialog confirm-text
${message_text}                         xpath=//div[@class="k-notification-content"]/span                                       # Prompt information
${submit_and_add_another}               xpath=//button[contains(.,'Submit and Add Another')]                                    # Submit and Add Another button
# Deactivated Users page
${deactivated_users_page}               xpath=//span[contains(.,'Deactivated Users')]                                           # Deactivated Users page
${activate_user_button}                 xpath=//button[contains(.,'Activate User')]                                             # Activate User button
# user modify
${button_Upload}                        xpath=//input[@type="file"]                                                             # Upload a photo
${upload_avatar_button}                 xpath=//button[contains(.,'Upload a photo...')]                                         # Upload a photo... button
${button_Remove}                        xpath=//button[contains(.,"Remove avatar")]                                             # Remove avatar button
${username_input}                       xpath=//input[@placeholder="Username"]                                                  # Username entry box
${name_input}                           xpath=//input[@placeholder="Name"]                                                      # Name entry box
${title_input}                          xpath=//input[@placeholder="Title"]                                                     # Title entry box
${location_input}                       xpath=//input[@placeholder="Location"]                                                  # Location entry box
${mobile_input}                         xpath=//input[@placeholder="Mobile Phone"]                                              # Mobile Phone entry box
${groups_add}                           xpath=//input[@autocomplete="off"]                                                      # Groups add button
${cancel_button}                        xpath=//div[@class="col-sm-8 col-sm-offset-2"]/button[contains(.,'Cancel')]             # CANCEL button
${update_button}                        xpath=//button[contains(.,"Update User")]                                               # Update User button
${deactivate_user_button}               xpath=//button[contains(.,'Deactivate User')]                                           # Deactivate User button
${send_reset_button}                    xpath=//button[contains(.,'Send Reset Password Email')]                                 # Send Reset Password Email button
${second_groups_delete_button}          xpath=//ul/li[2]//span[@aria-label="delete"]                                            # second groups delete button
${first_groups_delete_button}           xpath=//span[@aria-label="delete"]                                                      # first groups delete button
${no_groups_tips}                       xpath=//span[contains(.,'You must specify at least one group')]                         # no groups tips
${role_select}                          xpath=//select[@name="role"]                                                            # role select button
${license_type_select}                  xpath=//span[@role="listbox"]/span[@class="k-select"]                                   # license type select button
${select_workspace_admin}               xpath=//option[contains(.,'Workspace Admin')]                                           # select Workspace Admin role
${select_group_admin}                   xpath=//option[contains(.,'Group Admin')]                                               # select Group Admin role
${select_user}                          xpath=//option[contains(.,'User')]                                                      # select User role
${team_license_type}                    xpath=//div[@class='k-list-scroller']//div[@class='Content']//b[contains(.,'Team')]     # team license type
${add_second_group}                     xpath=//label[contains(.,'Groups')]/..//input[@autocomplete="off"]                      # add second group input
${add_another_group}                    xpath=//input[@placeholder="Groups"]                                                    # add another group input
${mobile_phone_input}                   xpath=//input[@placeholder="Mobile Phone"]                                              # Mobile Phone input
${wrong_phone_tag}                      xpath=//span[contains(.,'This is not a valid phone number')]                            # This is not a valid phone number
${Remove_avatar_button}                 xpath=//button[contains(.,'Remove avatar')]                                             # Remove avatar'
# user modify check
${after_modify_name}                    xpath=//div[@class="cardName"]                                                          # name after modify
${after_modify_title}                   xpath=//div[@class="text-muted cardSub"][1]                                             # title after modify
${after_modify_location}                xpath=//div[@class="text-muted cardSub"][2]                                             # location after modify
${first_groups_name}                    xpath=//li[@class="k-button"][1]/span[1]                                                # first groups name
${second_groups_name}                   xpath=//li[@class="k-button"][2]/span[1]                                                # second groups name
# active users search
${active_users_page}                    xpath=//span[contains(.,'Active Users')]                                                # Active Users page
${button_DETAILS}                       xpath=//button[contains(text(),"Details")]                                              # DETAILS button
${first_line_data}                      xpath=//div[@class="ag-center-cols-container"]//div[@row-index="0"]                     # The first row of data
# Invitations
${invitations_page}                     xpath=//span[contains(.,'Invitations')]                                                 # Invitations page
${resend_invitation}                    xpath=//div[@row-index="0"]//button[contains(.,'Resend')]                               # Resend Invitation
${cancel_invitation}                    xpath=//div[@row-index="0"]//button[contains(.,'Cancel')]                               # Cancel Invitation
${resend_all_invitation}                xpath=//button[contains(.,'Resend All')]                                                # Resend All Invitations
${cancel_all_invitation}                xpath=//button[contains(.,'Cancel All')]                                                # Cancel All Invitations
${Invitation_has_been_sent}             xpath=//span[contains(.,'Invitation has been sent')]                                    # Invitation has been sent提示信息
${Invitations_has_been_sent}            xpath=//span[contains(.,'Invitations has been sent')]                                   # Invitations has been sent提示信息
# export
${report_view_button}                   xpath=//button[contains(.,'Report View')]                                               # Report View button
# Export to CSV
${export_to_CSV_button}                 xpath=//button[contains(.,'Export to CSV')]                                             # Export to CSV
# Invitations sort
${report_view_button}                       xpath=//button[contains(.,'Report View')]                                           # Report View button
${sort_by_name}                             xpath=//span[contains(.,'Name')]                                                    # sort by name
${sort_by_email}                            xpath=//span[contains(.,'Email')]                                                   # sort by Email
${sort_by_role}                             xpath=//span[contains(.,'Role')]                                                    # sort by Role
${sort_by_groups}                           xpath=//div[@ref="eLabel"]/span[contains(.,'Groups')]                               # sort by Groups
${sort_by_timestamp}                        xpath=//span[contains(.,'Sent')]                                                    # sort by timestamp