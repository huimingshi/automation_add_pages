*** Variables ***
# Analytics
${groups_choose}                        xpath=//label[contains(.,'Group')]/following-sibling::select                        # Group choose select
${total_users}                          xpath=//td[contains(.,'Total Users')]/following-sibling::td[1]/span                 # Total Users