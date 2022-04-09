# Citron 基于Robotframework+selenium+python的说明文档

---

## 需要改动的配置项
- Lib/python_Lib/ui_keywords.py模块的第十一行，修改file_path为当前主机上的浏览器的默认下载路径
- Lib/public.robot的第十一行，修改${browser_type}为你想启动的浏览器
### Lib目录简介
- Lib路径下的文件，都是封装的scripts下的脚本执行所需调用的关键字，包括关键字的参数，xpath定位路径
- 其中Lib/python_Lib目录下的文件，都是通过python封装的关键字，供其他代码调用
### publicData目录简介
- publicData路径下的文件，存放需要上传的图片、修改的图片；以及所有账户的账号密码（请勿修改）
### scripts目录简介
- scripts路径下的文件，存放每个模块对应的UI测试脚本
### 所有的进行call的case，都是通过python自定义的关键字驱动进行自动化脚本的开发的，每个步骤如果出错了都已添加截图功能
<br><br>
---
---
## 执行脚本的主机上所需要安装的一系列第三方库和环境
1.保证主机上安装了python3,python3配置到系统环境变量中

2.保证主机上安装了浏览器驱动（驱动版本和浏览器版本必须匹配），且浏览器驱动在环境变量中已配置

3.pip install selenium

4.pip install robotframework

5.pip install robotframework-seleniumlibrary

6.pip install robotframework-selenium2library

...
---

## 多种浏览器驱动的下载路径
1、Chrome驱动下载地址：http://chromedriver.storage.googleapis.com/index.html

2、edge驱动下载地址：https://developer.microsoft.com/en-us/microsoft-edge/tools/webdriver/ 
- 需注意，下载到本地的‘msedgedriver.exe’文件要改名为‘MicrosoftWebDriver.exe’，否则会报WebDriverException异常

---

## 如何只执行citron的case？
  进入到Citron目录下，cmd中执行命令：robot --exclude small_range scripts
## 如何只执行small range的case？
  进入到Citron目录下，cmd中执行命令：robot --include small_range scripts