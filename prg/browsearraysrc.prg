REQUEST HB_MEMIO
 
static function oSciMenuSci()
*****************************   
LOCAL AtPrompt := {}
LOCAL cStr_Get
LOCAL cStr_Sombra

cStr_Get    := "Desativar Get Tela Cheia"
cStr_Sombra := "DesLigar Sombra"

AADD( AtPrompt, {"E^ncerrar",    {"E^ncerrar Execucao do SCI","","T^rocar de Empresa","Trocar de U^suario","","C^opia de Seguranca","R^estaurar Copia de Seguranca"}})
AADD( AtPrompt, {"M^odulos",     {"Controle de E^stoque","Contas a R^eceber","Contas a P^agar","Contas C^orrentes","Controle de P^roducao","Controle de P^onto","Mala D^ireta","V^endedores"}})
AADD( AtPrompt, {"V^endas",      {"Terminal PDV","Terminal Consulta de Precos","Relatorio Vendas *","Relatorio Receber *","Relatorio Recebido *","Cadastra Senha Caixa","","Resumo Caixa Individual", "Detalhe Caixa Individual","Detalhe Diario Caixa Geral *","Detalhe Emissao Recibos em Carteira","Detalhe Emissao Recibos Banco", "Detalhe Emissao Recibos Outros","","Rol Debito C/C Cliente","Reajuste Debito C/C Cliente","Consulta Debito C/C","Baixar Debito C/C","","Comandos de Impressora Fiscal"}})
AADD( AtPrompt, {"B^ackup",      {"Copia de Seguranca","Restaurar Copia de Seguranca","Gerar Arquivo Batch de Copia Seguranca","", "Reindexar Normal", "Reindexar Verificando Duplicidade","Reindexar Parcialmente", "Eliminar Arquivos Temporarios"}})
AADD( AtPrompt, {"E^ditor",      {"Editar Arquivo","Imprimir Arquivo", "Teste Reindexar Thread","Gerar Arquivo PDF"}})
AADD( AtPrompt, {"A^mbiente",    {"Spooler de Impressao","Layout Janela","", "Cor Pano de Fundo","Cor de Menu","Cor Cabecalho","Cor Alerta","Cor Borda","Cor Item Desativado","Cor Box Mensagem", "Cor Light Bar", "Cor HotKey", "Cor LightBar HotKey","", "Pano de Fundo","Frame", cStr_Sombra, cStr_Get, "Alterar Senha"}})

AADD( AtPrompt, {"ArQ^uivos",    {"Manutencao Diretorios","Arquivos da Base de Dados","","Reindexar Normal","Reindexar Verificando Duplicidade","","Eliminar Arquivos Temporarios","Cadastra e Altera Usuario","Configuracao de Base Dados","Retorno Acesso","Separar Movimento Anual","Caixa Automatico","Zerar Movimento de Conta","Cadastrar Impressora","Alterar Impressora", "Renovar Codigo de Acesso"}})
AADD( AtPrompt, {"R^econstruir ", {"Base de Dados", "Arquivo Nota", "Arquivo Printer", "Arquivo EntNota","Arquivo Prevenda"}})
AADD( AtPrompt, {"S^hell",       {"Shell         ALT D","Comandos DOS  ALT X"}})
AADD( AtPrompt, {"H^elp",        {"Sobre o Sistema","Ultimas Alteracoes","Help"}})
Return( AtPrompt )   

function aMaxStrLenBi(aArray)
   LOCAL a
   LOCAL b
   LOCAL c
   LOCAL nLen    := 0
	LOCAL nMaxLen := 0

   for EACH a in aArray
      if Valtype(a) == 'A'         
         for EACH b in a
            if Valtype(b) == 'A'
               for EACH c in b
                  nLen := AValia(c)[3]
                  if nMaxLen < nLen
                     nMaxLen := nLen
                  endif
               next
            else
               nLen := AValia(b)[3]
               if nMaxLen < nLen
                  nMaxLen := nLen
               endif                     
            endif  
         next                                 
      else
         nLen := AValia(a)[3]            	
         if nMaxLen < nLen
            nMaxLen := nLen
         endif               
      endif   
   next      
   return nMaxLen
   
   
function BrowseArray(aArray)
      LOCAL nTam := 40
      LOCAL a
      LOCAL b
      LOCAL c       
      LOCAL cALias              
      LOCAL aField :=  {{ "ID",    "C", 10,   0 },;
                        { "VALOR", "C", nTam, 0 },;
                        { "TYPE",  "C", 1,    0 },;
                        { "WIDTH", "N", 3,    0 },;
                        { "DEC",   "N", 1,    0 }}
       
      if !(HB_IsNil(aArray)) .and. HB_IsArray(aArray) .and. Len(aArray) != 0         
         aField[2,3] := aMaxStrLenBi(aArray)
         dbCreate( "mem:test", aField,, .T., "memarea")
         select memarea    
         for EACH a in aArray
            if Valtype(a) == 'A'         
               for EACH b in a
                  if Valtype(b) == 'A'
                     for EACH c in b                        
                        aValor := Avalia(c)
                        memarea->(dbAppend())
                        memarea->Id    := alltrim(str(a:__ENumIndex)) + '.' + alltrim(str(a:__ENumIndex)) + '.' + alltrim(str(c:__ENumIndex))
                        memarea->Valor := aValor[1]
                        memarea->Type  := aValor[2]
                        memarea->Width := aValor[3]
                        memarea->Dec   := aValor[4]                        
                     next   
                  else
                     aValor := Avalia(b)
                     memarea->(dbAppend())
                     memarea->Id    := alltrim(str(a:__ENumIndex)) + '.' + alltrim(str(b:__ENumIndex))
                     memarea->Valor := aValor[1]
                     memarea->Type  := aValor[2]
                     memarea->Width := aValor[3]
                     memarea->Dec   := aValor[4]                                    
                  endif  
               next                  
               memarea->(dbAppend())
            else
               aValor := Avalia(a)               
               memarea->(dbAppend())
               memarea->Id    := alltrim(str(a:__ENumIndex))
               memarea->Valor := aValor[1]
               memarea->Type  := aValor[2]
               memarea->Width := aValor[3]
               memarea->Dec   := aValor[4]
            endif   
         next     
         MemArea->(DbGotop())         
         browse()
         MemArea->(dbCloseArea())
          
          /* Free memory */       
         dbDrop( "mem:test" )
      else
         Alert("Array invalido ou vazio")
      endif
      return nil
   
function Avalia(var)   
   nType  := ValType(var)            
   nDec   := 0
   cStr   := var
   nLen   := 0
   switch nType
   case "C"       
      nLen  := Len(cStr)      
      exit
   case "T"
   case "D"
      nLen := 8
      cStr := Dtoc(var)      
      exit               
   case "L"
      nLen := 1
      cStr := if(var == .t., ".T.", ".F.")
      exit                              
   case "N"   
      cStr := AllTrim(str(var))                              
      nLen := Len(cStr)
      nPos := Rat(".", cStr)
      nDec := Len(Right(cStr,(nLen-nPos)))                                    
      exit                                             
   case "U"
      nLen := 3
      cStr := "nil"
      exit               
   otherwise
   endswitch
   return {cStr, nType, nLen, nDec }
      
function BrowseArraySimplesV(aArray)
       LOCAL i
       LOCAL f
       LOCAL cALias       
       LOCAL aField := {{ "ID",    "+", 0,  0 },;
                        { "VALOR", "C", 40, 0 },;
                        { "TYPE",  "C", 1,  0 },;
                        { "WIDTH", "N", 3,  0 },;
                        { "DEC",   "N", 1,  0 }}
       
    
         dbCreate( "mem:test", aField,, .T., "memarea")
         select memarea
    
         for EACH f in aArray
            nType  := ValType(f)            
            nDec   := 0
            cStr   := f
            switch nType
            case "C"       
               nLen  := Len(f)
               aadd(aField,{"V" + alltrim(str(f:__ENumIndex)), nType, nLen, nDec })
               exit
            case "T" 
            case "D" 
               nLen := 8
               cStr := Dtoc(f)
               aadd(aField,{"V" + alltrim(str(f:__ENumIndex)), nType, nLen, nDec })
               exit               
            case "L"
               nLen := 1
               cStr := if(f == .t., ".T.", ".F.")
               aadd(aField,{"V" + alltrim(str(f:__ENumIndex)), nType, nLen, nDec })
               exit                              
            case "N"   
               cStr := AllTrim(str(f))                              
               nLen := Len(cStr)
               nPos := Rat(".", cStr)
               nDec := Len(Right(cStr,(nLen-nPos)))                              
               aadd(aField,{"V" + alltrim(str(f:__ENumIndex)), nType, nLen, nDec })
               exit                                             
            case "U"
               nLen := 3
               cStr := "nil"
               aadd(aField,{"V" + alltrim(str(f:__ENumIndex)), "C", nLen, nDec })
               exit               
            otherwise
            endswitch
            memarea->(dbAppend())
            memarea->Valor := cStr
            memarea->Type  := nType
            memarea->Width := nLen
            memarea->Dec   := nDec
         next
         MemArea->(DbGotop())         
         browse()
         MemArea->(dbCloseArea())
          
          /* Free memory */       
         dbDrop( "mem:test" )
         return             
         
function BrowseArrayDbf()
       LOCAL i
       LOCAL nField       
       LOCAL cALias
       LOCAL aField := {{ "ID",    "+", 9,  0 },;
                        { "NAME",  "C", 20, 0 },;
                        { "TYPE",  "C", 1,  0 },;
                        { "WIDTH", "N", 3,  0 },;
                        { "DEC",   "N", 1,  0 }}
       
       if Used()
         cAlias  := Alias()         
         aCampos := (cALias)->(DbStruct())
         dbCreate( "mem:test", aField,, .T., "memarea" )

         for EACH nField in aCampos
             memarea->(dbAppend())
             memarea->Name  := nField[1]
             memarea->Type  := nField[2]
             memarea->Width := nField[3]
             memarea->Dec   := nField[4]
         next      
       
         /*
         FOR i := 1 TO 1000
            dbAppend()
            //FIELD->ID := hb_Random() * 1000000
         NEXT
         INDEX ON FIELD->ID TAG f1
         dbEval( {|| QOut( FIELD->ID ) } )
         */
         select memarea
         MemArea->(DbGotop())       
         Browse()
         MemArea->(dbCloseArea())
          
          /* Free memory */       
         dbDrop( "mem:test" )
      else
         Alert("Nenhuma area selecionada")
      endif    
      return       
          
function BrowseArraySimplesH(aArray)
       LOCAL i
       LOCAL f
       LOCAL cALias
       LOCAL aField := {}
       
    
         for EACH f in aArray
            nType := ValType(f)
            switch nType
            case "C"
               nLen := Len(f)               
               aadd(aField,{"V" + alltrim(str(f:__ENumIndex)), nType, nLen, 0 })
               exit
            case "D"
               nLen := 8
               aadd(aField,{"V" + alltrim(str(f:__ENumIndex)), nType, nLen, 0 })
               exit               
            case "L"
               nLen := 1
               aadd(aField,{"V" + alltrim(str(f:__ENumIndex)), nType, nLen, 0 })
               exit                              
            case "N"   
               cStr := AllTrim(str(f))                              
               nLen := Len(cStr)
               nPos := Rat(".", cStr)
               nDec := Len(Right(cStr,(nLen-nPos)))               
               aadd(aField,{"V" + alltrim(str(f:__ENumIndex)), nType, nLen, nDec })
               exit                                             
            case "U"
               nLen := 3
               aadd(aField,{"V" + alltrim(str(f:__ENumIndex)), "C", nLen, 0 })
               exit                                             
               
            otherwise
            endswitch
         next
         
         dbCreate( "mem:test", aField,, .T., "memarea" )               
         select memarea
         
         memarea->(dbAppend())
         for EACH f in aArray             
            nType := ValType(f)            
            switch nType
            case "U"
               cCampo := alltrim(str(f:__ENumIndex))
               memarea->&("V" + cCampo ) := "nil"
               exit
           otherwise
               cCampo := alltrim(str(f:__ENumIndex))
               memarea->&("V" + cCampo ):= f   
               exit
            endswitch
         next      
         

         MemArea->(DbGotop())       
         Browse()
         MemArea->(dbCloseArea())
          
          /* Free memory */       
         dbDrop( "mem:test" )
       
         /*
         FOR i := 1 TO 1000
            dbAppend()
            //FIELD->ID := hb_Random() * 1000000
         NEXT
         INDEX ON FIELD->ID TAG f1
         dbEval( {|| QOut( FIELD->ID ) } )
         */
         
      
         return                
   
          
