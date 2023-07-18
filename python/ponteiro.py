from ctypes import windll, Structure, c_int, c_short, c_ushort, byref, c_uint, c_wchar_p
import ctypes
from ctypes.util import find_library as findlib
from ctypes import *

mylib = ctypes.CDLL('msvcr90.dll')
printf = mylib.printf

i = c_int(42)
pi = pointer(i)
print(pi)


######################################################################################################

class Bar(Structure):
    _fields_ = [
        ("count", c_int),
        ("values", POINTER(c_int))
        ]


bar = Bar()
bar.values = (c_int * 3)(1, 2, 3)
bar.count = 3
for i in range(bar.count):
    print bar.values[i]


######################################################################################################


class cell(Structure):
    pass


cell._fields_ = [("name", c_char_p),
                 ("next", POINTER(cell))]

c1 = cell()
c1.name = "foo"
c2 = cell()
c2.name = "bar"
c1.next = pointer(c2)
c2.next = pointer(c1)
p = c1
for i in range(8):
    print p.name,
    p = p.next[0]


######################################################################################################

class POINT(Structure):
    _fields_ = ("x", c_int), ("y", c_int)


class RECT(Structure):
    _fields_ = ("a", POINT), ("b", POINT)


p1 = POINT(1, 2)
p2 = POINT(3, 4)
rc = RECT(p1, p2)
print rc.a.x, rc.a.y, rc.b.x, rc.b.y

# now swap the two points
rc.a, rc.b = rc.b, rc.a
print rc.a.x, rc.a.y, rc.b.x, rc.b.y

######################################################################################################

s = c_char_p()
s.value = "abc def ghi"
print(s.value)
print(s.value is s.value)

######################################################################################################

short_array = (c_short * 4)()
print(sizeof(short_array))

# resize(short_array, 4)
resize(short_array, 32)
sizeof(short_array)
sizeof(type(short_array))

s = short_array[:]
print(s)


######################################################################################################


class Bottles(object):
    def __init__(self, number):
        self._as_parameter_ = number


bottles = Bottles(42)
printf("%d bottles de cerveja: %d \n", bottles, bottles)
