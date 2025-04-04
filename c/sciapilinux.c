#include "sciapilinux.h"

#ifdef __GNUC__
#pragma GCC diagnostic ignored "-Wunused-local-typedefs"
#pragma GCC diagnostic ignored "-Wunused-but-set-variable"
#pragma GCC diagnostic ignored "-Wunused-function"
//#pragma GCC diagnostic ignored "-Wwrite-strings"
//#warning "this header is deprecated"
#endif

// synonymn for MS_* 
	HB_FUNC_TRANSLATE(TRIM,    	   RTRIM)
	HB_FUNC_TRANSLATE(MS_TRIM,       RTRIM)
	HB_FUNC_TRANSLATE(MS_LTRIM,      LTRIM)
	HB_FUNC_TRANSLATE(MS_STRZERO,    STRZERO)
	HB_FUNC_TRANSLATE(MS_LEN,        LEN)
	HB_FUNC_TRANSLATE(MS_CAPITALIZE, CAPITALIZE)
	HB_FUNC_TRANSLATE(MS_TELA,       TELA)

//==================================================================================================

/*
static size_t strlen( char s[] )
{
	int i = 0;
	while(s[i] != '\0' ){
		i++;
	}
	return i;
}
*/

//==================================================================================================

char *chr( MS_SIZE n ) {
   char *ch = (char *)malloc(sizeof(char*));
   ch[1]    = '\0';
   memset(ch, n, 1);
   return(ch);
}

//==================================================================================================

char chrx(int n) {
   return (char)n;
}

//==================================================================================================

int asc(char cExp) {
	return (int)cExp;
}

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

char *spacechar( size_t stTamBlock, char chInit )
{
    TString pBuf = (char *)malloc(stTamBlock + 1);
    //char *pBuf = new char[stTamBlock];
    if(pBuf != 0)
        memset(pBuf, chInit, stTamBlock);

    pBuf[stTamBlock] = '\0';
    return pBuf;
}

//=================================================================

char *space(int x, char ch)
{
    char *buff = (char *)malloc(x * sizeof(char *));

    if(buff != 0)
        memset(buff, ch, x);

    buff[x] = '\0';
    return buff;
}

//=================================================================

void *spaceset(size_t size, char ch)
{
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

char *memcpy2(char *dest, char *orig, int n) {
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

char *strleft(TString str, size_t pos) {
    TString ch = space(pos,32);
    memcpy2(ch, str, pos);
    
    if(ch)
        return (ch);
    return (NULL);
}

//=================================================================

char *strleft2(TString str, size_t pos) {
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

char *strrigth(TString str, size_t pos) {
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

char *strsubstr(TString str, size_t ini, size_t fim) {
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

static char *replicate(MS_CHAR *str, MS_SIZE vezes)
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

//==================================================================================================

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
   
	if( iRow >= 0 && iCol >= 0 && iRow <= iMaxRow && iCol <= iMaxCol)
   {
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
      hb_retc(buffer);
      free(buffer);
      return;      
	}
   else{	
		hb_errRT_BASE_SubstR( EG_ARG, 1111, NULL, HB_ERR_FUNCNAME, HB_ERR_ARGS_BASEPARAMS );
		return;
	}   
	hb_retc_null();
   return;
}	

HB_FUNC( TELA )
{
   MS_SIZE        iColor   = hb_parni(1); 
   MS_INT  	      iCol     = 0;
   MS_INT  	      iRow     = 0;
   MS_INT  	      iLeft    = 0;
	MS_INT  	      iTop     = 0;
   MS_INT         iBottom  = hb_gtMaxRow();
   MS_INT         iRight   = hb_gtMaxCol();
	HB_SIZE        nTextLen;
	HB_SIZE        nLen;
   MS_SIZE        size    = (HB_SIZE)(((iBottom-iTop)+1) * ((iRight-iLeft)+1));
	MS_CHAR        *buffer = (MS_CHAR*)calloc(size, sizeof(buffer));
   HB_TCHAR	      *szText = (MS_CHAR*)calloc(size, sizeof(buffer));
	PHB_CODEPAGE   cdp     = hb_gtHostCP();			
   HB_SIZE        nIndex  = 0;
	HB_WCHAR       wc;

   if(!HB_ISNUM(1))
      if( iColor == 0)
         iColor = hb_gtGetCurrColor();
      
   if(HB_ISCHAR(2))
   {   
      if(hb_parclen(2) == 0)                 // panofundo
      {
         szText   = chr(32);                 // espaco em branco
         nTextLen = (HB_SIZE)strlen(szText);
         nLen     = (HB_SIZE)szText;
      }else{		
         szText   = hb_parc(2);
         nTextLen = hb_parclen(2);
         nLen     = hb_parclen(2);
      }
      if(HB_ISNUM(3)) iTop    = hb_parni(3);
      if(HB_ISNUM(4)) iLeft   = hb_parni(4);
      if(HB_ISNUM(5)) iBottom = hb_parni(5);
      if(HB_ISNUM(6)) iRight  = hb_parni(6);   
      iCol                    = iLeft;
      iRow                    = iTop;   
      hb_gtSetPos(iTop, iLeft);
      hb_gtGetPos(&iTop, &iLeft);

      nLen = size = (HB_SIZE)(((iBottom-iTop)+1) * ((iRight-iLeft)+1));
      buffer = (MS_CHAR*)calloc(size, sizeof(buffer));		
      hb_gtBeginWrite();
      
      for(HB_SIZE n=0; n<size;){
         for(HB_SIZE y=0; y<nTextLen; y++, n++){
            buffer[n] = szText[y];
            if( n == size) break;
         }
      }
      buffer[size]='\0';
      
      while(nLen--)
      {
         if( HB_CDPCHAR_GET( cdp, buffer, size, &nIndex, &wc ))
            hb_gtPutChar( iRow, iCol++, iColor, 0, wc );
         else break;

         if( iCol > iRight){
            iCol = iLeft;
            iRow++;
         }
      }			
      hb_gtEndWrite();      
      hb_retc(buffer);
      free(buffer);
      return;
   }
   free(buffer);
   hb_errRT_BASE_SubstR( EG_ARG, 1111, NULL, HB_ERR_FUNCNAME, HB_ERR_ARGS_BASEPARAMS );
   hb_retc_null();
   return;
}	

HB_FUNC( MS_CHAR )
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

      if( iTop && iLeft && iBottom && iRight )
      {
         const char * pszBox   = buffer;

         if( pszBox )
         {
            hb_gtDrawBox(iTop,
                         iLeft,
                         iBottom,
                         iRight,
                         pszBox,
                         iColor );
         }
      }
      hb_gtEndWrite();      
   }
	hb_retc_null();
   return;
}	

/*
 * DispBox() function
 */

#include "hbapi.h"
#include "hbapigt.h"
#include "hbapiitm.h"

HB_FUNC( DISPBOX )
{
   PHB_ITEM pTop    = hb_param( 1, HB_IT_NUMERIC );
   PHB_ITEM pLeft   = hb_param( 2, HB_IT_NUMERIC );
   PHB_ITEM pBottom = hb_param( 3, HB_IT_NUMERIC );
   PHB_ITEM pRight  = hb_param( 4, HB_IT_NUMERIC );

   if( pTop && pLeft && pBottom && pRight )
   {
      const char * pszBox   = hb_parc( 5 );
      const char * pszColor = hb_parc( 6 );

      if( pszBox )
      {
         int iColor;

         if( pszColor )
            iColor = hb_gtColorToN( pszColor );
         else if( HB_ISNUM( 6 ) )
            iColor = hb_parni( 6 );
         else
            iColor = -1;
         hb_gtBoxEx( hb_itemGetNI( pTop ),
                     hb_itemGetNI( pLeft ),
                     hb_itemGetNI( pBottom ),
                     hb_itemGetNI( pRight ),
                     pszBox,
                     iColor );
      }
      else
      {
         char szOldColor[ HB_CLRSTR_LEN ];

         if( pszColor )
         {
            hb_gtGetColorStr( szOldColor );
            hb_gtSetColorStr( pszColor );
         }

         if( hb_parni( 5 ) == 2 )
            hb_gtBoxD( hb_itemGetNI( pTop ),
                       hb_itemGetNI( pLeft ),
                       hb_itemGetNI( pBottom ),
                       hb_itemGetNI( pRight ) );

         else
            hb_gtBoxS( hb_itemGetNI( pTop ),
                       hb_itemGetNI( pLeft ),
                       hb_itemGetNI( pBottom ),
                       hb_itemGetNI( pRight ) );

         if( pszColor )
            hb_gtSetColorStr( szOldColor );
      }
   }
}

//==================================================================================================

HB_FUNC( HB_DISPBOX )
{
   PHB_ITEM pTop    = hb_param( 1, HB_IT_NUMERIC );
   PHB_ITEM pLeft   = hb_param( 2, HB_IT_NUMERIC );
   PHB_ITEM pBottom = hb_param( 3, HB_IT_NUMERIC );
   PHB_ITEM pRight  = hb_param( 4, HB_IT_NUMERIC );

   if( pTop && pLeft && pBottom && pRight )
   {
      const char * pszBox   = hb_parc( 5 );
      const char * pszColor = hb_parc( 6 );
      int          iColor   = pszColor ? hb_gtColorToN( pszColor ) : hb_parnidef( 6, -1 );

      hb_gtDrawBox( hb_itemGetNI( pTop ),
                    hb_itemGetNI( pLeft ),
                    hb_itemGetNI( pBottom ),
                    hb_itemGetNI( pRight ),
                    pszBox,
                    iColor );
   }
}

/*-----------------------------------------------------------------------------------------------
 * hb_default() and __defaultNIL() functions
*/

#include "hbapi.h"
#include "hbapiitm.h"

typedef enum
{
   HB_IT_U,
   HB_IT_N,
   HB_IT_C,
   HB_IT_L,
   HB_IT_T,
   HB_IT_E,
   HB_IT_H,
   HB_IT_A,
   HB_IT_O,
   HB_IT_P,
} HB_IT_BASIC;

static HB_IT_BASIC s_hb_itemTypeBasic( PHB_ITEM pItem )
{
   switch( HB_ITEM_TYPE( pItem ) )
   {
      case HB_IT_ARRAY:
         return hb_arrayIsObject( pItem ) ? HB_IT_O : HB_IT_A;

      case HB_IT_BLOCK:
      case HB_IT_SYMBOL:
         return HB_IT_E;

      case HB_IT_DATE:
      case HB_IT_TIMESTAMP:
         return HB_IT_T;

      case HB_IT_LOGICAL:
         return HB_IT_L;

      case HB_IT_INTEGER:
      case HB_IT_LONG:
      case HB_IT_DOUBLE:
         return HB_IT_N;

      case HB_IT_STRING:
      case HB_IT_MEMO:
         return HB_IT_C;

      case HB_IT_HASH:
         return HB_IT_H;

      case HB_IT_POINTER:
         return HB_IT_P;
   }
   return HB_IT_U;
}


HB_FUNC( HB_DEFAULT )
{
   /*
	PHB_ITEM pDefault = hb_param( 2, HB_IT_ANY );

   if( pDefault && s_hb_itemTypeBasic( hb_param( 1, HB_IT_ANY ) ) != s_hb_itemTypeBasic( pDefault ))
      hb_itemParamStore( 1, pDefault );   
   */
   
   PHB_ITEM pParam   = hb_param(1, HB_IT_ANY);
   PHB_ITEM pDefault = hb_param(2, HB_IT_ANY);

   if( pDefault && s_hb_itemTypeBasic( pParam ) != s_hb_itemTypeBasic( pDefault ))
	{
		hb_itemParamStore( 1, pDefault );
		pParam = pDefault;
	}
	hb_itemReturn( pParam );
}

HB_FUNC( HB_DEFAULTVALUE )
{
   PHB_ITEM pParam   = hb_param(1, HB_IT_ANY);
   PHB_ITEM pDefault = hb_param(2, HB_IT_ANY);

   if( pDefault && s_hb_itemTypeBasic( pParam ) != s_hb_itemTypeBasic( pDefault ))
		pParam = pDefault;
   hb_itemReturn( pParam );
}

/* For compatibility with legacy DEFAULT ... TO ... command.
   Not recommended for new code. */
HB_FUNC( __DEFAULTNIL )
{
   PHB_ITEM pParam   = hb_param(1, HB_IT_ANY);
   PHB_ITEM pDefault = hb_param(2, HB_IT_ANY);
   if( hb_pcount() >= 2 && HB_IS_NIL( hb_param( 1, HB_IT_ANY))){
      hb_itemParamStore( 1, hb_param( 2, HB_IT_ANY ));
      hb_itemReturn( pDefault );
   }
   hb_itemReturn( pParam );   
}

HB_FUNC( HB_DEFAULTNIL )
{
   PHB_ITEM pParam   = hb_param(1, HB_IT_ANY);
   PHB_ITEM pDefault = hb_param(2, HB_IT_ANY);
   if( hb_pcount() >= 2 && HB_IS_NIL( hb_param( 1, HB_IT_ANY))){
      hb_itemParamStore( 1, hb_param( 2, HB_IT_ANY ));
      hb_itemReturn( pDefault );
   }  
   hb_itemReturn( pParam );
}

/*-----------------------------------------------------------------------------------------------
ms_replicate(<string>, <nvezes>)
ms_replicate("=", 80)
-----------------------------------------------------------------------------------------------*/
HB_FUNC( MS_REPLICATE )
{
	int iParams = hb_pcount();

//	if( iParams == 2 && HB_ISCHAR( 1 ) && HB_ISNUM( 2 ) )
	if(hb_pcount() == 2 && HB_ISCHAR(1) && HB_ISNUM(2))
   {
		char *szText = replicate((char*)hb_parc(1), hb_parni(2));
		hb_retc(szText);
		free(szText);
		return;
	}
	else
   {
		hb_errRT_BASE_SubstR( EG_ARG, 1111, NULL, HB_ERR_FUNCNAME, HB_ERR_ARGS_BASEPARAMS );
		return;
	}
}

/*-----------------------------------------------------------------------------------------------*/	

HB_FUNC( MS_FOR )
{
	if( hb_pcount() >= 1){	
		MS_SIZE ch     = hb_parni(1);
		MS_SIZE vezes  = hb_parni(2);
		MS_SIZE n;		
		MS_CHAR *buf;
		
		if(HB_ISNUM(1) && HB_ISNUM(2)){
			buf = space(vezes, 32);
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

/*-----------------------------------------------------------------------------------------------
ms_clear(<color>, <string>)
ms_clear(31, "░▒▓")
-----------------------------------------------------------------------------------------------*/
HB_FUNC(MS_CLEAR)
{
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
	printf("%s",buffer);
	free(buffer);
	hb_retc_null();
}

/*-----------------------------------------------------------------------------------------------*/	

static HB_BOOL hb_ctGetWinCord(MS_INT *piTop, MS_INT *piLeft, MS_INT *piBottom, MS_INT *piRight )
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
				  
HB_FUNC( MS_CLEARSCREEN)
{   
   hb_retni( system( "clear" ) );
	//hb_retc_null();
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

// STRZERO(string/numeric, int nlen, int ndec, char ch )
HB_FUNC( STRZERO )
{
	int iParams          = hb_pcount();
   int iLen             = hb_parni(2);
   char ch              = hb_parni(4);
	const char *pString  = hb_parc(1);
   PHB_ITEM pBuf 	      = hb_param(1, HB_IT_STRING);
	PHB_ITEM pNumber 	   = hb_param(1, HB_IT_NUMERIC);
	PHB_ITEM pWidth  	   = NULL;
	PHB_ITEM pDec    	   = NULL;
   
   switch ( iParams )
   {
      case 0 :
         return;
         break;
    
      case 1 :
         if(!(HB_ISCHAR(1)) && !(HB_ISNUM(1))){
            return;
            break;
         }
         if(HB_ISCHAR(1)){
            hb_retc(pString);
            return;
            break;
         }            
         
         break;
    
      case 2 :
         if(HB_ISCHAR(1) && (HB_ISCHAR(2))){
            hb_retc(pString);
            return;
            break;
         }
         if(HB_ISCHAR(2)){
            if( HB_ISNUM(1)){
               pWidth  = NULL;
               break;
            }
            else
            {
               return;
               break;
            }
         }
         if(HB_ISNUM(1)){
            if( !HB_ISNUM(2)){
               iParams = 1;
               pString = NULL;               
               pWidth  = NULL;
               break;
            }            
         }                     
         break;    
         
      case 3 :        
         if(!(HB_ISCHAR(1)) && !(HB_ISNUM(1))){
            return;
            break;
         }
         break;
      
      default :
         //hb_errRT_BASE_SubstR( EG_ARG, 6003, NULL, HB_ERR_FUNCNAME, HB_ERR_ARGS_BASEPARAMS );
         //return;
         break;
   }
  
   if( HB_ISCHAR(1) && hb_parni(2) <= (int)hb_parclen(1))
   {
      //iLen = (int)hb_parclen(1) + 1;
      hb_retc(pString);
      return;
   }
   
   if( iParams >= 1 && iParams <= 4 )
	{
      //const char *pString  = hb_parc(1);         
      //PHB_ITEM pNumber 	   = hb_param( 1, HB_IT_NUMERIC );
      //PHB_ITEM pWidth  	   = NULL;
      //PHB_ITEM pDec    	   = NULL;

      if( iParams >= 2 )
		{
         if( HB_ISCHAR(2)){
            pWidth  = hb_itemPutNILen( pWidth, 10, 0 );
            pString = NULL; 
         }
         else
            pWidth = hb_param( 2, HB_IT_NUMERIC );            
			if( pWidth == NULL )
            pNumber = NULL;
			else if( iParams >= 3 )
			{
            if( HB_ISCHAR(3))
               pDec = hb_itemPutNILen( pDec, 0, 0 );
            else            
               pDec = hb_param( 3, HB_IT_NUMERIC );
				if( pDec == NULL )
					pNumber = NULL;
			}
		}

		if(pNumber || pString)
		{
     
         char *szResult = hb_itemStr( pNumber, pWidth, pDec ); 
         if (pString){
            char dest[200];
            szResult = strdup(pString);
            int nx   = (int)strlen(szResult);               
            memset(dest, 32, iLen-nx); 
            dest[iLen-nx] = '\0';                  
            strcat(dest, szResult);                              
            szResult = dest;               
         }
         //cout << endl;
         //printf("%i", (int)strlen(szResult));
         
			if( szResult )
			{
				HB_SIZE nPos = 0;

				while( szResult[ nPos ] != '\0' && szResult[ nPos ] != '-' ){
               //printf("\t%d", szResult[nPos]);
					nPos++;
            }

				if( szResult[ nPos ] == '-' )
				{
					// NOTE: Negative sign found, put it to the first position 

					szResult[ nPos ] = ' ';

					nPos = 0;
					while( szResult[ nPos ] != '\0' && szResult[ nPos ] == ' ' )
                  if(ch)
                     szResult[ nPos++ ] = ch;
						else
                     szResult[ nPos++ ] = '0';

					szResult[ 0 ] = '-';
				}
				else
				{
					// Negative sign not found 

					nPos = 0;
					while( szResult[ nPos ] != '\0' && szResult[ nPos ] == ' ' )
                  if(ch)
                     szResult[ nPos++ ] = ch;
						else
                     szResult[ nPos++ ] = '0';						
				}               
            //printf("\t%s", pString);
            //printf("\t%s", szResult);
				hb_retc_buffer( szResult );
			}
			else                  
            //hb_retc_buffer( pString );
            hb_retc_null();
		}
	else
#ifdef HB_CLP_STRICT
      // NOTE: In CA-Cl*pper StrZero() is written in Clipper, and will call
      //			Str() to do the job, the error (if any) will also be thrown
      //			by Str().  [vszakats]
      hb_errRT_BASE_SubstR( EG_ARG, 1099, NULL, "STR", HB_ERR_ARGS_BASEPARAMS );
      return;     
#else
      hb_errRT_BASE_SubstR( EG_ARG, 6003, NULL, HB_ERR_FUNCNAME, HB_ERR_ARGS_BASEPARAMS );
      return;
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


HB_FUNC( MS_SYSTEM )
{
   MS_TCHAR *szValue = hb_parc(1);
   
   if( szValue )
   {
      hb_retni(system(szValue));
      //hb_retc(szValue);
   }  
   else
      hb_errRT_BASE_SubstR( EG_ARG, 1102, NULL, HB_ERR_FUNCNAME, HB_ERR_ARGS_BASEPARAMS );
}

//==================================================================================================

HB_FUNC( FT_CHDIR )
{
   hb_retl( HB_ISCHAR( 1 ) && hb_fsChDir( hb_parc( 1 ) ) );
}

//==================================================================================================

static MS_SIZE len(MS_CHAR *str)
{
	return((MS_INT)strlen(str)); 
}	

/*-----------------------------------------------------------------------------------------------*/	

/*
int main(void)
{
   TString buffer = (TString)"Hello World";   
   //MS_CHAR *buffer = (MS_CHAR*)"Hello World";   
   printf("%s %d", buffer, len(buffer));
   return 0;
}
*/

/*-----------------------------------------------------------------------------------------------*/	

/* returns n copies of a single space */

HB_FUNC( SPACE )
 {
    PHB_ITEM pItem 	= hb_param( 1, HB_IT_NUMERIC );
    PHB_ITEM pString	= hb_param( 1, HB_IT_STRING );
    int nLen 	      = hb_parni( 2);

    if( pItem )
    {
       HB_ISIZ nLen = hb_itemGetNS( pItem );
       if( nLen > 0 )
       {
          char * szResult = ( char * ) hb_xgrab( nLen + 1 );

          /* NOTE: String overflow could never occur since a string can
                   be as large as ULONG_MAX, and the maximum length that
                   can be specified is LONG_MAX here. [vszakats] */
          #if 0
          hb_errRT_BASE( EG_STROVERFLOW, 1233, NULL, HB_ERR_FUNCNAME, HB_ERR_ARGS_BASEPARAMS );
          #endif

          hb_xmemset( szResult, ' ', nLen );
          hb_retclen_buffer( szResult, nLen );
       }
       else
          hb_retc_null();
    }
    else      
    	if(pString){
         int size = hb_parclen(1);         
         if(nLen){                        
            size += nLen;            
         }
         char * szResult = ( char * ) hb_xgrab( size+1 );         
         hb_xmemset( szResult, ' ', size );
         hb_retclen_buffer( szResult, size );
      }
      else
         hb_errRT_BASE_SubstR( EG_ARG, 1105, NULL, HB_ERR_FUNCNAME, HB_ERR_ARGS_BASEPARAMS );
 }

/*-----------------------------------------------------------------------------------------------*/	
 
HB_FUNC( MS_SPACE )
 {
    PHB_ITEM pItem 	= hb_param( 1, HB_IT_NUMERIC );
    PHB_ITEM pString	= hb_param( 1, HB_IT_STRING );
    int nlen 	      = hb_parni( 2 );

    if( pItem )
    {
       HB_ISIZ nLen = hb_itemGetNS( pItem );
       if( nLen > 0 )
       {
          char * szResult = ( char * ) hb_xgrab( nLen + 1 );

          /* NOTE: String overflow could never occur since a string can
                   be as large as ULONG_MAX, and the maximum length that
                   can be specified is LONG_MAX here. [vszakats] */
          #if 0
          hb_errRT_BASE( EG_STROVERFLOW, 1233, NULL, HB_ERR_FUNCNAME, HB_ERR_ARGS_BASEPARAMS );
          #endif

          hb_xmemset( szResult, ' ', nLen );
          hb_retclen_buffer( szResult, nLen );
       }
       else
          hb_retc_null();
    }
    else      
    	if( pString ){
         char *szString = hb_itemGetC( pString );          
         if( nlen ){                               
            int size = hb_parclen( 1 );                  
            // char buffer[ 4096 ];
            // memset( buffer, '\0', 4096 );
            char *buffer = spacechar(nlen,0);
            strcat( buffer, szString );
            strcat( buffer, space( nlen - size, 32 ) );
            hb_retc( buffer );
            // hb_retc_buffer( buffer );
         }
         else
            hb_retc_buffer( szString );            
      }
      else
         hb_errRT_BASE_SubstR( EG_ARG, 1105, NULL, HB_ERR_FUNCNAME, HB_ERR_ARGS_BASEPARAMS );
 } 

/*-----------------------------------------------------------------------------------------------*/	

/*
 * Version detection functions
 *
 * Copyright 1999 {list of individual authors and e-mail addresses}
 * Copyright 1999 Luiz Rafael Culik <culik@sl.conex.net>
 *    hb_verPlatform() (support for determining the Windows version)
 * Copyright 1999 Jose Lalin <dezac@corevia.com>
 *    hb_verPlatform() (support for determining many Windows flavours)
 *    hb_verCompiler() (support for determining some compiler version/revision)
 * Copyright 2000-2014 Viktor Szakats (vszakats.net/harbour)
 *    hb_verCPU(), hb_verHostBitWidth(), hb_iswinver(), hb_iswinsp()
 *    hb_verPlatform() (support for detecting Windows NT on DOS, Wine, post-Windows 8, cleanups)
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2, or (at your option)
 * any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; see the file LICENSE.txt.  If not, write to
 * the Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
 * Boston, MA 02110-1301 USA (or visit https://www.gnu.org/licenses/).
 *
 * As a special exception, the Harbour Project gives permission for
 * additional uses of the text contained in its release of Harbour.
 *
 * The exception is that, if you link the Harbour libraries with other
 * files to produce an executable, this does not by itself cause the
 * resulting executable to be covered by the GNU General Public License.
 * Your use of that executable is in no way restricted on account of
 * linking the Harbour library code into it.
 *
 * This exception does not however invalidate any other reasons why
 * the executable file might be covered by the GNU General Public License.
 *
 * This exception applies only to the code released by the Harbour
 * Project under the name Harbour.  If you copy code from other
 * Harbour Project or Free Software Foundation releases into a copy of
 * Harbour, as the General Public License permits, the exception does
 * not apply to the code that you add in this way.  To avoid misleading
 * anyone as to the status of such modified files, you must delete
 * this exception notice from them.
 *
 * If you write modifications of your own for Harbour, it is your choice
 * whether to permit this exception to apply to your modifications.
 * If you do not wish that, delete this exception notice.
 *
 */

#include "hbapi.h"
#include "hbmemory.ch"

#if defined( HB_OS_WIN )

   #include <windows.h>
   #include "hbwinuni.h"
   #if defined( HB_OS_WIN_CE )
      #include "hbwince.h"
   #endif

   #ifndef VER_PLATFORM_WIN32_WINDOWS
   #define VER_PLATFORM_WIN32_WINDOWS  1
   #endif
   #ifndef VER_PLATFORM_WIN32_CE
   #define VER_PLATFORM_WIN32_CE  3
   #endif

   #ifndef VER_NT_WORKSTATION
   #define VER_NT_WORKSTATION  0x0000001
   #endif
   #ifndef VER_NT_DOMAIN_CONTROLLER
   #define VER_NT_DOMAIN_CONTROLLER  0x0000002
   #endif
   #ifndef VER_NT_SERVER
   #define VER_NT_SERVER  0x0000003
   #endif

   #ifndef VER_MINORVERSION
   #define VER_MINORVERSION  0x0000001
   #endif
   #ifndef VER_MAJORVERSION
   #define VER_MAJORVERSION  0x0000002
   #endif
   #ifndef VER_SERVICEPACKMINOR
   #define VER_SERVICEPACKMINOR  0x0000010
   #endif
   #ifndef VER_SERVICEPACKMAJOR
   #define VER_SERVICEPACKMAJOR  0x0000020
   #endif

   #ifndef VER_PRODUCT_TYPE
   #define VER_PRODUCT_TYPE  0x0000080
   #endif
   #ifndef VER_EQUAL
   #define VER_EQUAL  1
   #endif
   #ifndef VER_GREATER_EQUAL
   #define VER_GREATER_EQUAL  3
   #endif

   #ifndef SM_SERVERR2
   #define SM_SERVERR2  89
   #endif

#elif defined( HB_OS_OS2 )
   #define INCL_DOSMISC
   #include <os2.h>
#elif defined( HB_OS_DOS )
   #include <dos.h>
#elif defined( HB_OS_UNIX ) && ! defined( __CEGCC__ )
   #include <sys/utsname.h>
#endif

const char * hb_verCPU( void )
{
   HB_TRACE( HB_TR_DEBUG, ( "hb_verCPU()" ) );

#if   defined( HB_CPU_X86 )
   return "x86";
#elif defined( HB_CPU_X86_64 )
   return "x86-64";
#elif defined( HB_CPU_IA_64 )
   return "IA-64";
#elif defined( HB_CPU_PPC )
   return "PPC";
#elif defined( HB_CPU_PPC_64 )
   return "PPC64";
#elif defined( HB_CPU_SPARC )
   return "SPARC";
#elif defined( HB_CPU_SPARC_64 )
   return "SPARC64";
#elif defined( HB_CPU_ARM )
   return "ARM";
#elif defined( HB_CPU_ARM_64 )
   return "ARM64";
#elif defined( HB_CPU_MIPS )
   return "MIPS";
#elif defined( HB_CPU_SH )
   return "SuperH";
#elif defined( HB_CPU_ZARCH )
   return "z/Architecture";
#elif defined( HB_CPU_PARISC )
   return "PA-RISC";
#elif defined( HB_CPU_ALPHA )
   return "Alpha";
#elif defined( HB_CPU_POWER )
   return "POWER";
#elif defined( HB_CPU_M68K )
   return "m68k";
#elif defined( HB_CPU_SYS370 )
   return "System/370";
#elif defined( HB_CPU_SYS390 )
   return "System/390";
#else
   return "(unrecognized)";
#endif
}

static HB_BOOL s_win_iswow64( void )
{
   HB_BOOL bRetVal = HB_FALSE;

   #if defined( HB_OS_WIN ) && ! defined( HB_OS_WIN_64 )
   {
      typedef BOOL ( WINAPI * P_ISWOW64PROCESS )( HANDLE, PBOOL );

      P_ISWOW64PROCESS pIsWow64Process;

      HMODULE hModule = GetModuleHandle( TEXT( "kernel32" ) );

      if( hModule )
         pIsWow64Process = ( P_ISWOW64PROCESS ) HB_WINAPI_GETPROCADDRESS( hModule, "IsWow64Process" );
      else
         pIsWow64Process = NULL;

      if( pIsWow64Process )
      {
         BOOL bIsWow64 = FALSE;

         if( ! pIsWow64Process( GetCurrentProcess(), &bIsWow64 ) )
         {
            /* Try alternative method? */
         }

         if( bIsWow64 )
            bRetVal = HB_TRUE;
      }
   }
   #endif

   return bRetVal;
}

const char * hb_verHostCPU( void )
{
   HB_TRACE( HB_TR_DEBUG, ( "hb_verHostCPU()" ) );

   if( s_win_iswow64() )
      return "x86-64";

   return hb_verCPU();
}

int hb_verHostBitWidth( void )
{
   int nBits;

   /* Inherit the bit width we're building for */
   #if   defined( HB_ARCH_64BIT )
      nBits = 64;
   #elif defined( HB_ARCH_32BIT )
      nBits = 32;
   #elif defined( HB_ARCH_16BIT )
      nBits = 16;
   #else
      nBits = 0;
   #endif

   if( s_win_iswow64() )
      nBits = 64;

   return nBits;
}

/* NOTE: OS() function, as a primary goal will detect the version number
         of the target platform. As an extra it may also detect the host OS.
         The latter is mainly an issue in DOS, where the host OS can be OS/2
         WinNT/2K, Win3x, Win9x, DOSEMU, Desqview, etc. [vszakats] */

/* NOTE: The caller must free the returned buffer. [vszakats] */

/* NOTE: The first word of the returned string must describe
         the OS family as used in __PLATFORM__*. Latter macro
         will in fact be formed from the string returned
         by this function. [vszakats] */

/* NOTE: As it appears in __PLATFORM__* macro */
const char * hb_verPlatformMacro( void )
{
#if   defined( HB_OS_WIN_CE ) /* Must precede HB_OS_WIN */
   return "WINCE";            /* TODO: Change this to WCE for consistency? */
#elif defined( HB_OS_WIN )
   return "WINDOWS";          /* TODO: Change this to WIN for consistency? */
#elif defined( HB_OS_DOS )
   return "DOS";
#elif defined( HB_OS_OS2 )
   return "OS2";
#elif defined( HB_OS_LINUX )
   return "LINUX";
#elif defined( HB_OS_DARWIN )
   return "DARWIN";
#elif defined( HB_OS_BSD )
   return "BSD";
#elif defined( HB_OS_SUNOS )
   return "SUNOS";
#elif defined( HB_OS_HPUX )
   return "HPUX";
#elif defined( HB_OS_BEOS )
   return "BEOS";
#elif defined( HB_OS_QNX )
   return "QNX";
#elif defined( HB_OS_VXWORKS )
   return "VXWORKS";
#elif defined( HB_OS_SYMBIAN )
   return "SYMBIAN";
#elif defined( HB_OS_CYGWIN )
   return "CYGWIN";
#else
   return NULL;
#endif
}

#if defined( HB_OS_WIN )

static HB_BOOL s_fWinVerInit = HB_FALSE;

static HB_BOOL s_fWin10    = HB_FALSE;
static HB_BOOL s_fWin81    = HB_FALSE;
static HB_BOOL s_fWin8     = HB_FALSE;
static HB_BOOL s_fWin7     = HB_FALSE;
static HB_BOOL s_fWinVista = HB_FALSE;
static HB_BOOL s_fWin2K3   = HB_FALSE;
static HB_BOOL s_fWin2K    = HB_FALSE;
static int     s_iWinNT    = 0;
static int     s_iWin9x    = 0;
static int     s_iWine     = 0;

#if ! defined( HB_OS_WIN_CE )

#if ( defined( __DMC__ ) || ( defined( _MSC_VER ) && _MSC_VER < 1400 ) ) && \
   ! defined( __POCC__ )

   typedef struct _OSVERSIONINFOEXW
   {
      DWORD dwOSVersionInfoSize;
      DWORD dwMajorVersion;
      DWORD dwMinorVersion;
      DWORD dwBuildNumber;
      DWORD dwPlatformId;
      WCHAR szCSDVersion[ 128 ];
      WORD  wServicePackMajor;
      WORD  wServicePackMinor;
      WORD  wSuiteMask;
      BYTE  wProductType;
      BYTE  wReserved;
   } OSVERSIONINFOEXW, * LPOSVERSIONINFOEXW;
#endif

typedef BOOL ( WINAPI * _HB_VERIFYVERSIONINFO )( LPOSVERSIONINFOEXW, DWORD, DWORDLONG );
typedef ULONGLONG ( WINAPI * _HB_VERSETCONDITIONMASK )( ULONGLONG, DWORD, BYTE );

static HB_BOOL s_fVerInfoInit = HB_TRUE;
static _HB_VERIFYVERSIONINFO   s_pVerifyVersionInfo   = NULL;
static _HB_VERSETCONDITIONMASK s_pVerSetConditionMask = NULL;

static HB_BOOL s_hb_winVerifyVersionInit( void )
{
   if( s_fVerInfoInit )
   {
      HMODULE hModule = GetModuleHandle( TEXT( "kernel32.dll" ) );
      if( hModule )
      {
         s_pVerifyVersionInfo = ( _HB_VERIFYVERSIONINFO ) HB_WINAPI_GETPROCADDRESS( hModule, "VerifyVersionInfoW" );
         s_pVerSetConditionMask = ( _HB_VERSETCONDITIONMASK ) HB_WINAPI_GETPROCADDRESS( hModule, "VerSetConditionMask" );
      }
      s_fVerInfoInit = HB_FALSE;
   }

   return s_pVerifyVersionInfo &&
          s_pVerSetConditionMask;
}

#endif

static void s_hb_winVerInit( void )
{
#if ! defined( HB_OS_WIN_CE )
   s_fWin10    = hb_iswinver( 10, 0, 0, HB_TRUE );
   s_fWin81    = hb_iswinver( 6, 3, 0, HB_TRUE );
   s_fWin8     = hb_iswinver( 6, 2, 0, HB_TRUE );
   s_fWin7     = hb_iswinver( 6, 1, 0, HB_TRUE );
   s_fWinVista = hb_iswinver( 6, 0, 0, HB_TRUE );
   s_fWin2K3   = hb_iswinver( 5, 2, VER_NT_SERVER, HB_TRUE ) || hb_iswinver( 5, 2, VER_NT_DOMAIN_CONTROLLER, HB_TRUE );
   s_fWin2K    = hb_iswinver( 5, 0, 0, HB_TRUE );

#if !( defined( HB_OS_WIN_64 ) || ( defined( _MSC_VER ) && _MSC_VER > 1310 ) )
   {
      OSVERSIONINFO osvi;
      osvi.dwOSVersionInfoSize = sizeof( osvi );
      if( GetVersionEx( &osvi ) )
      {
         /* NOTE: Value is VER_PLATFORM_WIN32_CE on WinCE */
         if( osvi.dwPlatformId != VER_PLATFORM_WIN32_WINDOWS )
            s_iWin9x = 0;
         else if( osvi.dwMajorVersion == 4 && osvi.dwMinorVersion < 10 )
            s_iWin9x = 5;  /* 95 */
         else if( osvi.dwMajorVersion == 4 && osvi.dwMinorVersion == 10 )
            s_iWin9x = 8;  /* 98 */
         else
            s_iWin9x = 9;  /* ME */

         if( osvi.dwPlatformId != VER_PLATFORM_WIN32_NT )
            s_iWinNT = 0;
         else if( osvi.dwMajorVersion == 3 && osvi.dwMinorVersion == 51 )
            s_iWinNT = 3;  /* 3.51 */
         else if( osvi.dwMajorVersion == 4 && osvi.dwMinorVersion == 0 )
            s_iWinNT = 4;  /* 4.0 */
         else
            s_iWinNT = 5;  /* newer */
      }
   }
#endif

   {
      /* NOTE: Unofficial Wine detection.
               https://www.mail-archive.com/wine-devel@winehq.org/msg48659.html */
      HMODULE hntdll = GetModuleHandle( TEXT( "ntdll.dll" ) );
      if( hntdll && HB_WINAPI_GETPROCADDRESS( hntdll, "wine_get_version" ) )
         s_iWine = 1;
   }

   if( s_fWin2K )
      s_iWinNT = 5;
#endif

   s_fWinVerInit = HB_TRUE;
}

#elif defined( HB_OS_DOS )

static HB_BOOL s_fWinVerInit = HB_FALSE;

static HB_BOOL s_fWin10    = HB_FALSE;
static HB_BOOL s_fWin81    = HB_FALSE;
static HB_BOOL s_fWin8     = HB_FALSE;
static HB_BOOL s_fWin7     = HB_FALSE;
static HB_BOOL s_fWinVista = HB_FALSE;
static HB_BOOL s_fWin2K3   = HB_FALSE;
static HB_BOOL s_fWin2K    = HB_FALSE;
static int     s_iWinNT    = 0;
static int     s_iWin9x    = 0;
static int     s_iWine     = 0;

static void s_hb_winVerInit( void )
{
   union REGS regs;

   /* TODO */
   s_fWin10    = HB_FALSE;
   s_fWin81    = HB_FALSE;
   s_fWin8     = HB_FALSE;
   s_fWin7     = HB_FALSE;
   s_fWinVista = HB_FALSE;
   s_fWin2K3   = s_fWinVista;
   s_fWin2K    = HB_FALSE;

   /* Host OS detection: Windows NT family */

   {
      regs.HB_XREGS.ax = 0x3306;
      HB_DOS_INT86( 0x21, &regs, &regs );

      if( regs.HB_XREGS.bx == 0x3205 )
         s_iWinNT = 5;
   }

   /* Host OS detection: 95/98 */

   if( s_iWinNT == 0 )
   {
      regs.HB_XREGS.ax = 0x1600;
      HB_DOS_INT86( 0x2F, &regs, &regs );

      if( regs.h.al != 0x80 &&
          regs.h.al != 0xFF &&
          regs.h.al >= 4 )
         s_iWin9x = 5;
   }

   s_fWinVerInit = HB_TRUE;
}

#endif

/* NOTE: Must be larger than 128, which is the maximum size of
         osvi.szCSDVersion (Windows). [vszakats] */
#define PLATFORM_BUF_SIZE  255

char * hb_verPlatform( void )
{
   char * pszPlatform;

   HB_TRACE( HB_TR_DEBUG, ( "hb_verPlatform()" ) );

   pszPlatform = ( char * ) hb_xgrab( PLATFORM_BUF_SIZE + 1 );

#if defined( HB_OS_DOS )

   {
      union REGS regs;

      regs.h.ah = 0x30;
      HB_DOS_INT86( 0x21, &regs, &regs );

      hb_snprintf( pszPlatform, PLATFORM_BUF_SIZE + 1, "DOS %d.%02d", regs.h.al, regs.h.ah );

      /* Host OS detection: Windows 2.x, 3.x, 95/98 */

      {
         regs.HB_XREGS.ax = 0x1600;
         HB_DOS_INT86( 0x2F, &regs, &regs );

         if( regs.h.al != 0x00 && regs.h.al != 0x80 )
         {
            char szHost[ 128 ];

            if( regs.h.al == 0x01 || regs.h.al == 0xFF )
               hb_snprintf( szHost, sizeof( szHost ), " (Windows 2.x)" );
            else
               hb_snprintf( szHost, sizeof( szHost ), " (Windows %d.%02d)", regs.h.al, regs.h.ah );

            hb_strncat( pszPlatform, szHost, PLATFORM_BUF_SIZE );
         }
      }

      /* Host OS detection: Windows NT family */

      {
         regs.HB_XREGS.ax = 0x3306;
         HB_DOS_INT86( 0x21, &regs, &regs );

         if( regs.HB_XREGS.bx == 0x3205 )
            hb_strncat( pszPlatform, " (Windows NT)", PLATFORM_BUF_SIZE );
      }

      /* Host OS detection: OS/2 */

      {
         regs.h.ah = 0x30;
         HB_DOS_INT86( 0x21, &regs, &regs );

         if( regs.h.al >= 10 )
         {
            char szHost[ 128 ];

            if( regs.h.al == 20 && regs.h.ah > 20 )
               hb_snprintf( szHost, sizeof( szHost ), " (OS/2 %d.%02d)", regs.h.ah / 10, regs.h.ah % 10 );
            else
               hb_snprintf( szHost, sizeof( szHost ), " (OS/2 %d.%02d)", regs.h.al / 10, regs.h.ah );

            hb_strncat( pszPlatform, szHost, PLATFORM_BUF_SIZE );
         }
      }
   }

#elif defined( HB_OS_OS2 )

   {
      unsigned long aulQSV[ QSV_MAX ] = { 0 };
      APIRET rc = DosQuerySysInfo( 1L, QSV_MAX, ( void * ) aulQSV, sizeof( ULONG ) * QSV_MAX );

      if( rc == 0 )
      {
         /* is this OS/2 2.x ? */
         if( aulQSV[ QSV_VERSION_MINOR - 1 ] < 30 )
            hb_snprintf( pszPlatform, PLATFORM_BUF_SIZE + 1, "OS/2 %ld.%02ld",
                         aulQSV[ QSV_VERSION_MAJOR - 1 ] / 10,
                         aulQSV[ QSV_VERSION_MINOR - 1 ] );
         else
            hb_snprintf( pszPlatform, PLATFORM_BUF_SIZE + 1, "OS/2 %2.2f",
                         ( float ) aulQSV[ QSV_VERSION_MINOR - 1 ] / 10 );
      }
      else
         hb_snprintf( pszPlatform, PLATFORM_BUF_SIZE + 1, "OS/2" );
   }

#elif defined( HB_OS_WIN )

   {
      const char * pszName = "";

      OSVERSIONINFO osvi;

      memset( &osvi, 0, sizeof( osvi ) );

#if defined( HB_OS_WIN_CE )
      pszName = " CE";
      osvi.dwOSVersionInfoSize = sizeof( osvi );
      GetVersionEx( &osvi );
#else
      /* Detection of legacy Windows versions */
      switch( hb_iswin9x() )
      {
         case 5:
            osvi.dwMajorVersion = 4;
            osvi.dwMinorVersion = 0;
            pszName = " 95";
            break;
         case 8:
            osvi.dwMajorVersion = 4;
            osvi.dwMinorVersion = 10;
            pszName = " 98";
            break;
         case 9:
            osvi.dwMajorVersion = 4;
            osvi.dwMinorVersion = 90;
            pszName = " ME";
            break;
      }
#endif

      if( pszName[ 0 ] == '\0' )
      {
#if defined( HB_OS_WIN_CE )
         pszName = " CE";
#else
         if( hb_iswinver( 11, 0, 0, HB_TRUE ) )
         {
            osvi.dwMajorVersion = 11;
            osvi.dwMinorVersion = 0;
            pszName = " 11 or newer";
         }
         else if( hb_iswin10() )
         {
            osvi.dwMajorVersion = 10;
            osvi.dwMinorVersion = 0;
            if( hb_iswinver( 10, 0, VER_NT_WORKSTATION, HB_FALSE ) )
               pszName = " 10";
            else
               pszName = " Server 2016";
         }
         else if( hb_iswin81() )
         {
            osvi.dwMajorVersion = 6;
            osvi.dwMinorVersion = 3;
            if( hb_iswinver( 6, 3, VER_NT_WORKSTATION, HB_FALSE ) )
               pszName = " 8.1";
            else
               pszName = " Server 2012 R2";
         }
         else if( hb_iswinvista() )
         {
            if( hb_iswin8() )
            {
               osvi.dwMajorVersion = 6;
               osvi.dwMinorVersion = 2;
               if( hb_iswinver( 6, 2, VER_NT_WORKSTATION, HB_FALSE ) )
                  pszName = " 8";
               else
                  pszName = " Server 2012";
            }
            else if( hb_iswinver( 6, 1, 0, HB_FALSE ) )
            {
               osvi.dwMajorVersion = 6;
               osvi.dwMinorVersion = 1;
               if( hb_iswinver( 6, 1, VER_NT_WORKSTATION, HB_FALSE ) )
                  pszName = " 7";
               else
                  pszName = " Server 2008 R2";
            }
            else
            {
               osvi.dwMajorVersion = 6;
               osvi.dwMinorVersion = 0;
               if( hb_iswinver( 6, 0, VER_NT_WORKSTATION, HB_FALSE ) )
                  pszName = " Vista";
               else
                  pszName = " Server 2008";
            }
         }
         else if( hb_iswinver( 5, 2, 0, HB_FALSE ) )
         {
            osvi.dwMajorVersion = 5;
            osvi.dwMinorVersion = 2;
            if( hb_iswinver( 5, 2, VER_NT_WORKSTATION, HB_FALSE ) )
               pszName = " XP x64";
            else if( GetSystemMetrics( SM_SERVERR2 ) != 0 )
               pszName = " Server 2003 R2";
            else
               pszName = " Server 2003";
         }
         else if( hb_iswinver( 5, 1, 0, HB_FALSE ) )
         {
            osvi.dwMajorVersion = 5;
            osvi.dwMinorVersion = 1;
            pszName = " XP";
         }
         else if( hb_iswin2k() )
         {
            osvi.dwMajorVersion = 5;
            osvi.dwMinorVersion = 0;
            pszName = " 2000";
         }
         else
            pszName = " NT";
#endif
      }

      hb_snprintf( pszPlatform, PLATFORM_BUF_SIZE + 1, "Windows%s%s %lu.%lu",
                   pszName,
                   s_iWine ? " (Wine)" : "",
                   osvi.dwMajorVersion,
                   osvi.dwMinorVersion );

      /* Add service pack/other info */

      if( hb_iswin2k() )
      {
         int tmp;

         for( tmp = 5; tmp > 0; --tmp )
         {
            if( hb_iswinsp( tmp, HB_TRUE ) )
            {
               char szServicePack[ 8 ];
               hb_snprintf( szServicePack, sizeof( szServicePack ), " SP%u", tmp );
               hb_strncat( pszPlatform, szServicePack, PLATFORM_BUF_SIZE );
               break;
            }
         }
      }
#if defined( HB_OS_WIN_CE )
      else
      {
         /* Also for Win9x and NT, but GetVersionEx() is deprecated
            so we avoid it. */
         if( osvi.szCSDVersion[ 0 ] != TEXT( '\0' ) )
         {
            char * pszCSDVersion = HB_OSSTRDUP( osvi.szCSDVersion );
            int i;

            /* Skip the leading spaces (Win95B, Win98) */
            for( i = 0; pszCSDVersion[ i ] != '\0' && HB_ISSPACE( ( int ) pszCSDVersion[ i ] ); i++ )
               ;

            if( pszCSDVersion[ i ] != '\0' )
            {
               hb_strncat( pszPlatform, " ", PLATFORM_BUF_SIZE );
               hb_strncat( pszPlatform, pszCSDVersion + i, PLATFORM_BUF_SIZE );
            }
            hb_xfree( pszCSDVersion );
         }
      }
#endif
   }

#elif defined( __CEGCC__ )
   {
      hb_snprintf( pszPlatform, PLATFORM_BUF_SIZE + 1, "Windows CE" );
   }
#elif defined( HB_OS_UNIX )

   {
      struct utsname un;

      uname( &un );
#if defined( HB_OS_MINIX )
      hb_snprintf( pszPlatform, PLATFORM_BUF_SIZE + 1, "%s Release %s Version %s %s",
                   un.sysname, un.release, un.version, un.machine );
#else
      hb_snprintf( pszPlatform, PLATFORM_BUF_SIZE + 1, "%s %s %s", un.sysname, un.release, un.machine );
#endif
   }

#else

   {
      hb_strncpy( pszPlatform, "(unrecognized)", PLATFORM_BUF_SIZE );
   }

#endif

   return pszPlatform;
}

HB_BOOL hb_iswinver( int iMajor, int iMinor, int iType, HB_BOOL fOrUpper )
{
#if defined( HB_OS_WIN ) && ! defined( HB_OS_WIN_CE )
   if( s_hb_winVerifyVersionInit() )
   {
      OSVERSIONINFOEXW ver;
      DWORD dwTypeMask = VER_MAJORVERSION | VER_MINORVERSION;
      DWORDLONG dwlConditionMask = 0;

      memset( &ver, 0, sizeof( ver ) );
      ver.dwOSVersionInfoSize = sizeof( ver );
      ver.dwMajorVersion = ( DWORD ) iMajor;
      ver.dwMinorVersion = ( DWORD ) iMinor;

      dwlConditionMask = s_pVerSetConditionMask( dwlConditionMask, VER_MAJORVERSION, fOrUpper ? VER_GREATER_EQUAL : VER_EQUAL );
      dwlConditionMask = s_pVerSetConditionMask( dwlConditionMask, VER_MINORVERSION, fOrUpper ? VER_GREATER_EQUAL : VER_EQUAL );

      /* MSDN says in https://msdn.microsoft.com/library/ms725492
           "If you are testing the major version, you must also test the
            minor version and the service pack major and minor versions."
         However, Wine (as of 1.7.53) breaks on this. Since native Windows
         apparently doesn't care, we're not doing it for now.
         Wine (emulating Windows 7) will erroneously return HB_FALSE from
         these calls:
           hb_iswinver( 6, 1, 0, HB_FALSE );
           hb_iswinver( 6, 1, VER_NT_WORKSTATION, HB_FALSE );
         Removing the Service Pack check, or changing HB_FALSE to HB_TRUE
         in above calls, both fixes the problem. [vszakats] */
#if defined( __HB_DISABLE_WINE_VERIFYVERSIONINFO_BUG_WORKAROUND )
      ver.wServicePackMajor =
      ver.wServicePackMinor = ( WORD ) 0;
      dwTypeMask |= VER_SERVICEPACKMAJOR | VER_SERVICEPACKMINOR;
      dwlConditionMask = s_pVerSetConditionMask( dwlConditionMask, VER_SERVICEPACKMAJOR, VER_GREATER_EQUAL );
      dwlConditionMask = s_pVerSetConditionMask( dwlConditionMask, VER_SERVICEPACKMINOR, VER_GREATER_EQUAL );
#endif

      if( iType )
      {
         dwTypeMask |= VER_PRODUCT_TYPE;
         ver.wProductType = ( BYTE ) iType;
         dwlConditionMask = s_pVerSetConditionMask( dwlConditionMask, VER_PRODUCT_TYPE, VER_EQUAL );
      }

      return ( HB_BOOL ) s_pVerifyVersionInfo( &ver, dwTypeMask, dwlConditionMask );
   }
#else
   HB_SYMBOL_UNUSED( iMajor );
   HB_SYMBOL_UNUSED( iMinor );
   HB_SYMBOL_UNUSED( iType );
   HB_SYMBOL_UNUSED( fOrUpper );
#endif
   return HB_FALSE;
}

HB_BOOL hb_iswinsp( int iServicePackMajor, HB_BOOL fOrUpper )
{
#if defined( HB_OS_WIN ) && ! defined( HB_OS_WIN_CE )
   if( s_hb_winVerifyVersionInit() )
   {
      OSVERSIONINFOEXW ver;
      DWORDLONG dwlConditionMask = 0;

      memset( &ver, 0, sizeof( ver ) );
      ver.dwOSVersionInfoSize = sizeof( ver );
      ver.wServicePackMajor = ( WORD ) iServicePackMajor;

      dwlConditionMask = s_pVerSetConditionMask( dwlConditionMask, VER_SERVICEPACKMAJOR, fOrUpper ? VER_GREATER_EQUAL : VER_EQUAL );

      return ( HB_BOOL ) s_pVerifyVersionInfo( &ver, VER_SERVICEPACKMAJOR, dwlConditionMask );
   }
#else
   HB_SYMBOL_UNUSED( iServicePackMajor );
   HB_SYMBOL_UNUSED( fOrUpper );
#endif
   return HB_FALSE;
}

int hb_iswine( void )
{
#if defined( HB_OS_WIN ) || defined( HB_OS_DOS )
   if( ! s_fWinVerInit )
      s_hb_winVerInit();
   return s_iWine;
#else
   return 0;
#endif
}

HB_BOOL hb_iswin10( void )
{
#if defined( HB_OS_WIN ) || defined( HB_OS_DOS )
   if( ! s_fWinVerInit )
      s_hb_winVerInit();
   return s_fWin10;
#else
   return HB_FALSE;
#endif
}

HB_BOOL hb_iswin81( void )
{
#if defined( HB_OS_WIN ) || defined( HB_OS_DOS )
   if( ! s_fWinVerInit )
      s_hb_winVerInit();
   return s_fWin81;
#else
   return HB_FALSE;
#endif
}

HB_BOOL hb_iswin8( void )
{
#if defined( HB_OS_WIN ) || defined( HB_OS_DOS )
   if( ! s_fWinVerInit )
      s_hb_winVerInit();
   return s_fWin8;
#else
   return HB_FALSE;
#endif
}

HB_BOOL hb_iswin7( void )
{
#if defined( HB_OS_WIN ) || defined( HB_OS_DOS )
   if( ! s_fWinVerInit )
      s_hb_winVerInit();
   return s_fWin7;
#else
   return HB_FALSE;
#endif
}

HB_BOOL hb_iswinvista( void )
{
#if defined( HB_OS_WIN ) || defined( HB_OS_DOS )
   if( ! s_fWinVerInit )
      s_hb_winVerInit();
   return s_fWinVista;
#else
   return HB_FALSE;
#endif
}

HB_BOOL hb_iswin2k3( void )
{
#if defined( HB_OS_WIN ) || defined( HB_OS_DOS )
   if( ! s_fWinVerInit )
      s_hb_winVerInit();
   return s_fWin2K3;
#else
   return HB_FALSE;
#endif
}

HB_BOOL hb_iswin2k( void )
{
#if defined( HB_OS_WIN ) || defined( HB_OS_DOS )
   if( ! s_fWinVerInit )
      s_hb_winVerInit();
   return s_fWin2K;
#else
   return HB_FALSE;
#endif
}

int hb_iswinnt( void )
{
#if defined( HB_OS_WIN ) || defined( HB_OS_DOS )
   if( ! s_fWinVerInit )
      s_hb_winVerInit();
   return s_iWinNT;
#else
   return 0;
#endif
}

int hb_iswin9x( void )
{
#if defined( HB_OS_WIN ) || defined( HB_OS_DOS )
   if( ! s_fWinVerInit )
      s_hb_winVerInit();
   return s_iWin9x;
#else
   return 0;
#endif
}

HB_BOOL hb_iswince( void )
{
#if defined( HB_OS_WIN_CE )
   return HB_TRUE;
#else
   return HB_FALSE;
#endif
}

/* NOTE: The caller must free the returned buffer. [vszakats] */

#define COMPILER_BUF_SIZE  80

char * hb_verCompiler( void )
{
   char * pszCompiler;
   const char * pszName;
   char szSub[ 64 ];
   int iVerMajor;
   int iVerMinor;
   int iVerPatch;
   int iVerMicro = 0;
   int iElements = 0;

   HB_TRACE( HB_TR_DEBUG, ( "hb_verCompiler()" ) );

   pszCompiler = ( char * ) hb_xgrab( COMPILER_BUF_SIZE );
   szSub[ 0 ] = '\0';

#if defined( __IBMC__ ) || defined( __IBMCPP__ )

   #if defined( __IBMC__ )
      iVerMajor = __IBMC__;
   #else
      iVerMajor = __IBMCPP__;
   #endif

   if( iVerMajor >= 300 )
      pszName = "IBM Visual Age C++";
   else
      pszName = "IBM C++";

   iVerMajor /= 100;
   iVerMinor = iVerMajor % 100;
   iVerPatch = 0;

#elif defined( __POCC__ )

   pszName = "Pelles ISO C Compiler";
   iVerMajor = __POCC__ / 100;
   iVerMinor = __POCC__ % 100;
   iVerPatch = 0;

#elif defined( __LCC__ )

   pszName = "Logiciels/Informatique lcc-win32";
   iVerMajor = 0 /* __LCC__ / 100 */;
   iVerMinor = 0 /* __LCC__ % 100 */;
   iVerPatch = 0;

#elif defined( __DMC__ )

   pszName = __DMC_VERSION_STRING__;
   iVerMajor = 0;
   iVerMinor = 0;
   iVerPatch = 0;

#elif defined( __INTEL_COMPILER )

   pszName = "Intel(R) C";

   #if defined( __cplusplus )
      hb_strncpy( szSub, "++", sizeof( szSub ) - 1 );
   #endif

   iVerMajor = __INTEL_COMPILER / 100;
   iVerMinor = ( __INTEL_COMPILER % 100 ) / 10;
   iVerPatch = 0;

#elif defined( __ICL )

   pszName = "Intel(R) C";

   #if defined( __cplusplus )
      hb_strncpy( szSub, "++", sizeof( szSub ) - 1 );
   #endif

   iVerMajor = __ICL / 100;
   iVerMinor = __ICL % 100;
   iVerPatch = 0;

#elif defined( __ICC )

   pszName = "Intel(R) (ICC) C";

   #if defined( __cplusplus )
      hb_strncpy( szSub, "++", sizeof( szSub ) - 1 );
   #endif

   iVerMajor = __ICC / 100;
   iVerMinor = __ICC % 100;
   iVerPatch = 0;

#elif defined( __OPENCC__ )

   pszName = "Open64 C";

   #if defined( __cplusplus )
      hb_strncpy( szSub, "++", sizeof( szSub ) - 1 );
   #endif

   iVerMajor = __OPENCC__;
   iVerMinor = __OPENCC_MINOR__;
#if __OPENCC_PATCHLEVEL__ - 0 <= 0
   #undef __OPENCC_PATCHLEVEL__
   #define __OPENCC_PATCHLEVEL__ 0
#endif
   iVerPatch = __OPENCC_PATCHLEVEL__;

#elif defined( __clang__ ) && defined( __clang_major__ )

   /* NOTE: keep clang detection before msvc detection. */

   pszName = "LLVM/Clang C";

   #if defined( __cplusplus )
      hb_strncpy( szSub, "++", sizeof( szSub ) - 1 );
   #endif

   iVerMajor = __clang_major__;
   iVerMinor = __clang_minor__;
   iVerPatch = __clang_patchlevel__;

#elif defined( __clang__ )

   pszName = "LLVM/Clang C";

   #if defined( __cplusplus )
      hb_strncpy( szSub, "++", sizeof( szSub ) - 1 );
   #endif

   hb_strncat( szSub, " 1.x", sizeof( szSub ) - 1 );

   iVerMajor = iVerMinor = iVerPatch = 0;

#elif defined( __llvm__ ) && defined( __GNUC__ )

   pszName = "LLVM/GNU C";

   #if defined( __cplusplus )
      hb_strncpy( szSub, "++", sizeof( szSub ) - 1 );
   #endif

   iVerMajor = __GNUC__;
   iVerMinor = __GNUC_MINOR__;
   #if defined( __GNUC_PATCHLEVEL__ )
      iVerPatch = __GNUC_PATCHLEVEL__;
   #else
      iVerPatch = 0;
   #endif

#elif defined( _MSC_VER )

   #if _MSC_VER >= 800
      pszName = "Microsoft Visual C";
   #else
      pszName = "Microsoft C";
   #endif

   #if defined( __cplusplus )
      hb_strncpy( szSub, "++", sizeof( szSub ) - 1 );
   #endif

   iVerMajor = _MSC_VER / 100;
   iVerMinor = _MSC_VER % 100;

   #if defined( _MSC_FULL_VER )
      #if _MSC_VER >= 1400
         iVerPatch = _MSC_FULL_VER - ( _MSC_VER * 100000 );
      #else
         iVerPatch = _MSC_FULL_VER - ( _MSC_VER * 10000 );
      #endif
   #else
      iVerPatch = 0;
   #endif

#elif defined( __BORLANDC__ )

   #if __BORLANDC__ >= 0x0590  /* Version 5.9 */
      #if __BORLANDC__ >= 0x0620  /* Version 6.2 */
         pszName = "Borland/Embarcadero C++";
      #else
         pszName = "Borland/CodeGear C++";
      #endif
   #else
      pszName = "Borland C++";
   #endif
   #if   __BORLANDC__ == 0x0400  /* Version 3.0 */
      iVerMajor = 3;
      iVerMinor = 0;
      iVerPatch = 0;
   #elif __BORLANDC__ == 0x0410  /* Version 3.1 */
      iVerMajor = 3;
      iVerMinor = 1;
      iVerPatch = 0;
   #elif __BORLANDC__ == 0x0452  /* Version 4.0 */
      iVerMajor = 4;
      iVerMinor = 0;
      iVerPatch = 0;
   #elif __BORLANDC__ == 0x0460  /* Version 4.5 */
      iVerMajor = 4;
      iVerMinor = 5;
      iVerPatch = 0;
   #elif __BORLANDC__ >= 0x0500  /* Version 5.x */
      iVerMajor = __BORLANDC__ >> 8;
      iVerMinor = ( __BORLANDC__ & 0xFF ) >> 4;
      iVerPatch = __BORLANDC__ & 0xF;
   #else /* Version 4.x */
      iVerMajor = __BORLANDC__ >> 8;
      iVerMinor = ( __BORLANDC__ - 1 & 0xFF ) >> 4;
      iVerPatch = 0;
   #endif

#elif defined( __TURBOC__ )

   pszName = "Borland Turbo C";
   iVerMajor = __TURBOC__ >> 8;
   iVerMinor = __TURBOC__ & 0xFF;
   iVerPatch = 0;

#elif defined( __MPW__ )

   pszName = "MPW C";
   iVerMajor = __MPW__ / 100;
   iVerMinor = __MPW__ % 100;
   iVerPatch = 0;

#elif defined( __WATCOMC__ )

   #if __WATCOMC__ < 1200
      pszName = "Watcom C";
   #else
      pszName = "Open Watcom C";
   #endif

   #if defined( __cplusplus )
      hb_strncpy( szSub, "++", sizeof( szSub ) - 1 );
   #endif

   iVerMajor = __WATCOMC__ / 100;
   iVerMinor = __WATCOMC__ % 100;

   #if defined( __WATCOM_REVISION__ )
      iVerPatch = __WATCOM_REVISION__;
   #else
      iVerPatch = 0;
   #endif

#elif defined( __DCC__ )

   pszName = "Wind River Compiler (diab)";

   iVerMajor = ( __VERSION_NUMBER__ / 1000 ) % 10;
   iVerMinor = ( __VERSION_NUMBER__ / 100 ) % 10;
   iVerPatch = ( __VERSION_NUMBER__ / 10 ) % 10;
   iVerMicro = __VERSION_NUMBER__ % 10;
   iElements = 4;

#elif defined( __TINYC__ )

   pszName = "Tiny C Compiler";

   iVerMajor = __TINYC__ / 100;
   iVerMinor = ( __TINYC__ % 100 ) / 10;
   iVerPatch = ( __TINYC__ % 100 ) % 10;

#elif defined( __PCC__ )

   pszName = "Portable C Compiler";

   iVerMajor = __PCC__;
   iVerMinor = __PCC_MINOR__;
   iVerPatch = __PCC_MINORMINOR__;

   #if defined( __GNUC__ )
      hb_snprintf( szSub, sizeof( szSub ), " (GCC %d.%d.%d emul.)",
                   __GNUC__, __GNUC_MINOR__, __GNUC_PATCHLEVEL__ );
   #endif

#elif defined( __GNUC__ )

   #if defined( __DJGPP__ )
      pszName = "Delorie GNU C";
   #elif defined( __CYGWIN__ )
      pszName = "Cygwin GNU C";
   #elif defined( __MINGW32__ )
      pszName = "MinGW GNU C";
   #elif defined( __EMX__ )
      pszName = "EMX GNU C";
   #else
      pszName = "GCC/GNU C";
   #endif

   #if defined( __cplusplus )
      hb_strncpy( szSub, "++", sizeof( szSub ) - 1 );
   #endif

   iVerMajor = __GNUC__;
   iVerMinor = __GNUC_MINOR__;
   #if defined( __GNUC_PATCHLEVEL__ )
      iVerPatch = __GNUC_PATCHLEVEL__;
   #else
      iVerPatch = 0;
   #endif

#elif defined( __SUNPRO_C )

   pszName = "Sun C";
   #if __SUNPRO_C < 0x1000
      iVerMajor = __SUNPRO_C / 0x100;
      iVerMinor = ( __SUNPRO_C & 0xff ) / 0x10;
      iVerPatch = __SUNPRO_C & 0xf;
   #else
      iVerMajor = __SUNPRO_C / 0x1000;
      iVerMinor = __SUNPRO_C / 0x10 & 0xff;
      iVerMinor = iVerMinor / 0x10 * 0xa + iVerMinor % 0x10;
      iVerPatch = __SUNPRO_C & 0xf;
   #endif

#elif defined( __SUNPRO_CC )

   pszName = "Sun C++";
   #if __SUNPRO_CC < 0x1000
      iVerMajor = __SUNPRO_CC / 0x100;
      iVerMinor = ( __SUNPRO_CC & 0xff ) / 0x10;
      iVerPatch = __SUNPRO_CC & 0xf;
   #else
      iVerMajor = __SUNPRO_CC / 0x1000;
      iVerMinor = __SUNPRO_CC / 0x10 & 0xff;
      iVerMinor = iVerMinor / 0x10 * 0xa + iVerMinor % 0x10;
      iVerPatch = __SUNPRO_CC & 0xf;
   #endif

#else

   pszName = NULL;
   iVerMajor = iVerMinor = iVerPatch = 0;

#endif

   if( pszName )
   {
      if( iElements == 4 )
         hb_snprintf( pszCompiler, COMPILER_BUF_SIZE, "%s%s %d.%d.%d.%d", pszName, szSub, iVerMajor, iVerMinor, iVerPatch, iVerMicro );
      else if( iVerPatch != 0 )
         hb_snprintf( pszCompiler, COMPILER_BUF_SIZE, "%s%s %d.%d.%d", pszName, szSub, iVerMajor, iVerMinor, iVerPatch );
      else if( iVerMajor != 0 || iVerMinor != 0 )
         hb_snprintf( pszCompiler, COMPILER_BUF_SIZE, "%s%s %d.%d", pszName, szSub, iVerMajor, iVerMinor );
      else
         hb_snprintf( pszCompiler, COMPILER_BUF_SIZE, "%s%s", pszName, szSub );
   }
   else
      hb_strncpy( pszCompiler, "(unrecognized)", COMPILER_BUF_SIZE - 1 );

#if defined( __clang_version__ )
   if( strstr( __clang_version__, "(" ) )
      /* "2.0 (trunk 103176)" -> "(trunk 103176)" */
      hb_snprintf( szSub, sizeof( szSub ), " %s", strstr( __clang_version__, "(" ) );
   else
      hb_snprintf( szSub, sizeof( szSub ), " (%s)", __clang_version__ );
   hb_strncat( pszCompiler, szSub, COMPILER_BUF_SIZE - 1 );
#endif

#if defined( __DJGPP__ )
   hb_snprintf( szSub, sizeof( szSub ), " (DJGPP %i.%02i)", ( int ) __DJGPP__, ( int ) __DJGPP_MINOR__ );
   hb_strncat( pszCompiler, szSub, COMPILER_BUF_SIZE - 1 );
#endif

   #if defined( HB_ARCH_16BIT )
      hb_strncat( pszCompiler, " (16-bit)", COMPILER_BUF_SIZE - 1 );
   #elif defined( HB_ARCH_32BIT )
      hb_strncat( pszCompiler, " (32-bit)", COMPILER_BUF_SIZE - 1 );
   #elif defined( HB_ARCH_64BIT )
      hb_strncat( pszCompiler, " (64-bit)", COMPILER_BUF_SIZE - 1 );
   #endif

   return pszCompiler;
}

/* NOTE: The caller must free the returned buffer. [vszakats] */

/* NOTE:
   CA-Cl*pper 5.2e returns: "Clipper (R) 5.2e Intl. (x216)  (1995.02.07)"
   CA-Cl*pper 5.3b returns: "Clipper (R) 5.3b Intl. (Rev. 338) (1997.04.25)"
 */

/*
char * hb_verHarbour( void )
{
   char * pszVersion;
   char szDateRaw[ 11 ];
   char szDate[ 17 ];

   HB_TRACE( HB_TR_DEBUG, ( "hb_verHarbour()" ) );

   hb_snprintf( szDateRaw, sizeof( szDateRaw ), "%d", hb_verCommitRev() );

   szDate[ 0 ] = '2';
   szDate[ 1 ] = '0';
   szDate[ 2 ] = szDateRaw[ 0 ];
   szDate[ 3 ] = szDateRaw[ 1 ];
   szDate[ 4 ] = '-';
   szDate[ 5 ] = szDateRaw[ 2 ];
   szDate[ 6 ] = szDateRaw[ 3 ];
   szDate[ 7 ] = '-';
   szDate[ 8 ] = szDateRaw[ 4 ];
   szDate[ 9 ] = szDateRaw[ 5 ];
   szDate[ 10 ] = ' ';
   szDate[ 11 ] = szDateRaw[ 6 ];
   szDate[ 12 ] = szDateRaw[ 7 ];
   szDate[ 13 ] = ':';
   szDate[ 14 ] = szDateRaw[ 8 ];
   szDate[ 15 ] = szDateRaw[ 9 ];
   szDate[ 16 ] = '\0';

   pszVersion = ( char * ) hb_xgrab( 80 );
   hb_snprintf( pszVersion, 80, "Harbour %d.%d.%d%s (%s) (%s)",
                HB_VER_MAJOR, HB_VER_MINOR, HB_VER_RELEASE, HB_VER_STATUS,
                hb_verCommitIDShort(), szDate );

   return pszVersion;
}
*/

char * hb_verPCode( void )
{
   char * pszPCode;

   HB_TRACE( HB_TR_DEBUG, ( "hb_verPCode()" ) );

   pszPCode = ( char * ) hb_xgrab( 24 );
   hb_snprintf( pszPCode, 24, "PCode version: %d.%d",
                HB_PCODE_VER >> 8, HB_PCODE_VER & 0xFF );

   return pszPCode;
}

#if defined( HB_LEGACY_LEVEL4 )
char * hb_verBuildDate( void )
{
   return ( char * ) hb_xgrabz( 1 );
}
#endif


/*
 * hb_StrFormat() function
 *
 * Copyright 2008 Mindaugas Kavaliauskas <dbtopas at dbtopas.lt>
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2, or (at your option)
 * any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; see the file LICENSE.txt.  If not, write to
 * the Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
 * Boston, MA 02110-1301 USA (or visit https://www.gnu.org/licenses/).
 *
 * As a special exception, the Harbour Project gives permission for
 * additional uses of the text contained in its release of Harbour.
 *
 * The exception is that, if you link the Harbour libraries with other
 * files to produce an executable, this does not by itself cause the
 * resulting executable to be covered by the GNU General Public License.
 * Your use of that executable is in no way restricted on account of
 * linking the Harbour library code into it.
 *
 * This exception does not however invalidate any other reasons why
 * the executable file might be covered by the GNU General Public License.
 *
 * This exception applies only to the code released by the Harbour
 * Project under the name Harbour.  If you copy code from other
 * Harbour Project or Free Software Foundation releases into a copy of
 * Harbour, as the General Public License permits, the exception does
 * not apply to the code that you add in this way.  To avoid misleading
 * anyone as to the status of such modified files, you must delete
 * this exception notice from them.
 *
 * If you write modifications of your own for Harbour, it is your choice
 * whether to permit this exception to apply to your modifications.
 * If you do not wish that, delete this exception notice.
 *
 */

#include "hbapi.h"
#include "hbapiitm.h"
#include "hbapierr.h"

typedef struct
{
   char *  pData;
   HB_SIZE nLen;
   HB_SIZE nMax;
} BUFFERTYPE;

static void bufadd( BUFFERTYPE * pBuf, const char * pAdd, HB_SIZE nLen )
{
   if( pBuf->nLen + nLen >= pBuf->nMax )
   {
      pBuf->nMax += ( pBuf->nMax >> 1 ) + nLen;
      pBuf->pData = ( char * ) hb_xrealloc( pBuf->pData, pBuf->nMax );
   }
   memcpy( pBuf->pData + pBuf->nLen, pAdd, nLen );
   pBuf->nLen += nLen;
   pBuf->pData[ pBuf->nLen ] = '\0';
}

static void hb_itemHexStr( PHB_ITEM pItem, char * pStr, HB_BOOL fUpper )
{
   HB_MAXUINT nValue, nTmp;
   int iLen;

   nValue = nTmp = hb_itemGetNInt( pItem );

   iLen = 0;
   do
   {
      ++iLen;
      nTmp >>= 4;
   }
   while( nTmp );

   pStr[ iLen ] = '\0';
   do
   {
      int iDigit = ( int ) ( nValue & 0x0F );
      pStr[ --iLen ] = ( char ) ( iDigit + ( iDigit < 10 ? '0' :
                                             ( fUpper ? 'A' : 'a' ) - 10 ) );
      nValue >>= 4;
   }
   while( iLen );
}

PHB_ITEM hb_strFormat( PHB_ITEM pItemReturn, PHB_ITEM pItemFormat, int iCount, PHB_ITEM * pItemArray )
{
   BUFFERTYPE  buffer;
   PHB_ITEM    pItem;
   const char  *pFmt, *pFmtEnd, *pFmtSave;
   int         i, iParam, iParamNo, iWidth, iDec;
   HB_SIZE     nSize;
   HB_BOOL     fLeftAlign, fForceSign, fPadZero, fSpaceSign, fSign, fTab;

   pFmt = hb_itemGetCPtr( pItemFormat );
   nSize = hb_itemGetCLen( pItemFormat );
   pFmtEnd = pFmt + nSize;

   buffer.nMax = nSize + 16;
   buffer.nLen = 0;
   buffer.pData = ( char * ) hb_xgrab( buffer.nMax );
   buffer.pData[ 0 ] = '\0';

   iParam = 0;
   while( pFmt < pFmtEnd )
   {
      if( *pFmt != '%' )
      {
         bufadd( &buffer, pFmt++, 1 );
         continue;
      }

      pFmtSave = pFmt++;

      if( *pFmt == '%' )
      {
         bufadd( &buffer, pFmt++, 1 );
         continue;
      }

      iWidth = iDec = -1;
      fLeftAlign = fForceSign = fPadZero = fSpaceSign = 0;

      /* parse parameter number */
      iParamNo = 0;
      while( HB_ISDIGIT( *pFmt ) )
         iParamNo = iParamNo * 10 + *pFmt++ - '0';

      if( iParamNo > 0 && *pFmt == '$' )
      {
         pFmt++;
      }
      else
      {
         iParamNo = -1;
         pFmt = pFmtSave + 1;
      }

      /* Parse flags */
      do
      {
         switch( *pFmt )
         {
            case '-':
               fLeftAlign = 1;
               continue;
            case '+':
               fForceSign = 1;
               continue;
            case ' ':
               fSpaceSign = 1;
               continue;
            case '0':
               fPadZero = 1;
               continue;
         }
         break;
      }
      while( *++pFmt );

      /* Parse width */
      if( HB_ISDIGIT( *pFmt ) )
      {
         iWidth = 0;
         while( HB_ISDIGIT( *pFmt ) )
            iWidth = iWidth * 10 + *pFmt++ - '0';
      }

      /* Parse decimals */
      if( *pFmt == '.' )
      {
         pFmt++;
         iDec = 0;
         if( HB_ISDIGIT( *pFmt ) )
         {
            while( HB_ISDIGIT( *pFmt ) )
               iDec = iDec * 10 + *pFmt++ - '0';
         }
      }

      /* Parse specifier */
      if( *pFmt == 'c' || *pFmt == 'd' || *pFmt == 'x' || *pFmt == 'X' ||
          *pFmt == 'f' || *pFmt == 's' || *pFmt == 't' )
      {
         if( iParamNo == -1 )
            iParamNo = ++iParam;

         pItem = ( iParamNo > iCount ) ? NULL : pItemArray[ iParamNo - 1 ];
      }
      else
         pItem = NULL;

      switch( *pFmt )
      {
         case 'c':
         {
            char  buf[ 1 ];

            buf[ 0 ] = ( char ) hb_itemGetNI( pItem );
            if( fLeftAlign )
            {
               bufadd( &buffer, buf, 1 );
            }
            if( iWidth > 1 )
            {
               for( i = 1; i < iWidth; i++ )
                  bufadd( &buffer, " ", 1 );
            }
            if( ! fLeftAlign )
            {
               bufadd( &buffer, buf, 1 );
            }
            break;
         }
         case 'd':
         case 'x':
         case 'X':
         {
            char  * pStr = NULL;
            const char * pStr2;
            int   iSize, iExtra;

            fSign = 0;
            if( pItem && HB_IS_NUMERIC( pItem ) )
            {
               iSize = sizeof( HB_MAXINT ) * 3 + 1;
               pStr2 = pStr = ( char * ) hb_xgrab( iSize + 1 );
               if( *pFmt == 'd' )
                  hb_itemStrBuf( pStr, pItem, iSize, 0 );
               else
                  hb_itemHexStr( pItem, pStr, *pFmt == 'X' );

               while( *pStr2 == ' ' )
                  pStr2++;
               iSize = ( int ) strlen( pStr2 );
               if( *pStr2 == '-' )
               {
                  fSign = 1;
                  iSize--;
                  pStr2++;
               }
            }
            else if( pItem && HB_IS_LOGICAL( pItem ) )
            {
               iSize = 1;
               if( hb_itemGetL( pItem ) )
                  pStr2 = "1";
               else
                  pStr2 = "0";
            }
            else
            {
               iSize = 1;
               pStr2 = "0";
            }

            iExtra = 0;
            if( fForceSign || fSpaceSign || fSign )
               iExtra = 1;

            /* If decimals is set, zero padding flag is ignored */
            if( iDec >= 0 )
               fPadZero = 0;

            if( fLeftAlign )
            {
               /* Zero padding is ignored on left Align */
               /* ForceSign has priority over SpaceSign */
               if( fSign )
                  bufadd( &buffer, "-", 1 );
               else if( fForceSign )
                  bufadd( &buffer, "+", 1 );
               else if( fSpaceSign )
                  bufadd( &buffer, " ", 1 );

               for( i = iSize; i < iDec; i++ )
                  bufadd( &buffer, "0", 1 );

               bufadd( &buffer, pStr2, ( HB_SIZE ) iSize );
               if( iDec > iSize )
                  iSize = iDec;
               for( i = iSize + iExtra; i < iWidth; i++ )
                  bufadd( &buffer, " ", 1 );
            }
            else
            {
               /* Right align */
               if( fPadZero )
               {
                  /* ForceSign has priority over SpaceSign */
                  if( fSign )
                     bufadd( &buffer, "-", 1 );
                  else if( fForceSign )
                     bufadd( &buffer, "+", 1 );
                  else if( fSpaceSign )
                     bufadd( &buffer, " ", 1 );

                  for( i = iSize + iExtra; i < iWidth; i++ )
                     bufadd( &buffer, "0", 1 );

                  bufadd( &buffer, pStr2, strlen( pStr2 ) );
               }
               else
               {
                  for( i = ( iSize > iDec ? iSize : iDec ) + iExtra; i < iWidth; i++ )
                     bufadd( &buffer, " ", 1 );

                  /* ForceSign has priority over SpaceSign */
                  if( fSign )
                     bufadd( &buffer, "-", 1 );
                  else if( fForceSign )
                     bufadd( &buffer, "+", 1 );
                  else if( fSpaceSign )
                     bufadd( &buffer, " ", 1 );

                  for( i = iSize; i < iDec; i++ )
                     bufadd( &buffer, "0", 1 );

                  bufadd( &buffer, pStr2, ( HB_SIZE ) iSize );
               }
            }

            if( pStr )
               hb_xfree( pStr );
            break;
         }

         case 'f':
         {
            char  * pStr = NULL;
            const char * pStr2;
            int   iSize, iExtra, iD;

            if( pItem && HB_IS_NUMERIC( pItem ) )
            {
               hb_itemGetNLen( pItem, &iSize, &iD );

               if( iDec != -1 )
               {
                  iSize += iDec - iD + 1;
                  iD = iDec;
               }

               /* Let 255 be a limit for number length */
               if( iSize > 255 )
                  iSize = 255;
               if( iD > 253 )
                  iD = 253;
               if( iSize < iD + 2 )
                  iSize = iD + 2;

               pStr2 = pStr = ( char * ) hb_xgrab( iSize + 1 );
               hb_itemStrBuf( pStr, pItem, iSize, iD );

               if( pStr[ 0 ] == '*' && iSize < 255 )
               {
                  pStr2 = pStr = ( char * ) hb_xrealloc( pStr, 256 );
                  hb_itemStrBuf( pStr, pItem, 255, iD );
               }
               while( *pStr2 == ' ' )
                  pStr2++;
               iSize = ( int ) strlen( pStr2 );
            }
            else
            {
               iSize = 1;
               pStr2 = "0";
            }

            iExtra = 0;
            if( ( fForceSign || fSpaceSign ) && *pStr2 != '-' )
               iExtra = 1;

            if( fLeftAlign )
            {
               /* Zero padding is ignored on left Align */
               if( *pStr2 != '-' )
               {
                  /* ForceSign has priority over SpaceSign */
                  if( fForceSign )
                     bufadd( &buffer, "+", 1 );
                  else
                  {
                     if( fSpaceSign )
                        bufadd( &buffer, " ", 1 );
                  }
               }
               bufadd( &buffer, pStr2, ( HB_SIZE ) iSize );
               for( i = iSize + iExtra; i < iWidth; i++ )
                  bufadd( &buffer, " ", 1 );
            }
            else
            {
               /* Right align */
               if( fPadZero )
               {
                  if( *pStr2 == '-' )
                  {
                     bufadd( &buffer, pStr2++, 1 );
                  }
                  else
                  {
                     /* ForceSign has priority over SpaceSign */
                     if( fForceSign )
                        bufadd( &buffer, "+", 1 );
                     else
                     {
                        if( fSpaceSign )
                           bufadd( &buffer, " ", 1 );
                     }
                  }
                  for( i = iSize + iExtra; i < iWidth; i++ )
                     bufadd( &buffer, "0", 1 );

                  bufadd( &buffer, pStr2, strlen( pStr2 ) );
               }
               else
               {
                  for( i = iSize + iExtra; i < iWidth; i++ )
                     bufadd( &buffer, " ", 1 );

                  if( *pStr2 != '-' )
                  {
                     /* ForceSign has priority over SpaceSign */
                     if( fForceSign )
                        bufadd( &buffer, "+", 1 );
                     else
                     {
                        if( fSpaceSign )
                           bufadd( &buffer, " ", 1 );
                     }
                  }
                  bufadd( &buffer, pStr2, ( HB_SIZE ) iSize );
               }
            }

            if( pStr )
               hb_xfree( pStr );
            break;
         }

         case 't': //27.07.2021
         {
            if( pItem && HB_IS_NUMERIC( pItem ) )
            {
               const char * pStr = NULL;
               HB_ISIZ nSize = hb_itemGetNS( pItem );
               //printf("%d", nSize);
               if( nSize > 0 )
                  for( i = 0; i < nSize; i++ )
                     bufadd( &buffer, " ", 1 );
            }
            break;
         }

         case 's':
         {
            const char * pStr = hb_itemGetCPtr( pItem );

            nSize = hb_itemGetCLen( pItem );
            if( iDec >= 0 )
            {
               if( ( HB_SIZE ) iDec < nSize )
                  nSize = iDec;
            }
            if( fLeftAlign )
               bufadd( &buffer, pStr, nSize );

            if( iWidth > 1 )
            {
               for( i = ( int ) nSize; i < iWidth; i++ )
                  bufadd( &buffer, " ", 1 );
            }

            if( ! fLeftAlign )
               bufadd( &buffer, pStr, nSize );

            break;
         }

         default:
         {
            bufadd( &buffer, pFmtSave, pFmt - pFmtSave );
            continue;
         }
      }
      pFmt++;
   }

   pItemReturn = hb_itemPutCL( pItemReturn, buffer.pData, buffer.nLen );
   hb_xfree( buffer.pData );
   return pItemReturn;
}

HB_FUNC( HB_STRFORMAT )
{
   PHB_ITEM pFormat = hb_param( 1, HB_IT_STRING );

   if( pFormat )
   {
      int        iParams = hb_pcount();
      PHB_ITEM * pItemArray = NULL;

      if( iParams > 1 )
      {
         int i;
         pItemArray = ( PHB_ITEM * ) hb_xgrab( ( iParams - 1 ) * sizeof( PHB_ITEM ) );
         for( i = 1; i < iParams; i++ )
            pItemArray[ i - 1 ] = hb_param( i + 1, HB_IT_ANY );
      }

      hb_itemReturnRelease( hb_strFormat( NULL, pFormat, iParams - 1, pItemArray ) );

      if( iParams > 1 )
         hb_xfree( pItemArray );
   }
   else
      hb_errRT_BASE_SubstR( EG_ARG, 1099, NULL, HB_ERR_FUNCNAME, HB_ERR_ARGS_BASEPARAMS );
}

/*
function main()
   a := Array(10)
   afill(a, "VILMAR")
   ? hb_strformat("%s %t %s", "ITEM", 8, "VALOR")
   ? hb_strformat("%s", Repl("=",20))
   for i := 1 to Len(a)
      ? hb_strformat("%05d%t%s", i, 8, a[i] + '-' + StrZero(i, 5))
  next
*/

/*
 * The Console API
 * hb/src/rtl/console.c
 */

#include "hbapi.h"
#include "hbapicdp.h"
#include "hbapiitm.h"
#include "hbapifs.h"
#include "hbapierr.h"
#include "hbapigt.h"
#include "hbstack.h"
#include "hbset.h"
#include "hb_io.h"

#if defined( HB_OS_WIN )
   #include <windows.h>
   #if defined( HB_OS_WIN_CE )
      #include "hbwince.h"
   #endif
#endif

/* NOTE: Some C compilers like Borland C optimize the call of small static buffers
 *       into an integer to read it faster. Later, programs like CodeGuard
 *       complain if the given buffer was smaller than an int. [ckedem]
 */

/* length of buffer for CR/LF characters */
#if ! defined( HB_OS_EOL_LEN ) || HB_OS_EOL_LEN < 4
#  define CRLF_BUFFER_LEN  4
#else
#  define CRLF_BUFFER_LEN  HB_OS_EOL_LEN + 1
#endif

static const char s_szCR[] = { HB_CHAR_CR, 0 };
static const char s_szLF[] = { HB_CHAR_LF, 0 };
static const char s_szCRLF[] = { HB_CHAR_CR, HB_CHAR_LF, 0 };

#if defined( HB_OS_UNIX ) && ! defined( HB_EOL_CRLF )
   static const char * s_szEOL = s_szLF;
   static const int s_iEOLLen = 1;
#else
   static const char * s_szEOL = s_szCRLF;
   static const int s_iEOLLen = 2;
#endif

static HB_FHANDLE s_hFilenoStdin  = ( HB_FHANDLE ) HB_STDIN_HANDLE;
static HB_FHANDLE s_hFilenoStdout = ( HB_FHANDLE ) HB_STDOUT_HANDLE;
static HB_FHANDLE s_hFilenoStderr = ( HB_FHANDLE ) HB_STDERR_HANDLE;

typedef struct
{
   int row;
   int col;
} HB_PRNPOS, * PHB_PRNPOS;

static HB_TSD_NEW( s_prnPos, sizeof( HB_PRNPOS ), NULL, NULL );

static PHB_PRNPOS hb_prnPos( void )
{
   return ( PHB_PRNPOS ) hb_stackGetTSD( &s_prnPos );
}

void hb_conInit( void )
{
   HB_TRACE( HB_TR_DEBUG, ( "hb_conInit()" ) );

#if ! defined( HB_OS_WIN )
   /* On Windows file handles with numbers 0, 1, 2 are
      translated inside filesys to:
      GetStdHandle( STD_INPUT_HANDLE ), GetStdHandle( STD_OUTPUT_HANDLE ),
      GetStdHandle( STD_ERROR_HANDLE ) */

   s_hFilenoStdin  = fileno( stdin );
   s_hFilenoStdout = fileno( stdout );
   s_hFilenoStderr = fileno( stderr );

#endif

#ifdef HB_CLP_UNDOC
   {
      /* Undocumented CA-Cl*pper switch //STDERR:x */
      int iStderr = hb_cmdargNum( "STDERR" );

      if( iStderr == 0 || iStderr == 1 )  /* //STDERR with no parameter or 0 */
         s_hFilenoStderr = s_hFilenoStdout;
      /* disabled in default builds. It's not multi-platform and very
       * dangerous because it can redirect error messages to data files
       * [druzus]
       */
#ifdef HB_CLP_STRICT
      else if( iStderr > 0 ) /* //STDERR:x */
         s_hFilenoStderr = ( HB_FHANDLE ) iStderr;
#endif
   }
#endif

   /*
    * Some compilers open stdout and stderr in text mode, but
    * Harbour needs them to be open in binary mode.
    */
   hb_fsSetDevMode( s_hFilenoStdin,  FD_BINARY );
   hb_fsSetDevMode( s_hFilenoStdout, FD_BINARY );
   hb_fsSetDevMode( s_hFilenoStderr, FD_BINARY );

   if( hb_gtInit( s_hFilenoStdin, s_hFilenoStdout, s_hFilenoStderr ) != HB_SUCCESS )
      hb_errInternal( 9995, "Harbour terminal (GT) initialization failure", NULL, NULL );

   if( hb_cmdargCheck( "INFO" ) )
   {
      hb_conOutErr( hb_gtVersion( 1 ), 0 );
      hb_conOutErr( hb_conNewLine(), 0 );
   }
}

void hb_conRelease( void )
{
   HB_TRACE( HB_TR_DEBUG, ( "hb_conRelease()" ) );

   /*
    * Clipper does not restore screen size on exit so I removed the code with:
    *    hb_gtSetMode( s_originalMaxRow + 1, s_originalMaxCol + 1 );
    * If the low-level GT drive change some video adapter parameters which
    * have to be restored on exit then it should does it in its Exit()
    * method. Here we cannot force any actions because it may cause bad
    * results in some GTs, e.g. when the screen size is controlled by remote
    * user and not Harbour application (some terminal modes), [Druzus]
    */

   hb_gtExit();

   hb_fsSetDevMode( s_hFilenoStdin,  FD_TEXT );
   hb_fsSetDevMode( s_hFilenoStdout, FD_TEXT );
   hb_fsSetDevMode( s_hFilenoStderr, FD_TEXT );
}

const char * hb_conNewLine( void )
{
   HB_TRACE( HB_TR_DEBUG, ( "hb_conNewLine()" ) );

   return s_szEOL;
}

HB_FUNC( HB_EOL )
{
   hb_retc_const( s_szEOL );
}

#if defined( HB_LEGACY_LEVEL4 )

/* Deprecated */
HB_FUNC( HB_OSNEWLINE )
{
   hb_retc_const( s_szEOL );
}

#endif

HB_FUNC( HB_STREOL )
{
   HB_SIZE nLen = hb_parclen( 1 );

   HB_SIZE nCR = 0;
   HB_SIZE nLF = 0;

   const char * szEOL = s_szEOL;

   if( nLen > 0 )
   {
      const char * szText = hb_parc( 1 );

      do
      {
         switch( *szText++ )
         {
         case HB_CHAR_CR:
            ++nCR;
            break;
         case HB_CHAR_LF:
            ++nLF;
            break;
         }
      }
      while( --nLen );

      if( nLF )
      {
         if( nCR == 0 )
            szEOL = s_szLF;
         else if( nCR == nLF )
            szEOL = s_szCRLF;
      }
      else if( nCR )
         szEOL = s_szCR;
   }

   hb_retc_const( szEOL );
}

/* Output an item to STDOUT */
void hb_conOutStd( const char * szStr, HB_SIZE nLen )
{
   HB_TRACE( HB_TR_DEBUG, ( "hb_conOutStd(%s, %" HB_PFS "u)", szStr, nLen ) );

   if( nLen == 0 )
      nLen = strlen( szStr );

   if( nLen > 0 )
      hb_gtOutStd( szStr, nLen );
}

/* Output an item to STDERR */
void hb_conOutErr( const char * szStr, HB_SIZE nLen )
{
   HB_TRACE( HB_TR_DEBUG, ( "hb_conOutErr(%s, %" HB_PFS "u)", szStr, nLen ) );

   if( nLen == 0 )
      nLen = strlen( szStr );

   if( nLen > 0 )
      hb_gtOutErr( szStr, nLen );
}

/* Output an item to the screen and/or printer and/or alternate */
void hb_conOutAlt( const char * szStr, HB_SIZE nLen )
{
   PHB_FILE pFile;

   HB_TRACE( HB_TR_DEBUG, ( "hb_conOutAlt(%s, %" HB_PFS "u)", szStr, nLen ) );

   if( hb_setGetConsole() )
      hb_gtWriteCon( szStr, nLen );

   if( hb_setGetAlternate() && ( pFile = hb_setGetAltHan() ) != NULL )
   {
      /* Print to alternate file if SET ALTERNATE ON and valid alternate file */
      hb_fileWrite( pFile, szStr, nLen, -1 );
   }

   if( ( pFile = hb_setGetExtraHan() ) != NULL )
   {
      /* Print to extra file if valid alternate file */
      hb_fileWrite( pFile, szStr, nLen, -1 );
   }

   if( ( pFile = hb_setGetPrinterHandle( HB_SET_PRN_CON ) ) != NULL )
   {
      /* Print to printer if SET PRINTER ON and valid printer file */
      hb_fileWrite( pFile, szStr, nLen, -1 );
      hb_prnPos()->col += ( int ) nLen;
   }
}

/* Output an item to the screen and/or printer */
static void hb_conOutDev( const char * szStr, HB_SIZE nLen )
{
   PHB_FILE pFile;

   HB_TRACE( HB_TR_DEBUG, ( "hb_conOutDev(%s, %" HB_PFS "u)", szStr, nLen ) );

   if( ( pFile = hb_setGetPrinterHandle( HB_SET_PRN_DEV ) ) != NULL )
   {
      /* Display to printer if SET DEVICE TO PRINTER and valid printer file */
      hb_fileWrite( pFile, szStr, nLen, -1 );
      hb_prnPos()->col += ( int ) nLen;
   }
   else
      /* Otherwise, display to console */
      hb_gtWrite( szStr, nLen );
}

static char * hb_itemStringCon( PHB_ITEM pItem, HB_SIZE * pnLen, HB_BOOL * pfFreeReq )
{
   /* logical values in device output (not console, stdout or stderr) are
      shown as single letter */
   if( HB_IS_LOGICAL( pItem ) )
   {
      *pnLen = 1;
      *pfFreeReq = HB_FALSE;
      return ( char * ) ( hb_itemGetL( pItem ) ? "T" : "F" );
   }
   return hb_itemString( pItem, pnLen, pfFreeReq );
}

HB_FUNC( OUTSTD ) /* writes a list of values to the standard output device */
{
   int iPCount = hb_pcount(), iParam;

   for( iParam = 1; iParam <= iPCount; iParam++ )
   {
      char * pszString;
      HB_SIZE nLen;
      HB_BOOL fFree;

      if( iParam > 1 )
         hb_conOutStd( " ", 1 );
      pszString = hb_itemString( hb_param( iParam, HB_IT_ANY ), &nLen, &fFree );
      if( nLen )
         hb_conOutStd( pszString, nLen );
      if( fFree )
         hb_xfree( pszString );
   }
}

HB_FUNC( OUTERR ) /* writes a list of values to the standard error device */
{
   int iPCount = hb_pcount(), iParam;

   for( iParam = 1; iParam <= iPCount; iParam++ )
   {
      char * pszString;
      HB_SIZE nLen;
      HB_BOOL fFree;

      if( iParam > 1 )
         hb_conOutErr( " ", 1 );
      pszString = hb_itemString( hb_param( iParam, HB_IT_ANY ), &nLen, &fFree );
      if( nLen )
         hb_conOutErr( pszString, nLen );
      if( fFree )
         hb_xfree( pszString );
   }
}

HB_FUNC( QQOUT ) /* writes a list of values to the current device (screen or printer) and is affected by SET ALTERNATE */
{
   int iPCount = hb_pcount(), iParam;

   for( iParam = 1; iParam <= iPCount; iParam++ )
   {
      char * pszString;
      HB_SIZE nLen;
      HB_BOOL fFree;

      if( iParam > 1 )
         hb_conOutAlt( " ", 1 );
      pszString = hb_itemString( hb_param( iParam, HB_IT_ANY ), &nLen, &fFree );
      if( nLen )
         hb_conOutAlt( pszString, nLen );
      if( fFree )
         hb_xfree( pszString );
   }
}

HB_FUNC( QOUT )
{
   PHB_FILE pFile;

   hb_conOutAlt( s_szEOL, s_iEOLLen );

   if( ( pFile = hb_setGetPrinterHandle( HB_SET_PRN_CON ) ) != NULL )
   {
      PHB_PRNPOS pPrnPos = hb_prnPos();

      pPrnPos->row++;
      pPrnPos->col = hb_setGetMargin();

      if( pPrnPos->col )
      {
         char buf[ 256 ];

         if( pPrnPos->col > ( int ) sizeof( buf ) )
         {
            char * pBuf = ( char * ) hb_xgrab( pPrnPos->col );
            memset( pBuf, ' ', pPrnPos->col );
            hb_fileWrite( pFile, pBuf, ( HB_USHORT ) pPrnPos->col, -1 );
            hb_xfree( pBuf );
         }
         else
         {
            memset( buf, ' ', pPrnPos->col );
            hb_fileWrite( pFile, buf, ( HB_USHORT ) pPrnPos->col, -1 );
         }
      }
   }

   HB_FUNC_EXEC( QQOUT );
}

HB_FUNC( __EJECT ) /* Ejects the current page from the printer */
{
   PHB_PRNPOS pPrnPos;
   PHB_FILE pFile;

   if( ( pFile = hb_setGetPrinterHandle( HB_SET_PRN_ANY ) ) != NULL )
   {
      static const char s_szEop[ 4 ] = { 0x0C, 0x0D, 0x00, 0x00 }; /* Buffer is 4 bytes to make CodeGuard happy */
      hb_fileWrite( pFile, s_szEop, 2, -1 );
   }

   pPrnPos = hb_prnPos();
   pPrnPos->row = pPrnPos->col = 0;
}

HB_FUNC( PROW ) /* Returns the current printer row position */
{
   hb_retni( ( int ) hb_prnPos()->row );
}

HB_FUNC( PCOL ) /* Returns the current printer row position */
{
   hb_retni( ( int ) hb_prnPos()->col );
}

static void hb_conDevPos( int iRow, int iCol )
{
   PHB_FILE pFile;

   HB_TRACE( HB_TR_DEBUG, ( "hb_conDevPos(%d, %d)", iRow, iCol ) );

   /* Position printer if SET DEVICE TO PRINTER and valid printer file
      otherwise position console */

   if( ( pFile = hb_setGetPrinterHandle( HB_SET_PRN_DEV ) ) != NULL )
   {
      int iPRow = iRow;
      int iPCol = iCol + hb_setGetMargin();
      PHB_PRNPOS pPrnPos = hb_prnPos();

      if( pPrnPos->row != iPRow || pPrnPos->col != iPCol )
      {
         char buf[ 256 ];
         int iPtr = 0;

         if( pPrnPos->row != iPRow )
         {
            if( ++pPrnPos->row > iPRow )
            {
               memcpy( &buf[ iPtr ], "\x0C\x0D\x00\x00", 2 );  /* Source buffer is 4 bytes to make CodeGuard happy */
               iPtr += 2;
               pPrnPos->row = 0;
            }
            else
            {
               memcpy( &buf[ iPtr ], s_szEOL, s_iEOLLen );
               iPtr += s_iEOLLen;
            }

            while( pPrnPos->row < iPRow )
            {
               if( iPtr + s_iEOLLen > ( int ) sizeof( buf ) )
               {
                  hb_fileWrite( pFile, buf, ( HB_USHORT ) iPtr, -1 );
                  iPtr = 0;
               }
               memcpy( &buf[ iPtr ], s_szEOL, s_iEOLLen );
               iPtr += s_iEOLLen;
               ++pPrnPos->row;
            }
            pPrnPos->col = 0;
         }
         else if( pPrnPos->col > iPCol )
         {
            buf[ iPtr++ ] = '\x0D';
            pPrnPos->col = 0;
         }

         while( pPrnPos->col < iPCol )
         {
            if( iPtr == ( int ) sizeof( buf ) )
            {
               hb_fileWrite( pFile, buf, ( HB_USHORT ) iPtr, -1 );
               iPtr = 0;
            }
            buf[ iPtr++ ] = ' ';
            ++pPrnPos->col;
         }

         if( iPtr )
            hb_fileWrite( pFile, buf, ( HB_USHORT ) iPtr, -1 );
      }
   }
   else
      hb_gtSetPos( iRow, iCol );
}

/* NOTE: This should be placed after the hb_conDevPos() definition. */

HB_FUNC( DEVPOS ) /* Sets the screen and/or printer position */
{
   if( HB_ISNUM( 1 ) && HB_ISNUM( 2 ) )
      hb_conDevPos( hb_parni( 1 ), hb_parni( 2 ) );

#if defined( HB_CLP_UNDOC )
   /* NOTE: Both 5.2e and 5.3 does that, while the documentation
            says it will return NIL. [vszakats] */
   hb_itemReturn( hb_param( 1, HB_IT_ANY ) );
#endif
}

HB_FUNC( SETPRC ) /* Sets the current printer row and column positions */
{
   if( hb_pcount() == 2 && HB_ISNUM( 1 ) && HB_ISNUM( 2 ) )
   {
      PHB_PRNPOS pPrnPos = hb_prnPos();
      pPrnPos->row = hb_parni( 1 );
      pPrnPos->col = hb_parni( 2 );
   }
}

HB_FUNC( DEVOUT ) /* writes a single value to the current device (screen or printer), but is not affected by SET ALTERNATE */
{
   char * pszString;
   HB_SIZE nLen;
   HB_BOOL fFree;

   if( HB_ISCHAR( 2 ) )
   {
      char szOldColor[ HB_CLRSTR_LEN ];

      hb_gtGetColorStr( szOldColor );
      hb_gtSetColorStr( hb_parc( 2 ) );

      pszString = hb_itemStringCon( hb_param( 1, HB_IT_ANY ), &nLen, &fFree );
      if( nLen )
         hb_conOutDev( pszString, nLen );
      if( fFree )
         hb_xfree( pszString );

      hb_gtSetColorStr( szOldColor );
   }
   else if( hb_pcount() >= 1 )
   {
      pszString = hb_itemStringCon( hb_param( 1, HB_IT_ANY ), &nLen, &fFree );
      if( nLen )
         hb_conOutDev( pszString, nLen );
      if( fFree )
         hb_xfree( pszString );
   }
}

HB_FUNC( DISPOUT ) /* writes a single value to the screen, but is not affected by SET ALTERNATE */
{
   char * pszString;
   HB_SIZE nLen;
   HB_BOOL bFreeReq;

   if( HB_ISCHAR( 2 ) )
   {
      char szOldColor[ HB_CLRSTR_LEN ];

      hb_gtGetColorStr( szOldColor );
      hb_gtSetColorStr( hb_parc( 2 ) );

      pszString = hb_itemStringCon( hb_param( 1, HB_IT_ANY ), &nLen, &bFreeReq );

      hb_gtWrite( pszString, nLen );

      if( bFreeReq )
         hb_xfree( pszString );

      hb_gtSetColorStr( szOldColor );
   }
   else if( hb_pcount() >= 1 )
   {
      pszString = hb_itemStringCon( hb_param( 1, HB_IT_ANY ), &nLen, &bFreeReq );

      hb_gtWrite( pszString, nLen );

      if( bFreeReq )
         hb_xfree( pszString );
   }
}

/* Undocumented Clipper function */

/* NOTE: Clipper does no checks about the screen positions. [vszakats] */

HB_FUNC( DISPOUTAT )  /* writes a single value to the screen at specific position, but is not affected by SET ALTERNATE */
{
   char * pszString;
   HB_SIZE nLen;
   HB_BOOL bFreeReq;

   if( HB_ISCHAR( 4 ) )
   {
      char szOldColor[ HB_CLRSTR_LEN ];

      hb_gtGetColorStr( szOldColor );
      hb_gtSetColorStr( hb_parc( 4 ) );

      pszString = hb_itemStringCon( hb_param( 3, HB_IT_ANY ), &nLen, &bFreeReq );

      hb_gtWriteAt( hb_parni( 1 ), hb_parni( 2 ), pszString, nLen );

      if( bFreeReq )
         hb_xfree( pszString );

      hb_gtSetColorStr( szOldColor );
   }
   else if( hb_pcount() >= 3 )
   {
      pszString = hb_itemStringCon( hb_param( 3, HB_IT_ANY ), &nLen, &bFreeReq );

      hb_gtWriteAt( hb_parni( 1 ), hb_parni( 2 ), pszString, nLen );

      if( bFreeReq )
         hb_xfree( pszString );
   }
}

/* Harbour extension, works like DispOutAt() but does not change cursor position */

HB_FUNC( HB_DISPOUTAT )
{
   if( hb_pcount() >= 3 )
   {
      char * pszString;
      HB_SIZE nLen;
      HB_BOOL bFreeReq;
      int iColor;

      pszString = hb_itemStringCon( hb_param( 3, HB_IT_ANY ), &nLen, &bFreeReq );

      if( HB_ISCHAR( 4 ) )
         iColor = hb_gtColorToN( hb_parc( 4 ) );
      else if( HB_ISNUM( 4 ) )
         iColor = hb_parni( 4 );
      else
         iColor = -1;

      hb_gtPutText( hb_parni( 1 ), hb_parni( 2 ), pszString, nLen, iColor );

      if( bFreeReq )
         hb_xfree( pszString );
   }
}

/* Same as hb_DispOutAt(), but draws with the attribute HB_GT_ATTR_BOX,
   so we can use it to draw graphical elements. */
HB_FUNC( HB_DISPOUTATBOX )
{
   HB_SIZE nLen = hb_parclen( 3 );

   if( nLen > 0 )
   {
      int iRow = hb_parni( 1 );
      int iCol = hb_parni( 2 );
      const char * pszString = hb_parc( 3 );
      int iColor;
      PHB_CODEPAGE cdp;
      HB_SIZE nIndex = 0;
      HB_WCHAR wc;

      if( HB_ISCHAR( 4 ) )
         iColor = hb_gtColorToN( hb_parc( 4 ) );
      else if( HB_ISNUM( 4 ) )
         iColor = hb_parni( 4 );
      else
         iColor = hb_gtGetCurrColor();

      cdp = hb_gtBoxCP();

      while( HB_CDPCHAR_GET( cdp, pszString, nLen, &nIndex, &wc ) )
         hb_gtPutChar( iRow, iCol++, iColor, HB_GT_ATTR_BOX, wc );

      hb_gtFlush();
   }
}

HB_FUNC( HB_GETSTDIN ) /* Return handle for STDIN */
{
   hb_retnint( ( HB_NHANDLE ) s_hFilenoStdin );
}

HB_FUNC( HB_GETSTDOUT ) /* Return handle for STDOUT */
{
   hb_retnint( ( HB_NHANDLE ) s_hFilenoStdout );
}

HB_FUNC( HB_GETSTDERR ) /* Return handle for STDERR */
{
   hb_retnint( ( HB_NHANDLE ) s_hFilenoStderr );
}

/*
 * The CodePages API
*/

#include "hbapi.h"
#include "hbapiitm.h"
#include "hbapierr.h"
#include "hbapicdp.h"
#include "hbapifs.h"
#include "hbapigt.h"
#include "hbstack.h"
#include "hbset.h"
#include "hb_io.h"

HB_FUNC( HB_CDPSELECT )
{
   const char * id = hb_parc( 1 );

   hb_retc( hb_cdpID() );

   if( id )
      hb_cdpSelectID( id );
}

HB_FUNC( HB_CDPEXISTS )
{
   const char * id = hb_parc( 1 );

   if( id )
      hb_retl( hb_cdpFind( id ) != NULL );
   else
      hb_errRT_BASE_SubstR( EG_ARG, 3012, NULL, HB_ERR_FUNCNAME, HB_ERR_ARGS_BASEPARAMS );
}

HB_FUNC( HB_CDPUNIID )
{
   const char * id = hb_parc( 1 );
   PHB_CODEPAGE cdp = id ? hb_cdpFindExt( id ) : hb_vmCDP();

   hb_retc( cdp ? cdp->uniTable->uniID : NULL );
}

HB_FUNC( HB_CDPINFO )
{
   const char * id = hb_parc( 1 );
   PHB_CODEPAGE cdp = id ? hb_cdpFindExt( id ) : hb_vmCDP();

   hb_retc( cdp ? cdp->info : NULL );
}

HB_FUNC( HB_CDPISCHARIDX )
{
   const char * id = hb_parc( 1 );
   PHB_CODEPAGE cdp = id ? hb_cdpFindExt( id ) : hb_vmCDP();
   HB_BOOL fResult = HB_FALSE;

   if( cdp )
   {
      fResult = HB_CDP_ISCHARIDX( cdp );
      if( HB_CDP_ISCUSTOM( cdp ) && HB_ISLOG( 2 ) )
      {
         if( hb_parl( 2 ) )
            cdp->type |= HB_CDP_TYPE_CHARIDX;
         else
            cdp->type &= ~HB_CDP_TYPE_CHARIDX;
      }
   }
   hb_retl( fResult );
}

HB_FUNC( HB_CDPCHARMAX )
{
   hb_retnl( ( 1 << ( ( int ) ( hb_cdpIsUTF8( hb_cdpFindExt( hb_parc( 1 ) ) ) ? sizeof( HB_WCHAR ) : sizeof( HB_UCHAR ) ) * 8 ) ) - 1 );
}

HB_FUNC( HB_CDPISUTF8 )
{
   hb_retl( hb_cdpIsUTF8( hb_cdpFindExt( hb_parc( 1 ) ) ) );
}

HB_FUNC( HB_CDPLIST )
{
   const char ** list = hb_cdpList();
   HB_ISIZ nPos;

   nPos = 0;
   while( list[ nPos ] )
      ++nPos;

   hb_reta( nPos );

   nPos = 0;
   while( list[ nPos ] )
   {
      hb_storvc( list[ nPos ], -1, nPos + 1 );
      ++nPos;
   }

   hb_xfree( ( void * ) list );
}

/* NOTE: CA-Cl*pper 5.2e Intl. will return: "NATSORT v1.2i x14 19/Mar/93" */
/* NOTE: CA-Cl*pper 5.3  Intl. will return: "NATSORT v1.3i x19 06/Mar/95" */
HB_FUNC_TRANSLATE( __NATSORTVER, HB_CDPINFO )

/*
 * extended CP PRG functions
 */
HB_FUNC( HB_TRANSLATE )
{
   HB_SIZE nLen = hb_parclen( 1 );
   const char * szIdIn = hb_parc( 2 );
   const char * szIdOut = hb_parc( 3 );

   if( nLen && ( szIdIn || szIdOut ) )
   {
      PHB_CODEPAGE cdpIn = szIdIn ? hb_cdpFindExt( szIdIn ) : hb_vmCDP();
      PHB_CODEPAGE cdpOut = szIdOut ? hb_cdpFindExt( szIdOut ) : hb_vmCDP();

      if( cdpIn && cdpOut && cdpIn != cdpOut &&
          ( cdpIn->uniTable != cdpOut->uniTable ||
            HB_CDP_ISCUSTOM( cdpIn ) ||
            HB_CDP_ISCUSTOM( cdpOut ) ) )
      {
         char * szResult = hb_cdpnDup( hb_parc( 1 ), &nLen, cdpIn, cdpOut );
         hb_retclen_buffer( szResult, nLen );
      }
      else
         hb_itemReturn( hb_param( 1, HB_IT_STRING ) );
   }
   else
      hb_retc_null();
}

HB_FUNC( HB_STRTOUTF8 )
{
   HB_SIZE nLen = hb_parclen( 1 ), nDest = 0;
   char * szDest = NULL;

   if( nLen )
   {
      const char * szCP = hb_parc( 2 );
      PHB_CODEPAGE cdp = szCP ? hb_cdpFindExt( szCP ) : hb_vmCDP();

      if( cdp )
      {
         if( hb_cdpIsUTF8( cdp ) )
         {
            hb_itemReturn( hb_param( 1, HB_IT_STRING ) );
            return;
         }
         else
         {
            const char * szString = hb_parc( 1 );
            nDest = hb_cdpStrAsUTF8Len( cdp, szString, nLen, 0 );
            szDest = ( char * ) hb_xgrab( nDest + 1 );
            hb_cdpStrToUTF8( cdp, szString, nLen, szDest, nDest + 1 );
         }
      }
   }
   if( szDest )
      hb_retclen_buffer( szDest, nDest );
   else
      hb_retc_null();
}

HB_FUNC( HB_UTF8TOSTR )
{
   const char *szString = hb_parc(1);;
   const char *pFmt;
   PHB_ITEM pItem = hb_param(1, HB_IT_ANY);
   pFmt           = hb_itemGetCPtr( pItem );
   HB_SIZE nLen;
   HB_BOOL fFree;
   
   if( HB_ISCHAR(1)){
      szString = hb_parc(1);
   }
   else
   {
      if( HB_IS_NUMERIC(pItem))
      {
         PHB_ITEM pNumber = hb_param(1, HB_IT_NUMERIC );
         PHB_ITEM pWidth  = NULL;
         PHB_ITEM pDec    = NULL;
         char *szResult   = hb_itemStr( pNumber, pWidth, pDec ); 
         if( szResult )
            hb_retc_buffer( szResult );
         else
         {
            hb_retc_null();
            hb_errRT_BASE_SubstR( EG_ARG, 3012, NULL, HB_ERR_FUNCNAME, HB_ERR_ARGS_BASEPARAMS );
         }
         return;
      }
   }
   
   if( szString )
   {
      HB_SIZE nLen = hb_parclen( 1 ), nDest = 0;
      char * szDest = NULL;

      if( nLen )
      {
         const char * szCP = hb_parc( 2 );
         PHB_CODEPAGE cdp = szCP ? hb_cdpFindExt( szCP ) : hb_vmCDP();

         if( cdp )
         {
            if( hb_cdpIsUTF8( cdp ) )
            {
               hb_itemReturn( hb_param( 1, HB_IT_STRING ) );
               return;
            }
            else
            {
               szString = hb_parc( 1 );
               nDest = hb_cdpUTF8AsStrLen( cdp, szString, nLen, 0 );
               szDest = ( char * ) hb_xgrab( nDest + 1 );
               hb_cdpUTF8ToStr( cdp, szString, nLen, szDest, nDest + 1 );
            }
         }
      }

      if( szDest )
         hb_retclen_buffer( szDest, nDest );
      else
         hb_retc_null();
   }
   else
      hb_errRT_BASE_SubstR( EG_ARG, 3012, NULL, HB_ERR_FUNCNAME, HB_ERR_ARGS_BASEPARAMS );
}

//==================================================================================================

/*
static int iQuitRequested = 0;
static int iLastSignal = 0;

static void sig_handler( int iSigNo )
{
   iLastSignal = iSigNo;
   hb_vmRequestQuit();
   return;
}

HB_FUNC( HB_LASTSIGNAL )
{
   hb_retni( iLastSignal );
}

HB_FUNC( HB_SETSIGNALS )
{
   struct sigaction act;
   int iSignals[] = { SIGTERM, SIGHUP, SIGQUIT, SIGINT, 0 }, i;

   signal(SIGPIPE, SIG_IGN);

   for( i = 0; iSignals[i]; ++i )
   {
      sigaction( iSignals[i], 0, &act );
      act.sa_handler = sig_handler;
      act.sa_flags = SA_RESTART;
      sigaction( iSignals[i], &act, 0);
   }
}
*/

//==================================================================================================

int main() {
	printf("main()\n");
	printf("chr(65)=%c\n",  chrx(65));
	printf("chr(65)=%c\n",  chrx(asc('A')));
	printf("asc('A')=%d\n", asc('A'));
	printf("asc('A')=%d\n", asc(chrx(65)));
	return 0;
}
