#-*- encoding: gb2312 -*-
import poplib
import re

# pop3服务器地址
host = "outlook.office365.com"
# 用户名
username = "Huiming.shi.helplightning@outlook.com"
# 密码
password = "H1beijing"

def from_email_get_content():
    # 创建一个pop3对象，这个时候实际上已经连接上服务器了
    pp = poplib.POP3_SSL(host)
    # 设置调试模式，可以看到与服务器的交互信息
    pp.set_debuglevel(1)
    # 向服务器发送用户名
    pp.user(username)
    # 向服务器发送密码
    pp.pass_(password)
    # 获取服务器上信件信息，返回是一个列表，第一项是一共有多上封邮件，第二项是共有多少字节
    ret = pp.stat()
    print("ret is :", ret)
    resp, mails, octets = pp.list()
    # 获取最新一封邮件
    # Poplib模块的retr()函数使用来下载邮件的。它每次刚好下载一封邮件，我们必须传递给他想要下载的邮件的数字。
    # print mails#['1 2721', '2 2784', '3 2986', '4 28987', '5 10056', '6 753', '7 763']
    # 注意索引号从1开始，那么最新的一封邮件就是索引最大的那个数值
    lenString = len(mails)
    resp1, mailContent, octets1 = pp.retr(lenString)  # mailContent:邮件内容
    # 退出
    pp.quit()
    # print("邮件内容是:",mailContent)
    return mailContent

def obtain_meeting_link():
    mailContent  = from_email_get_content()
    contain_tag = 0
    i = 0
    gather_content = []
    for one in mailContent:
        one_text = one.decode('utf-8')
        # i += 1
        # print(f'第{i}个元素：', one_text)
        if one_text.endswith('='):
            one_text = one_text[:-1]
            # print(f'第{i}个元素：', one_text)
            gather_content.append(one_text)
        else:
            gather_content.append(one_text)
    # print('聚集后的邮件内容列表是：',gather_content)
    gather_content = ''.join(gather_content)
    # print('聚集后的邮件内容字符串是：',gather_content)
    if 'Accept Invitation' in gather_content:
        contain_tag = 1
        list_code = re.findall('href=3D"(.*?)" target=3D',gather_content)
        if list_code == []:
            list_code = re.findall('href="(.*?)" target=',gather_content)
        # print('list_code为：',list_code)
        list_code = list_code[0]
        # 如果是OTU meeting link的话，邮件内容会带出来'3D'这种多余的字符，此处给处理掉
        if 'sig=3D' in list_code:
            list_code = list_code.replace('sig=3D','sig=')
            return list_code
        else:
            return list_code
    if contain_tag == 0:
        return 'There is no such email'


if __name__ == '__main__':
    print(obtain_meeting_link())