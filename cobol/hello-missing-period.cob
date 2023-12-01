GCOBOL*>-<*
      *> Author: Brian Tiffin
      *> Dedicated to the public domain
      *>
      *> Date started: January 2017
      *> Modified: 2017-01-27/06:04-0500
      *>
      *> Tectonics:
      *>   cobc -x hello-missing-period.cob
      *>+<*
      *>
      *> hello-missing-period.cob, GnuCOBOL FAQ tutorial error
      *> This program will NOT compile, missing a full stop after
      *>  IDENTIFICATION DIVISION
      *>
       identification division
       program-id. hello-missing.

       procedure division.
       display "Hello, world"
       goback.

       end program hello-missing.
