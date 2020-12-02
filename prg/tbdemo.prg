/*
 * $Id: tbdemo.prg [vcatafesta] $
	14:53 segunda-feira, 16 de abril de 2018
 */
 
#include <box.ch>
#include <fileio.ch>
#include <directry.ch>
#include "browsearraysrc.prg"

#define def	   function
#define endef
#define true	.t.
#define false  .f.
#define null   nil
#define NULL   nil
REQUEST HB_MEMIO

*-----------------*
def Main(argc)
*-----------------*
	LOCAL xCoringa   := "*.dbf"
	LOCAL aFileList  := {}
	LOCAL aFiles[ Adir(xCoringa)]
	LOCAL aSelect[Adir(xCoringa)]
	LOCAL nChoice

	Set Dele ON
	if argc = nil 
		Afill(aselect, true)
		Adir(xCoringa , aFiles)
		Aeval(aFiles, { |element| Qout(element) })
		Aeval( Directory(xCoringa), {|aDirectory|;
									Aadd( aFileList,;
									dtoc(       aDirectory[F_DATE])        + "  " + ;
									substr(     aDirectory[F_TIME], 1 , 5) + "  " + ;
									if( substr( aDirectory[F_ATTR], 1 , 1) == "D", "   <DIR>", ;
									tran(       aDirectory[F_SIZE], "99,999,999 Bytes"))  + "  " + ;									
									padr(       aDirectory[F_NAME], 15 ))})
									//Upper(PADR( aDirectory[F_NAME], 15 )))})
		cls
		? "Macrosoft TDBdemo, Copyright (c), Vilmar Catafesta"
		? "[ESC] sair, [ENTER] selecionar"
		SetColor("W+/B")
		nRow1 := 05 + Len( aFileList)
		if nRow1 > 24
			nRow1 = 24
		endif			
		@ 5 , 10 , nRow1 + 1 , 70 BOX B_SINGLE_DOUBLE + space(1)
		nChoice := aChoice(06 , 11 , nRow1, 69 , aFileList)
		if nchoice = 0
			QuitTBDemo()
		endif	
		use (AllTrim(right(aFileList[nChoice],15))) new
	else
		Use (argc) New      
	endif
   cAlias := Alias()
   SetColor("W+/B")
   cls
	Browse()
   BrowseArrayDbf()
   BrowseArray((cAlias)->(DbStruct()))
	QuitTBDemo()
endef
	
def QuitTBDemo()
	setcolor("")
	SetPos(maxrow(), 0)
	? "Macrosoft TDBdemo terminate!"
	quit
endef
