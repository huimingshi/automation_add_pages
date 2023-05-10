# _*_ coding: utf-8 _*_ #
# @Time     :5/10/2023 11:38 AM
# @Author   :Huiming Shi

import os
import platform
import subprocess


class ExecuteNewCallCase(object):

    ROBOT_LIST = ['Audio_plus.robot','Call_center.robot','Direct_call.robot','Expert_Group_Call.robot','MHS_call.robot','OTU_call.robot']

    def get_system_type(self):
        """
        获取操作系统类型：Windows
        :return:
        """
        return platform.system()

    def get_path(self):
        """
        获取当前文件的路径前缀
        :return:
        """
        return os.path.dirname(os.path.abspath(__file__))

    def execute_new_call_case(self):
        """
        执行每个需要再Call页面上传文件的脚本
        :return:
        """
        cmd = 'robot  {}'
        for one in self.ROBOT_LIST:
            subprocess.run(cmd.format(one),shell=True,executable='/bin/bash')

if __name__ == '__main__':
    dgl = ExecuteNewCallCase()
    dgl.execute_new_call_case()
