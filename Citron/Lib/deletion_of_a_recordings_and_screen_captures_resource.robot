*** Settings ***
Library           Collections
Library           Selenium2Library
Library           DateTime
Library           String
Resource          public.robot
Resource          All_Pages_Xpath/WS_Admin/Calls.robot
Resource          All_Pages_Xpath/crunch_page.robot
Resource          All_Pages_Xpath/public_xpath.robot
Library           python_Lib/ui_keywords.py

*** Variables ***
# user for call
${site_admin_email}                             huiming.shi@helplightning.com
${normal_usernameA_for_calls}                   Huiming.shi.helplightning+123456789
${call_time}                                    20


*** Keywords ***
enter_site_calls
    # enter SITE ADMINISTRATION Users page
    click element   ${enter_site_menu}
    sleep  0.5s
    # click Calls page menu
    click element   ${enter_calls}
    sleep  1s
    # Wait until the first row shows up
    wait until element is visible    ${first_data_show}    20

enter_workspace_workspace_settings
    # click workspace ADMINISTRATION page menu
    click element   ${enter_workspace_menu}
    sleep  1s
    # click Users page menu
    click element   ${enter_Workspace_settings}
    sleep  2s
    # Wait until enter page
    wait until element is visible   ${workspace_settings_tag}    20

#enter_workspace_calls
#    # click workspace ADMINISTRATION menu
#    click element   ${enter_workspace_menu}
#    sleep  1s
#    # click Users page menu
#    click element   ${enter_calls}
#    wait until element is visible    ${occurred_within_choose}
#    wait until element is visible    ${ws_calls_first_data_show}

#enter_group_calls
#    # click workspace ADMINISTRATION menu
#    click element   ${enter_group_menu}
#    sleep  0.5s
#    # click Users page menu
#    click element   ${enter_calls}
#    sleep  3s

enter_normal_recents
    # click Recents button
    click element    ${enter_recents}
    sleep  2s
    wait until element is visible    ${details_button}

enter_enterprises_audit_log
    # enter crunch Audit Logs page
    click element    ${audit_log_menu}
    wait until element is visible     ${audit_log_table}//tr[2]    20s
    sleep  3s

select_one_call_has_screen_capture
    [Arguments]   ${call_username}
    # select one call that has Screen Capture
    click element   ${search_input}
    sleep  0.5s
    input text   ${search_input}   ${call_username}
    sleep  3s
    # click DETAILS button
    click element   ${first_data_Details}
    wait until element is visible   ${enter_details_tag}

normal_user_select_one_call_has_screen_capture
    # click DETAILS button
    click element  ${first_data_Details}
    wait until element is visible  ${enter_details_tag}

click_one_screenshot
    # 在通话详情页面点击一个截图
    wait until element is visible   ${call_detail_screenshot}
    click element    ${call_detail_screenshot}
    # 截图后出现的的删除按钮
    wait until element is visible    ${delete_screenshot_button}

click_delete_screenshot
    # 点击截图后出现的的删除按钮
    click element   ${delete_screenshot_button}

check_delete_screen_capture
    # 滑动到底
    swipe_browser_to_bottom
    # 在通话详情页面点击一个截图
    click_one_screenshot
    # 点击截图后出现的的删除按钮
    click_delete_screenshot
    # The confirm window should be shown up
    ${count}   get element count   xpath=//div[@class="modal-body" and text()="Are you sure you want to delete this screen capture?"]
    should be equal as strings   ${count}   1
    # Click Cancel button,
    click element   xpath=//button[@class="k-button" and text()="Cancel"]
    sleep  1s
    # the Screen Capture should not be deleted.
    ${count}  get element count   ${call_detail_screenshot}
    should be equal as integers   ${count}   3
    ${count}  get element count   ${attachment_selectable_selected}
    should be equal as integers   ${count}   1
    # 点击截图后出现的的删除按钮
    click_delete_screenshot
    # Click Yes button
    click element    ${latest_modified_window_ok_button}
    sleep  1s
    # this screen capture is removed from the list and server
    ${count}  get element count   ${call_detail_screenshot}
    should be equal as integers   ${count}   3
    ${count}  get element count   ${attachment_selectable_selected}
    should be equal as integers   ${count}   0

delete_record_in_crunch_is_correct
    [Arguments]   ${expect_delete_log}
    # check modify record in crunch is correct
    @{LogList}=    Create List
    FOR   ${i}   IN RANGE   20
        ${get_log}   get text    ${audit_log_table}//tr[${i}+1]/td[5]
        Append To List    ${LogList}    ${get_log}
    END
    log  ${LogList}
    should contain   ${LogList}    ${expect_delete_log}

delete_menu_is_not_visible
    # delete menu is not visible
    wait until element is visible    ${click_on_ellipses}   20
    click element   ${click_on_ellipses}
    sleep  1s
    element should not be visible    ${delete_screen_capture}

set_recordings_and_screen_open
    ${count}   get element count   ${recordings_and_screen_open}
    Run Keyword If   '${count}'=='1'   click element   ${recordings_and_screen_open}