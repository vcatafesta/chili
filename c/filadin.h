#ifndef __FILADIN_H__
#define __FILADIN__H__

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

/*-----------------------------------------------------------------------------------------------*/	
#ifdef __cplusplus
	using namespace std;
#endif
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
#define fi 
#define true            1
#define false           0
#define OK	            1
#define NOK	            0
#define CONSOLE_FULLSCREEN_MODE 1
#define p 					printf
#define MALLOC(ptr, size) { \
										ptr = malloc(size); \
										if (ptr == NULL) { \
											fprintf(stderr, "Erro na alocacao de memoria. \n"); \
											exit(1); \
										} \
									} \

/*-----------------------------------------------------------------------------------------------*/	
typedef char						MS_CHAR;
typedef char 						*TString;
typedef const char   			MS_TCHAR;
typedef unsigned const char   MS_UCCHAR;
typedef int                   MS_INT;
typedef size_t              	MS_SIZE_T;
typedef unsigned long int     MS_ULINT;
typedef short             		MS_SHORT;
/*-----------------------------------------------------------------------------------------------*/	

struct aluno{
	int matricula;
	char nome[30];
	float n1;
	float n2;
	float n3;
};
typedef struct fila FILA;

struct fila {
	struct elemento *inicio;
	struct elemento *final;
};

struct elemento{
	struct aluno dados;
	struct elemento *prox;
};
typedef struct elemento ELEM;

#endif
