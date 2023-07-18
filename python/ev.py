# coding: utf-8
# from funcoes import array_str
import funcoes as MS

# aNomes = MS.array_names(100, 20)
# print(aNomes)
# print("Olá,", aNomes)

# for i in aNomes:
#    print 'Olá', i, i[0:3], i[1:5]

l = ['David', 'Pythonista', '+1-514-555-1234']
name, title, phone = l
print(name, title, phone)

people = [l, ['Guido', 'BDFL', 'unlisted']]
for (name, title, phone) in people:
    print name, phone

david, (gname,
        gtitle,
        gphone) = people
print(gname,
      gtitle,
      gphone,
      david
      )
