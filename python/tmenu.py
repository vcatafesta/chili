from __future__ import print_function
#from colorconsole import terminal
import terminal
from tambiente import *
from funcoes import *


class TMenu(TAmbiente):
    name = 'TMenu'

    def create(self):
        aprint(1, 0, chr(32) * maxcol(), self.cormenu, maxcol())
        x = 0
        for a in self.menuprincipal:
            aprint(1, x, a, self.cormenu, 10)
            x += len(a) + 1

            # nchoice = self.MsMenu(1, True)
            # self.MSMenuCabecalho(1, 0)
