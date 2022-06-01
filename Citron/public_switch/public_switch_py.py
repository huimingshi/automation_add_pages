# _*_ coding: utf-8 _*_ #
# @Time     :5/6/2022 2:57 PM
# @Author   :Huiming Shi

# small range的call类型的case需要运行的浏览器类型；Firefox——>火狐浏览器，Chrome——>谷歌浏览器
SMALL_RANGE_BROWSER_TYPE = 'Chrome'      # 暂不支持Firefox，请固定为Chrome

# citron的除去call的case需要运行的浏览器类型；Firefox——>火狐浏览器，Chrome——>谷歌浏览器
CITRON_BROWSER_TYPE = 'Firefox'

# 浏览器设置的文件默认下载路径
DOWNLOAD_PATH = r'C:\Users\ts\Downloads'

# Citron的地址
TEST_WEB = 'https://app-stage.helplightning.net.cn/'

# 默认的隐式等待时间
IMPLICIT_WAIT = 15

# 设置默认的超时时间s
PAGE_LOAD_TIMEOUT = 180

# 显示等待超时时间
WEBDRIVERWAIT_TIMEOUT = 20

# 显示等待轮询时间
POLL_FREQUENCY = 0.5