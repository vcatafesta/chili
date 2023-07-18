# coding: cp860
from __future__ import print_function

import ctypes
import multiprocessing
import string
import threading
import time
#import winsound
#from ctypes import wintypes
#from msvcrt import getch
#import WConio
import psutil
from colorconsole import terminal
from progress_bar import *

from define import *

#mylib = ctypes.CDLL('msvcr90.dll')
#printf = mylib.printf
#user32 = ctypes.WinDLL('user32', use_last_error = True)

INPUT_MOUSE = 0
INPUT_KEYBOARD = 1
INPUT_HARDWARE = 2

KEYEVENTF_EXTENDEDKEY = 0x0001
KEYEVENTF_KEYUP = 0x0002
KEYEVENTF_UNICODE = 0x0004
KEYEVENTF_SCANCODE = 0x0008

MAPVK_VK_TO_VSC = 0

# msdn.microsoft.com/en-us/library/dd375731
VK_TAB = 0x09
VK_MENU = 0x12

# C struct definitions

#wintypes.ULONG_PTR = wintypes.WPARAM


class newvar():
    pass


def sci_logger(orig_func):
    import logging
    logging.basicConfig(filename = 'sci.log'.format(orig_func.__name__),
                        level =
                        logging.INFO)

    def wrapper(*args, **kwargs):
        logging.info('Funcao: {} com args: {}, e kwargs: {}'.format(
                orig_func.__name__, args, kwargs))
        return orig_func(*args, **kwargs)

    return wrapper


def space(n, char = 32):
    buffer = chr(char) * int(n)
    return buffer


def replicate(str, vezes):
    ptr = ''
    for x in range(vezes):
        ptr += str
    return (ptr)


def clear():
    screen = terminal.get_terminal()
    screen.reset()
    screen.clear()
    setpos(0, 0)


def write(row, col, cstr):
    screen = terminal.get_terminal()
    screen.gotoXY(row, col)
    print(cstr, end = '')


def maxcol():
    screen = terminal.get_terminal()
    return screen.maxcol()


def maxrow():
    screen = terminal.get_terminal()
    return screen.maxrow()


def setpos(row, col):
    screen = terminal.get_terminal()
    screen.gotoXY(row, col)


def cor(icor):
    if icor:
        screen = terminal.get_terminal()
        screen.SetConsoleTextAttribute(icor)
    else:
        return 31


def aprint(row, col, str, cor, ilen = 1, debug = None):
    nlen = len(str)
    screen = terminal.get_terminal()
    screen.SetConsoleTextAttribute(cor)
    setpos(row, col)
    if (ilen > nlen):
        str.join(space(ilen - nlen))
    elif (ilen != 1 and ilen < nlen):
        str.join(left(str, ilen))
    print(str, end = '')
    return


def tela(icor = None, cstr = None):
    if not icor:
        icor = 15
    x = len(cstr)
    iTop = 0
    iLeft = 0
    iBottom = maxrow()
    iRight = maxcol()
    size = (((iBottom - iTop)) * ((iRight - iLeft)))
    dif = size - (size / x)
    buffer = replicate(cstr, (size / x) + dif)

    # fflush(stdout)
    setpos(0, 0)
    screen = terminal.get_terminal()
    screen.SetConsoleTextAttribute(icor)
    print(buffer)


def roloc(icor):
    return icor * 16


def savevideo():
    try:
        screen = terminal.get_terminal()
        destino = screen.GetText()
    finally:
        return destino


def savescreen():
    return (savevideo())


def restvideo(buffer):
    try:
        screen = terminal.get_terminal()
        screen.PutText(buffer)
    finally:
        return


def setcursor(ntype = 0):
    # 0 for no cursor,
    # 1 for normal cursor,
    # 2 for block cursor.
    try:
        WConio.setcursortype(ntype)
    finally:
        return


def reset_colors():
    screen = terminal.get_terminal()
    screen.reset_colors()


def setcolor(cor = None):
    if not cor:
        cor = 15
    screen = terminal.get_terminal()
    screen.SetConsoleTextAttribute(cor)


def pep468(**kwargs):
    print(list(kwargs.keys()))


def m_frame():
    buffer = str()

    for x in BOX_SINGLE:
        buffer += chr(x)
    return buffer


def left(var, x):
    tam = len(var)
    if x > tam:
        var += replicate(' ', (x - tam))
    return var[0:x]


def right(var, x):
    return (var[-x:])


def reverse(var):
    return (var[::-1])


def substr(var, x, y):
    x -= 1
    y += x
    return var[x:y]


# def right(var, x):
#    return var[-x]

def iif(condicao, condtrue, condfalse):
    if condicao:
        return condtrue
    else:
        return condfalse


def box(nRow, nCol, nRow1, nCol1, cFrame, nCor, titulo = None):
    nComp = (nCol1 - nCol) - 1
    center = maxcol() / 2

    for x in range(nRow, nRow1):
        aprint(x, nCol, space(nComp), nCor, nComp + 1)

    aprint(nRow, nCol, left(cFrame, 1), nCor, 1)
    aprint(nRow, nCol + 1, replicate(substr(cFrame, 5, 1), nComp), nCor, 1)
    aprint(nRow, nCol1, substr(cFrame, 2, 1), nCor, 1)

    for x in range(nRow + 1, nRow1):
        aprint(x, nCol, substr(cFrame, 6, 1), nCor, 1)
        aprint(x, nCol1, substr(cFrame, 6, 1), nCor, 1)

    aprint(nRow1, nCol, substr(cFrame, 3, 1), nCor, 1)
    aprint(nRow1, nCol + 1, replicate(substr(cFrame, 5, 1), nComp), nCor, 1)
    aprint(nRow1, nCol1, substr(cFrame, 4, 1), nCor, 1)
    if titulo:
        aprint(nRow, nCol + 1, '', roloc(nCor), nComp)
        aprint(nRow, center, titulo, roloc(nCor), 1)


def desenhaQuadrado(altura, largura, simbolo = ' ', preenchimento = ' '):
    cor(75)
    print(simbolo * largura)
    for _ in range(altura - 2):
        print('{}{}{}'.format(simbolo, preenchimento * (largura - 2), simbolo))
    print(simbolo * largura)


def alerta(string, cor, centralizar = nil):
    string = str(string)
    cok = ' OK '
    nlinhas = strcount(';', string)
    string = string.split(';', nlinhas)
    nLen = amaxstrlen(string)

    if not cor: cor = 75
    if nLen < 6: nLen = 6
    row = (maxrow() / 2) - (nlinhas / 2) - 4
    col = (maxcol() - nLen) / 2
    center = (maxcol() - len(cok)) / 2
    cScreen = savevideo()

    setcursor(0)
    box(row, col - 2, row + 4 + nlinhas, col + nLen + 1, m_frame(), cor)
    for c in string:
        if centralizar:
            ncol = (maxcol() - len(c)) / 2
        else:
            ncol = col
        aprint(row + 1, ncol, c, cor)
        row += 1
    aprint(row + 2, center, " OK ", roloc(cor))
    readkey()
    restvideo(cScreen)


def conf(texto, cor):
    cScreen = savevideo()
    aArray = [' Sim ', ' Nao ']
    nlinhas = len(aArray)
    lretval = True

    if len(texto) < 6:
        LargJan = 6
    else:
        LargJan = len(texto)
    # endif

    row = (maxrow() / 2) - (nlinhas / 2) - 4
    col = (maxcol() - LargJan) / 2
    col1 = col + LargJan + 1
    row1 = row + 3 + nlinhas
    csep = chr(195) + replicate(chr(196), LargJan) + chr(180)

    box(row, col, row1, col1, m_frame(), cor)
    aprint(row + 1, col + 1, texto, cor, 1)
    aprint(row + 2, col, csep, cor, 1)
    errorbeep()
    lretval = achoice(row + 2, col, row1, col1, aArray, cor, texto)
    restvideo(cScreen)
    return (lretval == 0)


def achoice1(row, col, row1, col1, aArray, cor):
    tam = len(aArray);
    nlarguratotal = (col1 - col)
    poscur = 0

    if not cor:
        cor = 75
    while True:
        nPos = row
        for nx in range(tam):
            if nPos >= col1: break
            cline = left(aArray[nx], nlarguratotal)
            aprint(nPos + nx, col + 1, iif(nx == poscur, cline, cline.upper()),
                   iif(nx == poscur, roloc(cor), cor))
        # next

        key = ord(getch())
        if key == 0:
            return 0
        elif key == 13:
            return poscur + 1
        elif key == 27:
            return 0
        elif key == 224:  # Special keys (arrows, f keys, ins, del, etc.)
            skey = ord(getch())

            if skey == 73:  # PGUP
                if poscur == 0:
                    poscur = tam - 1
                else:
                    poscur = 0
            elif skey == 81:  # PGDOWN
                if poscur == (tam - 1):
                    poscur = 0
                else:
                    poscur = tam - 1
            elif skey == 80:
                poscur += 1
            elif skey == 72:
                poscur -= 1
            elif skey == 75 or skey == 77:
                poscur -= 1
        if poscur < 0:
            poscur = tam - 1
        elif poscur > (tam - 1):
            poscur = 0


def achoice(nrow, ncol, nrow1, ncol1, aArray, ncor, ctitulo = '', espacomenu=0):
    tam = len(aArray)
    ntamtitle = len(ctitulo)
    nlargura = nrow + amaxstrlen(aArray) + 1

    if ncol1 < nlargura:
        ncol1 = nlargura

    if ncol1 > maxcol():
        ncol1 = maxcol()

    if (ncol1 - ncol) < ntamtitle:
        ncol1 = (ncol + ntamtitle)

    nmaxrow = maxrow() - 3
    # nrow1 = nrow + tam
    # nrow1 = nrow + tam

    nrow1 = iif(nrow1 > nmaxrow, nmaxrow, nrow1)
    nlarguratotal = (ncol1 - ncol) - 2
    poscur = 0

    if not ncor: ncor = 75
    # box(nrow, ncol, nrow1, ncol1, cFrame = m_frame(), nCor = ncor, titulo = ctitulo.upper())
    nfirstitem = 0
    nlastitem = (nrow1 - nrow)
    nlastitem = iif(tam < nlastitem, tam, nlastitem)
    nitems = nlastitem

    while True:
        nPos = nrow + 1
        nindex = 0
        for index, nx in enumerate(aArray[nfirstitem:nlastitem]):
            cline = space(espacomenu) + left(nx, nlarguratotal)
            nindex = index + nfirstitem
            aprint(nPos, ncol + 1, iif(nindex == poscur, cline.upper(), cline), iif(nindex == poscur, roloc(ncor), ncor), nlarguratotal - 1)
            nPos += 1
        # next
        xset = {'index'     : nindex,
                'items'     : nitems,
                'poscur'    : poscur,
                'nfirstitem': nfirstitem,
                'nlastitem' : nlastitem,
                'tam'       : tam
                }
        xset = {'Linha ': poscur, 'de ': tam}
        # aprint(0, 0, xset, 31)
        # aprint(0, 0, list([nlarguratotal, nindex, nitems, poscur, nfirstitem, nlastitem, tam]), 31)
        key = ord(getch())
        if key == 0 or key == K_ESC:
            return K_ESC

        elif key == K_RETURN:
            return poscur

        elif key == K_ESPECIAL:  # Special keys (arrows, f keys, ins, del, etc.)
            skey = ord(getch())

            if skey == K_PGUP:
                poscur -= nitems
                if poscur <= nfirstitem:
                    nfirstitem -= nitems
                    nlastitem -= nitems
                    # poscur = nlastitem

            elif skey == K_PGDN:
                poscur += nitems
                if poscur >= nlastitem:
                    nfirstitem += nitems
                    nlastitem += nitems
                    # poscur = nfirstitem

            if skey == K_CTRL_PGUP:
                poscur = 0

            elif skey == K_CTRL_DGDN:
                poscur = tam - 1

            elif skey == K_UP:
                poscur -= 1
                if poscur <= nfirstitem:
                    nfirstitem -= 1
                    nlastitem -= 1

            elif skey == K_DOWN:
                poscur += 1
                if poscur >= nlastitem:
                    nfirstitem += 1
                    nlastitem += 1

            elif skey == K_LEFT:
                poscur -= 1

            elif skey == K_RIGHT:
                poscur += 1

        if poscur <= 0:
            poscur = 0
            nfirstitem = poscur
            nlastitem = nitems

        elif poscur >= tam - 1:
            poscur = tam - 1
            nlastitem = poscur + 1
            nfirstitem = nlastitem - nitems


def inc_item(poscur, nfirstitem, nlastitem):
    return poscur + 1, nfirstitem + 1, nlastitem + 1


def readkey():
    nkey = ord(getch())
    return nkey


def mensagem(string, cor):
    cscreen = savevideo()
    nMaxRow = maxrow()
    nMaxCol = maxcol()
    nLen = len(string)
    row = ((nMaxRow / 2) - 5)
    col = ((nMaxCol - nLen) / 2)

    if (cor == 0):
        cor = 75

    box(row - 1, col, row + 5, col + nLen + 6, m_frame(), cor)
    aprint(row + 2, col + 3, string, cor)
    return (cscreen)


def informa(texto, cor):
    aArray = [" Ok "]
    # cScreen = savevideo()
    if len(texto) < 6:
        LargJan = 6
    else:
        LargJan = len(texto)
    row = (maxrow() - 7) / 2
    col = (maxcol() - LargJan) / 2
    Com = col + LargJan + 1
    nRetVal = True

    box(row - 2, col - 1, row + 3, Com + 1, m_frame(), cor)
    aprint(row - 1, col + 1, texto, cor, 1)
    aprint(row, col, space(LargJan + 2, 196), cor, 1)
    nRetVal = achoice(row + 1, col, row + 1, Com, aArray, cor)
    # restvideo(cScreen)
    return (nRetVal == 1)


def getpass(prompt = "Password: "):
    import termios, sys
    fd = sys.stdin.fileno()
    old = termios.tcgetattr(fd)
    new = termios.tcgetattr(fd)
    new[3] = new[3] & ~termios.ECHO  # lflags
    try:
        termios.tcsetattr(fd, termios.TCSADRAIN, new)
        passwd = raw_input(prompt)
    finally:
        termios.tcsetattr(fd, termios.TCSADRAIN, old)
    return passwd


def imprimehora(n):
    aprint(0, maxcol() - 19, str(time.ctime()), 75)
    return


def horacerta():
    t = threading.Thread(target = imprimehora, args = (1,))
    t.start()
    while t.isAlive():
        time.sleep(1)


def intro():
    bar = ProgressBar("Carregando Sistema", offset = 2, total_width = 50)
    bar(100)
    time.sleep(.1)
    del bar
    bar = ProgressBar("Carregando Menu", offset = 2, total_width = 50)
    bar(100)
    time.sleep(.1)
    del bar
    return


def maxstrlen(xArray):
    ntam = len(xArray)
    nlen = 0
    nmaxlen = 0

    for x in range(0, ntam):
        nlen = len(xArray[x])
        if nmaxlen < nlen:
            nmaxlen = nlen
    return (nmaxlen)


def amaxstrlen(xArray):
    ntam = len(xArray)
    nlen = 0
    nmaxlen = 0

    for x in xArray:
        nlen = len(x)
        if nmaxlen < nlen:
            nmaxlen = nlen
    return (nmaxlen)


def aprintlen(xArray):
    return (len(xArray))


def m_title(ctitle = None):
    from sci import oAmbiente

    if not ctitle == None:
        oAmbiente.title = ctitle
    return oAmbiente.title


def fazmenu(ntopo, nesquerda, aarray, cor, ctitulo = None, nfundo = None):
    cframe = m_frame()
    cframe2 = substr(cframe, 2, 1)
    if nfundo == None: nfundo = (ntopo + len(aarray) + 3)
    ndireita = (nesquerda + amaxstrlen(aarray) + 1)

    if ctitulo == None:
        ctitulo = 'ESCOLHA UMA OPCAO'
    ntamtitle = len(ctitulo) + 12
    cchar = '{0}{3}{0}{2}{3}{3}{3}{3}'.format(chr(179), chr(251), chr(242),
                                              chr(0xB0))
    ctitulo += space(3) + cchar

    if (ndireita - nesquerda) < ntamtitle:
        ndireita = (nesquerda + ntamtitle)

    if (nfundo > maxrow()):
        nfundo = maxrow() - 2

    box(ntopo, nesquerda, nfundo, ndireita, cframe, cor)
    aprint(nfundo - 1, nesquerda + 1, ctitulo, roloc(cor), (ndireita - nesquerda) - 1)
    aprint(nfundo - 2, nesquerda + 1, replicate(substr(cframe, 5, 1), (ndireita - nesquerda) - 1), cor)
    nchoice = achoice(ntopo, nesquerda, nfundo - 2, ndireita, aarray, cor, ctitulo, espacomenu=1)
    return (nchoice)


def upper(str):
    return (str.upper())


def lower(str):
    return (str.lower())


def errorbeep():
    # winsound.Beep(500, 100)
    winsound.Beep(200, 50)


def processor_core():
    try:
        n = multiprocessing.cpu_count()
    except NotImplementedError:
        pass
    return n


def cpu_freq(porcpu = True):
    return (psutil.cpu_freq(percpu = porcpu))


def cpu_percent():
    return (psutil.cpu_percent())


def virtual_memory():
    return (psutil.boot_time())


def total_memory():
    return (psutil._TOTAL_PHYMEM)


def disk_partitions():
    return (psutil.disk_partitions())


def disk_usage():
    return (psutil.disk_usage('/'))


def swap_memory():
    return (psutil.swap_memory())


def net_io_counters():
    return (psutil.net_io_counters(pernic = True))


def net_connections():
    return (psutil.net_connections())


def net_if_stats():
    return (psutil.net_if_stats())


def valtype(obj):
    if type(obj) == int:
        return "N"
    elif type(obj) == str:
        return "C"
    elif type(obj) == str:
        return "C"
    elif type(obj) == iter:
        return "I"
    elif type(obj) == bool:
        return "L"
    elif type(obj) == tuple:
        return "T"
    elif type(obj) == object:
        return "O"
    elif type(obj) == dict:
        return "D"
    elif type(obj) == classmethod:
        return "CS"


def aadd(obj, item):
    return (obj.append(item))


def array(ntam, var = None):
    if var == None:
        return ([var for index, item in enumerate(range(ntam))])
    else:
        return ([str(index) for index, item in enumerate(range(ntam))])


'''
def array_strzero(ntam, nlen, var = None):
    if var == None:
        # return ([strzero(index, nlen) for index, item in enumerate(range(ntam))])
        # return ([strzero(index, index) for index, item in enumerate(range(ntam))])
        return ([strzero(index, index) for index, item in enumerate(range(ntam))])
    else:
        return ([var.zfill(index) + str(index) for index, item in enumerate(range(ntam))])
'''


def array2(ntam):
    a = []
    for x in range(ntam):
        a.append(None)
    return a


def empty(exp):
    return len(exp) <= 0


def val(obj):
    return (int(obj))


def strzero(obj, n = 0):
    if n == 0 or n == None:
        n = len(str(obj))
    return (str(obj).zfill(n))


def inkey(n):
    time.sleep(n)
    return


def Aclone(lista):
    return (list(lista))


def date():
    return (str(time.ctime()))

'''
class MOUSEINPUT(ctypes.Structure):
    _fields_ = (("dx", wintypes.LONG),
                ("dy", wintypes.LONG),
                ("mouseData", wintypes.DWORD),
                ("dwFlags", wintypes.DWORD),
                ("time", wintypes.DWORD),
                ("dwExtraInfo", wintypes.ULONG_PTR))


class KEYBDINPUT(ctypes.Structure):
    _fields_ = (("wVk", wintypes.WORD),
                ("wScan", wintypes.WORD),
                ("dwFlags", wintypes.DWORD),
                ("time", wintypes.DWORD),
                ("dwExtraInfo", wintypes.ULONG_PTR))

    def __init__(self, *args, **kwds):
        super(KEYBDINPUT, self).__init__(*args, **kwds)
        # some programs use the scan code even if KEYEVENTF_SCANCODE
        # isn't set in dwFflags, so attempt to map the correct code.
        if not self.dwFlags & KEYEVENTF_UNICODE:
            self.wScan = user32.MapVirtualKeyExW(self.wVk,
                                                 MAPVK_VK_TO_VSC, 0)


class HARDWAREINPUT(ctypes.Structure):
    _fields_ = (("uMsg", wintypes.DWORD),
                ("wParamL", wintypes.WORD),
                ("wParamH", wintypes.WORD))


class INPUT(ctypes.Structure):
    class _INPUT(ctypes.Union):
        _fields_ = (("ki", KEYBDINPUT),
                    ("mi", MOUSEINPUT),
                    ("hi", HARDWAREINPUT))

    _anonymous_ = ("_input",)
    _fields_ = (("type", wintypes.DWORD),
                ("_input", _INPUT))


LPINPUT = ctypes.POINTER(INPUT)


def _check_count(result, func, args):
    if result == 0:
        raise ctypes.WinError(ctypes.get_last_error())
    return args


user32.SendInput.errcheck = _check_count
user32.SendInput.argtypes = (wintypes.UINT,  # nInputs
                             LPINPUT,  # pInputs
                             ctypes.c_int)  # cbSize

'''
def PressKey(hexKeyCode):
    x = INPUT(type = INPUT_KEYBOARD,
              ki = KEYBDINPUT(wVk = hexKeyCode))
    user32.SendInput(1, ctypes.byref(x), ctypes.sizeof(x))


def ReleaseKey(hexKeyCode):
    x = INPUT(type = INPUT_KEYBOARD,
              ki = KEYBDINPUT(wVk = hexKeyCode,
                              dwFlags = KEYEVENTF_KEYUP))
    user32.SendInput(1, ctypes.byref(x), ctypes.sizeof(x))


def KeyBoard(nKey):
    PressKey(nKey)
    # ReleaseKey(VK_TAB)  # Tab~


def StrHotKey(cMenu, cHotKey, nMenuOuSubMenu):
    cChar = "^"
    cSwap = space(0)
    nDel = 0
    nPos = 3
    nConta = 0
    cStr = space(0)
    cNew = space(0)

    nPos = iif(nMenuOuSubMenu == 1, 3, 4)
    nConta = StrCount(cChar, cMenu)
    if nConta <= 0:  # sem cChar ?
        cMenu = Stuff(cMenu, nPos, nDel, cChar)

    nConta = StrCount(cChar, cMenu)
    if nConta > 0:
        cHotKey = StrExtract(cMenu, cChar, 1)
        cMenu = StrSwap(cMenu, cChar, 1, cSwap)
    return


def ifnil(obj, default):
    if obj:
        return obj
    else:
        # for item in globals():
        #    if id(item) == id(obj):
        #       globals()[item] = default
        globals()['obj'] = default
        return default


def dispacth_if(operator, x, y):
    if operator == 'add':
        return x + y
    if operator == 'sub':
        return x - y
    if operator == 'mul':
        return x * y
    if operator == 'div':
        return x / y
    if operator == 'exp':
        return x ** y
    return None


def dispacth_dict(operator, x, y):
    return {
        'add': lambda: x + y,
        'sub': lambda: x - y,
        'mul': lambda: x * y,
        'div': lambda: x / y,
        'exp': lambda: x ** y,
        }.get(operator, lambda: None)()


def funcZero():
    return 0


def funcUm():
    return 1


def funcDois():
    return 2


def funcDefault():
    return None


def switch(arg):
    return {
        0: funcZero,
        1: funcUm,
        2: funcDois
        }.get(arg, lambda: None)()  # }.get(arg, funcDefault)()


def strcount(delim, string):
    return (string.count(delim))


def inc_array():
    doubled_odds = []
    for n in numbers:
        if n % 2 == 1:
            doubled_odds.append(n * 2)


def inc_array2():
    doubled_odds = [n * 2 for n in numbers if n % 2 == 1]


import socket

confiaveis = ['www.google.com', 'www.yahoo.com', 'www.bb.com.br']


def check_host():
    global confiaveis
    for host in confiaveis:
        a = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        a.settimeout(.5)
        try:
            b = a.connect_ex((host, 80))
            if b == 0:  # ok, conectado
                return True
        except:
            pass
        a.close()
    return False


''''

at = []
disp = []
aadd(at, ["Encerrar", ["Encerrar Execucao do SCI", ""]])
aadd(at, ["Modulos", ["Controle de Estoque", "Contas a Receber", "Contas a Pagar"]])

for row in at:
    print(row)
    disp.append(True)  # y = [True for j in at for True in at]
    for n in row[1]:
        print(n)
        disp.append(True)  # y = [True for j in at for True in at]
print(disp, len(disp))
readkey()
'''

# functions

import random
import rstr
import names
import datetime


def funcA():
    print(random.randint(1, 10))
    print(rstr.rstr('sdajdfkasflsjflsfksafksa', 5))
    print(datetime.datetime.now().isoformat())
    print(datetime.datetime.now().isoformat(" "))
    print(names.get_first_name())
    print(names.get_last_name())
    print(names.get_full_name())


def gen_age():
    # gera numero inteiros entre 15 e 99
    return random.randint(15, 99)


def gen_cpf():
    # gera uma string com 11 caracteres numericos
    return \
        rstr.rstr('1234567890', 11)


def gen_phone():
    return '({0}) {1}-{2}'.format(
            rstr.rstr('1234567890', 2),
            rstr.rstr('1234567890', 4),
            rstr.rstr('1234567890', 4))


def strRTrimlen(str):
    tam = len(str)
    nlen = tam
    buffer = reverse(str)

    '''
    for x in buffer:
        if x == ' ':
            nlen -= 1
        else:
            break
    return 0, nlen
    '''

    for x in buffer:
        if x == ' ':
            nlen -= 1
        else:
            break
    return nlen

    """
    for x in range(tam - 1, 0, -1):
        if str[x] == ' ':
            nlen -= 1
        else:
            break
    return nlen
    """


def strLTrimlen(str):
    tam = len(str)
    nlen = 0

    for x in range(0, tam):
        if str[x] == ' ':
            nlen += 1
        else:
            break
    return nlen


def rtrim(str):
    # return str[strRTrimlen(str)[0]:strRTrimlen(str)[1]:]
    return str[0:strRTrimlen(str)]


def ltrim(str):
    return str[strLTrimlen(str):]


def alltrim(var):
    # var = var[0:strRTrimlen(var)]
    # return var[strLTrimlen(var):]
    return (rtrim(ltrim(var)))


def test_trim():
    c = " VILMAR CATAFESTA "
    print(c, len(c), ltrim(c), len(ltrim(c)), alltrim(c), len(alltrim(c)))
    print()
    print(list(c))
    # print(list(reverse(ltrim(reverse(c)))), len(reverse(ltrim(reverse(c)))))
    print(list(rtrim(c)), len(c))
    print(list(ltrim(c)), len(c))
    print(list(ltrim(rtrim(c))), len(c))
    print(list(alltrim(c)), len(c))


def test_left():
    c = "VILMAR CATAFESTA"
    print(c, len(c))
    print()
    print(list(c))
    print(list(left(c, 20)), len(left(c, 20)))


def test_iter():
    old_list = [2, 4, 7, 13, 16]
    new_list = [element * 2 for element in old_list if element % 2 == 0]

    for i in new_list:
        print(i)


def IsNumber(obj):
    return (type(obj) is int)


def IsLogical(obj):
    return (type(obj) is bool)


def IsList(obj):
    return (type(obj) is list)


def IsStr(obj):
    return (type(obj) is str)


def IsCharacter(obj):
    return (type(obj) is str)


def IsFile(obj):
    return (type(obj) is file)


def strtran(cString, cProcura, cSubstitui, nInicio = None, nCont = None):
    return (cString.replace(cProcura, cSubstitui))


def ains(obj, nposicao, value = None):
    return obj.insert(nposicao, value)


def aclone(afonte):
    return (list(afonte))


def acopy(afonte, adestino, ninicio = 0, ncont = 0, nposdestino = 0):
    if ninicio == 0 and ncont == 0 and nposdestino == 0:
        adestino = aclone(afonte)
    else:
        ncopiado = 0
        for x, item in enumerate(afonte):
            if x >= ninicio:
                if ncont == 0 or ncopiado < ncont:
                    nlen = len(adestino)
                    if nlen > nposdestino + ncopiado:
                        adestino.pop((nposdestino + ncopiado))
                    ains(adestino, nposdestino + ncopiado, item)
                    ncopiado += 1
    return adestino


def strsort(str, reverse = False):
    str = list(str)
    str.sort(reverse = reverse)
    return ''.join(str)


class Aluno:
    def __init__(self, nome, matricula):
        self.nome = nome
        self.matricula = matricula

    def __str__(self):
        return "%s - %s" % (str(self.nome), str(self.matricula))


def Aluno_run(alunos):
    for aluno in alunos:
        print(aluno)

    alunos.sort(key = lambda self: self.nome)
    for aluno in alunos:
        print(aluno)

    def key_func(aluno):
        return aluno.nome

    alunos.sort(key = key_func)
    for aluno in alunos:
        print(aluno)

    from operator import attrgetter

    alunos.sort(key = attrgetter("nome"))

    alunos = [("Jose", 12345), ("Maria", 28374), ("Joao", 11119),
              ("Joana", 12346)]
    alunos.sort(key = lambda x: x[0])
    print(alunos)

    from operator import itemgetter
    alunos.sort(key = itemgetter(1))
    print(alunos)


def Aluno_test():
    alunos = [Aluno("".join(random.sample(string.ascii_letters, 5)),
                    random.randint(0, 100)) for i in range(10)]
    Aluno_run(alunos)


def printf_test():
    printf("%d bottles de cerveja: \n", 10)
    printf("Aniversario: %02d/%02d/%04d\n", 18, 9, 1966);
    return


def asort(adestino, ninicio = 0, ncont = 0, reverse = False):
    if ninicio <= 0 and ncont <= 0:
        adestino.sort(reverse = reverse)
    else:
        if ncont <= 0: ncont = len(adestino)
        # new_list = [upper(item) for item in a]
        # new_list = [upper(element) for index, element in enumerate(adestino) if index >= ninicio and index <= ncont + ninicio]
        # clist = [[index, element] for index, element in enumerate(adestino) if index >= ninicio and index <= ncont + ninicio]
        nlist = [index for index, element in enumerate(adestino) if
                 index >= ninicio and index <= ncont + ninicio]
        clist = [element for index, element in enumerate(adestino) if
                 index >= ninicio and index <= ncont + ninicio]
        clist.sort(reverse = reverse)
        for x, y in zip(nlist, clist):
            adestino[x] = y
    return adestino


def array_str(ntam, nlen):
    if nlen > 50: nlen = 50
    return ["".join(random.sample(string.ascii_letters, nlen)) for i in
            range(ntam)]


def array_str_random(ntam, nlen):
    return ["".join(strzero(random.randint(0, nlen), nlen)) for i in
            range(ntam)]


def array_names(ntam, nlen):
    a = ["".join(names.get_full_name()) for i in range(ntam)]
    return sorted(a)


def array_int(ntam, nlen):
    return [random.randint(0, nlen) for i in range(ntam)]


def make_squares(key, value = 0):
    """Return a dictionary and a list..."""
    d = {key: value}
    l = [key, value]
    return d, l


def array_strzero(ntam, nlen, var = None, key = None):
    if var == None: var = str()
    if type(var) == int: var = str(var)
    ilen = len(var)
    if key != None:
        return [key(''.join(var + strzero(i, nlen - ilen))) for i in
                range(ntam)]
    else:
        return [''.join(var + strzero(i, nlen - ilen)) for i in range(ntam)]


def bissextoarray(*args):
    return map((lambda x: x % 4 == 0 and x % 100 != 0), args)


def bissextofilter(*args):
    return filter((lambda x: x % 4 == 0 and x % 100 != 0), args)


def bissexto(arg):
    return True in map((lambda x: x % 4 == 0 and x % 100 != 0), [arg])


StrTran = strtran
StrZero = strzero
Aclone = aclone
Ains = ains
Acopy = acopy
Asort = asort
StrSort = strsort

# a = array_str(10, 5)
# a = array_str(1000, 20)
# b = [upper(item) for item in a]
# print(a)
# print(asort(a, 8, -1))

# a = array_strzero(5, 5, 'ev', key = lambda x: right(upper(StrZero(x)),10))
# print(a)
