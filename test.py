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

# next(my_test)
# next(my_test)
# next(my_test)
# next(my_test)
# next(my_test)
# next(my_test)
# next(my_test)
# next(my_test)
# next(my_test)
# next(my_test)
# next(my_test)

for one in my_test:
    pass

a_string = "123456"
print(list(a_string))
v1 = list([1,2,3,4,5,6])
print(type(v1)) 