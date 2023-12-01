       identification division.
       program-id. HELLO.
       author. Vilmar Catafesta.
      *===========================
      *this is a comment in cobol
      *Columns  8-11 A Margin
      *Columns 12-72 B Margin
      *===========================
       environment division.
       data division.
       working-storage section.
      *===========================
       procedure division.
            display 'hello.cob, Copyright (c) 2023 Vilmar Catafesta'
                ' <vcatafesta@gmail.com>'
            display 'Hello World!'.
            stop run.
