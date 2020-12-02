 #include "browsearraysrc.prg"

 function Main(...)
   
   aArray :={{ "VILMAR CATAFESTA, O GATINHO",;
               DATE(),;
               .t.,;
               nil,;
               123456789.12,;
               1234789.12,;
               12789.12;
            },;            
            { "EVILI FRANCIELE DA SILVA SOARES",;
               DATE(),;
               .t.,;
               nil,;
               123456789.12,;
               1234789.12,;
               12789.12;
   }} 

   BrowseArray(aArray)
   BrowseArray(oSciMenuSci())
   BrowseArray({"1", 1 , .T., 10.43,NIL})

   Use empresa new
   BrowseArrayDbf()
