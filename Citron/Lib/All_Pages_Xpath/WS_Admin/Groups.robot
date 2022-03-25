*** Variables ***
# Groups
${switch_to_groups_success}                 xpath=//h1[text()="Groups"]                                                                 # 切换到Groups页面成功
${create_group_button}                      xpath=//button[contains(.,'Create Group')]                                                  # Create Group button
${group_name_input}                         xpath=//input[@placeholder="Enter a name"]                                                  # Group Name input
${description_input}                        xpath=//textarea[@placeholder="Enter a brief description"]                                  # Description input
${choose_file}                              xpath=//input[@accept="image/*"]                                                            # Choose File
${group_visibility_input}                   xpath=//input[@placeholder="Add Member Groups"]                                             # Group Visibility input
${OnCall_group_visibility_input}            xpath=//input[@placeholder="Add On-Call groups"]                                            # On-Call Group Visibility input
${group_list_search}                        xpath=//input[@id="filter-text-box"]                                                        # group list search input
${members_button}                           xpath=//button[contains(.,'Members')]                                                       # Members button
${edit_members_search}                      xpath=//input[@id="quick-search-text-box"]                                                  # Edit Members Search Users input
${choose_group_admin}                       xpath=//input[@placeholder="Choose users"]                                                  # choose Group Administrators input
${On_Call_notifications}                    xpath=//input[@placeholder="Enter email address (optional)"]                                # On-Call Notifications input
${update_details_button}                    xpath=//button[contains(.,'Update Details')]                                                # Update Details button
${delete_group_button}                      xpath=//button[contains(.,'Delete Group')]                                                  # Delete Group button
${group_details_button}                     xpath=//button[contains(.,'Details')]                                                       # Details button
# Edit Members
${edit_members_button}                      xpath=//button[contains(.,'Edit Members')]                                                  # Edit Members button
${first_line_use_name}                      xpath=//div[@class="modal-content"]//div[@row-index="0"]/div[2]//div[@class="cardName"]     # User name in the first line
${search_users_input}                       xpath=//input[@id="quick-search-text-box"]                                                  # Search Users input
${add_more_users_button}                    xpath=//button[contains(.,'Add More Users...')]                                             # Add More Users... button
${del_or_add_button}                        xpath=//button[@class="k-button includeUserButton"]                                         # del or add button
${ok_button}                                xpath=//button[contains(.,'OK')]                                                            # OK button

