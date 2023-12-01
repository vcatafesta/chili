GCOBOL*>-<*                                                             
      *> Author: Brian Tiffin
      *> Dedicated to the public domain
      *>
      *> Date started: January 2017
      *> Modified: 2017-02-02/17:22-0500 btiffin
      *>
      *> Tectonics:
      *>   cobc -x hello.cob
      *>   ./hello
      *>+<*
      *>
      *> hello.cob, GnuCOBOL FAQ tutorial
      *>
       identification division.
       program-id. hello.

       procedure division.
       display "Hello, world"
       goback.

       end program hello.
