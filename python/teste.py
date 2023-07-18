'''
x = 0xFB
a = 'VILMAR CATAFESTA'
print(a)
print[a[0]]
print(len(a))
print(type(a))
print(a[-5:])

'''


def aadd(obj, item):
    obj.append(item)
    return


def array(ntam):
    a = []
    for x in range(ntam):
        a.append(None)
    return a


def xMenu():
    AtPrompt = []
    aadd(AtPrompt, ["Inclusao", ["SubA1", "SubA2", "", "SubA3", "SubA4"]])
    aadd(AtPrompt, ["Alteraro", ["SubB1", "SubB2", "SubMenu 3"]])
    aadd(AtPrompt, ["Impressao", ["SubC1", "SubB2", "SubMenu 3", "SubMenu 4"]])
    aadd(AtPrompt, ["Consulta", ["SubD1", "SubB2", "SubMenu 3", "SubMenu 4"]])
    aadd(AtPrompt, ["Help", ["SubE1", "SubB2", "SubMenu 3", "SubMenu 4"]])
    return (AtPrompt)

menu = xMenu()
nTam = len(menu)
'''
for nX in range(0, nTam):
    # cMenu = menu[nX::1]
    # print(cMenu)
    item = menu[nX][1][0]
    print(item)
'''


nPos = 1
for nX in range(0, len(menu[nPos][1])):
    print(menu[nPos][1][nX])


def strzero(obj, n):
    return (str(obj).zfill(n))


print(strzero("10.5", 5))