*** Variables ***
# Calls
${occurred_within_choose}                   xpath=//label[contains(.,'Occurred Within')]/following-sibling::select                          # Occurred Within choose
${calls_last_365_days_select}               xpath=//option[contains(.,'Last 365 Days')]                                                     # Last 365 Days选项
${first_call_time}                          xpath=//div[@class="ag-center-cols-container"]/div[@row-index="0"]/div[5]                       # The time of the first call
${export_button}                            xpath=//button[contains(.,'Export')]                                                            # Export button
${export_current_table}                     xpath=//button[contains(.,'Export Current Table')]                                              # Export Current Table button
${generate_table}                           xpath=//button[contains(.,'Generated')]                                                         # Generated Table button
${generate_new_call_report}                 xpath=//button[contains(.,'Generate New Call Report')]                                          # Generate New Call Report button
${generated_table}                          xpath=//button[contains(.,'Generated')]                                                         # Generated X minutes age button
${Preparing_Call_Report}                    xpath=//h4[contains(.,'Preparing Call Report:')]                                                # Preparing Call Report
${add_tags_input}                           xpath=//input[@type="text" and @role="listbox"]                                                 # Add tags...  input
${delete_tags_button}                       xpath=//span[@aria-label="delete"]                                                              # delete tags button
${add_comment_input}                        xpath=//textarea[@placeholder="Add a comment..."]                                               # Add a comment...  input
${details_save_button}                      xpath=//div[@class="CallDetails"]//button[contains(.,'Save')]                                   # details SAVE button
${close_details_button}                     xpath=//div[@class="modal-header"]//span[contains(.,'×')]                                       # close details button
${calls_details_button}                     xpath=//div[@row-index="0"]//button[contains(.,'Details')]                                      # Calls Details button
${calls_get_counts}                         xpath=//span[@ref="lbRecordCount"]                                                              # Calls counts
${participant_name}                         xpath=//table[@class="table table-striped"]//a                                                  # participant name
${tag_count}                                xpath=//ul[@role="listbox"]//a/span                                                             # tag count
${comment_count}                            xpath=//div[@class="comment-text row"]                                                          # comment count
${view_count}                               xpath=//button[contains(.,'View')]/../..                                                        # view count
${call_button_xpath}                        xpath=//button[contains(.,'Call')]                                                              # Call button
${ws_calls_first_data_show}                 xpath=//div[@class="ag-center-cols-container"]/div[@row-index="0"]/div[1]                       # 首行数据