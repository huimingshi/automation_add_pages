*** Variables ***
# Site Settings
${site_name_input}                      xpath=//input[@name="name"]                                                 # Site Name input
${time_zone_select}                     xpath=//select[@name="time_zone"]                                           # Time Zone select
${contact_name_input1}                  xpath=//input[@name="contact_name"]                                         # Contact Name input
${contact_email_input1}                 xpath=//input[@name="contact_email"]                                        # Contact Email input
${contact_phone_input}                  xpath=//input[@name="contact_phone"]                                        # Contact Phone input
${update_settings_button}               xpath=//button[contains(.,'Update')]                                        # Update Site Settings button