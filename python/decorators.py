def outer_function():
    message = 'Hi'

    def inner_function():
        print(message)

    return inner_function()


outer_function()
hi_func = outer_function()


#################################################################################
def outer_function(msg):
    message = msg

    def inner_function():
        print(message)

    return inner_function()


hi_func = outer_function('Hi')
by_func = outer_function('Bye')


#################################################################################


def cumprimentar(nome):
    return 'Hello ' + nome


greet_someone = cumprimentar
print(greet_someone('Vilmar'))


#################################################################################

def greet(name):
    def get_message():
        return "Hello "

    result = get_message() + name
    return result


print(greet('Vilmar'))


#################################################################################

def hello(nome):
    return 'Alo ' + nome


def call_func(func):
    other_name = 'Evili'
    return func(other_name)


print(call_func(hello))


#################################################################################

def compose_greet_func():
    def get_message():
        return "Hello there!"

    return get_message


greet = compose_greet_func()
print(greet())


#################################################################################

def compose_greet_func(nome):
    def get_message():
        return "Ola " + nome + "!"

    return get_message


greet = compose_greet_func("John")
print(greet())


#################################################################################

def get_text(name):
    return "lorem ipsum, {0} dolor sit amet".format(name)


def p_decorate(func):
    def func_wrapper(name):
        return "<p>{0}</p>".format(func(name))

    return func_wrapper


my_get_text = p_decorate(get_text)

print(my_get_text("John"))


#################################################################################

def p_decorate(func):
    def func_wrapper(name):
        return "<p>{0}</p>".format(func(name))

    return func_wrapper


@p_decorate
def get_text(name):
    return "lorem ipsum, {0} dolor sit amet".format(name)


print(get_text("John"))


#################################################################################

def p_decorate(func):
    def func_wrapper(name):
        return "<p>{0}</p>".format(func(name))

    return func_wrapper


def strong_decorate(func):
    def func_wrapper(name):
        return "<strong>{0}</strong>".format(func(name))

    return func_wrapper


def div_decorate(func):
    def func_wrapper(name):
        return "<div>{0}</div>".format(func(name))

    return func_wrapper


get_text = div_decorate(p_decorate(strong_decorate(get_text)))


@div_decorate
@p_decorate
@strong_decorate
def get_text(name):
    return "lorem ipsum, {0} dolor sit amet".format(name)


print(get_text("John"))


#################################################################################

def p_decorate(func):
    def func_wrapper(self):
        return "<p>{0}</p>".format(func(self))

    return func_wrapper


class Person(object):
    def __init__(self):
        self.name = "John"
        self.family = "Doe"

    @p_decorate
    def get_fullname(self):
        return self.name + " " + self.family


my_person = Person()
print(my_person.get_fullname())


#################################################################################

def p_decorate(func):
    def func_wrapper(*args, **kwargs):
        return "<p>{0}</p>".format(func(*args, **kwargs))

    return func_wrapper


class Person(object):
    def __init__(self):
        self.name = "John"
        self.family = "Doe"

    @p_decorate
    def get_fullname(self):
        return self.name + " " + self.family


my_person = Person()

print(my_person.get_fullname())


#################################################################################

def tags(tag_name):
    def tags_decorator(func):
        def func_wrapper(name):
            return "<{0}>{1}</{0}>".format(tag_name, func(name))

        return func_wrapper

    return tags_decorator


@tags("p")
def get_text(name):
    return "Hello " + name


print(get_text("John"))

#################################################################################

from functools import wraps


def tags(tag_name):
    def tags_decorator(func):
        @wraps(func)
        def func_wrapper(name):
            return "<{0}>{1}</{0}>".format(tag_name, func(name))

        return func_wrapper

    return tags_decorator


@tags("p")
def get_text(name):
    """returns some text"""
    return "Hello " + name


print(get_text.__name__)  # get_text
print(get_text.__doc__)  # returns some text
print(get_text.__module__)  # __main__

#################################################################################

import time


def timing_function(some_function):
    """
    Outputs the time a function takes
    to execute.
    """

    def wrapper():
        t1 = time.time()
        some_function()
        t2 = time.time()
        return "Time it took to run the function: " + str((t2 - t1)) + "\n"

    return wrapper


@timing_function
def my_function():
    num_list = []
    for num in (range(0, 10000)):
        num_list.append(num)
    print("\nSum of all the numbers: " + str((sum(num_list))))


print(my_function())


#################################################################################

def decorator_function(original_function):
    def wrapper_function(*args, **kwargs):
        print('wrapper executado antes de {}'.format(
                original_function.__name__))
        return original_function(*args, **kwargs)

    return wrapper_function


@decorator_function
def display():
    print('Display function ran')


@decorator_function
def display_info(name, age):
    print("display_info ran with arguments ({},{})".format(name, age))


display_info('Vilmar', 50)
display()

#################################################################################

from funcoes import sci_logger


@sci_logger
def display_info_log(name, age):
    print("display_info ran with arguments ({},{})".format(name, age))


display_info_log('Vilmar', 50)
display_info_log('Vilmar', 150)
display_info_log('Vilmar', 250)
display_info_log('Vilmar', 350)

