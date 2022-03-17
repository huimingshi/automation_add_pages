*** Variables ***
# Contacts
${favorite_button}                      xpath=//div[@class="ag-center-cols-container"]//i                                       # favorite/unfavorite button
${personal_search_input}                xpath=//div[@id="user-tabs-pane-2"]//input[@id="filter-text-box"]                       # personal search
${personal_search_result}               xpath=//div[@id="user-tabs-pane-2"]//div[@class="ag-center-cols-container"]/div         # personal search result
${first_team_username}                  xpath=//div[@id="user-tabs-pane-1"]//div[@row-index="0"]//div[@class="cardName"]        # team page first username
${first_personal_username}              xpath=//div[@id="user-tabs-pane-2"]//div[@row-index="0"]//div[@class="cardName"]        # personal page first username
${team_search_input}                    xpath=//div[@id="user-tabs-pane-1"]//input[@id="filter-text-box"]                       # team search
${team_search_result}                   xpath=//div[@id="user-tabs-pane-1"]//div[@class="ag-center-cols-container"]/div         # team search result
${team_page_call}                       xpath=//div[@id="user-tabs-pane-1"]//button[contains(.,"Call")]                         # team page call button
${personal_page_call}                   xpath=//div[@id="user-tabs-pane-2"]//button[contains(.,"Call")]                         # personal page call button
${send_invite_button}                   xpath=//button[contains(.,"Send Invite")]                                               # Send Invite button
${cancel_send_invite_button}            xpath=//div[@class="modal-body"]//button[contains(.,"Cancel")]                          # Cancel Send Invite button