#ifndef __SCIAPI_H__
#define __SCIAPI_H__

//#include <iostream>
//#include <windows.h>
//#include <conio.h>
#include <stdio.h>
#include <ctype.h>
#include "hbapi.h"
#include "hbapifs.h"
#include "hbapigt.h"
#include "hbapiitm.h"
#include "hbapierr.h"
#include "hbapicdp.h"
#include "hbdefs.h"
#include "hbapigt.h"
#include "hbgtcore.h"
#include "hbapiitm.h"
#include "hbset.h"
#include "hbstack.h"
#include "hbvm.h"
#include "signal.h"

/*-----------------------------------------------------------------------------------------------*/	
 
#ifdef __cplusplus
using namespace std;
#endif /* __cplusplus */

/*-----------------------------------------------------------------------------------------------*/	

#if defined(__BORLANDC__)	
	#pragma warn -nak	
#endif	

#if defined( __GNUC__ )
//#pragma GCC diagnostic ignored "-Wwrite-strings"
#pragma GCC diagnostic ignored "-Wunused-variable"
#pragma GCC diagnostic ignored "-Wformat"
//#pragma GCC diagnostic ignored "-Wuninitialized"
//#pragma GCC diagnostic ignored "-Wunused-function"
//#pragma GCC diagnostic ignored "-Wduplicated-cond"
#pragma GCC diagnostic ignored "-Wformat-extra-args"
#endif
/*-----------------------------------------------------------------------------------------------*/	
typedef unsigned short WORD;
typedef unsigned char BYTE;
typedef unsigned long DWORD;

typedef struct _tcor {
	WORD	fBlue;
	WORD 	fGreen;
	WORD	fRed;
	WORD	fIntensity;
	
	WORD 	bBlue;
	WORD 	bGreen;
	WORD 	bRed;
	WORD 	bIntesity;
} TCOR, *TCOR_PTR;

/*-----------------------------------------------------------------------------------------------*/	

// C++9
//enum Range   { Max = 2147483648L, Min = 255L };
enum Days    {Domingo=1, Segunda, Terca, Quarta, Quinta, Sexta, Sabado};
enum _color_ {c1 = 0x0003 };

/*-----------------------------------------------------------------------------------------------*/	

// C++11
//enum Range   : LONG  { Max = 2147483648L, Min = 255L };
//enum Days    : BYTE  {Domingo=1, Segunda, Terca, Quarta, Quinta, Sexta, Sabado};
//enum _color_ : DWORD {c1 = 0x0003 };
/*-----------------------------------------------------------------------------------------------*/	

char *space(int x, char ch);
#define fi
#define true            1
#define false           0
#define OK	            1
#define NOK	            0
#define CONSOLE_FULLSCREEN_MODE 1
#define p 					printf
#define ccout 				{ puts(space(80,'='));}
#define MALLOC(ptr, size) { \
										ptr = malloc(size); \
										if (ptr == NULL) { \
											fprintf(stderr, "Erro na alocacao de memoria. \n"); \
											exit(1); \
										} \
									} \

/*-----------------------------------------------------------------------------------------------*/	

typedef char						HB_CHAR;
typedef const char   			HB_TCHAR;
typedef unsigned const char   HB_UCCHAR;

typedef HB_CHAR					MS_CHAR;
typedef HB_TCHAR	   			MS_TCHAR;
typedef HB_UCCHAR				   MS_UCCHAR;
typedef HB_SIZE               MS_SIZE;
typedef int                   MS_INT;
typedef unsigned long int     MS_ULINT;
typedef HB_SHORT              MS_SHORT;
typedef size_t              	MS_SIZE_T;
typedef char 						*TString;

/*-----------------------------------------------------------------------------------------------*/	

static void _color( int iNewColor);
//static bool hb_ctGetWinCord( int * piTop, int * piLeft, int * piBottom, int * piRight);
static HB_BOOL hb_ctGetWinCord( int * piTop, int * piLeft, int * piBottom, int * piRight);
extern void   _xcolor_fundo(WORD BackColor);

/*-----------------------------------------------------------------------------------------------*/	

DWORD 		dwWindowSize;
DWORD 		dwConSize;
DWORD 		dwMaxRow;
DWORD 		dwMaxCol;
DWORD 		cCharsWritten;
TCOR			TColor;
WORD		 	Color = 0x0003 | 0x0004;
/*-----------------------------------------------------------------------------------------------*/	

#endif  //__SCIAPI_H__
