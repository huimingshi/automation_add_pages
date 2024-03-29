*** Variables ***
# account information
${crunch_site_username}                 big_admin                                                                               # crunch big admin username
${crunch_site_password}                 asdQWE123                                                                               # crunch big admin password

${enterprise_username}                  emily.huang+bsb                                                                         # enterprise username
${enterprise_password}                  abc123                                                                                  # enterprise password

${belong_enterprise_username}           Huiming.shi.helplightning+enterprise_user@outlook.com

${cognito_login_username}               xiaoyan.yan+cognito@helplightning.com                                                   # cognito username
${cognito_login_email}                  emily.huang+cognito@helplightning.com                                                   # cognito login email
${cognito_login_password}               Abc12345                                                                                # cognito login password

${site_admin_username}                  huiming.shi@helplightning.com                                                           # site admin username
${site_admin_password}                  *IK<8ik,8ik,                                                                            # site admin password

${site_admin_username_auto}             hlnauto+basic                                                                           # site admin username
${site_admin_password_auto}             Abc12345                                                                                # site admin password

${site_admin_name_one_workspace}        Huiming.shi.helplightning+11111111111@outlook.com                                       # Site Admin user which just has one workspace
${site_admin_pass_one_workspace}        *IK<8ik,8ik,                                                                            # Site Admin pass which just has one workspace

${workspace_admin_username}             Huiming.shi.helplightning@outlook.com                                                   # workspace admin username(This is a workspace admin with many groups)
${workspace_admin_password}             *IK<8ik,8ik,                                                                            # workspace admin password

${group_admin_username}                 Huiming.shi.helplightning+8888888888@outlook.com                                        # group admin username (belong to citron)
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

${a_team_user_username}                 Huiming.shi.helplightning+a_team_user@outlook.com                                       # a team user (belong to big_admin)(has no personal user)
${a_team_user_name}                     Huiming.shi.helplightning+a_team_user
${a_team_user_password}                 *IK<8ik,8ik,

${other_site_user_1_username}           Huiming.shi.helplightning+other_site_1@outlook.com                                      # an other site user whitch used to call personal user (belong to big_admin first workspace)(is normal user in Huiming.shi.helplightning+an_expert_user)
${other_site_user_1_name}               Huiming.shi.helplightning+other_site_1
${other_site_user_1_password}           *IK<8ik,8ik,

${other_site_user_2_username}           Huiming.shi.helplightning+other_site_2@outlook.com                                      # an other site user whitch used to call personal user (belong to citron)(is normal user in Huiming.shi.helplightning+9988776655 first workspace)
${other_site_user_2_name}               Huiming.shi.helplightning+other_site_2
${other_site_user_2_password}           *IK<8ik,8ik,

${other_site_user_3_username}           Huiming.shi.helplightning+other_site_3@outlook.com                                      # an other site user whitch used to call personal user (belong to citron)(is normal user in Huiming.shi.helplightning+9988776655 second workspace)
${other_site_user_3_name}               Huiming.shi.helplightning+other_site_3
${other_site_user_3_password}           *IK<8ik,8ik,

${big_admin_on_call_group}              three_user_in_this_on_call_group                                                        # big_admin 第一个WS下的on-call group

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
${Expert_User5_username}                Huiming.shi.helplightning+EU5@outlook.com                                               # Expert User5 username(User_Aa_Bb_group)
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
${ws_branding_A_user}                   Huiming.shi.helplightning+test_WS_branding_A@outlook.com                                # WS_branding_setting_WS1下的user

${ws_branding_B_user}                   Huiming.shi.helplightning+test_WS_branding_B@outlook.com                                # WS_branding_setting_WS1下的user

${ws_branding_C_user}                   Huiming.shi.helplightning+test_WS_branding_C@outlook.com                                # WS_branding_setting_WS1和WS_branding_setting_WS2下的user

${ws_branding_D_user}                   Huiming.shi.helplightning+test_WS_branding_D@outlook.com                                # WS_branding_setting_WS2下的user

${EG_user_A_user}                       Huiming.shi.helplightning+EG_user_A@outlook.com                                         # WS_branding_setting_WS1下的user

${EG_user_B_user}                       Huiming.shi.helplightning+EG_user_B@outlook.com                                         # WS_branding_setting_WS1下Expert_Group_1的user

${ws3_branding_A_user}                  Huiming.shi.helplightning+test_WS3_branding_A@outlook.com                               # WS_branding_setting_WS3下的user
${ws3_branding_A_username}              Huiming.shi.helplightning+test_WS3_branding_A

${ws3_branding_B_user}                  Huiming.shi.helplightning+test_WS3_branding_B@outlook.com                               # WS_branding_setting_WS3下的user

${ws3_branding_C_user}                  Huiming.shi.helplightning+test_WS3_branding_C@outlook.com                               # WS_branding_setting_WS3下的user
${ws3_branding_C_username}              Huiming.shi.helplightning+test_WS3_branding_C

${WS_branding_setting_WS1}              WS_branding_setting_WS1                                                                 # WS_branding_setting_WS1

${WS_branding_setting_WS2}              WS_branding_setting_WS2                                                                 # WS_branding_setting_WS2

${WS_branding_setting_WS3}              WS_branding_setting_WS3                                                                 # WS_branding_setting_WS3

${Expert_Group_1}                       Expert_Group_1                                                                          # Expert_Group_1的name(两个WS下同样的group)

${WS_1_Big_Logo}                        https://s3.cn-north-1.amazonaws.com.cn/helplightning-avatars-stage-asia/files/5d2f55df-c84a-46a3-8eca-70aee8e21b41/original_big_logo_url

${WS_1_Branding_Avatar}                 https://s3.cn-north-1.amazonaws.com.cn/helplightning-avatars-stage-asia/files/18c58116-acac-4fa8-9c90-8fce9aa73a85/original_default_avatar_url

${WS_2_Branding_Avatar}                 https://s3.cn-north-1.amazonaws.com.cn/helplightning-avatars-stage-asia/files/e96af995-dedb-41f3-aedc-1808477f8253/original_default_avatar_url

${User_B_customer_avatar}               https://s3.cn-north-1.amazonaws.com.cn/helplightning-avatars-stage-asia/users/avatars/59946/thumb/picture_63812904140.jpg

${WS3_User_B_customer_avatar}           https://s3.cn-north-1.amazonaws.com.cn/helplightning-avatars-stage-asia/users/avatars/60108/thumb/avatar2_63813432766.jpg

${Malphite}                             Thank you for using 熔岩巨兽

${default_product_name}                 Thank you for using Help Lightning
# Personal user to add as personal user
# username:  hlnauto+p22@outlook.com
# password:  Welcome1