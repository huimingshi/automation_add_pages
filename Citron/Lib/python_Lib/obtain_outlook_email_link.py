#-*- encoding: gb2312 -*-
import poplib
import re

# pop3��������ַ
host = "outlook.office365.com"
# �û���
username = "Huiming.shi.helplightning@outlook.com"
# ����
password = "H1beijing"

def from_email_get_content():
    # ����һ��pop3�������ʱ��ʵ�����Ѿ������Ϸ�������
    pp = poplib.POP3_SSL(host)
    # ���õ���ģʽ�����Կ�����������Ľ�����Ϣ
    pp.set_debuglevel(1)
    # ������������û���
    pp.user(username)
    # ���������������
    pp.pass_(password)
    # ��ȡ���������ż���Ϣ��������һ���б���һ����һ���ж��Ϸ��ʼ����ڶ����ǹ��ж����ֽ�
    ret = pp.stat()
    print("ret is :", ret)
    resp, mails, octets = pp.list()
    # ��ȡ����һ���ʼ�
    # Poplibģ���retr()����ʹ���������ʼ��ġ���ÿ�θպ�����һ���ʼ������Ǳ��봫�ݸ�����Ҫ���ص��ʼ������֡�
    # print mails#['1 2721', '2 2784', '3 2986', '4 28987', '5 10056', '6 753', '7 763']
    # ע�������Ŵ�1��ʼ����ô���µ�һ���ʼ��������������Ǹ���ֵ
    lenString = len(mails)
    resp1, mailContent, octets1 = pp.retr(lenString)  # mailContent:�ʼ�����
    # �˳�
    pp.quit()
    # print("�ʼ�������:",mailContent)
    return mailContent

def get_email_link(tag):
    mailContent = from_email_get_content()
    contain_tag = 0
    i = 0
    gather_content = []
    for one in mailContent:
        one_text = one.decode('utf-8')
        i += 1
        print(f'��{i}��Ԫ�أ�', one_text)
        if one_text.endswith('='):
            one_text = one_text[:-1]
            print(f'��{i}��Ԫ�أ�', one_text)
            gather_content.append(one_text)
        else:
            gather_content.append(one_text)
    print('�ۼ�����ʼ������б��ǣ�',gather_content)
    gather_content = ''.join(gather_content)
    print('�ۼ�����ʼ������ַ����ǣ�',gather_content)
    if tag == 'Accept Invitation' and 'Accept Invitation' in gather_content:
        contain_tag = 1
        list_code = re.findall('href=3D"(.*?)" target=3D',gather_content)
        if list_code == []:
            list_code = re.findall('href="(.*?)" target=',gather_content)
        print('list_codeΪ��',list_code)
        list_code = list_code[0]
        # �����OTU meeting link�Ļ����ʼ����ݻ������'3D'���ֶ�����ַ����˴��������
        if 'sig=3D' in list_code:
            list_code = list_code.replace('sig=3D','sig=')
            return list_code
        else:
            return list_code
    elif tag == 'Click here to set your password:' and 'Click here to set your password:' in gather_content:
        link = re.findall('Click here to set your password: (.*?)Getting StartedDownload', gather_content)
        print('���ʼ���ȡ��link_listΪ��', link)
        print('���ʼ���ȡ��link_list����Ϊ��', len(link))
        print('���ʼ���ȡ��linkΪ��', link[0])
        return link[0]
    elif tag in gather_content:
        contain_tag = 1
        print(gather_content)
        link = re.findall('https.*',gather_content)
        print('���ʼ���ȡ��link_listΪ��', link)
        print('���ʼ���ȡ��link_list����Ϊ��', len(link))
        print('���ʼ���ȡ��linkΪ��', link[0])
        link = link[0].split(' ')[0]
        if link.endswith('We'):   # confirmation_token
            link = link[0:-2]
            return link
        elif link.endswith("You've"):   # Change My Password:
            link = link[0:-6]
            return link
        elif link.endswith('Getting'):   # Click here to set your password:
            link = link[0:-7]
            return link
        else:
            return link
    elif contain_tag == 0:
        return 'There is no such email'

def get_email_verification_code():
    mailContent = from_email_get_content()
    list = []
    contain_tag = 0
    for one in mailContent:
        one_text = one.decode('utf-8')
        print(one_text)
        list.append(one_text)
        if 'Your verification code is ' in one_text:
            contain_tag = 1
            print(one_text)
            list_code = one_text.split('Your verification code is ')
            break
    if contain_tag == 0:
        return 'There is no such email'
    else:
        return  list_code[-1][:6]

def get_external_invitation_message(expect_get_content):
    mailContent = from_email_get_content()
    i = 0
    gather_content = []
    for one in mailContent:
        one_text = one.decode('utf-8')
        i += 1
        # print(f'��{i}��Ԫ�أ�', one_text)
        if one_text.endswith('='):
            one_text = one_text[:-1]
            # print(f'��{i}��Ԫ�أ�', one_text)
            gather_content.append(one_text)
        else:
            gather_content.append(one_text)
    print('�ۼ�����ʼ������б��ǣ�',gather_content)
    if expect_get_content in gather_content:
        return 'External invitation message is correct'
    else:
        return 'External invitation message is not correct'

if __name__ == '__main__':
    # print(get_email_link('Change My Password:'))
    print(get_email_link('Click here to set your password:'))
    # print(get_email_link('Accept Invitation'))
    # print(get_email_link('confirmation_token'))
    # print(get_email_verification_code())
    # print(get_external_invitation_message("You have been invited to join Huiming.shi.helplightning+personal on a auto_default_workspace's support call using Help Lightning."))