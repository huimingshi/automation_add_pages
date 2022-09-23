import os
import csv
import re
import calendar
import sys
import zipfile

sys.path.append(os.path.dirname(os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))))
print(sys.path)
from Citron.public_switch.public_switch_py import DOWNLOAD_PATH
from Citron.public_switch.pubLib import get_system_type, get_picture_path

def all_file_name(file_path):
    """
    # Gets all files in the current directory, return a list
    :param file_path:
    :return: return a filename list
    """
    for root, dirs, files in os.walk(DOWNLOAD_PATH):
        return files

def check_zipFile_exists(partial_file_name = 'call-report'):
    """
    # Check whether the ZIP file exists
    :param partial_file_name: zip文件的部分名
    :return: if exists, return zip file name;
             else, return "There is no such zip file"
    """
    files_list = all_file_name(DOWNLOAD_PATH)
    # partial_file_name = 'call-report'
    exists_tag = 0
    for file_name in files_list:
        if partial_file_name in file_name:
            zipFileName = file_name
            exists_tag = 1
            return zipFileName,exists_tag
    if exists_tag == 0:
        return "There is no such zip file"

def delete_zip_file(partial_file_name = 'call-report'):
    """
    # Deleting all ZIP File
    :param partial_file_name: zip文件的部分名
    :return: if exists zip file ,return "Zip file has been deleted";
             else, return "There is no zip file"
    """
    files_list = all_file_name(DOWNLOAD_PATH)
    # partial_file_name = 'call-report'
    exists_tag = 0
    for file_name in files_list:
        if partial_file_name in file_name:
            exists_tag = 1
            system_type = get_system_type()
            if system_type == 'Windows':
                zip_file_path = DOWNLOAD_PATH + f'\\{check_zipFile_exists(partial_file_name)[0]}'
            else:
                zip_file_path = DOWNLOAD_PATH + f'/{check_zipFile_exists(partial_file_name)[0]}'
            os.remove(zip_file_path)
    if exists_tag == 0:
        return "There is no zip file"
    else:
        return "Zip file has been deleted"

def read_zip_file_check_cloumns():
    """
    # Read the first line field of the CSV file
    :return:
    """
    zip_file_name = check_zipFile_exists()[0]
    zip_file_path = path_for_download_file(DOWNLOAD_PATH, zip_file_name)
    print("zip_file_path is ", zip_file_path)
    # 读取Zip文件
    azip = zipfile.ZipFile(zip_file_path)
    # 解压在当前工作目录
    azip.extractall(DOWNLOAD_PATH)
    report_file_path = path_for_download_file(DOWNLOAD_PATH, "report.csv")
    result = os.path.exists(report_file_path)
    print(result)
    if result:
        with open(report_file_path, 'r',encoding='utf-8') as f:
            reader = csv.reader(f)
            print(type(reader))
            result = list(reader)
            print(result[0])
            return  result[0], result[1]
    else:
        return 'There is no such file'

def check_jpg_picture_exists():
    """
    # Check whether the jpg picture exists
    :return: if exists, return jpg picture name list;
             else, return "There is no such jpg picture"
    """
    files_list = all_file_name(DOWNLOAD_PATH)
    partial_file_name = 'IMG_CAP_'
    exists_tag = 0
    jpg_list = []
    for file_name in files_list:
        if partial_file_name in file_name:
            jpgPictureName = file_name
            exists_tag = 1
            jpg_list.append(jpgPictureName)
    if exists_tag == 0:
        return "There is no such jpg picture"
    else:
        return jpg_list, exists_tag

def delete_picture_jpg_file():
    """
    # Deleting all jpg File
    :return:  Jpg picture has been deleted
    """
    jpg_list = check_jpg_picture_exists()[0]
    system_type = get_system_type()
    if jpg_list != "T":
        for one in jpg_list:
            if system_type == 'Windows':
                jpg_file_path = DOWNLOAD_PATH + f'\\{one}'
            else:
                jpg_file_path = DOWNLOAD_PATH + f'/{one}'
            os.remove(jpg_file_path)
    return  "Jpg picture has been deleted"

def check_jpeg_picture_exists():
    """
    # Check whether the jpeg picture exists
    :return: if exists, return jpg picture name list;
             else, return "There is no such jpg picture"
    """
    files_list = all_file_name(DOWNLOAD_PATH)
    partial_file_name = 'image_'
    exists_tag = 0
    jpeg_list = []
    for file_name in files_list:
        if partial_file_name in file_name:
            JpegPictureName = file_name
            exists_tag = 1
            jpeg_list.append(JpegPictureName)
    if exists_tag == 0:
        return "There is no such jpeg picture"
    else:
        return jpeg_list, exists_tag

def delete_picture_jpeg_file():
    """
    # Deleting all jpeg File
    :return:  Jpeg picture has been deleted
    """
    jpeg_list = check_jpeg_picture_exists()[0]
    system_type = get_system_type()
    if jpeg_list != "T":
        for one in jpeg_list:
            if system_type == 'Windows':
                jpeg_file_path = DOWNLOAD_PATH + f'\\{one}'
            else:
                jpeg_file_path = DOWNLOAD_PATH + f'/{one}'
            os.remove(jpeg_file_path)
    return  "Jpeg picture has been deleted"

def path_for_download_file(file_path, download_file_name):
    """
    # Obtaining the download path for export file
    :param file_path:
    :return:
    """
    system_type = get_system_type()
    if system_type == 'Windows':
        export_file_path = DOWNLOAD_PATH + f'\\{download_file_name}'
        return export_file_path
    else:
        export_file_path = DOWNLOAD_PATH + f'/{download_file_name}'
        return export_file_path

def short_for_month(month_english):
    """
    # Short for month
    :param month_english:
    :return: Short for month
    """
    short_month = month_english[:3]
    return  short_month

def convert_month_to_number(month_english):
    """
    # Convert the month to a number
    :param month_english:
    :return:
    """
    short_month = short_for_month(month_english)
    month_int = list(calendar.month_abbr).index(short_month)
    return month_int

def changed_data_to_the_exact_time(time_string):
    """
    # Change the data to the exact time
    :param time_string:
    :return: the exact time
    """
    convert_time = time_string.split(' ')
    month_int = convert_month_to_number(convert_time[0])
    convert_time[0] = str(month_int)
    convert_time[1] = convert_time[1].replace(',','')
    convert_time = convert_time[2] + convert_time[1] + convert_time[0] + convert_time[-1] + convert_time[3]
    return convert_time

def conversion_of_precise_time(time_string):
    """
    # Conversion of precise time
    :param time_string:
    :return:
    """
    convert_time = time_string.split(':')
    if int(convert_time[1]) >= 1:
        return  'More than a minute'
    else:
        return  'Less than a minute'

def split_src_img(src_img):
    """
    # 把获取到的src通过”?“去切片，返回列表的第一个字符串
    :param time_string:
    :return:
    """
    after_split_src = src_img.split('?')
    return after_split_src[0]

def sort_order_list(list):
    """
    # Sort lists in order
    :param list:
    :return: A list sorted in order
    """
    list.sort()
    return  list

def two_lists_are_identical(list1,list2):
    """
    # The two lists are identical
    :param list1: 
    :param list2: 
    :return: 
    """
    tag = 0
    for i in range(len(list1)):
        if list1[i] != list2[i]:
            tag = 1
    if tag == 0:
        return "The two lists are identical"
    else:
        return  "The two lists are not exactly the same"

def compare_two_lists(list1,list2):
    """
    # Compare two lists
    :param list1:
    :param list2:
    :return:
    """
    list1.sort()
    list2.sort()
    if list1==list2:
        return "Two lists are equal"
    else:
        return "The two lists are not equal"

def list_contain_another_list(list):
    """
    # The two lists partially duplicate data
    :param list:
    :return:
    """
    another_list = ['11 tag', '11t', '1234567890asdfghjklmuiytrewqwe12', '16 tag', '1627', '1628', '17 tag', '6 tag', '66', 'aa', 'ad tag2', 'alligator', 'andr', 'andr tag', 'andr tag1', 'andr tag2', 'andr tag4', 'andr tag5', 'Android tag', 'Android tag2', 'bad weather', 'c tag', 'c2', 'ca\u2006go', 'chrismas', 'chrismas2', 'chrismas4', 'cus', 'dolphin', 'duphin', 'd\u2006d', 'ea1 tag', 'ea1tag', 'en-waiting', 'Error-en', 'eu3', 'eu4', 'expert', 'expert tag', 'ff tag', 'fg', 'finalOn', 'final~off', 'final~on', 'flower', 'g', 'germ', 'gh', 'ghjk', 'gj', 'gn', 'g\u2006j\u2006n', 'h', 'h tag', 'haha', 'hh', 'hj', 'huawei t', 'h\u2006j', 'io', 'iOS tag', 'iOS tag2', 'iOS tag5', 'iostag2', 'ip t', 'iPad tag', 'iphone tag', 'iphone6', 'jh', 'jk', 'jkl', 'jl', 'keep', 'lea', 'mi', 'mi tag', 'mi10', 'mi10t', 'mini', 'mini2', 'mn', 'nj', 'no screenshot', 'owner', 'p tag', 'pad t', 'pad tag', 'pad tag1', 'pad tag2', 'pixel t', 'puffer', 'r', 'REC-Default-OFF', 'rec~default~on', 'sa tag', 'safari tag', 'screenshots removed', 'shark', 'starfish', 'tag1', 'tag2', 'tortoise', 'tree', 'uu', 'v', 'vbnn', 'vn', 'vv', 'v\u2006h\u2006n\u2006b\u2006b', 'web', 'web t', 'web t2', 'web tag', 'web tag1', 'web tag2', 'web6', 'webtag1', 'zxc', 'リベンジ', '哥', '地方', '好看', '安当然', '小aoa', '把n', '烦', '看', '这可能', '迷你tag']
    tag = 0
    for one in another_list:
        if one not in list:
            print(one)
            tag = 1
    if tag == 1:
        return "The two lists do not duplicate partial data"
    else:
        return "The two lists partially duplicate data"

def sort_inverted_order_list(list):
    """
    # Sort lists in order
    :param list:
    :return: A list sorted in reverse order
    """
    list.sort(reverse=True)
    return  list

def check_file_and_delete(download_file_name):
    """
    # Check whether there are existing files in the path and delete them if there are
    :return:
    """
    export_file_path = path_for_download_file(DOWNLOAD_PATH, download_file_name)
    result = os.path.exists(export_file_path)
    if result:
        os.remove(export_file_path)
        return 'File has been deleted'
    else:
        return 'There is no such file'

def read_csv_file_check_cloumns(download_file_name):
    """
    # Read the first line field of the CSV file
    :return:
    """
    export_file_path = path_for_download_file(DOWNLOAD_PATH, download_file_name)
    result = os.path.exists(export_file_path)
    if result:
        with open(export_file_path, 'r',encoding='utf-8') as f:
            reader = csv.reader(f)
            print(type(reader))
            result = list(reader)
            print(result[1])
            return  result[1]
    else:
        return 'There is no such file'

def string_with_whitespace_removed(a_string):
    """
    # String with whitespace removed
    :param a_string:
    :return:
    """
    new_list = []
    a_string = a_string.split(',')
    for one in a_string:
        one = one.strip()
        new_list.append(one)
    new_string = ','.join(new_list)
    return new_string

def converts_string_to_lowercase(string_text):
    """
    # Converts a string to lowercase
    :param role:
    :return:
    """
    return string_text.lower()

def converts_string_to_uppercase(string_text):
    """
    # Converts a string to lowercase
    :param role:
    :return:
    """
    return string_text.upper()

def string_conversion(a_string):
    """
    # String conversion
    :param a_string:
    :return:
    """
    if a_string == 'Active':
        a_string = 'true'
    elif a_string == 'Inactive':
        a_string = 'false'
    return a_string

def string_in_list_object(a_string,a_list):
    """
    # Determines that the string is in an object in the list
    :param a_string: 需要判断的字符串
    :param a_list: 需要判断的列表
    :return:
    """
    tag = 0
    for one in a_list:
        if a_string in one:
            tag = 1
    if tag == 1:
        return "There is audit logs"
    else:
        return "There is not audit logs"

def compare_the_two_pictures(picture_id_1,picture_id_2):
    """
    # Compare the two pictures for consistency
    :param picture_id_1: First picture
    :param picture_id_2: Second picture
    :return:
    """
    first_picture_id = re.findall('thumb/(.*?).jpg?', picture_id_1)
    second_picture_id = re.findall('thumb/(.*?).jpg?', picture_id_2)
    print(first_picture_id[0][:8])
    print(second_picture_id[0][:8])
    if first_picture_id[0][:8] == second_picture_id[0][:8]:
        return 'The two pictures are identical'
    else:
        return 'The two pictures are different'

def get_modify_picture_path(picture_name = 'modify_picture.jpg'):
    """
    # 获取modify_picture.jpg绝对路径
    :return: modify_picture.jpg绝对路径
    """
    return get_picture_path(picture_name)


if __name__ == '__main__':
    # print(get_picture_path())
    print(get_modify_picture_path('_ 小炮 + Tristana_.jpg'))
    # get_system_type()
    # print(string_with_whitespace_removed('11 tag, 11t, 16 tag, ad tag2'))
    print(check_zipFile_exists('original'))
    delete_zip_file('original')