from __future__ import print_function
from funcoes import *
from memoedit_ch import *
from setcurs_ch import *


def MemoRead(filename):
    f = open(filename, 'r')
    return (f, f.read())


def MemoEdit(cString, nTop, nLeft, nBottom, nRight, lEditMode, xUserFunction, nLineLength, nTabSize, nTextBuffRow, nTextBuffColumn, nWindowRow, nWindowColumn):
    oEd = None
    nOldCursor = None

    if not IsNumber(nTop): nTop = 0
    if not IsNumber(nLeft): nLeft = 0
    if not IsNumber(nBottom): nBottom = maxrow()
    if not IsNumber(nRight): nRight = maxcol()
    if not IsLogical(lEditMode): lEditMode = True
    if not IsNumber(nLineLength): nLineLength = nRight - nLeft + 1
    if not IsNumber(nTabSize): nTabSize = 4
    if not IsNumber(nTextBuffRow): nTextBuffRow = 1
    if not IsNumber(nTextBuffColumn): nTextBuffColumn = 0
    if not IsNumber(nWindowRow): nWindowRow = 0
    if not IsNumber(nWindowColumn): nWindowColumn = nTextBuffColumn
    if not IsCharacter(cString): cString = ''

    oEd = HBMemoEditor().New(StrTran(cString, chr(K_TAB), space(1)), nTop, nLeft, nBottom, nRight, lEditMode, nLineLength, nTabSize, nTextBuffRow, nTextBuffColumn, nWindowRow, nWindowColumn)
    oEd.MemoInit(xUserFunction)
    oEd.display()

    if not IsLogical(xUserFunction) or xUserFunction == True:
        nOldCursor = SetCursor(iif(Set(_SET_INSERT), SC_INSERT, SC_NORMAL))
        oEd.Edit()
        if oEd.Changed() and oEd.Saved():
            cString = oEd.GetText()
        SetCursor(nOldCursor)
    return


filename = 'readme.txt'
modo = 'r'
try:
    (f, cString) = MemoRead(filename)
    MemoEdit(cString)

    nlines = 10
    buffer = 100  # maxcol() * maxrow()

    # box(0, 0, 25, 102, m_frame(), 31, filename)
    # for x in range(nlines):
    aprint(0 + 1, 1, cString, 31)

except Exception as erro:
    print(erro)

finally:
    f.close()


class HbEditor:
    pass

    def __init__(self):
        self.cFile = ""

        self.aText = []
        self.naTextLen = 0

        self.nTop = 0
        self.nLeft = 0
        self.nBottom = 0
        self.nRight = 0

        self.nFirstCol = 1
        self.nFirstRow = 1
        self.nRow = 1
        self.nCol = 1

        self.nPhysRow = 0
        self.nPhysCol = 0

        self.nNumCols = 1
        self.nNumRows = 1

        self.nTabWidth = 8
        self.lEditAllow = True
        self.lSaved = False
        self.lWordWrap = False
        self.nWordWrapCol = 0
        self.lDirty = False
        self.lExitEdit = False
        self.cColorSpec = ''

    def new(self, cString, nTop, nLeft, nBottom, nRight, lEditMode, nLineLength, nTabSize, nTextRow, nTextCol, nWndRow, nWndCol):
        pass

    def GetParagraph(self, nRow):
        pass

    def BrowseText(self, nPassedKey):
        pass

    def LoadFile(self, cFileName):
        cString = ''

        if os.path.isfile(cFileName):
            self.cFile = cFileName
            cString = MemoRead(cFileName)
        else:
            cstring = ''

        self.aTextText = Text2Array(cString, iif(self.lWordWrap, self.nNumCols, NIL))
        self.naTextLen = len(self.aText)

        if self.naTextLen == 0:
            aadd(self.aText, HBTextLine().New())
            self.naTextLen += 1

        self.lDirty = False
        self.MoveCursor(K_CTRL_PGUP)
        return self

    def LoadText(self, cString):
        self.aTextText = Text2Array(cString, iif(self.lWordWrap, self.nNumCols, NIL))
        self.naTextLen = len(self.aText)
        if self.naTextLen == 0:
            aadd(self.aText, HBTextLine().New())
            self.naTextLen += 1

        self.lDirty = False
        self.MoveCursor(K_CTRL_PGUP)
        return self

    def SaveFile(self):
        if not empty(self.cFile):
            self.lDirty = not hb_MemoWrit(self.cFile, self.GetText())
            return not self.lDirty
        return False

    def AddLine(self, cLine, lSoftCR):
        aadd(self.aText, HBTextLine().New(), lSoftCR)
        self.naTextLen += 1
        return self

    def InsertLine(self, cLine, lSoftCR, nRow):
        self.AddLine()
        Ains(self.aText, nRow)
        self.aText[nRow] = HBTextLine():New(cLine, lSoftCR)
        return self

    def RemoveLine(self, nRow):
        pass

    def GetLine(self, nRow):
        pass

    def LineLen(self, nRow):
        pass

    def SplitLine(self, nRow):
        pass

    def GotoLine(self, nRow):
        pass

    def GetText(self):
        pass

    def display(self):
        pass

    def RefreshLine(self):
        pass

    def RefreshColumn(self):
        pass

    def LineColo(self, nRow):
        pass

    def MoveCursor(self, nKey):
        pass

    def InsertState(self, lInsState):
        pass

    def Edit(self, nPassedKey):
        pass

    def ExitState(self):
        pass

    def KeyboardHook(self, nKey):
        pass

    def IdleHook(self):
        pass

    def Resize(self, nTop = None, nLeft = None, nBottom = None, nRight = None):

        if nTop == None:
            nTop = self.nTop
        if nLeft == None:
            nLeft = self.nLeft
        if nBottom == None:
            nBottom = self.nBottom
        if nRight == None:
            nRight = self.nRight

        self.nTop = nTop
        self.nLeft = nLeft
        self.nBottom = nBottom
        self.nRight = nRight

        self.nNumCols = self.nRight - self.nLeft + 1
        self.nNumRows = self.nBottom - self.nTop + 1

        if (self.nRow - self.nFirstRow) > self.nNumRows:
            self.nFirstRow = self.nRow

        self.nFirstCol = 1
        self.nCol = 1

        self.SetPos(self.nTop + self.nRow - self.nFirstRow, self.nLeft)
        self.display()

    def SetColor(self, cColorString):
        pass

    def Hilite(self):
        pass

    def DeHilite(self):
        pass

    def SetPos(self, nRow, nCol):
        pass

    def Row(self):
        return self.nPhysRow

    def Col(self):
        return self.nPhysCol

    def RowPos(self):
        pass

    def ColPos(self):
        pass

    def Saved(self):
        pass

    def Changed(self):
        pass

    def IsWordWrap(self):
        pass

    def WordWrapCol(self):
        pass

    def hitTest(self):
        pass

    def RefreshWindow(self):
        self.display()


class HBMemoEditor(HbEditor):
    lCallKeyboardHook = False
    xUserFunction = None

    def MemoInit(self, xUserFunction):
        nKey = None
        self.xUserFunction = xUserFunction

        if IsCharacter(self.xUserFunction):
            while nKey in self.xDo(ME_INIT) != ME_DEFAULT:
                self.HandleUserKey(nKey, nKey)
        return

    def Edit(self):
        nKey = None
        aConfigurableKeys = [K_CTRL_Y, K_CTRL_T, K_CTRL_B, K_CTRL_V, K_ALT_W, K_ESC]
        bKeyBlock = None

        if self.lEditAllow and IsCharacter(self.xUserFunction):
            while not self.lExitEdit:
                if NextKey() == 0:
                    self.IdleHook()

                nKey = ord(getch())

                if nKey in aConfigurableKeys:
                    self.HandleUserKey(nKey, self.xDo(iif(self.lDirty, ME_UNKEYX, ME_UNKEY)))
                else:
                    super(self.Edit())
        else:
            super(self.Edit(nKey))
        return

    def KeyboardHook(self, nKey):
        nYesNoKey = None
        cBackScr = None
        nRow = None
        nCol = None

        if IsCharacter(self.xUserFunction):
            if not self.lCallKeyboardHook:
                self.lCallKeyboardHook = True
                self.HandleUserKey(nKey, self.xDo(iif(self.lDirty, ME_UNKEYX, ME_UNKEY)))
                self.lCallKeyboardHook = False
        else:
            if nKey == K_ESC:
                if self.lDirty and Set(_SET_SCOREBOARD):
                    cBackScr = savevideo()
                    nrow = Row()
                    nCol = Col()

                    aprint(0, maxcol() - 18, "Abort Edit? (Y/N", 31)
                    SetPos(nRow, nCol)

                    if nYesNoKey == Asc('Y') or nYesNoKey == Asc('y'):
                        hb_SetLastKey(K_ESC)
                        self.lSaved = False
                        self.lExitEdit = True
                else:
                    self.lSaved = False
                    self.lExitEdit = True
        return

    def IdleHook(self):
        if IsCharacter(self.xUserFunction):
            self.xDo(ME_IDLE)
        return

    def HandleUserKey(self, nKey, nUserKey):

        if nUserKey == ME_DEFAULT:
            if nKey == K_ESC:
                self.lSaved = False
                self.lExitEdit = True
            elif nKey <= 256 or nKey == K_ALT_W:
                super(self.Edit(nKey))

            elif (nUserKey >= 1 and nUserKey <= 31) or nUserKey == K_ALT_W:
                super(self.Edit(nUserKey))
            elif nUserKey == ME_DATA:
                if nKey <= 256:
                    super(self.Edit(nKey))
            elif nUserKey == ME_TOGGLEWRAP:
                self.lWordWrap = not self.lWordWrap

            elif nUserKey == ME_TOGGLESCROLL:
                pass

            elif nUserKey == ME_WORDRIGHT:
                self.MoveCursor(K_CTRL_RIGHT)

            elif nUserKey == ME_BOTTOMRIGHT:
                self.MoveCursor(K_CTRL_END)

            else:
                pass

        return

    def xDo(self, nStatus):
        pass

    def MoveCursor(self, nKey):
        pass
