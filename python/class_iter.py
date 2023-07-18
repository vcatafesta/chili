import os


def lin():
    print
    print('#' * 120)
    print
    return


class Library(object):
    def __init__(self):
        self.books = {'title': object, 'title2': object, 'title3': object, }

    def __getitem__(self, i):
        return self.books[i]

    def __iter__(self):
        return self.books.itervalues()

    def iter2(self):
        for title in self.books:
            yield self.books[title]


library = Library()
print library['title']

for book in library:
    print book, library.iter2()

print(library.books.values())


class Test(object):
    def __getitem__(self, items):
        print '%-15s  %s' % (type(items), items)


t = Test()
print t[1]
print t['hello world']
print t[1, 'b', 3.0]
print t[5:200:10]
print t['a':'z':3]
print t[object()]


class Test(object):
    def __call__(self, *args, **kwargs):
        print args
        print kwargs
        print '-' * 80


t = Test()
print t(1, 2, 3)
print t(a = 1, b = 2, c = 3)
print t(4, 5, 6, d = 4, e = 5, f = 6)


class Test1(object):
    def __init__(self):
        self.a = 'a'
        self.b = 'b'

    def __getattr__(self, name):
        return 123456


t = Test1()
print 'object variables: %r' % t.__dict__.keys()
print t.a
print t.b
print t.c
print getattr(t, 'd')
print hasattr(t, 'x')


class TestSetattr(object):
    def __init__(self):
        self.a = 'a'
        self.b = 'b'

    def __setattr__(self, name, value):
        print 'set %s to %s' % (name, repr(value))

        if name in ('a', 'b'):
            object.__setattr__(self, name, value)


t = TestSetattr()
t.c = 'z'
setattr(t, 'd', '888')


class Indexer:
    def __getitem__(self, index):
        return index ** 2


X = Indexer()
print X[2]  # X[i] calls X.__getitem__(i)

for i in range(5):
    print i, '**', 1, '->', X[i]  # Runs __getitem__(X, i) each time


class Slicer:
    def __getitem__(self, index):
        print index

    def __getslice__(self, i, j):
        print i, j

    def __setslice__(self, i, j, seq):
        print i, j, seq


print Slicer()[1]  # Runs __getitem__ with int, like 3.X
print Slicer()[1:9]  # Runs __getslice__ if present, else __getitem__
print Slicer()[1:9:2]  # Runs __getitem__ with slice(), like 3.X!


class C:
    def __index__(self):
        return 255


X = C()
# print hex(X)
# print bin(X)
# print oct(X)

lin()

for element in {'one': 1, 'two': 2}:
    print(element)

dict = {'Name': 'Zara', 'Age': 7, 'Class': 'First'}
print "Name  : ", dict['Name']
print "Age   : ", dict['Age']
lin()

for c in "Hello":
    print c

d = {'a': 1, 'b': 2, 'c': 3}
for k in d:
    print k

for v in d.itervalues():
    print v

for k, v in d.iteritems():
    print k, v

lin()

with open("sci.py") as f:
    for line in f:
        print repr(line)

lin()

for root, dirs, files in os.walk('/python/teste'):
    print root, dirs, files

lin()

names = ['Torre Eifell', "Torre Empire State", 'Torre Sears']
list(enumerate(names))

for indice, torre in enumerate(names):
    print indice, torre

lin()

# Iteration vs indexing
for i in range(len(names)):
    v = names[i]
    print i, v

# more powerfull:
for i, v in enumerate(names):
    print i, v

with open("sci.py") as f:
    for linenum, line in enumerate(f, start = 1):
        print linenum, line,

lin()

torres = ['Torre Eifell', "Torre Empire State", 'Torre Sears']
alturas = [324, 381, 442]

for i in range(len(torres)):
    nome = torres[i]
    altura = alturas[i]
    print "%s: %s metros" % (nome, altura)

# zip() makes pair-wise loops

for nome, altura in zip(torres, alturas):
    print "%s: %s metros" % (nome, altura)

# dict() acceps a stream of pairs

a = zip(torres, alturas)
b = enumerate(torres)
c = enumerate(zip(torres, alturas))
lin()
for i in a:
    print i

lin()
for x, y in b:
    print x, y

lin()
for x, y in c:
    print x, y[0], y[1]

lin()
for x, y in enumerate(zip(torres, alturas)):
    print x, y[0], y[1]

lin()


# Generators

def hello_world():
    yield "Hello"
    yield "world"


for x in hello_world():
    print x

lin()


# your own generator

def interesting_lines(f):
    for linenum, line in enumerate(f, start = 1):

        line = line.upper()
        line = line.strip()

        if line.count('SCI'):
            #continue
            yield linenum
            yield line
        if not line:
            continue
        #yield line


with open("sci.py") as f:
    for line in interesting_lines(f):
        print line

lin()

def header_line():
    with open("sci.py") as f:
        header_line = next(f)
        yield header_line

print header_line()