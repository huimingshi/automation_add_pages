*** Variables ***
# Contacts
${favorite_button}                      xpath=//div[@class="favorite-div"]//i                                                   # favorite/unfavorite button
${personal_search_result}               xpath=//div[@id="user-tabs-pane-2"]//div[@class="ag-center-cols-container"]/div         # personal search result
${first_team_username}                  xpath=//div[@id="user-tabs-pane-team"]//div[@class="ag-center-cols-container"]/div      # team page first username
${first_personal_username}              xpath=//div[@id="user-tabs-pane-personal"]//div[@row-index="0"]//div[@class="cardName"]        # personal page first username
${team_search_result}                   xpath=//div[@id="user-tabs-pane-team"]//div[@class="ag-center-cols-container"]/div      # team search result
${favorites_search_result}              xpath=//div[@id="user-tabs-pane-favorites"]//div[@class="ag-center-cols-container"]/div      # team search result
${team_page_call}                       xpath=//div[@id="user-tabs-pane-1"]//button[contains(.,"Call")]                         # team page call button
${personal_page_call}                   xpath=//div[@id="user-tabs-pane-2"]//button[contains(.,"Call")]                         # personal page call button
${send_invite_button}                   xpath=//div[@class="button invite-btn-container"]                                       # Send Invite button
${cancel_send_invite_button}            xpath=//div[@class="modal-body"]//button[contains(.,"Cancel")]                          # Cancel Send Invite button
${contacts_page_check}                  xpath=//button[text()="Send My Help Space Invitation"]
${personal_search_input}                xpath=//div[@id="user-tabs-pane-personal"]//input[@id="filter-text-box"]                # personal search
${favorites_search_input}               xpath=//div[@id="user-tabs-pane-favorites"]//input[@id="filter-text-box"]               # Favorites search
${team_search_input}                    xpath=//div[@id="user-tabs-pane-team"]//input[@id="filter-text-box"]                    # Team search
${directory_search_input}               xpath=//div[@id="user-tabs-pane-directory"]//input[@id="filter-text-box"]               # Directory search
${first_team_1}                         xpath=//div[@id="user-tabs-pane-team"]//div[@class="ag-center-cols-container"]/div[1]//div[@class="cardName"]     # Team第一行数据的username
${first_team_2}                         xpath=//div[@id="user-tabs-pane-team"]//div[@class="ag-center-cols-container"]/div[2]//div[@class="cardName"]     # Team第二行数据的username
${first_team_3}                         xpath=//div[@id="user-tabs-pane-team"]//div[@class="ag-center-cols-container"]/div[3]//div[@class="cardName"]     # Team第三行数据的username