def greet_me(**kwargs):
    if kwargs is not None:
        for key, value in kwargs.iteritems():
            print("%s == %s" % (key, value))


greet_me(name = "yasoob", idade = 30)


def table_things(**kwargs):
    for name, value in kwargs.items():
        print('{0} = {1}'.format(name, value))


table_things(
        apple = 'fruta',
        cabbage = 'vegetal'
        )


def print_three_things(a, b, c):
    print('a = {0}, b = {1}, c = {2}'.format(a, b, c))


mylist = ['aardvark', 'baboon', 'cat']
print_three_things(*mylist)


class Foo(object):
    def __init__(self, value1, value2):
        # do something with the values
        print(value1, value2)


class MyFoo(Foo):
    def __init__(self, *args, **kwargs):
        # do something else, don't care about the args
        print('myfoo')
        super(MyFoo, self).__init__(*args, **kwargs)


alist = ['aardvark', 'baboon', 'cat']
MyFoo(alist, None)

mynum = 1000
mystr = 'Hello World!'
print("{mystr} New-style formatting is {mynum}x more fun!".format(
        **locals()))


def sumFunction(*args):
    result = 0
    for x in args:
        result += x
    return result


num = [1, 2, 3, 4, 5]
soma = sumFunction(*num)
print(soma)
soma = sumFunction(3, 4, 6, 3, 6, 8, 9)
print(soma)


def someFunction(**kwargs):
    if 'text' in kwargs:
        print(kwargs['text'])


someFunction(text = "foo")

a = 'programar ou nao programar?'
a.replace('programar', 'ser')
print(a)
args = ['programar', 'ser']
# a.replace(args) # erro
a.replace(*args)
print(a)


def multiply(*args):
    z = 1
    for num in args:
        z *= num
    print(z)


multiply(4, 5)
multiply(10, 9)
multiply(2, 3, 4)
multiply(3, 5, 10, 6)


def print_kwargs(**kwargs):
    print(kwargs)


print_kwargs(kwargs_1 = "Shark", kwargs_2 = 4.5, kwargs_3 = True)


def print_values(**kwargs):
    for key, value in kwargs.items():
        print("The value of {} is {}".format(key, value))


print_values(my_name = "Sammy", your_name = "Casey")


def print_values(**kwargs):
    for key, value in kwargs.items():
        print("The value of {} is {}".format(key, value))


print_values(
        name_1 = "Alex",
        name_2 = "Gray",
        name_3 = "Harper",
        name_4 = "Phoenix",
        name_5 = "Remy",
        name_6 = "Val"
        )


def some_kwargs(kwarg_1, kwarg_2, kwarg_3):
    print("kwarg_1:", kwarg_1)
    print("kwarg_2:", kwarg_2)
    print("kwarg_3:", kwarg_3)


kwargs = {"kwarg_1": "Val", "kwarg_2": "Harper", "kwarg_3": "Remy"}
some_kwargs(**kwargs)

print('#' * 80)


def print_everything(*args):
    for count, thing in enumerate(args):
        result = '{0}. {1}'.format(count, thing)
        # print(result)
        yield result


frutas = ['apple', 'banana', 'cabbage']


result = print_everything(*frutas)
print(result)
for i in result:
    print (i)
