# _*_ coding: utf-8 _*_ #
# @Time     :11/30/2022 11:01 AM
# @Author   :Huiming Shi

a_list = [i for i in range(10)]
def test_yiled():
    print("开始执行")
    for one in a_list:
        yield one
        print("继续执行")

my_test = test_yiled()
print(type(my_test))

next(my_test)
next(my_test)
next(my_test)
next(my_test)
next(my_test)
next(my_test)
next(my_test)
next(my_test)
next(my_test)
next(my_test)
next(my_test)