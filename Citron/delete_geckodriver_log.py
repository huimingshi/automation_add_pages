#!/usr/bin/env python3
# _*_ coding: utf-8 _*_ #
# @Time     :12/13/2022 4:57 PM
# @Author   :Huiming Shi
import sys
import os
import platform



class DeleteGeckodriverLog(object):
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

    def get_all_files(self):
        """
        获取当前文件夹下的文件名称
        :return:
        """
        return os.listdir(self.get_path())

    def delete_geckodriver_log(self,file_name = "geckodriver"):
        """
        删除所有当前文件目录下的以file_name开头的文件
        :param file_name:
        :return:
        """
        system_type = self.get_system_type()
        if system_type == "Windows":
            splice_path = self.get_path() + "\\"
        else:
            splice_path = self.get_path() + "//"
        for one in self.get_all_files():
            if one.startswith(file_name):
                os.remove(splice_path + one)


if __name__ == '__main__':
    dgl = DeleteGeckodriverLog()
    dgl.delete_geckodriver_log()
