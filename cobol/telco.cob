COBOL
bench
mark
      *> 
      *> By William Klein, used with permission
      *>
       Identification Division.
        Program-ID. TELCO.
       Environment Division.
       Input-Output Section.
        File-Control.
           Select InFile  Assign to
                "/tmp/expon180.1e6".
      *>        "C:\TELCO.TEST".
           Select OutFile  Assign to
                "/tmp/TELCO.TXT"
                        Line
                        Sequential.
       Data Division.
        File Section.
       FD  InFile.
       01  InRec                Pic S9(15)      Packed-Decimal.
       01  InRec2.
           05                   Pic  X(7).
           05                   Pic S9(1)       Packed-Decimal.
             88  Premimum-Rate                  Value 1 3 5 7 9.
       FD  OutFile.
       01  OutRec               Pic X(70).
       Working-Storage Section.
       01  Misc.
           05                   Pic  X          Value "N".
             88  EOF                            Value "Y".
           05  Do-Calc          Pic  X          Value "Y".
             88  No-Calc                        Value "N".
           05.
               10  Start-Time   Pic X(21).
               10  End-Time     Pic X(21).
       01  Misc-Num.
           05  Price-Dec5       Pic S9(05)V9(06).
           05  Redefines Price-Dec5.
               10               Pic X(3).
               10               Pic S9(05).
                 88  Even-Round
                                Value 05000 25000 45000 65000 85000.
           05  Running-Totals.
               10  Price-Tot   Pic S9(07)V99    Binary.
               10  BTax-Tot    Pic S9(07)v99    Binary.
               10  DTax-Tot    Pic S9(07)V99    Binary  Value Zero.
               10  Output-Tot  Pic S9(07)V99    Binary.
           05  Temp-Num.
               10  Temp-Price   Pic S9(05)V99   Binary.
               10  Temp-Btax    Pic S9(05)V99   Binary.
               10  Temp-DTax    Pic S9(05)V99   Binary.
       01  WS-Output.
           05  Header-1         Pic X(70)       Value
               "  Time  Rate |        Price         Btax         Dtax |
      -        "      Output".
           05  Header-2         Pic X(70)       Value
               "-------------+----------------------------------------+-
      -        "------------".
           05  Detail-Line.
               10               Pic X(01)       Value Space.
               10  Time-Out     Pic zzzz9.
               10               Pic X(04)       Value Space.
               10  Rate-Out     Pic X.
               10               Pic X(04)       Value "  | ".
               10  Price-Out    Pic z,zzz,zz9.99.
               10               Pic X(01)       Value Spaces.
               10  Btax-Out     Pic z,zzz,zZ9.99.
               10               Pic X(01)       Value Spaces.
               10  Dtax-Out     Pic Z,zzz,zz9.99        Blank When Zero.
               10               Pic X(03)       Value " | ".
               10  Output-Out   Pic z,zzz,zZ9.99.
       Procedure Division.
        Mainline.
           Perform Init
           Perform Until EOF
               Read  InFile
                   At End
                       Set EOF  to True
                   Not At End
                       If No-Calc
                           Continue
                       Else
                           Perform  Calc-Para
                       End-If
                       Write OutRec from Detail-Line
               End-Read
           End-Perform
           Perform WindUp
           Stop Run
                .
       Calc-Para.
           Move InRec   to Time-Out
           If Premimum-Rate
               Move "D"         To Rate-Out
               Compute Temp-Price Rounded Price-Out Rounded Price-Dec5
                        = InRec * +0.00894
               Compute Temp-DTax DTax-Out
                        = Temp-Price * 0.0341
               Add Temp-Dtax to DTax-Tot
           Else
               Move "L"         To Rate-Out
               Compute Temp-Price Rounded Price-Out Rounded Price-Dec5
                        = InRec * +0.00130
               Move Zero to DTax-Out Temp-DTax
           End-If
           If Even-Round
               Subtract .01 from Temp-Price
               Move Temp-Price to Price-Out
           End-If
           Compute Temp-Btax BTax-Out
                        = Temp-Price * 0.0675
           Compute Output-Out
                        = Temp-Price + Temp-Btax + Temp-Dtax
           Add Temp-BTax        To Btax-Tot
           Add Temp-Price       to Price-Tot
           Compute Output-Tot
                        = Output-Tot + Function NumVal (Output-Out (1:))
               .
       Init.
           Open Input  InFile
                Output OutFile
           Write OutRec from Header-1
           Write OutRec from Header-2
           Display "Enter 'N' to skip calculations:" Upon Console
           Accept Do-Calc From Console
           Move Function Current-Date   To Start-Time
                .
       WindUp.
           Move Function Current-Date to End-Time
           Write OutRec         from Header-2
           Move Price-Tot       to Price-Out
           Move Btax-Tot        to Btax-Out
           Move Dtax-Tot        to Dtax-Out
           Move Output-Tot      to Output-Out
           Move "   Totals:"    to Detail-Line (1:12)
           Write OutRec         from Detail-Line
           Move Spaces          to OutRec
           String       "  Start-Time:"         Delimited by Size
                        Start-Time (9:2)        Delimited by Size
                        ":"                     Delimited by size
                        Start-Time (11:2)       Delimited by size
                        ":"                     Delimited by size
                        Start-Time (13:2)       Delimited by size
                        "."                     Delimited by size
                        Start-Time (15:2)       Delimited by size
                into OutRec
           Write OutRec
           Move Spaces          to OutRec
           String       "    End-Time:"         Delimited by Size
                        End-Time (9:2)          Delimited by Size
                        ":"                     Delimited by size
                        End-Time (11:2)         Delimited by size
                        ":"                     Delimited by size
                        End-Time (13:2)         Delimited by size
                        "."                     Delimited by size
                        End-Time (15:2)         Delimited by size
                into OutRec
           Write OutRec
           Close InFile
                 OutFile
                .

