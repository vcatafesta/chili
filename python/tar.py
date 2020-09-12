#import tarfile
#tar = tarfile.open("sample.tar.gz")
#tar.extractall()
#tar.close()

import tarfile
tar = tarfile.open("sample.tar.xz", "r:xz")
for tarinfo in tar:
    print(tarinfo.name, "is", tarinfo.size, "bytes in size and is ", end="")
    if tarinfo.isreg():
        print("a regular file.")
    elif tarinfo.isdir():
        print("a directory.")
    else:
        print("something else.")
        tar.close()

print(tar.getnames())


import tarfile
import time

t = tarfile.open('sample.tar.xz', 'r')
for info in t.getmembers():
    print(info.name)
    print('Modified:', time.ctime(info.mtime))
    print('Mode    :', oct(info.mode))
    print('Type    :', info.type)
    print('Size    :', info.size, 'bytes')
    print()

import tarfile
t = tarfile.open('sample.tar.xz', 'r')
for file_name in [ 'usr/share/info/which.info.gz', '.MTREE' ]:
    try:
        f = t.extractfile(file_name)
    except KeyError:
        print('ERROR: Did not find %s in tar archive' % file_name)
    else:
        print(file_name, ':', f.readlines())



def Fibonacci( pos ):
    if pos <= 1 :
        return 0
    if pos == 2:
        return 1
    n_1 = Fibonacci( pos-1 )
    n_2 = Fibonacci( pos-2 )
    n = n_1 + n_2
    return n

nth_fibo = Fibonacci( 5 )
print (nth_fibo)

