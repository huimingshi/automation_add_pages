*** Variables ***
# Workspace Settings
${workspace_settings_tag}                       xpath=//h1[contains(.,'Workspace Settings')]                                                                                # Workspace Settings tag
${open_tag_and_comment}                         xpath=//h1[contains(.,"After Call: Tagging and Comments")]/../..//div[@class="react-toggle"]                                # open After Call: Tagging and Comments settings
${on_status_xpath}                              xpath=//h1[contains(.,'After Call: Tagging and Comments')]/../..//div[@class="react-toggle react-toggle--checked"]          # on status xpath
${off_status_xpath}                             xpath=//h1[contains(.,'After Call: Tagging and Comments')]/../..//div[@class="react-toggle"]
${recordings_and_screen_open}                   xpath=//h1[contains(.,'After Call: Tagging and Comments')]/../..//div[@class="react-toggle"]                                # Set Recordings and Screen Captures open

${primary_contact_workspace_name}               xpath=//input[@name="name"]                                                                                                 # Primary Contact Workspace Name
${primary_contact_time_zone}                    xpath=//select[@name="time_zone"]                                                                                           # Primary Contact Time Zone
${primary_contact_contact_name}                 xpath=//input[@name="contact_name"]                                                                                         # Primary Contact Contact Name
${primary_contact_contact_email}                xpath=//input[@name="contact_email"]                                                                                        # Primary Contact Contact Email
${primary_contact_contact_phone}                xpath=//input[@name="contact_phone"]                                                                                        # Primary Contact Contact Phone
${primary_contact_update}                       xpath=//button[contains(.,'Update')]                                                                                        # Primary Contact Update button
${disclaimer_delete_user}                       xpath=//h1[contains(.,'Before Call: Disclaimer')]/../..                                                                     # Before Call: Disclaimer----Delete Users choose
${reset_all_disclaimers}                        xpath=//button[contains(.,'Reset All Accepted Disclaimers')]                                                                # Reset All Accepted Disclaimers button
${reset_all_accepted_disclaimers_ok}            xpath=//div[@role="dialog"]//button[text()='OK']                                                                            # Reset All Accepted Disclaimers OK
${disable_external_users}                       xpath=//h1[contains(.,'Security: Disable External Users')]/../..                                                            # Disable External Users button
${workspace_directory}                          xpath=//h1[contains(.,'Workspace Directory')]/../..                                                                         # Workspace Directory button
${directory_turn_on}                            xpath=//h1[contains(.,'Workspace Directory')]/../..//div[@class="react-toggle"]                                             # turn on Workspace Directory
${directory_turn_off}                           xpath=//h1[contains(.,'Workspace Directory')]/../..//div[@class="react-toggle react-toggle--checked"]                       # turn off Workspace Directory
${directory_switch_button}                      xpath=//h1[contains(.,'Workspace Directory')]/../..//div[@class="react-toggle-track"]                                       # on/off switch button:Workspace Directory
${tagging_and_comments}                         xpath=//h1[contains(.,'After Call: Tagging and Comments')]/../..                                                            # After Call: Tagging and Comments button
${survey_expand}                                xpath=//h1[contains(.,'After Call: End of Call Survey')]/../..//button[contains(.,'Expand')]                                # After Call: End of Call Survey Expand button
${switch_survey_close}                          xpath=//h1[contains(.,'After Call: End of Call Survey')]/../..//div[@class="react-toggle"]                                  # After Call: End of Call Survey open
${switch_survey_open}                           xpath=//h1[contains(.,'After Call: End of Call Survey')]/../..//div[@class="react-toggle react-toggle--checked"]            # After Call: End of Call Survey close
${survey_url_text}                              xpath=//div[@class="survey-options"]//button                                                                                # survey URL text
${survey_url_input}                             xpath=//input[@id="edit-input-field"]                                                                                       # survey URL input
${survey_url_save}                              xpath=//i[@class="fa fa-lg fa-save"]                                                                                        # survey URL save
${while_list_value}                             https://surveys.google.com/asdf1234?call=@CALL_ID@&user=@USER_NAME@                                                         # Value is in White List# off status xpath

# Retention Policy: Recordings and Screen Captures
${RaSC_pre_xpath}                               xpath=//h1[contains(.,'Retention Policy: Recordings and Screen Captures')]/../..                                            # pre xpath:Retention Policy: Recordings and Screen Captures
${RaSC_on_status_text}                          Recordings will be deleted after 60 days.                                                                                   # on status text:Retention Policy: Recordings and Screen Captures
${RaSC_off_status_text}                         Recordings will be deleted after the default value of 60 days.                                                              # off status text:Retention Policy: Recordings and Screen Captures
${RaSC_click_to_edit}                           xpath=//h1[contains(.,'Retention Policy: Recordings and Screen Captures')]/../..//button[contains(.,'Click to edit')]       # Click to edit button:Retention Policy: Recordings and Screen Captures
${RaSC_switch_button}                           xpath=//h1[contains(.,'Retention Policy: Recordings and Screen Captures')]/../..//div[@class="react-toggle-track"]          # on/off switch button:Retention Policy: Recordings and Screen Captures
${RaSC_set_day}                                 xpath=//input[@name="retentionValue"]                                                                                       # set day input :Retention Policy: Recordings and Screen Captures
${RaSC_save_button}                             xpath=//form[@class="retention-field"]//button[@type="submit"]                                                              # Save button :Retention Policy: Recordings and Screen Captures
${RaSC_cancel_button}                           xpath=//form[@class="retention-field"]//button[contains(.,'Cancel')]                                                        # Cancel button :Retention Policy: Recordings and Screen Captures
${RaSC_off_status_text_xpath}                   xpath=//span[text()="Recordings will be deleted after the default value of 60 days."]

# Retention Policy: Call Logs
${CL_pre_xpath}                                 xpath=//h1[contains(.,'Retention Policy: Call Logs')]/../..                                                                 # pre xpath :Retention Policy: Call Logs
${CL_on_status_text}                            Call Logs will be deleted after 365 days.                                                                                   # on status text:Retention Policy: Call Logs
${CL_off_status_text}                           When activated, Call Logs will be deleted after 365 days.                                                                   # off status text:Retention Policy: Call Logs
${CL_click_to_edit}                             xpath=//h1[contains(.,'Retention Policy: Call Logs')]/../..//button[contains(.,'Click to edit')]                            # Click to edit button
${CL_switch_button}                             xpath=//h1[contains(.,'Retention Policy: Call Logs')]/../..//div[@class="react-toggle-track"]                               # on/off switch button:Retention Policy: Call Logs
${CL_set_day}                                   xpath=//input[@name="retentionValue"]                                                                                       # set day input :Retention Policy: Call Logs
${CL_save_button}                               xpath=//form[@class="retention-field"]//button[@type="submit"]                                                              # Save button:Retention Policy: Call Logs
${CL_cancel_button}                             xpath=//form[@class="retention-field"]//button[contains(.,'Cancel')]                                                        # Cancel button:Retention Policy: Call Logs

# Before Call: Invitation Message
${before_call_invitation_message}               xpath=//h1[contains(.,'Before Call: Invitation Message')]/../..                                                             # Before Call: Invitation Message
${invitation_message_input}                     xpath=//input[@id="edit-input-field"]                                                                                       # Invitation Message填写
${invitation_message_save}                      xpath=//span[@class="input-group-btn"]/button                                                                               # Invitation Message保存
${invitation_message_save_ok}                   xpath=//button[text()="OK"]                                                                                                 # Invitation Message保存OK
${pure_character_invitation_message}            You and I are dark horses

# Workspace Branding
${workspace_branding}                           xpath=//h1[contains(.,'Workspace Branding')]/../..                                                                          # Workspace Branding
${product_name_input}                           xpath=//input[@name="product_name"]
${accent_color_input}                           xpath=//input[@name="accent_color"]
${save_changes_button}                          xpath=//button[text()="Save Changes"]
${change_big_logo}                              xpath=//label[text()="Big Logo"]/..//input[@type="file"]
${big_logo_img}                                 xpath=//label[text()="Big Logo"]/..//img
${change_default_avatar}                        xpath=//label[text()="Default Avatar"]/..//input[@type="file"]
${default_avatar_img}                           xpath=//label[text()="Default Avatar"]/..//img
${close_branding_setting}                       xpath=//div[@class="modal-content"]//button[text()="Close"]

# During Call: Recording
${during_call_recording}                        xpath=//h1[contains(.,'During Call: Recording')]/../..                                                                      # During Call: Recording
${always_on_select}                             xpath=//input[@value="always_on"]                                                                                           # set to always record
${opt_in_select}                                xpath=//input[@value="opt_in"]                                                                                              # set to Default-OFF
${opt_out_select}                               xpath=//input[@value="opt_out"]                                                                                             # set to Default-ON


# Primary Contact
${Updated_Business_settings}                    xpath=//span[contains(.,'Updated Business settings')]                                                                       # Updated Business settings提示信息