*** Variables ***
# crunch page
${Enterprises_menu}                     xpath=//a[text()=" Sites"]                                                  # crunch Enterprises menu
${audit_log_menu}                       xpath=//a[contains(.,' Audit Logs')]                                        # crunch Audit Logs menu
${audit_log_table}                      xpath=//table[@class="table table-striped"]                                 # crunch Audit Logs table
# new enterprises
${my_existent_email_name}               Huiming.shi.helplightning                                                   # My existent email
${new_enterprice_button}                xpath=//button[@class="btn btn-xs btn-link"]                                # new enterprice button
${enterprice_name_input}                xpath=//input[@name="businessName"]                                         # enterprice name input
${contact_name_input}                   xpath=//input[@name="contactName"]                                          # contact name input
${contact_email_input}                  xpath=//input[@name="email"]                                                # contact email input
${plan_select}                          xpath=//select[@name="plan"]                                                # plan select
${select_enterprise}                    xpath=//option[contains(.,'Enterprise')]                                    # select Enterprise plan
${register_button}                      xpath=//button[@type="submit" and contains(.,'Register')]                   # Register button