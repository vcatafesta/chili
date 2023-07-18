#include "hbclass.ch"

function main()
	LOCAL xTela := c():New()

   //SetMode(20, 80)
	Scroll()
	SetPos( 0, 0 )

   @ xTela:Getrow, Col() SAY "1st teste" // row foi definido em 10 default na criação da classe

   xTela:setRow(11) // ou xTela:setgetRow(10)
   @ xTela:Getrow, Col() SAY "2nd teste"

   xTela:setRow(12) // ou xTela:setgetRow(12)
   @ xTela:getRow, Col() SAY "3th teste"

   inkey(0)
	// linha abaixo somente para mostrar o erro ao acessar variável privada/hidden
	@ xTela:Row,      Col() SAY "outro" // Error BASE/41  Scope violation (hidden): C:ROW
   return nil

CLASS c
	HIDDEN:
		VAR row INIT 10
	EXPORTED:
		METHOD setgetRow(xValue) SETGET
		METHOD setRow(xValue) SETGET
		METHOD getRow() SETGET
END CLASS

METHOD setgetRow(xValue) Class c
   IF xValue != NIL
   	::row := xValue
   ENDIF
	return ::row

METHOD setRow(xValue) Class c
   IF xValue != NIL
   	::row := xValue
   ENDIF

METHOD getRow(xValue) Class c
	return ::row
