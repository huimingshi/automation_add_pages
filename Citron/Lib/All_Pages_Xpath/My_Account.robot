*** Variables ***
# My Account
${my_account_name}                      xpath=//input[@placeholder="Name"]                                      # My Account Name
${my_account_title}                     xpath=//input[@placeholder="Title (optional)"]                          # My Account Title
${my_account_location}                  xpath=//input[@placeholder="Location (optional)"]                       # My Account Location
${my_account_update}                    xpath=//button[contains(.,'Update')]                                    # My Account Update button
${my_account_update_success_tag}        xpath=//span[contains(.,'Updated settings sucessfully')]                # My Account Update success tag
${update_password_success_tag}          xpath=//span[contains(.,'Updated password successfully.')]              # My Account Update password success tag
${upload_a_photo}                       xpath=//input[@type="file"]                                             # Upload a photo input
${upload_avatar}                        xpath=//button[contains(.,'Upload a photo...')]                         # Upload a photo... button
${change_avatar}                        xpath=//button[contains(.,"Change avatar...")]                          # Change avatar... button
${remove_avatar}                        xpath=//button[contains(.,"Remove avatar")]                             # Remove avatar button
${default_avatar_src}                   xpath=//img                                                             # default avatar src
${get_avatar_src}                       xpath=//img[@class="avatar-preview"]                                    # get avatar src
${change_password}                      xpath=//button[contains(.,'Change password...')]                        # Change password... button
${current_password}                     xpath=//input[@id="password"]                                           # Current Password
${new_password}                         xpath=//input[@id="new_password"]                                       # New Password
${confirm_password}                     xpath=//input[@id="confirm_password"]                                   # Confirm New Password
${public_password_change}               ^YHN6yhn6yhn                                                            # public password
${mobile_phone_input}                   xpath=//input[@placeholder="Mobile Phone"]                              # Mobile Phone input
${my_account_name_input}                xpath=//input[@placeholder="Name"]                                      # Name Phone input
${my_account_title_input}               xpath=//input[@placeholder="Title (optional)"]                          # Title Phone input
${my_account_location_input}            xpath=//input[@placeholder="Location (optional)"]                       # Location Phone input
${wrong_phone_tag}                      xpath=//span[contains(.,'This is not a valid phone number')]            # This is not a valid phone number
${my_account_update_button}             xpath=//button[contains(.,'Update')]                                    # update button