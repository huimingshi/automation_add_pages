*** Variables ***
# account information
${crunch_site_username}                 big_admin                                                                               # crunch big admin username
${crunch_site_password}                 asdQWE123                                                                               # crunch big admin password

${enterprise_username}                  emily.huang+bsb                                                                         # enterprise username
${enterprise_password}                  abc123                                                                                  # enterprise password

${belong_enterprise_username}           Huiming.shi.helplightning+enterprise_user@outlook.com
${belong_enterprise_name}               Huiming.shi.helplightning+enterprise_user

${cognito_login_username}               xiaoyan.yan+cognito@helplightning.com                                                   # cognito username
${cognito_login_email}                  emily.huang+cognito@helplightning.com                                                   # cognito login email
${cognito_login_password}               Abc12345                                                                                # cognito login password

${site_admin_username}                  huiming.shi@helplightning.com                                                           # site admin username
${site_admin_name}                      huiming.shi
${site_admin_password}                  *IK<8ik,8ik,                                                                            # site admin password

${site_admin_username_auto}             hlnauto+basic                                                                           # site admin username
${site_admin_password_auto}             Abc12345                                                                                # site admin password

${site_admin_name_one_workspace}        Huiming.shi.helplightning+11111111111@outlook.com                                       # Site Admin user which just has one workspace
${site_admin_pass_one_workspace}        *IK<8ik,8ik,                                                                            # Site Admin pass which just has one workspace

${workspace_admin_username}             Huiming.shi.helplightning@outlook.com                                                   # workspace admin username(This is a workspace admin with many groups)
${workspace_admin_password}             *IK<8ik,8ik,                                                                            # workspace admin password

${group_admin_username}                 Huiming.shi.helplightning+8888888888@outlook.com                                        # group admin username (belong to citron)
${group_admin_name}                     Huiming.shi.helplightning+8888888888
${group_admin_real_name}                citron_group_admin
${group_admin_password}                 *IK<8ik,8ik,                                                                            # group admin password

${workspace_admin_username_one}         Huiming.shi.helplightning+99998888@outlook.com                                          # workspace admin username(This is a workspace admin with only one group)
${workspace_admin_password_one}         *IK<8ik,8ik,                                                                            # workspace admin password

${group_admin_username_one}             Huiming.shi.helplightning+999988881@outlook.com                                         # group admin username(This is a group admin with only one group)
${group_admin_password_one}             *IK<8ik,8ik,                                                                            # group admin password

${workspace_admin_username_two}         Huiming.shi.helplightning+66668888@outlook.com                                          # workspace admin username(This is a workspace admin with only two group)
${workspace_admin_password_two}         *IK<8ik,8ik,                                                                            # workspace admin password

${group_admin_username_two}             Huiming.shi.helplightning+666688881@outlook.com                                         # group admin username(This is a group admin with only two group)
${group_admin_password_two}             *IK<8ik,8ik,                                                                            # group admin password

${workspace_admin_username_auto}        Huiming.shi.helplightning+666888999@outlook.com                                         # workspace admin username(This is a workspace admin with a few groups and users)
${workspace_admin_password_auto}        *IK<8ik,8ik,                                                                            # workspace admin password

${workspace_admin_test_username}        Huiming.shi.helplightning+test_group@outlook.com                                        # workspace admin username(This is a workspace admin with a few groups and users)

${group_admin_username_auto}            Huiming.shi.helplightning+6668889991@outlook.com                                        # group admin username(This is a workspace admin with a few groups and users)
${group_admin_password_auto}            *IK<8ik,8ik,                                                                            # group admin password

${a_normal_test_username}               Huiming.shi.helplightning+23748795579@outlook.com                                       # a normal test username
${a_normal_test_password}               *IK<8ik,8ik,                                                                            # a normal test password

${group_admin_name}                     Huiming.shi.helplightning+45148523051                                                   # Administrator when adding a group
${On_Call_notifications_email}          468390125@qq.com                                                                        # On-Call Notifications

${group_admin_name_modify}              Huiming.shi.helplightning+56344533312                                                   # Administrator when adding a group
${On_Call_notifications_email_modify}   843361731@qq.com                                                                        # On-Call Notifications

${first_user_username}                  Huiming.shi.helplightning+111222333@outlook.com                                         # A normal user(belong to citron) account for adding and editing the team's test scripts（Ensure that users have only one group）
${first_user_name}                      Huiming.shi.helplightning+111222333
${first_user_password}                  *IK<8ik,8ik,

${second_user_username}                 Huiming.shi.helplightning+222333444@outlook.com                                         # A normal user(belong to citron) account for adding and editing the team's test scripts（Ensure that users have only one group）
${second_user_name}                     Huiming.shi.helplightning+222333444
${second_user_password}                  *IK<8ik,8ik,

${third_user_username}                  Huiming.shi.helplightning+111222333444@outlook.com                                      # A normal user(belong to citron) account for adding and editing the team's test scripts（Ensure that users have only one group）
${third_user_name}                      Huiming.shi.helplightning+111222333444
${third_user_password}                  *IK<8ik,8ik,

${another_site_admin_username}          Huiming.shi.helplightning+999999999999@outlook.com                                      # A site admin which for Test the Migrate Account(invitations tab)
${another_site_admin_password}          *IK<8ik,8ik,

${another_workspace_admin_username}     Huiming.shi.helplightning+999999999@outlook.com                                         # A workspace admin which for Test the Migrate Account(invitations tab)
${another_workspace_admin_password}     *IK<8ik,8ik,

${another_group_admin_username}         Huiming.shi.helplightning+99999999999@outlook.com                                       # A group admin which for Test the Migrate Account(invitations tab)
${another_group_admin_password}         *IK<8ik,8ik,

${normal_username_for_calls}            Huiming.shi.helplightning+123456789@outlook.com                                         # A normal user for make calls(belong to huiming.shi)
${normal_username_for_calls_name}       Huiming.shi.helplightning+123456789
${normal_password_for_calls}            *IK<8ik,8ik,

${normal_username_for_calls_B}          Huiming.shi.helplightning+0123456789@outlook.com                                        # B normal user for make calls(belong to huiming.shi)
${normal_name_for_calls_B}              Huiming.shi.helplightning+0123456789
${normal_password_for_calls_B}          *IK<8ik,8ik,

${personal_user_username}               Huiming.shi.helplightning+personal@outlook.com                                          # personal user for make calls(belong to citron)
${personal_user_name}                   Huiming.shi.helplightning+personal
${personal_user_password}               *IK<8ik,8ik,

${oncall_user_username}                 Huiming.shi.helplightning+oncall@outlook.com                                            # the normal user (belong to citron) is a oncall for group (on-call group 1)
${oncall_user_password}                 *IK<8ik,8ik,

${call_oncall_user_username}            Huiming.shi.helplightning+for_oncall@outlook.com                                        # the normal user is for call oncall (belong to citron)
${call_oncall_user_password}            *IK<8ik,8ik,

${switch_workspace_username}            Huiming.shi.helplightning+9988776655@outlook.com                                        # the user which is userd by switch workspace (belong to big_admin)(belong to WS1 and WS2)(on-call for two WS group)
${switch_workspace_name}                Huiming.shi.helplightning+9988776655
${switch_workspace_password}            *IK<8ik,8ik,

${for_check_user_online_or_not}         Huiming.shi.helplightning+online_or_not@outlook.com                                     # 属于两个WS，用来验证WS切换和user是否在线(belong to big_admin)(belong to WS1 and WS2)
${online_or_not_name}                   Huiming.shi.helplightning+online_or_not

${for_expert_call_username}             Huiming.shi.helplightning+998877665511111@outlook.com                                   # this user is belong to first WS (belong to big_admin)(belong to WS1)(has no personal user)
${for_expert_call_name}                 Huiming.shi.helplightning+998877665511111

${big_admin_first_WS_username}          Huiming.shi.helplightning+99887766551@outlook.com                                       # this user is belong to first WS (belong to big_admin)(belong to WS1)(has no personal user)
${big_admin_first_WS_name}              Huiming.shi.helplightning+99887766551
${big_admin_first_WS_password}          *IK<8ik,8ik,

${big_admin_third_WS_username}          Huiming.shi.helplightning+99887766553@outlook.com                                       # this user is belong to first WS (belong to big_admin)(belong to WS1)(has no personal user)
${big_admin_third_WS_name}              Huiming.shi.helplightning+99887766553
${big_admin_third_WS_password}          *IK<8ik,8ik,

${big_admin_second_WS_username}         Huiming.shi.helplightning+99887766552@outlook.com                                       # this user is belong to second WS (belong to big_admin)(belong to WS2)(has no personal user)
${big_admin_second_WS_password}         *IK<8ik,8ik,

${big_admin_another_first_WS_username}      Huiming.shi.helplightning+1o1o1o1o1o1o@outlook.com                                  # this user is belong to first WS (belong to big_admin)(belong to WS1)
${big_admin_another_first_WS_name}          Huiming.shi.helplightning+1o1o1o1o1o1o
${big_admin_another_first_WS_password}      *IK<8ik,8ik,

${an_expert_user_username}              Huiming.shi.helplightning+an_expert_user@outlook.com                                    # an expert user (belong to citron),is a oncall for group (on-call group 2)
${an_expert_user_name}                  Huiming.shi.helplightning+an_expert_user
${an_expert_user_password}              *IK<8ik,8ik,

${an_team_user_username}                Huiming.shi.helplightning+an_team_user                                                  # an team user (belong to citron)
${an_team_user_password}                *IK<8ik,8ik,

${never_log_in_username}                Huiming.shi.helplightning+never_log_in@outlook.com                                      # an Expert user which never log in (belong to big_admin)
${never_log_in_name}                    Huiming.shi.helplightning+never_log_in

${check_team_offline_username}          Huiming.shi.helplightning+check_team_offline@outlook.com                                # a team user (belong to big_admin)(has no personal user)
${check_team_offline_name}              Huiming.shi.helplightning+check_team_offline                                            # 临时创建的user，不用于其他case

${a_team_user_username}                 Huiming.shi.helplightning+a_team_user@outlook.com                                       # a team user (belong to big_admin)(has no personal user)
${a_team_user_name}                     Huiming.shi.helplightning+a_team_user
${a_team_user_password}                 *IK<8ik,8ik,

${for_team_call_username}               Huiming.shi.helplightning+team_user1@outlook.com                                        # a team user (belong to big_admin)(has no personal user)
${for_team_call_name}                   Huiming.shi.helplightning+team_user1

${personal_user1_username}              Huiming.shi.helplightning+personal_user_1@outlook.com                                   # big_admin下的user，用于进行personal user的验证
${personal_user1_name}                  Huiming.shi.helplightning+personal_user_1

${other_site_user_1_username}           Huiming.shi.helplightning+other_site_1@outlook.com                                      # an other site user whitch used to call personal user (belong to big_admin first workspace)(is normal user in Huiming.shi.helplightning+an_expert_user)
${other_site_user_1_name}               Huiming.shi.helplightning+other_site_1
${other_site_user_1_password}           *IK<8ik,8ik,

${other_site_user_2_username}           Huiming.shi.helplightning+other_site_2@outlook.com                                      # an other site user whitch used to call personal user (belong to citron)(is normal user in Huiming.shi.helplightning+9988776655 first workspace)
${other_site_user_2_name}               Huiming.shi.helplightning+other_site_2
${other_site_user_2_password}           *IK<8ik,8ik,

${for_other_site_call_username}         Huiming.shi.helplightning+other_site_21@outlook.com                                      # an other site user whitch used to call personal user (belong to citron)(is normal user in Huiming.shi.helplightning+9988776655 first workspace)
${for_other_site_call_name}             Huiming.shi.helplightning+other_site_21

${other_site_user_3_username}           Huiming.shi.helplightning+other_site_3@outlook.com                                      # an other site user whitch used to call personal user (belong to citron)(is normal user in Huiming.shi.helplightning+9988776655 second workspace)
${other_site_user_3_name}               Huiming.shi.helplightning+other_site_3
${other_site_user_3_password}           *IK<8ik,8ik,

${big_admin_on_call_group}              three_user_in_this_on_call_group                                                        # big_admin 第一个WS下的on-call group

${on_call_group_1}                      on-call group 1                                                                         # on-call group 1

# 下列账号都属于big_admin下的我自己创建的WS（Huiming.shi_Added_WS）中的User或者group
${Expert_A_username}                    Huiming.shi.helplightning+Expert_A@outlook.com                                          # Expert A username(Quantum Mechanics)
${Expert_A_name}                        Huiming.shi.helplightning+Expert_A
${Expert_B_username}                    Huiming.shi.helplightning+Expert_B@outlook.com                                          # Expert B username(Quantum Mechanics)
${Expert_B_name}                        Huiming.shi.helplightning+Expert_B
${Expert_C_username}                    Huiming.shi.helplightning+Expert_C@outlook.com                                          # Expert C username(Quantum Mechanics)
${Expert_C_name}                        Huiming.shi.helplightning+Expert_C
${random_2_username}                    Huiming.shi.helplightning+random_2@outlook.com                                          # random 2 username(professional_on_call_group)
${User_A_username}                      Huiming.shi.helplightning+User_A@outlook.com                                            # User A username(default)
${User_A_name}                          Huiming.shi.helplightning+User_A
${User_B_username}                      Huiming.shi.helplightning+User_B@outlook.com                                            # User B username(default)
${User_B_name}                          Huiming.shi.helplightning+User_B
${Feynman_username}                     Huiming.shi.helplightning+Feynman@outlook.com                                           # Feynman username(High Energy Physics)
${Quantum_Mechanics_group_name}         Quantum Mechanics                                                                       # Quantum Mechanics 这个on-call group

${User_Aa_username}                     Huiming.shi.helplightning+User_Aa@outlook.com                                           # User Aa username(User_Aa_Bb_group)
${User_Aa_name}                         Huiming.shi.helplightning+User_Aa
${User_Bb_username}                     Huiming.shi.helplightning+User_Bb@outlook.com                                           # User Bb username(User_Aa_Bb_group)
${User_Bb_name}                         Huiming.shi.helplightning+User_Bb
${User_Cc_username}                     Huiming.shi.helplightning+User_Cc@outlook.com                                           # User Cc username(User_Aa_Bb_group)
${User_Cc_name}                         Huiming.shi.helplightning+User_Cc
${Expert_Aa_username}                   Huiming.shi.helplightning+Expert_Aa@outlook.com                                         # Expert Aa username(Expert_Aa_on_call_group)（属于两个WS）
${Expert_Aa_name}                       Huiming.shi.helplightning+Expert_Aa
${Expert_Bb_username}                   Huiming.shi.helplightning+Expert_Bb@outlook.com                                         # Expert Bb username(Expert_Aa_on_call_group)
${Expert_Bb_name}                       Huiming.shi.helplightning+Expert_Bb
${another_on_call_group_name}           Expert_Aa_on_call_group

${Expert_User1_username}                Huiming.shi.helplightning+EU1@outlook.com                                               # Expert User1 username(User_Aa_Bb_group)
${Expert_User1_name}                    Huiming.shi.helplightning+EU1
${Expert_User2_username}                Huiming.shi.helplightning+EU2@outlook.com                                               # Expert User2 username(User_Aa_Bb_group)
${Expert_User2_name}                    Huiming.shi.helplightning+EU2
${Expert_User3_username}                Huiming.shi.helplightning+EU3@outlook.com                                               # Expert User3 username(User_Aa_Bb_group)
${Expert_User3_name}                    Huiming.shi.helplightning+EU3
${Expert_User4_username}                Huiming.shi.helplightning+EU4@outlook.com                                               # Expert User4 username(User_Aa_Bb_group)
${Expert_User4_name}                    Huiming.shi.helplightning+EU4
${Expert_User5_username}                Huiming.shi.helplightning+EU5@outlook.com                                               # Expert User5 username(User_Aa_Bb_group)(有personal user)
${Expert_User5_name}                    Huiming.shi.helplightning+EU5
${Team_User1_username}                  Huiming.shi.helplightning+TU1@outlook.com                                               # Team User1 username(User_Aa_Bb_group)
${Team_User1_name}                      Huiming.shi.helplightning+TU1
${Team_User2_username}                  Huiming.shi.helplightning+TU2@outlook.com                                               # Team User2 username(User_Aa_Bb_group)
${Team_User2_name}                      Huiming.shi.helplightning+TU2
${Expert_AaA_username}                  Huiming.shi.helplightning+Expert_AaA@outlook.com                                        # Expert AaA username(Expert_AaA_on_call_group)
${Expert_AaA_name}                      Huiming.shi.helplightning+Expert_AaA
${Expert_BbB_username}                  Huiming.shi.helplightning+Expert_BbB@outlook.com                                        # Expert BbB username(Expert_AaA_on_call_group)
${Expert_BbB_name}                      Huiming.shi.helplightning+Expert_BbB
${AaA_on_call_group_name}               Expert_AaA_on_call_group

${belong_two_WS_username}               Huiming.shi.helplightning+belong_two_WS@outlook.com                                     # belong two WS username(属于两个自己创建的WS)
${belong_two_WS_name}                   Huiming.shi.helplightning+belong_two_WS

${Huiming_shi_Added_WS}                 Huiming.shi_Added_WS                                                                    # 自己创建的WS
${Huiming_shi_Added_WS_another}         Huiming.shi_Added_WS_another                                                            # 自己创建的另一个WS

${another_WS_username}                  Huiming.shi.helplightning+another_WS_user@outlook.com                                   # another WS username
${another_WS_name}                      Huiming.shi.helplightning+another_WS_user

# 下列账号都属于Huiming.shi下的我自己创建的WS中的User或者group
${ws_branding_A_user}                   Huiming.shi.helplightning+test_WS_branding_A@outlook.com                                # WS_branding_setting_WS1下的user(有personal user)
${ws_branding_A_name}                   Huiming.shi.helplightning+test_WS_branding_A

${ws_branding_B_user}                   Huiming.shi.helplightning+test_WS_branding_B@outlook.com                                # WS_branding_setting_WS1下的user
${ws_branding_B_name}                   Huiming.shi.helplightning+test_WS_branding_B

${ws_branding_C_user}                   Huiming.shi.helplightning+test_WS_branding_C@outlook.com                                # WS_branding_setting_WS1和WS_branding_setting_WS2下的user
${ws_branding_C_name}                   Huiming.shi.helplightning+test_WS_branding_C

${ws_branding_D_user}                   Huiming.shi.helplightning+test_WS_branding_D@outlook.com                                # WS_branding_setting_WS2下的user

${EG_user_A_user}                       Huiming.shi.helplightning+EG_user_A@outlook.com                                         # WS_branding_setting_WS1下的user

${EG_user_B_user}                       Huiming.shi.helplightning+EG_user_B@outlook.com                                         # WS_branding_setting_WS1下Expert_Group_1的user


${ws3_branding_A_user}                  Huiming.shi.helplightning+test_WS3_branding_A@outlook.com                               # WS_branding_setting_WS3下的user
${ws3_branding_A_username}              Huiming.shi.helplightning+test_WS3_branding_A

${ws3_branding_B_user}                  Huiming.shi.helplightning+test_WS3_branding_B@outlook.com                               # WS_branding_setting_WS3下的user

${ws3_branding_C_user}                  Huiming.shi.helplightning+test_WS3_branding_C@outlook.com                               # WS_branding_setting_WS3下的user(有personal user)
${ws3_branding_C_username}              Huiming.shi.helplightning+test_WS3_branding_C

${test_WS3_TU1_user}                    Huiming.shi.helplightning+test_WS3_TU1@outlook.com                                      # WS_branding_setting_WS3下的user

${test_WS3_TU2_user}                    Huiming.shi.helplightning+test_WS3_TU2@outlook.com                                      # WS_branding_setting_WS3下的user
${test_WS3_TU2_user_name}               Huiming.shi.helplightning+test_WS3_TU2

${test_WS3_EU1_user}                    Huiming.shi.helplightning+test_WS3_EU1@outlook.com                                      # WS_branding_setting_WS3下的user

${test_WS3_EU2_user}                    Huiming.shi.helplightning+test_WS3_EU2@outlook.com                                      # WS_branding_setting_WS3下的user

${test_WS3_EU3_user}                    Huiming.shi.helplightning+test_WS3_EU3@outlook.com                                      # WS_branding_setting_WS3下的user

${WS_branding_setting_WS1}              WS_branding_setting_WS1                                                                 # WS_branding_setting_WS1

${WS_branding_setting_WS2}              WS_branding_setting_WS2                                                                 # WS_branding_setting_WS2

${WS_branding_setting_WS3}              WS_branding_setting_WS3                                                                 # WS_branding_setting_WS3

${Expert_Group_1}                       Expert_Group_1                                                                          # Expert_Group_1的name(两个WS下同样的group)

${On_call_group_001}                    On_call_group_001                                                                       # WS_branding_setting_WS3下的on-call group

${On_call_group_002}                    On_call_group_002                                                                       # WS_branding_setting_WS3下的on-call group

${WS_1_Big_Logo}                        https://s3.cn-north-1.amazonaws.com.cn/helplightning-avatars-stage-asia/files/5d2f55df-c84a-46a3-8eca-70aee8e21b41/original_big_logo_url

${WS_1_Branding_Avatar}                 https://s3.cn-north-1.amazonaws.com.cn/helplightning-avatars-stage-asia/files/18c58116-acac-4fa8-9c90-8fce9aa73a85/original_default_avatar_url

${WS_2_Branding_Avatar}                 https://s3.cn-north-1.amazonaws.com.cn/helplightning-avatars-stage-asia/files/e96af995-dedb-41f3-aedc-1808477f8253/original_default_avatar_url

${User_B_customer_avatar}               https://s3.cn-north-1.amazonaws.com.cn/helplightning-avatars-stage-asia/users/avatars/59946/thumb/picture_63812904140.jpg

${WS3_User_B_customer_avatar}           https://s3.cn-north-1.amazonaws.com.cn/helplightning-avatars-stage-asia/users/avatars/60108/thumb/avatar2_63813432766.jpg

${Malphite}                             Thank you for using 熔岩巨兽

${default_product_name}                 Thank you for using Help Lightning

# message 用例专用账号
# 下列账号都属于Huiming.shi下的我自己创建的WS中的User或者group
# out of call message
${message_test0_user}                   Huiming.shi.helplightning+message_test0@outlook.com
${message_test0_username}               Huiming.shi.helplightning+message_test0

${message_test1_user}                   Huiming.shi.helplightning+message_test1@outlook.com
${message_test1_username}               Huiming.shi.helplightning+message_test1

${message_test2_user}                   Huiming.shi.helplightning+message_test2@outlook.com
${message_test2_username}               Huiming.shi.helplightning+message_test2

${message_test3_user}                   Huiming.shi.helplightning+message_test3@outlook.com
${message_test3_username}               Huiming.shi.helplightning+message_test3

${message_test4_user}                   Huiming.shi.helplightning+message_test4@outlook.com
${message_test4_username}               Huiming.shi.helplightning+message_test4

${message_test5_user}                   Huiming.shi.helplightning+message_test5@outlook.com
${message_test5_username}               Huiming.shi.helplightning+message_test5

${message_test6_user}                   Huiming.shi.helplightning+message_test6@outlook.com
${message_test6_username}               Huiming.shi.helplightning+message_test6

${message_not_need_read_user}           Huiming.shi.helplightning+message_test_not_need_read@outlook.com
${message_not_need_read_username}       Huiming.shi.helplightning+message_test_not_need_read

${anyone_user}                          1648576793381491                                                                         # contacts中的随意一位联系人

${anyone_favorite_user}                 1645080318643799                                                                         # contacts中的favorite联系人

${directory_user}                       wqghwewj@123.com                                                                         # contacts中的directory联系人

${used_by_message_user01}               Huiming.shi.helplightning+used_chat_01@outlook.com                                       # 用于message测试（used_by_message_group）
${used_by_message_username01}           Huiming.shi.helplightning+used_chat_01

${used_by_message_user02}               Huiming.shi.helplightning+used_chat_02@outlook.com                                       # 用于message测试（used_by_message_group）
${used_by_message_username02}           Huiming.shi.helplightning+used_chat_02

${used_by_message_user03}               Huiming.shi.helplightning+used_chat_03@outlook.com                                       # 用于message测试（used_by_message_group）
${used_by_message_username03}           Huiming.shi.helplightning+used_chat_03

${used_by_message_user04}               Huiming.shi.helplightning+used_chat_04@outlook.com                                       # 用于message测试（used_by_message_group）
${used_by_message_username04}           Huiming.shi.helplightning+used_chat_04

# 下列账号都属于Huiming.shi下的我自己创建的WS中的User或者group
# in call message
${in_call_message_userA}                Huiming.shi.helplightning+in_call_messageA@outlook.com                                   # 属于message_test_WS_A
${in_call_message_usernameA}            Huiming.shi.helplightning+in_call_messageA

${in_call_message_userB}                Huiming.shi.helplightning+in_call_messageB@outlook.com                                   # 属于message_test_WS_A
${in_call_message_usernameB}            Huiming.shi.helplightning+in_call_messageB

${in_call_message_userD}                Huiming.shi.helplightning+in_call_messageD@outlook.com                                   # 属于message_test_WS_A(expert group下的user)
${in_call_message_usernameD}            Huiming.shi.helplightning+in_call_messageD

${in_call_message_userC}                Huiming.shi.helplightning+in_call_messageC@outlook.com                                   # 属于message_test_WS_B
${in_call_message_usernameC}            Huiming.shi.helplightning+in_call_messageC

${in_call_message_userD1}               Huiming.shi.helplightning+in_call_messageD1@outlook.com                                  # 属于big_admin的message_test_WS
${in_call_message_usernameD1}           Huiming.shi.helplightning+in_call_messageD1

${in_call_message_expert_group}         message_expert_groupA                                                                    # expert group

${message_test_WS_A}                    message_test_WS_A                                                                        # message_test_WS_A这个WS

# 下列账号都属于Huiming.shi下的我自己创建的WS中的User或者group
# In-call User Notifications
${notifications_user01}                 Huiming.shi.helplightning+notificat_01@outlook.com                                       # 用于Notificationse测试(In-call User Notifications)
${notifications_username01}             Huiming.shi.helplightning+notificat_01

${notifications_user02}                 Huiming.shi.helplightning+notificat_02@outlook.com                                       # 用于Notificationse测试(In-call User Notifications)
${notifications_username02}             Huiming.shi.helplightning+notificat_02

${notifications_user03}                 Huiming.shi.helplightning+notificat_03@outlook.com                                       # 用于Notificationse测试(In-call User Notifications)
${notifications_username03}             Huiming.shi.helplightning+notificat_03

${notifications_user04}                 Huiming.shi.helplightning+notificat_04@outlook.com                                       # 用于Notificationse测试(In-call User Notifications)
${notifications_username04}             Huiming.shi.helplightning+notificat_04

${notifications_user05}                 Huiming.shi.helplightning+notificat_05@outlook.com                                       # 用于Notificationse测试(In-call User Notifications)
${notifications_username05}             Huiming.shi.helplightning+notificat_05

# Personal user to add as personal user
# username:  hlnauto+p22@outlook.com
# password:  Welcome1