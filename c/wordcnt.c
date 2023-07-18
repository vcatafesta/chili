#include <stdio.h>
#include <stdlib.h> // exit
#include <string.h>
#include <ctype.h>
#include <termios.h>
#include "color.h"

#define MAXWORDLEN      16
#define NUL             ((char)0)
#define SPACE           ((char)0x20)
#define MAX_BUFFER_SIZE 1024
#define NELEMS(a)       (sizeof(a) / sizeof((a)[0]))
#define len(s)          ((int)strlen(s))
#define BEEP()          (printf("\x7"))
#define errorbeep()     (printf("\x7"))
#define LIMPA()         (printf("\x1B[2J"))
#define POS(x,y)        (printf("\x1B[%d;%df", x, y))
#define REV()           (printf("\x1B[7m"))
#define CH219()         (printf("\xDB"));
#define nil             0
#define space(y,c)      (memset((char*)malloc(sizeof(char*)*y),(char)c,y))
//#define replicate(c,y)  (memset((char*)malloc(sizeof(char*)*y),(char)c,y))
#define replicate(c,y)  (memset((char*)calloc(1,sizeof(char*)*y),(char)c,y))
//#define qout(s)         (puts(s))
#define qout(s)        	(printf("%s\n",s))
#define qqout(s)        (printf("%s",s))
#define write(s)        (printf("%s",s))
#define read(s)         (gets(s))
#define byte 				unsigned char
#define word 				unsigned short
#define dword 				unsigned long

char *nextword(char *wordptr)
{
	while (*wordptr == SPACE)
		wordptr++;
	return(wordptr);
}

int wordlen(char *wordptr)
{
	char *wordlimit;
	wordlimit = wordptr;

	while ( *wordlimit & *wordlimit!=SPACE )
		wordlimit++;
	return( wordlimit-wordptr );
}

int main(int argc, char **argv) {
	FILE	*infile;
	char	linebfr[MAX_BUFFER_SIZE];
	char	*wordptr;
	int	i;
	static int wordlencnt[MAXWORDLEN];
	static int overlencnt;

	qout(replicate('#', 100));
	printf("%swordcnt.c%s, Copyright (c) 2023 Vilmar Catafesta <vcatafesta@gmail.com>%s\n\n", LIGHTYELLOW, RED, RESET);
	write("Enter the input file's name: ");
	//gets(linebfr);
  	fgets(linebfr, MAX_BUFFER_SIZE, stdin);
  	if (!strlen(linebfr)) {
   	perror("You must specify an input file name!\n");
    	exit(1);
	}

	infile = fopen(linebfr, "r" );
	if ( !infile ) {
   	perror("Erro ");
		exit(1);
	}

	/* Each loop processes one line. NOTE: if a line is longer than the
 	 *	input buffer the program may produce invalid results. The very large
 	 * buffer makes this unlikely. 
 	 */

	while (fgets(linebfr, sizeof(linebfr), infile )) {
		printf("%s\n",linebfr);
		/* Check for buffer overflow & remove the trailing newline. */
		i = len(linebfr);
		if ( linebfr[i-1] != '\n' )
			printf( "Overlength line beginning\n\t%70s\n", linebfr );
		else
			linebfr[i-1] = NUL;

		/* lineptr points to the 1st word in linebfr (past leading spaces). */
		wordptr = nextword(linebfr);

		/* Each loop processes one word. The loop ends when [nextword]
			returns NULL, indicating there are no more words. 
		 */

		while (*wordptr) {
		/* Find the length of this word, increment the proper element of the
       length count array, & point to the space following the word. */
			i = wordlen(wordptr);
			if ( i > MAXWORDLEN )
				overlencnt++;
			else
				;
			wordlencnt[i]++;
			wordptr += i;

		/* Find the next word (if any). */
		wordptr = nextword(wordptr);
		}
	}

	/* Print the word length counts. Each loop prints one. */
	printf(  "  Length Count\n" );
	for ( i=1; i<MAXWORDLEN; i++ )
		printf( "  %5d %5d\n", i, wordlencnt[i] );
	printf( "Greater %5d\n", overlencnt );

	/* Close the file & quit. */
	fclose(infile);
	return 0;
}
