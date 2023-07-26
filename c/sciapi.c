#include "sciapi.h"

// synonymn for MS_* 
	HB_FUNC_TRANSLATE(TRIM,    	RTRIM)
	HB_FUNC_TRANSLATE(MS_TRIM,    RTRIM)
	HB_FUNC_TRANSLATE(MS_LTRIM,   LTRIM)
	HB_FUNC_TRANSLATE(MS_STRZERO, STRZERO)
	HB_FUNC_TRANSLATE(MS_LEN,     LEN)
	HB_FUNC_TRANSLATE(MS_CAPITALIZE, CAPITALIZE)

//==================================================================================================

void *malloc_s(size_t size) {
    void *p = malloc(size);
    if(p == NULL) {
        fprintf(stderr, "Memoria insuficiente. \n");
        exit(1);
    }
    memset(p, 0, size);
    return p;
}

//=================================================================

TString spacechar(size_t stTamBlock, char chInit) {
    TString pBuf = (char *)malloc(stTamBlock + 1);
    
    if(pBuf != 0)
        memset(pBuf, chInit, stTamBlock);
        
    pBuf[stTamBlock] = '\0';
    return pBuf;
}

//=================================================================

TString space(int x, char ch) {
    TString buff = (char *)malloc(x * sizeof(char *));
    
    if(buff != 0)
        memset(buff, ch, x);
        
    buff[x] = 0;
    return buff;
}

//=================================================================

void *spaceset(size_t size, char ch) {
    return(memset((char *)malloc_s(size * sizeof(char *)), ch, size));
}


//=================================================================

void strdisplay(char *str) {
    int i = 0;
    while(str[i]) {
        p("str[%i]   ", i);
        p("\tende[%i]", &str[i]);
        p("\tptr[%p] ", &str[i]);
        p("\tch=%3d  ", str[i]);
        p("\t %c \n  ", str[i++]);
    }
    puts("");
}

//=================================================================

void display(char *str) {
    int x;
    int max = strlen(str);
    
    ccout;
    printf("VETOR \t\tASCII \tDEC \tOCT \tHEX \tENDERECO \tPOINTER\n");
    ccout;
    for(x=0; x < max; x++)
        printf("str[%03d] \t%c \t%d \t%o \t%x \t%i \t%p \n", x, str[x], str[x], str[x],str[x], &str[x], &str[x], str[x]);
    ccout;
    printf("VETOR \t\tASCII \tDEC \tOCT \tHEX \tENDERECO \tPOINTER\n");
    ccout;
}

//=================================================================

TString memcpy2(char *dest, char *orig, int n) {
    int i;
    
    for(i=0 ; i < n ; i++)
        dest[i] = orig[i];
        
    return dest;
}

//=================================================================

void copiaString(MS_CHAR *dest, MS_CHAR *src) {
	if(dest)
		if(src)
			while((*dest++ = *src++))
				;
}

//=================================================================

TString strleft(TString str, size_t pos) {
    TString ch = space(pos,32);
    memcpy2(ch, str, pos);
    
    if(ch)
        return (ch);
    return (NULL);
}

//=================================================================

TString strleft2(TString str, size_t pos) {
    TString dest 	= space(pos, 32);
    size_t 	i 		= 0;
	 
    for(; i < pos ; i++)
        dest[i] = str[i];
    if(dest)
        return(dest);
    return (NULL);
}

//=================================================================

int min(size_t value1, size_t value2) {
    if(value1 < value2)
        return value1;
    return value2;
}

//=================================================================

int max(size_t value1, size_t value2) {
    if(value1 > value2)
        return value1;
    return value2;
}

//=================================================================

TString strrigth(TString str, size_t pos) {
    TString dest = space(pos,32);
    int n = strlen(str);
    int i = n - min(strlen(str), pos);
    int y = 0;
    
    for(; i < n ; i++)
        dest[y++] = str[i];
        
    if(dest)
        return (dest);
    fprintf(stderr, "Erro: strrigth()");
    return (NULL);
}

//=================================================================

TString strsubstr(TString str, size_t ini, size_t fim) {
    int     max  = strlen(str);
    TString dest = space(max,32);
    int     tam  = ini + fim -1;
    int     i    = ini-1;
    int     y    = 0;
    
    for(; i < tam ; i++)
        dest[y++] = str[i];
    if(dest)
        return (dest);
    fprintf(stderr, "Erro: strsubstr()");
    return (NULL);
}

/*-----------------------------------------------------------------------------------------------*/	

static MS_CHAR *replicate(MS_CHAR *str, MS_SIZE vezes)
{
	MS_SIZE lenstr = (MS_SIZE) strlen(str);
	MS_SIZE tam    = lenstr * vezes;
	MS_CHAR *ptr   = (MS_CHAR*)malloc(tam * sizeof(MS_CHAR)); // (MS_CHAR*)malloc(tam+1);
	MS_SIZE x;
	MS_SIZE y;
		
	if (str){
		if (ptr){
			for (x = 0; x < tam;){
				for (y = 0; y < lenstr; y++, x++) {
					ptr[x] = str[y];
				}
			}
		}
	}
	ptr[vezes] = '\0';
	if(ptr)
		return ptr;
	return NULL;		
}

/*-----------------------------------------------------------------------------------------------*/	

HB_FUNC(MS_REPLICATE)
{
	int iParams = hb_pcount();
	
	if( iParams == 2 && HB_ISCHAR(1) && HB_ISNUM(2)){
		MS_CHAR *szText = replicate((MS_CHAR*)hb_parc(1), hb_parni(2));
		hb_retc_buffer(szText);
		return;
	}
	else{	
		hb_errRT_BASE_SubstR( EG_ARG, 1111, NULL, HB_ERR_FUNCNAME, HB_ERR_ARGS_BASEPARAMS );
		return;
	}	
}

/*-----------------------------------------------------------------------------------------------*/	

HB_FUNC(MS_FOR)
{
	if( hb_pcount() >= 1){	
		MS_SIZE ch     = hb_parni(1);
		MS_SIZE vezes  = hb_parni(2);
		MS_SIZE n;		
		MS_CHAR *buf;
		
		if(HB_ISNUM(1) && HB_ISNUM(2)){
			buf = space(vezes, 32);
			for(n = 0; n <= vezes; ++n ){			  
				//printf("%c", ch);				
				buf[n] = ch;
			}
			buf[vezes] = '\0';
			hb_retc(buf);
			return;
		}
		if(HB_ISNUM(1)){
			buf = space(ch, 32);
			for(n = 0; n <= ch; ++n ){
				//printf("\n%i", n);
				//buf[n] = n;
			}	
			//buf[ch] = '\0';
			hb_retc(buf);
			return;		
		}
	}
	hb_errRT_BASE_SubstR( EG_ARG, 1111, NULL, HB_ERR_FUNCNAME, HB_ERR_ARGS_BASEPARAMS );
	return;
}

/*-----------------------------------------------------------------------------------------------*/	

static size_t strlen(char s[])
{
	int i = 0;
	while(s[i] != '\0' ){ 
		i++; 
	}
	return i;
}

/*-----------------------------------------------------------------------------------------------*/	

static MS_SIZE len(MS_CHAR *str)
{
	return((MS_INT)strlen(str)); 
}	

/*-----------------------------------------------------------------------------------------------*/	
	
static MS_SIZE ms_maxrow(void)
{	
	hConsole = GetStdHandle(STD_OUTPUT_HANDLE);    	                    	
	GetConsoleScreenBufferInfo(hConsole, &csbi);		 
	dwMaxRow = csbi.dwMaximumWindowSize.Y;		
	return(dwMaxRow);
}

/*-----------------------------------------------------------------------------------------------*/	
	
static MS_SIZE ms_maxcol(void){	
	hConsole = GetStdHandle(STD_OUTPUT_HANDLE);    	 	
	GetConsoleScreenBufferInfo(hConsole, &csbi);		 
	dwMaxCol = csbi.dwMaximumWindowSize.X;		
	return(dwMaxCol);
}

/*-----------------------------------------------------------------------------------------------*/	

MS_CHAR *chr(MS_SIZE n){
	MS_CHAR *ch = (char *)malloc(sizeof(char*));
	ch[1]       = '\0';
	memset(ch, n, 1);	   
   return(ch);
}
 

/*-----------------------------------------------------------------------------------------------*/	
 
HB_FUNC( MS_CLS )
{
	HB_TCHAR	*szText;
	HB_SIZE  nTextLen;
	HB_SIZE  nLen;
	MS_INT  	iRow;
	MS_INT  	iCol;
	MS_INT  	iMaxRow;
	MS_INT  	iMaxCol;	
	
	if(hb_parclen(2) == 0){
		szText   = chr(32);
		nTextLen = (HB_SIZE)strlen(szText);
		nLen     = (HB_SIZE)szText;
	}
	else{		
		szText   = hb_parc(2);
		nTextLen = hb_parclen(2);
		nLen     = hb_parclen(2);
	}
		
   long lDelay = hb_parnldef( 3, 0 );
   hb_gtSetPos(0 , 0);
	hb_gtGetPos(&iRow, &iCol);
	
   if(HB_ISNUM(3))
      iRow = 0; // hb_parni( 3 );
   
	if(HB_ISNUM(4))
      iCol = 0; // hb_parni( 4 );
   
	iMaxRow = hb_gtMaxRow();
   iMaxCol = hb_gtMaxCol();
   
	if( iRow >= 0 && iCol >= 0 && iRow <= iMaxRow && iCol <= iMaxCol){
		MS_SIZE      iTop    = 0;
		MS_SIZE      iLeft   = 0;
		MS_SIZE      iBottom = iMaxRow;
		MS_SIZE      iRight  = iMaxCol;		
	   MS_SIZE      size    = (HB_SIZE)(((iBottom-iTop)+1) * ((iRight-iLeft)+1));
		MS_CHAR      *buffer = (MS_CHAR*)calloc(size, sizeof(buffer));
		PHB_CODEPAGE cdp     = hb_gtHostCP();			
      HB_SIZE      nIndex  = 0;
      MS_SIZE      iColor  = hb_parni(1); 
		HB_WCHAR     wc;
		
		if( iColor == 0)
			iColor = hb_gtGetCurrColor();

      if( nLen > ( HB_SIZE ) ( iMaxRow - iRow + 1 ) )
         nLen = (iMaxRow - iRow + 1);

      hb_gtBeginWrite();
		
		for(MS_SIZE n=0; n<size;){
			for (HB_SIZE y=0; y<nTextLen; y++, n++){
				buffer[n] = szText[y];
				if( n == size)
					break;
			}
			buffer[size]='\0';   			
		}

		nLen = size;
		
      while( nLen-- ){
			if( HB_CDPCHAR_GET( cdp, buffer, size, &nIndex, &wc ))
				hb_gtPutChar( iRow, iCol++, iColor, 0, wc );
         else
            break;

			if( iCol > iMaxCol){
				iCol = 0;
				iRow++;
			}
				
         if( lDelay ){
            hb_gtEndWrite();
            hb_idleSleep( ( double ) lDelay / 1000 );
            hb_gtBeginWrite();
			}
		}			
      hb_gtEndWrite();			
		free(buffer);
	}
	hb_retc_null();
}	

/*-----------------------------------------------------------------------------------------------*/	

HB_FUNC( MS_CHAR){	
	CONSOLE_SCREEN_BUFFER_INFO csbi;    
	HANDLE   hConsole       = GetStdHandle(STD_OUTPUT_HANDLE);		
	COORD    coordScreen    = {0, 0};
	WORD     BackColor      = (WORD)hb_parni(1);		 
	LPVOID   lpReservedvoid = NULL; 
	DWORD    nNumberOfCharsToWrite;
	DWORD    cCharsWritten;
	DWORD    dwWindowSize;
	MS_TCHAR *string; 
	MS_CHAR  *buffer;
	MS_INT   size;
	MS_INT   x;
	MS_ULINT lpNumberOfCharsWritten;
	
	GetConsoleScreenBufferInfo(hConsole, &csbi);
	dwWindowSize	= csbi.dwMaximumWindowSize.X * csbi.dwMaximumWindowSize.Y;
	string       	= hb_parc(2);
	x      		 	= hb_parclen(2);
	size   		 	= dwWindowSize; // (int)(((iBottom-iTop)) * ((iRight-iLeft)));
	buffer  			= (MS_CHAR*)malloc(size);
	
	for (int n=0; n<=size;){
		for (int y=0; y<x; y++, n++){
			buffer[n] = string[y];
		}
	}
	buffer[size]          = '\0';
	nNumberOfCharsToWrite = size;		
	coordScreen.X 			 = 0;  // iTop
	coordScreen.Y 			 = 0;  // iBottom
	
	WriteConsole(hConsole, buffer, nNumberOfCharsToWrite, &lpNumberOfCharsWritten, lpReservedvoid);
	if(!FillConsoleOutputAttribute(hConsole, BackColor, dwWindowSize, coordScreen, &cCharsWritten))
		return;
	fi
	
	if(!GetConsoleScreenBufferInfo(hConsole, &csbi))
		return;				
				 
	free(buffer);	
	hb_retc_null();
}

/*-----------------------------------------------------------------------------------------------*/	

HB_FUNC( MS_TEMP_CHAR){	
	HANDLE hConsole;                   
	CONSOLE_SCREEN_BUFFER_INFO csbi;    
	hConsole = GetStdHandle(STD_OUTPUT_HANDLE);    	 
	GetConsoleScreenBufferInfo(hConsole, &csbi);
	//CHAR_INFO chiBuffer;     
	COORD coordScreen = {0, 0};
	DWORD nNumberOfCharsToWrite;
	DWORD dwWindowSize;
	DWORD cCharsWritten;
	unsigned long int lpNumberOfCharsWritten;
	LPVOID  lpReservedvoid = NULL; 
	const char *string; 
	char *buffer;
	int size;
	int n;
	int x;
	int y;
	 
	WORD BackColor = (WORD)hb_parni(1);
	 
	dwWindowSize = csbi.dwMaximumWindowSize.X * csbi.dwMaximumWindowSize.Y;
	 
	string = hb_parc(2);
	x      = hb_parclen(2);
	size   = dwWindowSize; // (int)(((iBottom-iTop)) * ((iRight-iLeft)));
	buffer = (char*)malloc(size);
	for (n=0; n<=size;){
		for (y=0; y<x; y++, n++){
			buffer[n] = string[y];
			if( n == size)
				break;
		}
	}
	
	buffer[size]  				= '\0';
	nNumberOfCharsToWrite	= size;		
	coordScreen.X 				= 0;  // iTop
	coordScreen.Y 				= 0;  // iBottom
	WriteConsole(hConsole, buffer, nNumberOfCharsToWrite, &lpNumberOfCharsWritten, lpReservedvoid);  

	if(!FillConsoleOutputAttribute(hConsole, BackColor, dwWindowSize, coordScreen, &cCharsWritten))
		return;			
	if(!GetConsoleScreenBufferInfo(hConsole, &csbi))
		return;		
				 
	cout << endl<< size << endl << lpNumberOfCharsWritten;
	free(buffer);
	hb_retc_null();
}

/*-----------------------------------------------------------------------------------------------*/	

HB_FUNC( MS_WRITECHAR){	
	CONSOLE_SCREEN_BUFFER_INFO csbi;    
	HANDLE 	hConsole    = GetStdHandle(STD_OUTPUT_HANDLE);	
	COORD 	coordScreen = {0, 0};
	DWORD 	dwWindowSize;
	MS_TCHAR *string; 
	MS_CHAR	*buffer;
	MS_INT 	size;
	MS_INT 	n;
	MS_INT	x;
	MS_INT 	y;
	
	GetConsoleScreenBufferInfo(hConsole, &csbi);	
	coordScreen.X 	= 0;  // iTop
	coordScreen.Y 	= 0;  // iBottom
	csbi.dwSize.X 	= 1;  // iLeft  - vezes a replicar o caractere
	csbi.dwSize.Y 	= 1;  // iRight - vezes a multiplicar o caractere acima	
	dwWindowSize 	= csbi.dwMaximumWindowSize.X * csbi.dwMaximumWindowSize.Y;	
	string 			= hb_parc(2);
	x      			= hb_parclen(2);
	size   			= dwWindowSize; // (int)(((iBottom-iTop)) * ((iRight-iLeft)));
	buffer 			= (MS_CHAR*)malloc(size);
	
   for (n=0; n<=size;){
		for (y=0; y<x; y++, n++){
			buffer[n] = string[y];			 
			 if( coordScreen.X < csbi.dwMaximumWindowSize.X){
					coordScreen.X++;  // iTop
			 }else{
				coordScreen.X = 0;  // iTop
			   coordScreen.Y++;  // iBottom			
			}
		 }
	}
 
	//chiBuffer.Char.AsciiChar = 176;	 
	//WriteConsoleOutput(hConsole, chiBuffer, coordBuffer, coordScreen, pWriteRegion);
	buffer[size]='\0';
	hb_retc_null();
}

/*-----------------------------------------------------------------------------------------------*/	

HB_FUNC( MS_SAY ){
	HANDLE hConsole;                   
	CONSOLE_SCREEN_BUFFER_INFO csbi;    
	//DWORD dwConSize;
	DWORD dwWindowSize;
	hConsole    = GetStdHandle(STD_OUTPUT_HANDLE);    	 
	GetConsoleScreenBufferInfo(hConsole, &csbi);
	
	HB_TCHAR *string; 
	char       *buffer;
	int        size;
	int        n;
	int        x;
	int        y;
	//int iTop    = 0;
	//int iLeft   = 0;
	//int iBottom  = csbi.dwSize.Y;
	//int iRight   = csbi.dwSize.X;
	
	//dwConSize    = csbi.dwSize.X * csbi.dwSize.Y;
	dwWindowSize = csbi.dwMaximumWindowSize.X * csbi.dwMaximumWindowSize.Y;
	
	//if(!FillConsoleOutputCharacter(hConsole, '²', dwConSize, coordScreen, &cCharsWritten))
	//   return;
	
	string = hb_parc(2);
	x      = hb_parclen(2);
	size   = dwWindowSize; // (int)(((iBottom-iTop)) * ((iRight-iLeft)));
	buffer = (char*)malloc(size);
	
   for (n=0; n<size;)
		 for (y=0; y<x; y++, n++)
		  {
			buffer[n] = string[y];
			if( n == size)
				break;
			 
		  }
	buffer[size] = '\0';
	cout << buffer << flush;
	_xcolor_fundo((WORD)hb_parni(1));
	free(buffer);
	hb_retc_null();
}

/*-----------------------------------------------------------------------------------------------*/	

HB_FUNC(MS_CLEAR){
	MS_CHAR	*string 	= (char*) hb_parc(2);	
	MS_INT	x 			= strlen(string);
	MS_INT	iTop    	= 0;
	MS_INT 	iLeft   	= 0;
	MS_INT 	iBottom 	= hb_gtMaxRow();
	MS_INT	iRight  	= hb_gtMaxCol();	
	MS_INT	size 		= (MS_INT)(((iBottom-iTop)) * ((iRight-iLeft)));
	MS_CHAR	*buffer 	= (MS_CHAR*)malloc(size);	
	MS_INT	n;	
	MS_INT 	y;
		
	for (n=0; n<size;){
		for (y=0; y<x; y++, n++){
			buffer[n] = string[y];
			if( n == size)
				break;
		}
	}
	buffer[size] = '\0';
	_color(75);
	printf(buffer);
	free(buffer);
	hb_retc_null();
}

/*-----------------------------------------------------------------------------------------------*/	

static bool hb_ctGetWinCord(MS_INT *piTop, MS_INT *piLeft, MS_INT *piBottom, MS_INT *piRight )
{
	MS_INT	iMaxRow	= hb_gtMaxRow();
	MS_INT 	iMaxCol 	= hb_gtMaxCol();

	//hb_gtGetPosEx(piTop, piLeft);
	hb_gtGetPos(piTop, piLeft);
	if(HB_ISNUM(1))
		*piTop = hb_parni(1);
		
	if(HB_ISNUM(2))
		*piLeft   = hb_parni(2);
		
	if( HB_ISNUM(3)){
		*piBottom = hb_parni(3) ;
		if(*piBottom > iMaxRow)
			*piBottom = iMaxRow;
	}
	else
		*piBottom = iMaxRow;
	
	if( HB_ISNUM(4))
	{
		*piRight = hb_parni(4);
		if( *piRight > iMaxCol )
			*piRight = iMaxCol;
	}
	else
		*piRight = iMaxCol;

	return *piTop  >= 0 && 
	       *piLeft >= 0 && 
	       *piTop  <= *piBottom && 
			 *piLeft <= *piRight;
}

/*-----------------------------------------------------------------------------------------------*/	

static void _color(MS_INT iNewColor){	
	MS_INT iTop		= 0;
	MS_INT iLeft   = 0;
	MS_INT iBottom	= hb_gtMaxRow();
	MS_INT iRight  = hb_gtMaxCol();
		
	if( hb_ctGetWinCord( &iTop, &iLeft, &iBottom, &iRight)){
		hb_gtBeginWrite();
		while(iTop <= iBottom){
			int iCol = iLeft;
			while( iCol <= iRight ){
				int iColor;
				HB_BYTE   bAttr;
				HB_USHORT usChar;
				hb_gtGetChar( iTop, iCol, &iColor, &bAttr, &usChar );
				hb_gtPutChar( iTop, iCol, iNewColor, bAttr, usChar );
				++iCol;
			}
			++iTop;
		}
		hb_gtEndWrite();
	}
	hb_retc_null();
}


/*-----------------------------------------------------------------------------------------------*/	

void _xcolor_fundo(WORD BackColor){
	CONSOLE_SCREEN_BUFFER_INFO csbi;    
	HANDLE hConsole 	= GetStdHandle(STD_OUTPUT_HANDLE);    	 
	COORD coordScreen	= {0, 0};
	DWORD dwConSize;	
	DWORD cCharsWritten;
   
	GetConsoleScreenBufferInfo(hConsole, &csbi);
	//BackColor = 0x0001 | 0x0004;
		 
	// Get the number of character cells in the current buffer
	if(!GetConsoleScreenBufferInfo(hConsole, &csbi))
		return;

	dwConSize              = csbi.dwSize.X * csbi.dwSize.Y;
		 
	//chifill.Attributes     = BACKGROUND_RED | FOREGROUND_INTENSITY;
	//chifill.Char.AsciiChar = (char)177;
		 
	// Fill the entire screen with blanks
	//if(!FillConsoleOutputCharacter(hConsole, '²', dwConSize, coordScreen, &cCharsWritten))
	//	  return;

	// Set the buffer's attributes accordingly.
	if(!FillConsoleOutputAttribute(hConsole, BackColor, dwConSize, coordScreen, &cCharsWritten))
		return;

	// SetConsoleTextAttribute(hConsole, BackColor);

	if(!GetConsoleScreenBufferInfo(hConsole, &csbi))
		return;

	// Put the cursor at its home coordinates.
	SetConsoleCursorPosition(hConsole, coordScreen);
	return;
}
	
/*-----------------------------------------------------------------------------------------------*/	
	
HB_FUNC( CLEARSCREEN ){
	CONSOLE_SCREEN_BUFFER_INFO csbi;    
   HANDLE 	hConsole 	= GetStdHandle(STD_OUTPUT_HANDLE);		
   COORD  	coordHome	= {0 , 0 };
	MS_CHAR 	caractere 	= 32;
	DWORD 	dummy;
	COORD 	coordCursor;
   
	coordCursor.X 	= 0;
   coordCursor.Y 	= 0;	
	GetConsoleScreenBufferInfo(hConsole, &csbi);	
	FillConsoleOutputCharacter( hConsole, caractere, csbi.dwSize.X * csbi.dwSize.Y, coordHome, &dummy);

	if (! SetConsoleCursorPosition(hConsole, coordCursor)) 
    {
        MessageBox(NULL, TEXT("SetConsoleCursorPosition"), TEXT("Console Error"), MB_OK); 
        return;
    }
}						

/*-----------------------------------------------------------------------------------------------*/	
				  
HB_FUNC( MS_CLEARSCREEN){
	system("cls");
	hb_retc_null();
}

/*-----------------------------------------------------------------------------------------------*/	

HB_FUNC( MS_MAXROW){	
	CONSOLE_SCREEN_BUFFER_INFO csbi;    
	HANDLE 		hConsole = GetStdHandle(STD_OUTPUT_HANDLE);	
	DWORD 		dwMaxRow;
	
	GetConsoleScreenBufferInfo(hConsole, &csbi);			 
	dwMaxRow = csbi.dwMaximumWindowSize.Y;	
	hb_retni( dwMaxRow );
}

/*-----------------------------------------------------------------------------------------------*/	
	
HB_FUNC( MS_MAXCOL){	
	CONSOLE_SCREEN_BUFFER_INFO csbi;    
	HANDLE 	hConsole = GetStdHandle(STD_OUTPUT_HANDLE);
	DWORD 	dwMaxCol;		

	GetConsoleScreenBufferInfo(hConsole, &csbi);
	dwMaxCol = csbi.dwMaximumWindowSize.X;		
	hb_retni( dwMaxCol );
}

/*-----------------------------------------------------------------------------------------------*/	

HB_FUNC( MS_MAXBUFFERROW ){	
	HANDLE	hConsole = GetStdHandle(STD_OUTPUT_HANDLE);    	 		
	COORD 	size 		= GetLargestConsoleWindowSize(hConsole);
	DWORD 	dwMaxRow;
		
	dwMaxRow = size.Y;
	hb_retni( dwMaxRow );
}

/*-----------------------------------------------------------------------------------------------*/	

HB_FUNC( MS_MAXBUFFERCOL ){	
	HANDLE 	hConsole = GetStdHandle(STD_OUTPUT_HANDLE);    	 	
	COORD 	size 		= GetLargestConsoleWindowSize(hConsole);
	DWORD dwMaxCol;
	
	dwMaxCol = size.X;
	hb_retni( dwMaxCol );
}

/*-----------------------------------------------------------------------------------------------*/	

HB_FUNC( MS_SETBUFFER ){
	CONSOLE_SCREEN_BUFFER_INFO csbi;    		
//	MS_SHORT x 			= hb_parni(1);
//	MS_SHORT y 			= hb_parni(2);
	HANDLE 	hConsole = GetStdHandle(STD_OUTPUT_HANDLE);    	 
	COORD 	coordScreen;
	
	GetConsoleScreenBufferInfo(hConsole, &csbi);			 		
	coordScreen	= csbi.dwMaximumWindowSize;				
	hb_retl(SetConsoleScreenBufferSize(hConsole, coordScreen));
}

/*-----------------------------------------------------------------------------------------------*/	

HB_FUNC( MS_SETCONSOLETITLE){		
	MS_TCHAR	*cTitulo = hb_parc(1);
	hb_retl(SetConsoleTitle(cTitulo));
}

/*-----------------------------------------------------------------------------------------------*/	

HB_FUNC(ISFILE){
	hb_retl(hb_fsFile(hb_parc(1)));
}

/*-----------------------------------------------------------------------------------------------*/	

HB_FUNC(NUMBERCURDRV){
	hb_retni(hb_fsCurDrv()); 
}

/*-----------------------------------------------------------------------------------------------*/	
	
HB_FUNC(FCHDIR){
	hb_retl(hb_fsChDir( hb_parc(1)));
}

/*-----------------------------------------------------------------------------------------------*/	
	
HB_FUNC(MKDIR){
	hb_retl(hb_fsMkDir( hb_parc(1)));
}

/*-----------------------------------------------------------------------------------------------*/	

HB_FUNC(MSG){
	MessageBox( GetActiveWindow(), hb_parc(1), hb_parc(2), 0 );
}

/*-----------------------------------------------------------------------------------------------*/	

HB_FUNC(MS_MSG){
	MessageBox( GetActiveWindow(), hb_parc(1), hb_parc(2), 0 );
}

/*-----------------------------------------------------------------------------------------------*/	

HB_FUNC(TELA){
   MS_TCHAR	*string  = hb_parc(2);;
   MS_INT	iTop     = 0;
   MS_INT	iLeft    = 0;   
   MS_INT 	iBottom  = ms_maxrow();
   MS_INT	iRight   = ms_maxcol();	
	MS_INT 	x        = hb_parclen(2);	
   MS_INT 	size     = (MS_INT)(((iBottom-iTop)) * ((iRight-iLeft)));
   MS_CHAR 	*buffer 	= (MS_CHAR*)calloc(size, sizeof(buffer));
	
   for (int n=0; n<size;){
		for (int y=0; y<x; y++, n++){
			buffer[n] = string[y];
			if( n == size)
				break;
		}
	}
   
	buffer[size]='\0';   
	hb_gtBeginWrite();
   cout << buffer << flush;
	cout << endl << iTop;
	cout << endl << iLeft;
	cout << endl << iBottom;
	cout << endl << iRight;
	cout << endl << len(buffer);
	cout << endl << size;
	hb_gtEndWrite();
	free(buffer);	
	hb_retc_null();
}	

/*-----------------------------------------------------------------------------------------------*/	

HB_FUNC(MS_SETWINDOWSIZE){
	HANDLE		hConsole		= GetStdHandle(STD_OUTPUT_HANDLE);
	HB_SHORT		Top        	= hb_parni(1);	
	HB_SHORT   	Left       	= hb_parni(2);
	HB_SHORT   	Bottom     	= hb_parni(3);	
	HB_SHORT   	Right      	= hb_parni(4);	
	SMALL_RECT 	ScreenSize 	= {Left, Top, Right, Bottom};	

	if (hConsole == INVALID_HANDLE_VALUE){
		MessageBox(NULL, TEXT("GetStdHandle"), TEXT("Console Error"), MB_OK);
		hb_retl(0);		
	}
	hb_retl(SetConsoleWindowInfo(hConsole, true, &ScreenSize));
}

/*-----------------------------------------------------------------------------------------------*/	

HB_FUNC(MS_SETCONSOLE){
	HANDLE     hConsole	= GetStdHandle(STD_OUTPUT_HANDLE); 
	HB_SHORT   Bottom  	= hb_parni(1);	
	HB_SHORT   Right   	= hb_parni(2);	
	SMALL_RECT Rect;     
	COORD      coord;
	
	coord.X     = Right;
	coord.Y     = Bottom;
	Rect.Top    = 0; 
   Rect.Left   = 0; 
   Rect.Bottom = Bottom - 1; 
   Rect.Right  = Right  - 1; 	
	
	if (hConsole == INVALID_HANDLE_VALUE){
		MessageBox(NULL, TEXT("GetStdHandle"), TEXT("Console Error"), MB_OK);
		hb_retl(0);		
	}
	
	//Change the internal buffer size:
	SetConsoleScreenBufferSize(hConsole, coord);
	
	// Change the console window size:
	hb_retl(SetConsoleWindowInfo(hConsole, TRUE, &Rect));	
	//hb_retl(SetConsoleDisplayMode(hStdout,CONSOLE_FULLSCREEN_MODE, &c));
}

/*-----------------------------------------------------------------------------------------------*/	

HB_FUNC( STRZERO ){
	int iParams = hb_pcount();

	if( iParams >= 1 && iParams <= 3 )
	{
		PHB_ITEM pNumber = hb_param( 1, HB_IT_NUMERIC );
		PHB_ITEM pWidth  = NULL;
		PHB_ITEM pDec    = NULL;

		if( iParams >= 2 )
		{
			pWidth = hb_param( 2, HB_IT_NUMERIC );
			if( pWidth == NULL )
				pNumber = NULL;
			else if( iParams >= 3 )
			{
				pDec = hb_param( 3, HB_IT_NUMERIC );
				if( pDec == NULL )
					pNumber = NULL;
			}
		}

		if( pNumber )
		{
			char * szResult = hb_itemStr( pNumber, pWidth, pDec );

			if( szResult )
			{
				HB_SIZE nPos = 0;

				while( szResult[ nPos ] != '\0' && szResult[ nPos ] != '-' )
					nPos++;

				if( szResult[ nPos ] == '-' )
				{
					// NOTE: Negative sign found, put it to the first position 

					szResult[ nPos ] = ' ';

					nPos = 0;
					while( szResult[ nPos ] != '\0' && szResult[ nPos ] == ' ' )
						szResult[ nPos++ ] = '0';

					szResult[ 0 ] = '-';
				}
				else
				{
					// Negative sign not found 

					nPos = 0;
					while( szResult[ nPos ] != '\0' && szResult[ nPos ] == ' ' )
						szResult[ nPos++ ] = '0';
				}

				hb_retc_buffer( szResult );
			}
			else
				hb_retc_null();
		}
		else
#ifdef HB_CLP_STRICT
			// NOTE: In CA-Cl*pper StrZero() is written in Clipper, and will call
			//			Str() to do the job, the error (if any) will also be thrown
			//			by Str().  [vszakats] 
			hb_errRT_BASE_SubstR( EG_ARG, 1099, NULL, "STR", HB_ERR_ARGS_BASEPARAMS );
#else
			hb_errRT_BASE_SubstR( EG_ARG, 6003, NULL, HB_ERR_FUNCNAME, HB_ERR_ARGS_BASEPARAMS );
#endif
	}	

}

/*-----------------------------------------------------------------------------------------------*/	
	
HB_FUNC( STR ){
	int iParams      		= hb_pcount();
	const char *string	= hb_parc(1);;
	PHB_ITEM pNumber 		= hb_param( 1, HB_IT_NUMERIC );
	PHB_ITEM pWidth  		= NULL;
	PHB_ITEM pDec    		= NULL;

	if( iParams >= 2 )
	{
		pWidth = hb_param( 2, HB_IT_NUMERIC );
		if( pWidth == NULL )
			pNumber = NULL;
		else if( iParams >= 3 )
		{
			pDec = hb_param( 3, HB_IT_NUMERIC );
			if( pDec == NULL )
				pNumber = NULL;
		}
	}

	if( pNumber )
	{
		char * szResult = hb_itemStr( pNumber, pWidth, pDec );

		if( szResult )
			hb_retc_buffer( szResult );
		else		   
			//hb_retc_null();
			hb_retc(string);
	}
	else
		//hb_errRT_BASE_SubstR( EG_ARG, 1099, NULL, HB_ERR_FUNCNAME, HB_ERR_ARGS_BASEPARAMS );
			hb_retc(string);		
}
	
/*-----------------------------------------------------------------------------------------------*/	

const char * hb_strLTrim( const char * szText, HB_SIZE * nLen ){
	HB_TRACE( HB_TR_DEBUG, ( "hb_strLTrim(%s, %p)", szText, ( void * ) nLen ) );

	while( *nLen && HB_ISSPACE( *szText ) )
	{
		szText++;
		( *nLen )--;
	}

	return szText;
}

/*-----------------------------------------------------------------------------------------------*/	

HB_SIZE hb_strRTrimLen( const char * szText, HB_SIZE nLen, HB_BOOL bAnySpace ){
	HB_TRACE( HB_TR_DEBUG, ( "hb_strRTrimLen(%s, %lu. %d)", szText, nLen, ( int ) bAnySpace ) );

	if( bAnySpace )
	{
		while( nLen && HB_ISSPACE( szText[ nLen - 1 ] ) )
			nLen--;
	}
	else
	{
		while( nLen && szText[ nLen - 1 ] == ' ' )
			nLen--;
	}

	return nLen;
}

/*-----------------------------------------------------------------------------------------------*/	

HB_FUNC( LTRIM ){
	PHB_ITEM pText = hb_param( 1, HB_IT_STRING );

	if( pText )
	{
		HB_SIZE nLen;
		HB_SIZE nSrc;
		const char * szText;

		nLen   = hb_itemGetCLen( pText );
		nSrc   = hb_itemGetCLen( pText );
		szText = hb_strLTrim( hb_itemGetCPtr( pText ), &nLen );

		if( nLen == nSrc )
			hb_itemReturn( pText );
		else
			hb_retclen( szText, nLen );
	}
	else 
	{
		// NOTE: "TRIM" is correct here [vszakats] 
		// hb_errRT_BASE_SubstR( EG_ARG, 1100, NULL, "TRIM", HB_ERR_ARGS_BASEPARAMS );		
	
		int iParams      		= hb_pcount();
		const char *string	= hb_parc(1);;
		PHB_ITEM pNumber 		= hb_param( 1, HB_IT_NUMERIC );
		PHB_ITEM pWidth  		= NULL;
		PHB_ITEM pDec    		= NULL;

		if( iParams >= 2 )
		{
			pWidth = hb_param( 2, HB_IT_NUMERIC );
			if( pWidth == NULL )
				pNumber = NULL;
			else if( iParams >= 3 )
			{
				pDec = hb_param( 3, HB_IT_NUMERIC );
				if( pDec == NULL )
					pNumber = NULL;
			}
		}

		if( pNumber )
		{
			char * szResult = hb_itemStr( pNumber, pWidth, pDec );

			if( szResult )
				hb_retc_buffer( szResult );
			else		   
				//hb_retc_null();
				hb_retc(string);
		}
		else
			//hb_errRT_BASE_SubstR( EG_ARG, 1101, NULL, HB_ERR_FUNCNAME, HB_ERR_ARGS_BASEPARAMS );
			hb_retc(string);				
	}
}

/*-----------------------------------------------------------------------------------------------*/	

HB_FUNC( RTRIM ){
	PHB_ITEM pText   = hb_param( 1, HB_IT_STRING );
	
	if( pText )
	{
		HB_SIZE nLen, nSrc;
		const char * szText = hb_itemGetCPtr( pText );

		nSrc = hb_itemGetCLen( pText );
		nLen = hb_strRTrimLen( szText, nSrc, HB_FALSE );

		if( nLen == nSrc )
			hb_itemReturn( pText );
		else
			hb_retclen( szText, nLen );
	}
	else
	{
	
		if( HB_ISNUM(1))
		{
			// NOTE: "TRIM" is correct here [vszakats] 
			//hb_errRT_BASE_SubstR( EG_ARG, 1100, NULL, "TRIM", HB_ERR_ARGS_BASEPARAMS );		
			//hb_retni((HB_SIZE)pNumber);		

			int iParams      		= hb_pcount();
			const char *string	= hb_parc(1);;
			PHB_ITEM pNumber 		= hb_param( 1, HB_IT_NUMERIC );
			PHB_ITEM pWidth  		= NULL;
			PHB_ITEM pDec    		= NULL;

			if( iParams >= 2 )
			{
				pWidth = hb_param( 2, HB_IT_NUMERIC );
				if( pWidth == NULL )
					pNumber = NULL;
				else if( iParams >= 3 )
				{
					pDec = hb_param( 3, HB_IT_NUMERIC );
					if( pDec == NULL )
						pNumber = NULL;
				}
			}

			if( pNumber )
			{
				char * szResult = hb_itemStr( pNumber, pWidth, pDec );

				if( szResult )
					hb_retc_buffer( szResult );
				else		   
					//hb_retc_null();
					hb_retc(string);
			}
			else
				//hb_errRT_BASE_SubstR( EG_ARG, 1099, NULL, HB_ERR_FUNCNAME, HB_ERR_ARGS_BASEPARAMS );
				hb_retc(string);				
		}
	}
}

/*-----------------------------------------------------------------------------------------------*/	
	
HB_FUNC( ALLTRIM ){
	PHB_ITEM pText = hb_param( 1, HB_IT_STRING );

	if( pText )
	{
		HB_SIZE nLen, nSrc;
		const char * szText = hb_itemGetCPtr( pText );

		nSrc   = hb_itemGetCLen( pText );
		nLen   = hb_strRTrimLen( szText, nSrc, HB_FALSE );
		szText = hb_strLTrim( szText, &nLen );

		if( nLen == nSrc )
			hb_itemReturn( pText );
		else
			hb_retclen( szText, nLen );
	}
	else
#ifdef HB_COMPAT_C53
		// NOTE: This runtime error appeared in CA-Cl*pper 5.3 [vszakats] 
#ifdef HB_CLP_STRICT
		hb_errRT_BASE_SubstR( EG_ARG, 2022, NULL, HB_ERR_FUNCNAME, 0 );
#else
		hb_errRT_BASE_SubstR( EG_ARG, 2022, NULL, HB_ERR_FUNCNAME, HB_ERR_ARGS_BASEPARAMS );
#endif
#else
		hb_retc_null();
#endif
}

/*-----------------------------------------------------------------------------------------------*/	

HB_FUNC( LEN ){
   PHB_ITEM pItem   	= hb_param(1, HB_IT_ANY);
	PHB_ITEM pWidth 	= NULL;
	PHB_ITEM	pDec 		= NULL;
	
	if(pItem){		
		if( HB_IS_LOGICAL(pItem)){						
			hb_retns(1);
			return;
		}		
		if( HB_IS_NUMERIC(pItem)){						
			HB_CHAR *pText = hb_itemStr(pItem, pWidth, pDec);
			if( pText ){				
				HB_SIZE 	nSrc 		= (HB_SIZE)strlen( pText );
				HB_SIZE 	nLen 		= hb_strRTrimLen( pText, nSrc, HB_FALSE );
				MS_TCHAR *szText	= hb_strLTrim( pText, &nLen );
				HB_SIZE 	nret 		= strlen(szText);
				
				if(nret)
				  hb_retns(nret);
				else						
					hb_errRT_BASE_SubstR( EG_ARG, 1111, NULL, HB_ERR_FUNCNAME, HB_ERR_ARGS_BASEPARAMS );
					//hb_retc_null();
				return;
			}			
		}
		
		if(pItem){
			if( HB_IS_STRING( pItem )){				
				HB_SIZE nLen = hb_itemGetCLen( pItem );
				PHB_CODEPAGE cdp = hb_vmCDP();
				if( HB_CDP_ISCHARIDX( cdp ) )
					nLen = hb_cdpTextLen( cdp, hb_itemGetCPtr( pItem ), nLen );
				hb_retns( nLen );
				return;
			}
			else if( HB_IS_ARRAY( pItem )){
				hb_retns( hb_arrayLen( pItem ) );
				return;
			}
			else if( HB_IS_HASH( pItem )){
				hb_retns( hb_hashLen( pItem ) );
				return;
			}
		}
   }
	//hb_retc_null();
   hb_errRT_BASE_SubstR( EG_ARG, 1111, NULL, HB_ERR_FUNCNAME, HB_ERR_ARGS_BASEPARAMS );
}

/*-----------------------------------------------------------------------------------------------*/	

#if defined( HB_OS_WIN )

   #include <windows.h>
   #include "hbwinuni.h"
   #if defined( HB_OS_WIN_CE )
      #include "hbwince.h"
   #endif

#elif defined( HB_OS_DOS )

   #include "hb_io.h"
   #if defined( __DJGPP__ ) || defined( __GNUC__ )
      #include <sys/param.h>
   #endif

#elif defined( HB_OS_OS2 ) && defined( __GNUC__ )

   #include "hb_io.h"

   /* 2004-03-25 - <maurilio.longo@libero.it>
      not needed anymore as of GCC 3.2.2 */

   #if defined( __EMX__ ) && __GNUC__ * 1000 + __GNUC_MINOR__ < 3002
      #include <emx/syscalls.h>
      #define gethostname __gethostname
   #endif

#elif defined( HB_OS_UNIX ) && ! defined( __WATCOMC__ )

   #if defined( HB_OS_VXWORKS )
      #include <hostLib.h>
   #endif
   #include <unistd.h>

#endif

#if ! defined( MAXGETHOSTNAME ) && ( defined( HB_OS_UNIX ) || \
      ( ( defined( HB_OS_OS2 ) || defined( HB_OS_DOS ) ) && \
        defined( __GNUC__ ) ) )
   #define MAXGETHOSTNAME 256      /* should be enough for a host name */
#endif

/*-----------------------------------------------------------------------------------------------*/	

char * hb_netname( void ){
	#if defined( HB_OS_WIN )

   DWORD dwLen = MAX_COMPUTERNAME_LENGTH + 1;
   TCHAR lpValue[ MAX_COMPUTERNAME_LENGTH + 1 ];

   lpValue[ 0 ] = TEXT( '\0' );
   GetComputerName( lpValue, &dwLen );
   lpValue[ MAX_COMPUTERNAME_LENGTH ] = TEXT( '\0' );

   if( lpValue[ 0 ] )
      return HB_OSSTRDUP( lpValue );

#elif defined( HB_OS_DOS )

#  if defined( __DJGPP__ ) || defined( __GNUC__ )
      char szValue[ MAXGETHOSTNAME + 1 ];
      szValue[ 0 ] = szValue[ MAXGETHOSTNAME ] = '\0';
      gethostname( szValue, MAXGETHOSTNAME );
      if( szValue[ 0 ] )
         return hb_osStrDecode( szValue );
#  else
      union REGS regs;
      struct SREGS sregs;
      char szValue[ 16 ];
      szValue[ 0 ] = szValue[ 15 ] = '\0';

      regs.HB_XREGS.ax = 0x5E00;
      regs.HB_XREGS.dx = FP_OFF( szValue );
      sregs.ds = FP_SEG( szValue );

      HB_DOS_INT86X( 0x21, &regs, &regs, &sregs );

      if( regs.h.ch != 0 && szValue[ 0 ] )
         return hb_osStrDecode( szValue );
#  endif

#elif ( defined( HB_OS_UNIX ) && ! defined( __WATCOMC__ ) ) || \
      ( defined( HB_OS_OS2 ) && defined( __GNUC__ ) )

   char szValue[ MAXGETHOSTNAME + 1 ];
   szValue[ 0 ] = szValue[ MAXGETHOSTNAME ] = '\0';
   gethostname( szValue, MAXGETHOSTNAME );
   if( szValue[ 0 ] )
      return hb_osStrDecode( szValue );

#endif

   return hb_getenv( "HOSTNAME" );
}

/*-----------------------------------------------------------------------------------------------*/	

HB_FUNC( NETNAME ){
   char * buffer = hb_netname();

   if( buffer )
      hb_retc_buffer( buffer );
   else
      hb_retc_null();
}

/*-----------------------------------------------------------------------------------------------*/	

static void hb_inkeySetTextKeys( const char * pszText, HB_SIZE nSize, HB_BOOL fInsert )
{
   PHB_CODEPAGE cdp = hb_vmCDP();
   HB_SIZE nIndex = 0;
   HB_WCHAR wc;

   if( fInsert )
   {
      HB_WCHAR buffer[ 32 ], * keys;
      HB_SIZE n = 0;

      keys = nSize <= HB_SIZEOFARRAY( buffer ) ? buffer :
                        ( HB_WCHAR * ) hb_xgrab( nSize * sizeof( HB_WCHAR ) );
      while( HB_CDPCHAR_GET( cdp, pszText, nSize, &nIndex, &wc ) )
         keys[ n++ ] = wc;

      while( n-- )
      {
         int iKey = keys[ n ] >= 128 ? HB_INKEY_NEW_UNICODE( keys[ n ] ) : keys[ n ];
         hb_inkeyIns( iKey );
      }
      if( nSize > HB_SIZEOFARRAY( buffer ) )
         hb_xfree( keys );
   }
   else
   {
      while( HB_CDPCHAR_GET( cdp, pszText, nSize, &nIndex, &wc ) )
      {
         int iKey = wc >= 128 ? HB_INKEY_NEW_UNICODE( wc ) : wc;
         hb_inkeyPut( iKey );
      }
   }
}

/*-----------------------------------------------------------------------------------------------*/	

HB_FUNC( INKEY )
{
   int iPCount = hb_pcount();

   hb_retni( 
					hb_inkey( iPCount == 1 || ( iPCount > 1 && HB_ISNUM( 1 )),
               hb_parnd( 1 ), 
					hb_parnidef( 2, hb_setGetEventMask()))
				);
}

/*-----------------------------------------------------------------------------------------------*/	

HB_FUNC( __KEYBOARD )
{
   /* Clear the typeahead buffer without reallocating the keyboard buffer */
   hb_inkeyReset();

   if( HB_ISCHAR( 1 ) )
      hb_inkeySetText( hb_parc( 1 ), hb_parclen( 1 ) );
}

/*-----------------------------------------------------------------------------------------------*/	

HB_FUNC( HB_KEYCLEAR )
{
   hb_inkeyReset();
}

/*-----------------------------------------------------------------------------------------------*/	

HB_FUNC( HB_KEYPUT )
{
   if( HB_ISNUM( 1 ) )
   {
      hb_inkeyPut( hb_parni( 1 ) );
   }
   else if( HB_ISCHAR( 1 ) )
   {
      hb_inkeySetTextKeys( hb_parc( 1 ), hb_parclen( 1 ), HB_FALSE );
   }
   else if( HB_ISARRAY( 1 ) )
   {
      PHB_ITEM pArray = hb_param( 1, HB_IT_ARRAY );
      HB_SIZE nIndex;
      HB_SIZE nElements = hb_arrayLen( pArray );

      for( nIndex = 1; nIndex <= nElements; ++nIndex )
      {
         HB_TYPE type = hb_arrayGetType( pArray, nIndex );

         if( type & HB_IT_NUMERIC )
         {
            hb_inkeyPut( hb_arrayGetNI( pArray, nIndex ) );
         }
         else if( type & HB_IT_STRING )
         {
            hb_inkeySetTextKeys( hb_arrayGetCPtr( pArray, nIndex ),
                                 hb_arrayGetCLen( pArray, nIndex ), HB_FALSE );
         }
      }
   }
}

/*-----------------------------------------------------------------------------------------------*/	

HB_FUNC( HB_KEYINS )
{
   if( HB_ISNUM( 1 ) )
   {
      hb_inkeyIns( hb_parni( 1 ) );
   }
   else if( HB_ISCHAR( 1 ) )
   {
      hb_inkeySetTextKeys( hb_parc( 1 ), hb_parclen( 1 ), HB_TRUE );
   }
   else if( HB_ISARRAY( 1 ) )
   {
      PHB_ITEM pArray = hb_param( 1, HB_IT_ARRAY );
      HB_SIZE nIndex;
      HB_SIZE nElements = hb_arrayLen( pArray );

      for( nIndex = 1; nIndex <= nElements; ++nIndex )
      {
         HB_TYPE type = hb_arrayGetType( pArray, nIndex );

         if( type & HB_IT_NUMERIC )
         {
            hb_inkeyIns( hb_arrayGetNI( pArray, nIndex ) );
         }
         else if( type & HB_IT_STRING )
         {
            hb_inkeySetTextKeys( hb_arrayGetCPtr( pArray, nIndex ),
                                 hb_arrayGetCLen( pArray, nIndex ), HB_TRUE );
         }
      }
   }
}

/*-----------------------------------------------------------------------------------------------*/	

HB_FUNC( HB_KEYNEXT )
{
   hb_retni( hb_inkeyNext( HB_ISNUM( 1 ) ? hb_parni( 1 ) : hb_setGetEventMask() ) );
}

/*-----------------------------------------------------------------------------------------------*/	

HB_FUNC( NEXTKEY )
{
   hb_retni( hb_inkeyNext( hb_setGetEventMask() ) );
}

/*-----------------------------------------------------------------------------------------------*/	

HB_FUNC( HB_KEYLAST )
{
   hb_retni( hb_inkeyLast( HB_ISNUM( 1 ) ? hb_parni( 1 ) : hb_setGetEventMask() ) );
}

/*-----------------------------------------------------------------------------------------------*/	

HB_FUNC( LASTKEY )
{
   hb_retni( hb_inkeyLast( HB_INKEY_ALL ) );
}

/*-----------------------------------------------------------------------------------------------*/	

HB_FUNC( HB_KEYSETLAST )
{
   if( HB_ISNUM( 1 ) )
      hb_retni( hb_inkeySetLast( hb_parni( 1 ) ) );
	fi	
}

/*-----------------------------------------------------------------------------------------------*/	
#if defined( HB_LEGACY_LEVEL5 )
HB_FUNC_TRANSLATE( HB_SETLASTKEY, HB_KEYSETLAST )
#endif

/*-----------------------------------------------------------------------------------------------*/	

HB_FUNC( HB_KEYCODE )
{
   const char * szValue = hb_parc( 1 );
   int iKey;

   if( szValue )
   {
      PHB_CODEPAGE cdp = hb_vmCDP();
      HB_SIZE nIndex = 0;
      HB_WCHAR wc;

      if( HB_CDPCHAR_GET( cdp, szValue, hb_parclen( 1 ), &nIndex, &wc ) )
         iKey = wc >= 128 ? HB_INKEY_NEW_UNICODE( wc ) : wc;
      else
         iKey = 0;
   }
   else
      iKey = 0;

   hb_retni( iKey );
}

/*-----------------------------------------------------------------------------------------------*/	

HB_FUNC( HB_KEYCHAR )
{
   char szKeyChr[ HB_MAX_CHAR_LEN ];
   HB_SIZE nLen;

   nLen = hb_inkeyKeyString( hb_parni( 1 ), szKeyChr, sizeof( szKeyChr ) );
   hb_retclen( szKeyChr, nLen );
}

/*-----------------------------------------------------------------------------------------------*/	

HB_FUNC( HB_KEYSTD )
{
   hb_retni( hb_inkeyKeyStd( hb_parni( 1 ) ) );
}

/*-----------------------------------------------------------------------------------------------*/	

HB_FUNC( HB_KEYEXT )
{
   hb_retni( hb_inkeyKeyExt( hb_parni( 1 ) ) );
}

/*-----------------------------------------------------------------------------------------------*/	

HB_FUNC( HB_KEYMOD )
{
   hb_retni( hb_inkeyKeyMod( hb_parni( 1 ) ) );
}

/*-----------------------------------------------------------------------------------------------*/	

HB_FUNC( HB_KEYVAL )
{
   hb_retni( hb_inkeyKeyVal( hb_parni( 1 ) ) );
}

/*-----------------------------------------------------------------------------------------------*/	

HB_FUNC( HB_KEYNEW )
{
   PHB_ITEM pText = hb_param( 1, HB_IT_STRING );
   int iMod 		= hb_parni( 2 );
   int iKey 		= pText ? hb_cdpTextGetU16( hb_vmCDP(), 
									 hb_itemGetCPtr( pText ), 
									 hb_itemGetCLen( pText ) ) : hb_parni( 1 );

   if( iKey >= 127 )
      iKey = HB_INKEY_NEW_UNICODEF( iKey, iMod );
   else if( ! pText || ( iMod & ( HB_KF_CTRL | HB_KF_ALT ) ) != 0 )
      iKey = HB_INKEY_NEW_KEY( iKey, iMod );
   else
      iKey = HB_INKEY_NEW_CHARF( iKey, iMod );

   hb_retni( iKey );
}

/*-----------------------------------------------------------------------------------------------*/	

HB_FUNC( MS_SETCONSOLEDISPLAYMODE )
{	
	HB_SHORT Bottom     = hb_parni(1);	
	HB_SHORT Right      = hb_parni(2);
	//PHB_ITEM Bottom     = hb_param(1, HB_IT_NUMERIC);
	//PHB_ITEM Right      = hb_param(2, HB_IT_NUMERIC);	
	HANDLE   hConsole   = GetStdHandle(STD_OUTPUT_HANDLE);    	 		
	COORD    ScreenSize = {Bottom, Right};		
		
	hb_retl(SetConsoleDisplayMode(hConsole, CONSOLE_FULLSCREEN_MODE, &ScreenSize));
}

/*-----------------------------------------------------------------------------------------------*/	

static void hb_val( HB_BOOL fExt )
{
   PHB_ITEM pText = hb_param( 1, HB_IT_STRING );
   PHB_ITEM pAny  = hb_param( 1, HB_IT_ANY );

   if( pText )
   {
      const char * szText = hb_itemGetCPtr( pText );
      int iWidth, iDec, iLen = ( int ) hb_itemGetCLen( pText );
      HB_BOOL fDbl;
      HB_MAXINT lValue;
      double dValue;

      fDbl = hb_valStrnToNum( szText, iLen, &lValue, &dValue, &iDec, &iWidth );

      if( fExt )
      {
         iLen = hb_parnidef( 2, iLen );

         if( fDbl && iDec > 0 )
            iLen -= iDec + 1;
			fi

         if( iLen > iWidth )
            iWidth = iLen;
         else if( iLen > 0 )
         {
            while( iWidth > iLen && *szText == ' ' )
            {
               iWidth--;
               szText++;
            }
         }
      }

      if( fDbl )
         hb_retndlen( dValue, iWidth, iDec );
      else
         hb_retnintlen( lValue, iWidth );
   }
   else
      hb_errRT_BASE_SubstR( EG_ARG, 1098, NULL, HB_ERR_FUNCNAME, HB_ERR_ARGS_BASEPARAMS );
}

/*-----------------------------------------------------------------------------------------------*/	

HB_FUNC( VAL )
{
   hb_val( HB_FALSE );
}

/*-----------------------------------------------------------------------------------------------*/	

HB_FUNC( HB_VAL )
{
   hb_val( HB_TRUE );
}

/*-----------------------------------------------------------------------------------------------*/	

/* converts string to lower case */
HB_FUNC( LOWER )
{
   PHB_ITEM pText = hb_param( 1, HB_IT_STRING );

   if( pText )
   {
      HB_SIZE nLen = hb_itemGetCLen( pText );
      char * pszBuffer = hb_cdpnDupLower( hb_vmCDP(), hb_itemGetCPtr( pText ), &nLen );
      hb_retclen_buffer( pszBuffer, nLen );
   }
   else
      hb_errRT_BASE_SubstR( EG_ARG, 1103, NULL, HB_ERR_FUNCNAME, HB_ERR_ARGS_BASEPARAMS );
}

//==================================================================================================

/* converts string to upper case */
HB_FUNC( UPPER )
{
   PHB_ITEM pText = hb_param( 1, HB_IT_STRING );

   if( pText )
   {
      HB_SIZE nLen = hb_itemGetCLen( pText );
      char * pszBuffer = hb_cdpnDupUpper( hb_vmCDP(), hb_itemGetCPtr( pText ), &nLen );
      hb_retclen_buffer( pszBuffer, nLen );
   }
   else
      hb_errRT_BASE_SubstR( EG_ARG, 1102, NULL, HB_ERR_FUNCNAME, HB_ERR_ARGS_BASEPARAMS );
}

//==================================================================================================

/* converts an ASCII code to a character value */
HB_FUNC( CHR )
{
   if( HB_ISNUM( 1 ) )
   {
      /* NOTE: CA-Cl*pper's compiler optimizer will be wrong for those
               Chr() cases where the passed parameter is a constant which
               can be divided by 256 but it's not zero, in this case it
               will return an empty string instead of a Chr( 0 ). [vszakats] */

      /* Believe it or not, Cl*pper does this! */
#ifdef HB_CLP_STRICT
      char szChar[ 2 ];
      szChar[ 0 ] = hb_parnl( 1 ) % 256;
      szChar[ 1 ] = '\0';
      hb_retclen( szChar, 1 );
#else
      PHB_CODEPAGE cdp = hb_vmCDP();
      if( HB_CDP_ISCHARUNI( cdp ) )
      {
         char szChar[ HB_MAX_CHAR_LEN ];
         HB_SIZE nLen;

         nLen = hb_cdpTextPutU16( hb_vmCDP(), szChar, sizeof( szChar ),
                                           ( HB_WCHAR ) hb_parni( 1 ) );
         hb_retclen( szChar, nLen );
      }
      else
         hb_retclen( hb_szAscii[ hb_parni( 1 ) & 0xFF ], 1 );
#endif
   }
   else
      hb_errRT_BASE_SubstR( EG_ARG, 1104, NULL, HB_ERR_FUNCNAME, HB_ERR_ARGS_BASEPARAMS );
}

//==================================================================================================

/* converts a character value to an ASCII code */
HB_FUNC( ASC )
{
   const char * szValue = hb_parc( 1 );

   if( szValue )
   {
      int iChar;
      PHB_CODEPAGE cdp = hb_vmCDP();
      if( HB_CDP_ISCHARUNI( cdp ) )
         iChar = hb_cdpTextGetU16( cdp, szValue, hb_parclen( 1 ) );
      else
         iChar = ( HB_UCHAR ) szValue[ 0 ];

      hb_retni( iChar );
   }
   else
      hb_errRT_BASE_SubstR( EG_ARG, 1107, NULL, HB_ERR_FUNCNAME, HB_ERR_ARGS_BASEPARAMS );
}

//==================================================================================================

MS_CHAR *capitalize(MS_TCHAR *s)
{
	MS_SIZE_T nlen = (MS_SIZE_T)strlen(s);
	MS_CHAR *buf   = space(nlen, 32);
   MS_SIZE_T i;
    
    for(i = 0; i< nlen; i++) {
		  buf[i] = s[i];
        if((i == 0 || s[i-1] == ' ') && (s[i] >= 'a' &&s[i] <= 'z'))
            buf[i] = toupper(s[i]);
    }	 	 
	buf[nlen] = '\0';
	return buf;	
}

//==================================================================================================

HB_FUNC( CAPITALIZE )
{
   MS_TCHAR *szValue = hb_parc(1);
   
   if( szValue )
   {
      MS_CHAR *pszBuffer = capitalize(szValue);
		hb_retc(pszBuffer);
   }
   else
      hb_errRT_BASE_SubstR( EG_ARG, 1102, NULL, HB_ERR_FUNCNAME, HB_ERR_ARGS_BASEPARAMS );
}

//==================================================================================================

