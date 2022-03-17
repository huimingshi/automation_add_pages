*** Variables ***
# Workspaces
${create_workspace_button}                  xpath=//button[contains(.,'Create Workspace')]                                                      # Create Workspace button
${workspace_add_another_button}             xpath=//button[contains(.,'Create and Add Another')]                                                # Create and Add Another button
${workspace_cancel_button}                  xpath=//form[@class="container-box form-horizontal"]//button[contains(.,'Cancel')]                  # Cancel button
${workspace_create_button}                  xpath=//form[@class="container-box form-horizontal"]//button[contains(.,'Create Workspace')]        # Create Workspace button
${workspace_name_input}                     xpath=//input[@name="name"]                                                                         # Workspace Name input
${workspace_description_input}              xpath=//textarea[@name="description"]                                                               # Description input
${list_edit_members_button}                 xpath=//button[contains(.,'Members')]                                                               # Members button
${edit_members_button}                      xpath=//button[contains(.,'Edit Members')]                                                          # Edit Members button
${add_more_users_button}                    xpath=//button[contains(.,'Add More Users...')]                                                     # Add More Users... button
${edit_members_search_input}                xpath=//input[@id="quick-search-text-box"]                                                          # Search Users input when Edit Members
${edit_members_add_button}                  xpath=//div[@row-index="0"]//button[contains(.,'Add')]                                              # ADD button
${edit_members_delete_button}               xpath=//button[contains(.,'Delete')]                                                                # Delete button
${workspace_update_details_button}          xpath=//button[contains(.,'Update Details')]                                                        # Update Details button
${deactivate_workspace_button}              xpath=//button[contains(.,'Deactivate Workspace')]                                                  # Deactivate Workspace button
${activate_workspace_button}                xpath=//button[contains(.,'Activate Workspace')]                                                    # Activate Workspace button