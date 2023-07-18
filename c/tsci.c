#include "funcky.h"
#include "pascal.h"
#include "tsci.h"
#include "conio.h"
#include "stdlib.h"
#include "stdio.h"
#define  NUM  10
#define  CHR  ":"

static int _corcabec = 75;
static int _cormenu  = 31;
static int _corfundo = 15;

void *savescreen();
void restela(void *buffer);
void ambiente(void);
void errorbeep();
void inimenu(void);
void cls(void);
int inkey(int time);
int menu(char *mat[]);
void setacor(void);
void *msopen(char *filename);
void mensagem(char *string, char *titulo, int cor);
char *inttostr(int val);
void criacfg(void);
int achoice(int ntop, int nleft, int nbottom, int nright, char *mat[]);

// Variaveis Estaticas
static char *pull[NUM]  = {"Encerrar","Sistemas","Vendas","Backup",
                           "Editor","Config","Arquivos","Reconstruir",
                           "Shell","Help"};

void main(void) {
   int npos = 0;

   criacfg();
   ambiente();
   menu(pull);
}

void ambiente(void) {
	_stdoutline("þ Aguarde, Carregando Executavel.");
	_stdoutline("þ Aguarde, Verificando Executavel.");
	cls();
 //  _FLscript1(1);
	_blinkbit(FALSE);
	_setdatef("DD/MM/YYYY");
	limpa();
	_border(3);
	statussup();
	statusinf();
}

void mabox(int top, int left, int bottom, int right) {
	_box( top, left, bottom, right, frame, _cormenu );
}

void statussup(void) {
	int  pos;
	int  mem;
	char vazio[2] = " ";
	char data[32];

	pos  = ( 80 - strlen( xsistema )) / 2 ;
	_areplicate( 00, 00, vazio, 80, _corcabec );
	_print( 00, 00, _datef(data), _corcabec );
	_print( 00, pos, xsistema, _corcabec );
	_clock12(00,72, _corcabec);
	return;
}

void linha(pos, cor)
int pos;
int cor;
{
	char vazio[2]	 = " ";
	_areplicate( pos, 00, vazio, 80, cor );
}

void statusinf(void) {
	int  pos;
	char vazio[2]	 = " ";

	pos = 80 - strlen( xnomefir );
	_areplicate( 24, 00, vazio, 80, _corcabec );
	_print( 24, 00, "F1ðHELP³F10ðCALC³", _corcabec );
	_print( 24, pos, xnomefir, _corcabec );
}

void wr( int nrow, int ncol, char *str, int _cor ) {
	if( _cor == 82 || _cor == 0 )
		_cor = 31;
	_print( nrow, ncol, str, _cor );
}

void limpa(void) {
	_cls( _corfundo, "±²°");
}

char *time(void) {
	char *buffer[32];
	return( _time( buffer ));
}

lecod() {
	int tecla;
	tecla = _getch();
	return( tecla );
}

void moldura( char x1, char x2, char y1, char y2, char c1, char c2, char c3, char c4, char c5, char c6) {
	int i;
	pos_c(x1,x2);
	_putch(c1);
	for(i=x2;i<y2;i++)
		_putch(c5);
	_putch(c2);
	for(i=x1+1;i<y1;i++){
		puts("\n");
		pos_c(i,x2);
		_putch(c6);
		pos_c(i,y2+1);
		_putch(c6);
	}
	pos_c(y1,x2);
	_putch(c3);
	for(i=x2;i<y2;i++)
		_putch(c5);
	_putch(c4);
}

int lastkey(void) {
	int tecla;
	tecla = _getch();
	return( tecla );
}

void fim(void) {
	cls();
	errorbeep();
	mabox( 04, 10, 8, 70);
	mswrite( 05, 11, xsistema, _cormenu);
	exit(0);
}

void mswrite(int row, int col, char *msg, int cor) {
	_print( row, col, msg, cor );
}

void acao(int pos) {
	int x = 24;
	int y = 18;
	switch(pos){
		case 0: exit(0); break;
      case 1: setacor(); break;
		case 2: wr( x, y, "Abrir",31); break;
		case 3: wr( x, y, "Abrir",31); break;
		case 4: wr( x, y, "Abrir",31); break;
		case 5: wr( x, y, "Abrir",31); break;
	}
	return;
}

void inclusao(void) {
	mabox(10, 1, 14, 78);
}

void restela(void *buffer) {
   _restvideo(0,0,24,79, buffer);
   _free( buffer );
}

void *savescreen() {
   void *buffer;
   int size;

	size   = (((24-0)+1) * ((79-0)+1)*2);
	buffer = _malloc(size);
	_savevideo(0,0,24,79, buffer);
	return buffer;
}

void errorbeep()
{
	_tone(100,5);
}

void cls(void)
{
	_cls(0,"");
}

void inimenu(void)
{
	char vazio[2] = " ";
	_areplicate(1, 0, vazio, 80, _cormenu );
}

int inkey(int time)
{
	return(_inkey(time));
}

void setacor(void)
{
   int ncor = _cormenu;
   int nkey;
   void *cscreen;

   cscreen = savescreen();
   while(Ok){
      mensagem("Enter para aceitar. Setas para escolher. Esc para cancelar.", "CONFIGURACAO DE COR DE MENU", ncor);
      nkey = _inkey(0);
      switch(nkey){
         case 24 : ncor--; break;
         case 5  : ncor++; break;
         case 13 : _cormenu = ncor; restela(cscreen); return;
         case 27 : restela(cscreen); return;
      }
   }
}

void *msopen(char *filename)
{
   return( fopen(filename, "w"));
}

void mensagem(char *string, char *titulo, int cor)
{
   int nLenStr = strlen(string);
   int nLenTit = strlen(titulo);
   int top     = 12;
   int largjan;
   int left;
   int right;

   largjan = nLenStr;
   if( nLenTit > nLenStr )
      largjan = nLenTit;
   left    = (_lastcol()-largjan)/2;
   right   = left + largjan;
   _settitle( titulo, 1, cor );
   _box(top-2,   left-1, top+2, right+2, frame, cor);
   _print(top,   left+1, string, cor);
}

char *inttostr(int val)
{
   char *temp;

   temp = "";
   return(_itoa(val, temp, 10));
}

void criacfg(void)
{
    if( !_isfile("TSCI.CFG", A_NORMAL));
       _fcreate("TSCI.CFG", 0);
}


int achoice(int ntop, int nleft, int nbottom, int nright, char *mat[])
{
   int nKey;
	int nx;
	int nLen;
	int nPos;
   int tam = NUM;
   int poscur  = 0;
   int nmaxlen = 0;

   for(nx=0;nx<tam;nx++){
      if((nLen = strlen(*(mat+nx))) > nmaxlen)
         nmaxlen = nLen;
   }
   mabox(ntop, nleft, nbottom, nright );
   while(Ok)
   {
      nPos = ntop+1;
      for(nx=0;nx<tam;nx++)
      {
         if(nx==poscur)
            _printn(nPos, nleft+2, *(mat+nx), _roloc(_cormenu), nmaxlen);
         else
            _printn(nPos, nleft+2, *(mat+nx), _cormenu, nmaxlen);
         nPos ++;
      }
      nKey = _inkey(0);
      switch(nKey){
         case seta_up   : --poscur; break;
         case seta_down : ++poscur; break;
         case seta_dir  : return(0);
         case seta_esq  : return(0);
         case 13        : return(poscur+1);
         case 27        : return(0);
      }
      if(poscur<0)
         poscur = NUM-1;
      else if(poscur>NUM-1)
         poscur = 0;
   }
}

int menu(char *mat[])
{
   int nKey;
	int nx;
	int nLen;
	int nPos;
   int tam    = NUM;
   int poscur = 0;
   int nlinha = 0;
   int nop;
   void *cScreen;

	while(Ok){
      inimenu();
      nPos = 0;
      for(nx=0;nx<tam;nx++){
         nLen = strlen(*(mat+nx));
         if(nx==poscur){
            nlinha=nPos;
            _printn(1, nPos, *(mat+nx), _roloc(_cormenu), nLen);
         }
         else
            _printn(1, nPos, *(mat+nx), _cormenu, nLen);
         nPos ++;
         nPos += nLen;
      }
      cScreen = savescreen();
      nop = achoice( 2, nlinha, 2+tam+1, nlinha+14, pull);
      restela(cScreen);
      nKey = _lastkey();
      switch(nop){
         case 0        : break;
         case 13       : return(nop);
         case 27       : return(0);
         case seta_dir : poscur++;break;
         case seta_esq : poscur--;break;
      }
      if(poscur<0)
         poscur = NUM-1;
      else if(poscur>NUM-1)
         poscur = 0;
   }
}
