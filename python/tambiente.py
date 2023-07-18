# coding: cp860
from clima import *
from tini import *


class TAmbiente(object):
    def __init__(self):
        self.name = 'TAmbiente'
        self.__attr = 0
        self.corcabec = 31
        self.cormenu = 15
        self.corfundo = 2
        self.coralerta = 22
        self.cordesativada = 8
        self.corlightbar = 124
        self.corhotkey = 11
        self.corhklightbar = 125

        self.panofundo = chr(0xB0) + chr(196)
        self.xsistema = "Macrosoft PySCI"
        self.cabec = self.xsistema + ' - MENU PRINCIPAL'
        self.xversao = '1.0.0.1 Python'
        self.xcopyright = 'Copyright (c), 2017 Macrosoft Informatica Ltda'
        self.footer = 'MACROSOFT SISTEMA DE INFORMATICA LTDA'
        self.title = "ESCOLHA UMA OPCAO"
        self.menuprincipal = ["Encerrar", "Sistemas", "Vendas", "Backup",
                              "Editor", "Config", "Arquivos", "Reconstruir",
                              "Shell", "Help"]
        screen = terminal.get_terminal()
        screen.set_title(self.cabec)
        self.maxcol = screen.maxcol()
        self.maxrow = screen.maxrow()
        self.title = str()
        self.nPos = 0
        self.ativo = 0
        self.nItem = 0
        self.lastkey = 0
        self.index = 0  # indices comecam em 0
        self.alterando = False
        self.StatusSup = self.cabec
        self.StatusInf = 'F1-HELP|F5-PRECOS|F10-CALC|{}|'.format(self.footer)
        self.CodiFirma = '0001'
        self.NomeFirma = "VCATAFESTA@GMAIL.COM"
        self.xUsuario = "ADMIN"
        self.Get_Ativo = True
        self.Sombra = True
        self.linha = 1
        self.nRegistrosImpressos = 0
        self.frame = m_frame()
        self.menu = self.xMenu()
        self.disp = self.xDisp()
        self.cotacao = TCotacao()

    @property
    def attr(self):
        return self.__attr

    @attr.setter
    def attr(self, value):
        self.__attr = value

    @attr.deleter
    def attr(self):
        del self.__attr

    def statusinf(self):
        _cstr = self.StatusInf
        aprint(self.maxrow - 1, 0, _cstr, self.corcabec, maxcol())

    def statussup(self):
        aprint(0, 0, self.cabec.center(self.maxcol, ' '), self.corcabec)
        aprint(0, self.maxcol - 24, str(time.ctime()), self.corcabec)

    def limpa(self, icor = None):
        if not icor: icor = self.corfundo
        tela(icor, self.panofundo)
        self.statussup()
        self.statusinf()
        return (self)

    def setacor(self, ntipo):
        oTemp = TAmbiente()
        oIni = TIni('SCI.INI')
        aini = ['corfundo', 'cormenu', 'corcabec', 'coralerta', 'cordesativada',
                'corligthbar', 'corhotkey', 'corhkligthbar']
        atipo = [self.corfundo, self.cormenu, self.corcabec, self.coralerta,
                 self.cordesativada, self.corlightbar, self.corhotkey,
                 self.corhklightbar]

        d = {'corcabec'     : self.corcabec,
             'cormenu'      : self.cormenu,
             'corfundo'     : self.corfundo,
             'coralerta'    : self.coralerta,
             'cordesativada': self.cordesativada,
             'corligthbar'  : self.corlightbar,
             'corhotkey'    : self.corhotkey,
             'corhkligthbar': self.corhklightbar
             }

        x = atipo[ntipo]
        y = atipo[ntipo]
        c = aini[ntipo]

        screen = savevideo()
        # from sci import oIni
        # from sci import oMenu
        # from sci import oAmbiente

        oTemp.corfundo = atipo[0]
        oTemp.cormenu = atipo[1]
        oTemp.corcabec = atipo[2]
        oTemp.coralerta = atipo[3]
        oTemp.cordesativada = atipo[4]
        oTemp.corlightbar = atipo[5]
        oTemp.corhotkey = atipo[6]
        oTemp.corhklightbar = atipo[7]
        oTemp.StatusSup = "TESTE DE COR - Cabecalho"
        oTemp.StatusInf = "TESTE DE COR - Rodape"
        while True:
            KeyBoard(K_ESC)
            oTemp.Show(True)
            mensagem(
                'Cor {} atual => #{:03}. Setas cima e baixo para alterar.'.format(
                    aini[ntipo].upper(), x), x)
            nkey = readkey()

            if nkey == K_ESC or nkey == 0:
                return (restvideo(screen))

            elif nkey == K_ENTER:
                atipo[ntipo] = x
                self.corfundo = atipo[0]
                self.cormenu = atipo[1]
                self.corcabec = atipo[2]
                self.coralerta = atipo[3]
                self.cordesativada = atipo[4]
                self.corlightbar = atipo[5]
                self.corhotkey = atipo[6]
                self.corhklightbar = atipo[7]
                oIni.set('SCI', c, x)
                return (restvideo(screen))

            elif nkey == 224:
                skey = readkey()
                if skey == K_DOWN or skey == K_LEFT:
                    x -= 1
                    if x <= 0:
                        x = 256
                elif skey == K_UP or skey == K_RIGHT:
                    x += 1
                    if x >= 256:
                        x = 0

            atipo[ntipo] = x
            oTemp.corfundo = atipo[0]
            oTemp.cormenu = atipo[1]
            oTemp.corcabec = atipo[2]
            oTemp.coralerta = atipo[3]
            oTemp.cordesativada = atipo[4]
            oTemp.corlightbar = atipo[5]
            oTemp.corhotkey = atipo[6]
            oTemp.corhklightbar = atipo[7]

        restvideo(screen)

    def xMenu(self):
        AtPrompt = []
        aadd(AtPrompt, ["Inclusao", ["SubA1", "SubA2", "", "SubA3", "SubA4"]])
        aadd(AtPrompt,
             ["Alteracao", ["SubB1", "SubB2", "SubMenu 3", "SubMenu 4"]])
        aadd(AtPrompt,
             ["Impressao", ["SubC1", "SubC2", "SubMenu 3", "SubMenu 4"]])
        aadd(AtPrompt,
             ["Consulta", ["SubD1", "SubD2", "SubMenu 3", "SubMenu 4"]])
        aadd(AtPrompt, ["Help", ["SubE1", "SubE2", "SubMenu 3", "SubMenu 4"]])
        return (AtPrompt)

    def xDisp(self):
        aDisp = []
        aadd(aDisp, [LIG, LIG, LIG, DES, LIG, LIG, LIG])
        aadd(aDisp, [LIG, LIG, LIG, LIG, LIG, LIG, LIG])
        aadd(aDisp, [LIG, LIG, LIG, LIG, LIG, LIG, LIG])
        aadd(aDisp, [LIG, LIG, LIG, LIG, LIG, LIG, LIG])
        aadd(aDisp, [LIG, LIG, LIG, LIG, LIG, LIG, LIG])
        aadd(aDisp, [LIG, LIG, LIG, LIG, LIG, LIG, LIG])
        aadd(aDisp, [LIG, LIG, LIG, LIG, LIG, LIG, LIG])
        return (aDisp)

    def MSMenuCabecalho(self, nLinha, nPos):
        nTam = len(self.menu)
        nMax = self.maxcol
        aHotKey = array(nTam)
        aRow = array(nTam)
        aCol = array(nTam)
        nSoma = 0
        nSoma1 = 0
        nX = 0
        nLen = 0
        nConta = 0
        cHotKey = space(0)
        cMenu = space(0)
        cStr = space(0)
        cNew = space(0)

        aprint(nLinha, 00, space(1), self.cormenu, nMax)
        for nX in range(0, nTam):
            cMenu = self.menu[nX][0]
            cHotKey = left(cMenu, 1)
            nSoma1 = 0
            # StrHotKey ( @cMenu, @cHotKey, 1)
            if (nSoma1 == len(cHotKey)) > 1:
                cHotKey = right(cHotKey, 1)
                nSoma1 -= 1
            self.menu[nX][0] = cMenu
            aHotKey[nX] = cHotKey
            nLen = len(self.menu[nX][0])
            aRow[nX] = nLinha
            aCol[nX] = nSoma + nSoma1
            aprint(
                    nLinha,
                    nSoma,
                    iif(nPos == nX, upper(cMenu), cMenu),
                    iif(nPos == nX, self.corlightbar, self.cormenu)
                    )
            aprint(
                    aRow[nX],
                    aCol[nX],
                    aHotKey[nX],
                    iif(nPos == nX, self.corhklightbar, self.corhotkey)
                    )
            nSoma += nLen + 1
            nSoma1 += nLen + 1
        return

    def MsMenu(self, nLinha, lManterScreen):
        cScreen = savescreen()
        nMaxCol = maxcol()
        nSoma = 0
        nX = 0
        nDireita = 0
        nVal = 1
        nMaior = 1
        nRetorno = 0.0
        cmenu = ""
        cPrinc = ""
        nKey = 0
        nMax = 0
        nBaixo = 0
        nTam = 0
        nTamSt = 0
        nCorrente = 1
        aNew = []
        aSelecao = []
        oP = 0
        cJanela = None
        nScr1 = None
        nScr2 = None
        nScr3 = None
        nScr4 = None
        xScreen = None
        nLinha = iif(nLinha == None, 0, nLinha)
        while True:
            nSoma = 0
            nX = 0
            nDireita = 0
            nVal = 1
            nMaior = 1
            nRetorno = 0.0
            cmenu = ""
            cPrinc = ""
            nKey = 0
            nMax = 0
            oP = 0
            nBaixo = 0
            nTamSt = 0
            nCorrente = 1
            aNew = []
            aSelecao = []
            nTam = 0

            self.MSMenuCabecalho(nLinha, self.nPos)
            for nX in range(0, self.nPos):
                nSoma += len(self.menu[nX - 1][0]) + 1
            nX = 0

            for nX in range(0, len(self.menu[self.nPos][1])):

                if empty(self.menu[self.nPos][1][nX]):
                    aadd(aNew, "")
                    aadd(aSelecao, ENABLE)
                else:
                    aadd(aNew, '  ' + self.menu[self.nPos][1][nX] + '  ')
                    aadd(aSelecao, self.disp[self.nPos][nX])
                    nTamSt = len(self.menu[self.nPos][1][nX]) + 2
                if nTamSt > nVal:
                    nVal = nTamSt
                    nMaior = nX

            nDireita = len(self.menu[self.nPos][1][nMaior]) + 6
            nBaixo = len(self.menu[self.nPos][1])
            nTam = nDireita + nSoma
            nMax = iif(nTam > nMaxCol, nMaxCol, nTam)
            nSoma = iif(nTam > nMaxCol, (nSoma - (nTam - nMaxCol)), nSoma)
            nSoma = iif(nSoma < 0, 0, nSoma)
            nTam += 5
            nScr1 = 1 + nLinha
            nScr2 = 0
            nScr3 = maxrow() - 1
            nScr4 = maxcol()
            xScreen = savevideo()
            box(
                    nLinha + 1,
                    nSoma,
                    nLinha + nBaixo + 2,
                    nMax,
                    self.frame,
                    self.cormenu
                    )
            oP = self.MSProcessa(
                    nLinha + 2,
                    nSoma + 1,
                    nLinha + nBaixo + 1,
                    nMax - 1,
                    aNew,
                    aSelecao
                    )
            if not lManterScreen: restvideo(xScreen)
            nMax = len(self.menu) - 1  # indice em Python iniciam em 0
            nKey = self.lastkey
            nRetorno = '{0}.{1:02}'.format(self.nPos + 1, oP + 1)

            if nKey == K_ESC:
                return ('{0}.{1:02}'.format(0, 0))
            elif nKey == K_ENTER or nKey == K_SPACE:
                if aSelecao[oP] == True:
                    return (nRetorno)
                else:
                    alerta("ERRO: Item Desativado")
            elif nKey == K_RIGHT:
                self.nPos += 1
            elif nKey == K_LEFT:
                self.nPos -= 1
            elif nKey == K_HOME or nKey == K_PGUP:
                self.nPos = 1
            elif nKey == K_END or nKey == K_DOWN:
                self.nPos = nMax
            self.nPos = iif(self.nPos > nMax, self.index, self.nPos)
            self.nPos = iif(self.nPos < self.index, nMax, self.nPos)
        return

    def MSProcessa(self, nCima, nEsquerda, nBaixo, nDireita, aNew,
                   aSelecionado):
        nTam = len(aNew)
        nMax = nTam - 1  # Indice Python iniciam em 0
        aHotKey = array(nTam)
        aRow = array(nTam)
        aCol = array(nTam)
        nRow = nCima  # - 1
        nTamSt = (nDireita - nEsquerda) + 1
        nKey = 1
        nConta = 0
        cSep = chr(195) + replicate(chr(196), nTamSt) + chr(180)
        cMenu = space(0)
        cStr = space(0)
        cNew = space(0)

        self.nItem = self.ativo
        setcursor(0)
        for nX in range(0, nTam):
            cMenu = aNew[nX]
            cHotKey = substr(cMenu, 3, 1)
            # StrHotKey( @ cMenu, @cHotKey, 2)
            aNew[nX] = cMenu
            nLen = (nTamSt - len(cMenu))
            nSoma1 = len(cHotKey)
            if nSoma1 > 1:
                cHotKey = right(cHotKey, 1)
            nSoma1 -= 1
            aHotKey[nX] = cHotKey
            aRow[nX] = nRow + nX
            aCol[nX] = nEsquerda + nSoma1

            if empty(cMenu):
                aprint(nRow + nX, nEsquerda - 1, cSep,
                       self.cormenu)  # Separador
                continue
            if aSelecionado[nX]:  # Item disponivel
                aprint(nRow + nX, nEsquerda, cMenu + space(nLen), self.cormenu)
            else:
                nConta += 1
                aprint(nRow + nX, nEsquerda, cMenu + space(nLen),
                       self.cordesativada)

        if self.nItem > nMax:
            self.nItem = nMax

        while OK:
            cMenu = aNew[self.nItem]
            nLen = (nTamSt - len(cMenu))

            if nConta != nMax:
                if aSelecionado[self.nItem] and not empty(cMenu):
                    aprint(nRow + self.nItem, nEsquerda,
                           upper(cMenu) + space(nLen), self.corlightbar)
                if aSelecionado[self.nItem] and empty(cMenu):
                    aprint(nRow + self.nItem, nEsquerda - 1, cSep, self.cormenu)
                    if self.lastkey == K_UP:
                        self.nItem -= 1
                    else:
                        self.nItem += 1
                    self.nItem = iif(self.nItem > nMax, self.index, self.nItem)
                    self.nItem = iif(self.nItem < self.index, nMax, self.nItem)
                    continue
                if not self.alterando:
                    if not aSelecionado[self.nItem]:
                        aprint(nRow + self.nItem, nEsquerda,
                               cMenu + space(nLen), self.cordesativada)
                        if self.lastkey == K_UP:
                            self.nItem -= 1
                        else:
                            self.nItem += 1
                        self.nItem = iif(self.nItem > nMax, self.index,
                                         self.nItem)
                        self.nItem = iif(self.nItem < self.index, nMax,
                                         self.nItem)
                        continue

            for nX in range(0, nTam):
                if aSelecionado[nX] and not empty(aNew[nX]):
                    aprint(aRow[nX], aCol[nX] + 2, aHotKey[nX],
                           iif(self.nItem == nX, self.corhklightbar,
                               self.corhotkey))

            nKey = readkey()
            self.lastkey = nKey
            if self.alterando:
                aprint(nRow + self.nItem, nEsquerda,
                       aNew[self.nItem] + space(nLen),
                       iif(aSelecionado[self.nItem], self.cormenu,
                           self.cordesativada - 1))
            else:
                aprint(nRow + self.nItem, nEsquerda,
                       aNew[self.nItem] + space(nLen),
                       iif(aSelecionado[self.nItem], self.cormenu,
                           self.cordesativada))

            if nKey == K_ESC:
                return (0)

            elif nKey == K_ENTER:
                return (self.nItem)

            elif nKey == K_HOME or nKey == K_PGUP:
                if self.nItem == 0:
                    self.nItem = nMax
                else:
                    self.nItem = self.index

            elif nKey == K_END or nKey == K_PGDN:
                if self.nItem == nMax:
                    self.nItem = self.index
                else:
                    self.nItem = nMax

            elif nKey == 224:
                sKey = readkey()
                self.lastkey = sKey
                if sKey == K_LEFT:
                    return (K_LEFT)
                elif sKey == K_RIGHT:
                    return (K_RIGHT)
                elif sKey == K_UP:
                    self.nItem -= 1
                elif sKey == K_DOWN:
                    self.nItem += 1

            self.nItem = iif(self.nItem > nMax, self.index, self.nItem)
            self.nItem = iif(self.nItem < self.index, nMax, self.nItem)
            self.ativo = self.nItem

        return

    def Show(self, lManterScreen = None):
        MenuClone = Aclone(self.menu)
        nSpMais = 0
        nChoice = 0

        self.limpa()
        self.StatSup()
        self.StatInf()

        iif(lManterScreen == None, lManterScreen == FALSO, lManterScreen)

        # self.nPos = 2
        if nSpMais > 1:
            self.AumentaEspacoMenu(nSpMais)

        nChoice = self.MsMenu(self.linha, lManterScreen)
        self.menu = Aclone(MenuClone)
        # self.StatSup()
        # self.StatInf()
        return (nChoice)

    def StatSup(self, cCabecalho = None):
        nTam = self.maxcol + 1
        nPos = (nTam - len(self.StatusSup))
        cCabecalho = iif(cCabecalho == None, self.StatusSup, cCabecalho)

        aprint(00, 00, "", self.corcabec, nTam)
        aprint(00, 00, cCabecalho.center(nTam), self.corcabec)
        aprint(00, self.maxcol - 18, date(), self.corcabec)
        return

    def StatInf(self, cMensagem = None):
        nTam = self.maxcol
        nCol = self.maxrow - 1
        nPos = (nTam - len(
            self.CodiFirma + ':' + self.xUsuario + '/' + self.NomeFirma)) - 1

        aprint(nCol, 00, "", nTam)
        aprint(nCol, 00, iif(cMensagem == None, self.StatusInf, cMensagem),
               self.corcabec, nTam)
        if cMensagem == None:
            aprint(nCol, nPos,
                   self.CodiFirma + ':' + self.xUsuario + '/' + self.NomeFirma,
                   self.corcabec)
        return self

    def AumentaEspacoMenu(self, nSp):
        nTam = len(self.menu)
        cSpMais = space(iif(nSp == None, 1, nSp))

        for nX in range(self.index, nTam):
            self.menu[nX, 1] = self.menu[nX, 1]
            self.menu[nX, 1] = cSpMais + self.menu[nX, 1] + cSpMais
        return

    def StatReg(self, cMensagem, nCor = None):
        nCor = ifnil(nCor, self.corcabec)
        nTam = self.maxcol
        nCol = self.maxrow - 1
        nPos = (
        nTam - len(self.CodiFirma + ':' + self.xUsuario + '/' + self.NomeFirma))

        # self.StatInf("")
        aprint(nCol, 00, iif(cMensagem == None, self.statusinf, cMensagem),
               nCor)
        return

    def ContaReg(self, cMensagem = None, nCor = None):
        nCor = ifnil(nCor, self.corcabec)
        if cMensagem != nil:
            if valtype(cMensagem) != "N":
                self.StatReg(cMensagem, nCor)
            else:
                self.StatReg("REGISTRO #" + strzero(cMensagem, 6), nCor)
                self.nRegistrosImpressos = cMensagem
        else:
            self.nRegistrosImpressos += 1
            self.StatReg("REGISTRO #" + strzero(self.nRegistrosImpressos, 6),
                         nCor)

        return True
