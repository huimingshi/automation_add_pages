*** Variables ***
# calls
${export_button}                        xpath=//button[contains(.,'Export')]                                        # Export button
${export_current_table_button}          xpath=//button[contains(.,'Export Current Table')]                          # Export Current Table button
${generate_new_call_report_button}      xpath=//button[contains(.,'Generate New Call Report')]                      # Generate New Call Report button
${generated_table}                      xpath=//button[contains(.,'Generated')]                                     # Generated X minutes age button
${tags_column}                          xpath=//div[@col-id="tags" and @role="presentation"]                        # The tags column
${occurred_input}                       xpath=//input[@placeholder="yyyy-mm-dd"]                                    # Occurred input
${occurred_within_choose}               xpath=//label[contains(.,'Occurred Within')]/following-sibling::select      # Occurred Within choose
${calls_last_365_days_select}           xpath=//option[contains(.,'Last 365 Days')]                                 # Last 365 Days选项
${calls_get_counts}                     xpath=//span[@ref="lbRecordCount"]                                          # Calls counts
${Preparing_Call_Report}                xpath=//h4[contains(.,'Preparing Call Report:')]                            # Preparing Call Report

# sort
${report_view_button}                   xpath=//button[contains(.,'Report View')]                                   # Report View button
${sort_by_owner}                        xpath=//span[contains(.,'Owner')]                                           # sort by Owner
${sort_by_owner_email}                  xpath=//span[contains(.,'Owner Email')]                                     # sort by Owner Email
${sort_by_participants}                 xpath=//span[contains(.,'Participants')]                                    # sort by Participants
${sort_by_workspace}                    xpath=//div[@role="presentation"]/span[contains(.,'Workspace')]             # sort by Workspace
${sort_by_occurred}                     xpath=//div[@role="presentation"]/span[contains(.,'Occurred')]              # sort by Occurred
${sort_by_end_status}                   xpath=//span[contains(.,'End Status')]                                      # sort by End Status
${sort_by_duration}                     xpath=//span[contains(.,'Duration')]                                        # sort by Duration
${sort_by_tags}                         xpath=//span[contains(.,'Tags')]                                            # sort by Tags