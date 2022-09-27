*** Variables ***
${send_a_new_message_button}                      //button[text()="SEND A NEW MESSAGE"]                                       # SEND A NEW MESSAGE按钮
${messages_SMHSI_button}                          //button[text()="Send My Help Space Invitation"]                            # Send My Help Space Invitation按钮
${search_messages_box}                            //div[@class="SearchMessages"]//input[@id="quick-search-text-box"]          # Search Messages查询框
${first_messages_info}                            //div[@class="ag-center-cols-viewport"]//div[@row-index="0"]                # 第一个Messages
${search_for_contacts_box}                        //div[@class="MessageGroup_title"]//input[@id="quick-search-text-box"]      # Search for contacts查询框
${first_search_contact}                           //div[@class="ag-center-cols-container"]/div[@row-index="0"]                # Search for contacts的第一个user
${create_message_group_button}                    //div[@class="MessageGroup_Tool_buttons"]/button[text()="CREATE"]           # Create Message Group按钮
${ChatSessionList_name}                           //div[@class="ChatSessionList_name"]                                        # 消息列表对应的username
${ChatSessionList_lastMessages}                   //div[@class="ChatSessionList_lastMessages"]                                # 消息列表对应的最后一条消息
${message_textarea}                               //div[@class="Chat"]//textarea                                              # 聊天输入框
${message_send_button}                            //div[@class="Chat"]//button[@class="k-button k-flat k-button-icon k-button-send"]     # 聊天内容发送按钮
${message_page_video}                             //div[@class="user_chat_buttons"]//span[text()="Video"]                     # 聊天中启动Video
${message_page_audio}                             //div[@class="user_chat_buttons"]//span[text()="Audio+"]                    # 聊天中启动Audio+
${message_page_info}                              //div[@class="user_chat_buttons"]//span[text()="Info"]                      # 聊天中查看Info
${message_page_back}                              //div[@class="user_chat_buttons"]//span[text()="Back"]                      # 点击Info后变成back按钮
${delete_message_button}                          //div[@class="ChatInfoToolButtons"]/button[text()="Delete"]                 # 删除聊天信息
${delete_message_dialog_body}                     //div[@class="modal-body"]                                                  # 删除聊天信息时弹出的会话框的内容
${delete_message_delete}                          //div[@class="modal-footer"]/button[text()="Delete"]                        # 确认删除聊天信息
${delete_message_cancel}                          //div[@class="modal-footer"]/button[text()="Cancel"]                        # 取消删除聊天信息
${send_message_count}                             //div[@class="k-message-group k-alt"]                                       # 发送message的数量
${send_message_username}                          //div[@class="k-message-group k-alt"]/p                                     # 发送message的用户名字
${receive_message_count}                          //div[@class="k-message-group"]                                             # 接收message的数量
${receive_message_username}                       //div[@class="k-message-group"]/p                                           # 接收message的用户名字
${need_send_hello}                                hello!                                                                      # 发送的hello!
${need_reply_world}                               world!                                                                      # 回复的world!
${http_www_baidu_com}                             https://www.baidu.com                                                       # 百度网址
${plain_english_text}                             plainEnglishText                                                            # 纯英文文本
${plain_chinese_text}                             德玛西亚                                                                      # 纯中文文本
${how_old_are_you}                                how old are you?                                                            # how old are you?文本
${My_help_space_urls_MHS}                         https://app-stage.helplightning.net.cn/meet/Huiming.shi.helplightning+message_test01
${My_help_space_urls_OTU}                         https://app-stage.helplightning.net.cn/meet/link/OHhTMnFsZFRJd0E9?sig=416C243A
${message_jpg}                                    _ 小炮 + Tristana_.jpg
${message_audio}                                  _ 音乐 + music_.mp3
${particial_message_audio}                        _ 音乐 + music_
${message_video}                                  _ 视频 + video_.mp4
${message_zip}                                    _ 肉啊皮 + zip_.zip
${message_pdf}                                    _ 匹敌爱抚 + pdf_.pdf
${big_size_file}                                  big_size_file.zip
${message_type_url}                               url                                                                         # 消息类型，url和text类型
${screen_capture_name}                            undefined                                                                   # 截屏图片的名称