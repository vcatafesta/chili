income = [25, 35, 45, 66]


def double_money(dollars):
    return dollars ** 2


new_income = list(map(double_money, income))
print(new_income)

x = [25, 35, 45, 66]
y = map(lambda a: a ** 2, x)
z = list(y)
print(z)


def mult_by_2(num):
    return num * 2


def do_math(func, num):
    return func(num)


times_two = mult_by_2
print('4 * 2 = ', times_two(4))
print('8 * 2 = ', do_math(times_two, 8))


def get_func_mult_by_num(num):
    def mult_by(value):
        return num * value

    return mult_by


generated_func = get_func_mult_by_num(5)
print('5 * 10 = ', generated_func(10))
listOfFuncs = [times_two, generated_func]
print('5 * 9 = ', listOfFuncs[1](9))


def is_it_odd(num):
    if num % 2 == 0:
        return False
    else:
        return True


def change_list(list, func):
    oddlist = []
    for i in list:
        if func(i):
            oddlist.append(i)
    return oddlist


aList = range(1, 20)
print(change_list(aList, is_it_odd))

def random_func(name : str, age : int, weight : float) -> str:
    print('Nome  :', name)
    print('Idade :', age)
    print('Peso  :', weight)
    return "{} is {} years old and weights {}".format(name, age, weight)

print(random_func("Derek", 41, 165.5))
print(random_func(89, "Derek", 'Turtle'))
print(random_func.__annotations__)

