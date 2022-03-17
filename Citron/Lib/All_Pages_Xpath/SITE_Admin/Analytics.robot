*** Variables ***
# Analytics
${number_of_completed_calls}                xpath=//th[contains(.,'Completed Calls')]/../../../..//p[@class="BigNumber"]        # the number of Completed Calls
${number_of_calls_by_group}                 xpath=//th[contains(.,'Calls by Group')]/../../../..//td[@class="Key"]              # the number of Calls by Group
${number_of_tag_rankings}                   xpath=//th[contains(.,'Tag Rankings')]/../../../..//td[@class="Key"]                # the number of Tag Rankings
${workspace_select_box}                     xpath=//label[contains(.,'Workspace')]/..//select[@id="occured-within"]             # workspace select box
${number_of_total_users}                    xpath=//td[contains(.,'Total Users')]/..//span[@class="MediumText"]                 # the number of Total Users