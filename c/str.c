/*
 * Harbour 3.2.0dev (r1607181832)
 * Borland/Embarcadero C++ 7.3 (32-bit)
 * Generated C source from "str.prg"
 */

#include "hbvmpub.h"
#include "hbinit.h"


HB_FUNC( MAIN );
HB_FUNC_EXTERN( TSTRING );
HB_FUNC_EXTERN( HB_LANGSELECT );
HB_FUNC_EXTERN( SCROLL );
HB_FUNC_EXTERN( SETPOS );
HB_FUNC_EXTERN( QOUT );
HB_FUNC_EXTERN( HB_VERSION );
HB_FUNC_EXTERN( NETNAME );
HB_FUNC_EXTERN( REPLICATE );
HB_FUNC_EXTERN( HB_KEYSETLAST );
HB_FUNC_EXTERN( HB_KEYCLEAR );
HB_FUNC_EXTERN( HB_KEYLAST );
HB_FUNC_EXTERN( VALTYPE );
HB_FUNC_EXTERN( CAPITALIZE );
HB_FUNC_EXTERN( LEN );
HB_FUNC( LIN );
HB_FUNC_EXTERN( DBFNSX );
HB_FUNC_EXTERN( HB_LANG_PT );


HB_INIT_SYMBOLS_BEGIN( hb_vm_SymbolInit_STR )
{ "MAIN", {HB_FS_PUBLIC | HB_FS_FIRST | HB_FS_LOCAL}, {HB_FUNCNAME( MAIN )}, NULL },
{ "NEW", {HB_FS_PUBLIC | HB_FS_MESSAGE}, {NULL}, NULL },
{ "TSTRING", {HB_FS_PUBLIC}, {HB_FUNCNAME( TSTRING )}, NULL },
{ "HB_LANGSELECT", {HB_FS_PUBLIC}, {HB_FUNCNAME( HB_LANGSELECT )}, NULL },
{ "SCROLL", {HB_FS_PUBLIC}, {HB_FUNCNAME( SCROLL )}, NULL },
{ "SETPOS", {HB_FS_PUBLIC}, {HB_FUNCNAME( SETPOS )}, NULL },
{ "QOUT", {HB_FS_PUBLIC}, {HB_FUNCNAME( QOUT )}, NULL },
{ "HB_VERSION", {HB_FS_PUBLIC}, {HB_FUNCNAME( HB_VERSION )}, NULL },
{ "NETNAME", {HB_FS_PUBLIC}, {HB_FUNCNAME( NETNAME )}, NULL },
{ "REPLICATE", {HB_FS_PUBLIC}, {HB_FUNCNAME( REPLICATE )}, NULL },
{ "HB_KEYSETLAST", {HB_FS_PUBLIC}, {HB_FUNCNAME( HB_KEYSETLAST )}, NULL },
{ "HB_KEYCLEAR", {HB_FS_PUBLIC}, {HB_FUNCNAME( HB_KEYCLEAR )}, NULL },
{ "HB_KEYLAST", {HB_FS_PUBLIC}, {HB_FUNCNAME( HB_KEYLAST )}, NULL },
{ "VALTYPE", {HB_FS_PUBLIC}, {HB_FUNCNAME( VALTYPE )}, NULL },
{ "CHANGED", {HB_FS_PUBLIC | HB_FS_MESSAGE}, {NULL}, NULL },
{ "GET", {HB_FS_PUBLIC | HB_FS_MESSAGE}, {NULL}, NULL },
{ "LEN", {HB_FS_PUBLIC | HB_FS_MESSAGE}, {NULL}, NULL },
{ "VALUE", {HB_FS_PUBLIC | HB_FS_MESSAGE}, {NULL}, NULL },
{ "_SET", {HB_FS_PUBLIC | HB_FS_MESSAGE}, {NULL}, NULL },
{ "TYPE", {HB_FS_PUBLIC | HB_FS_MESSAGE}, {NULL}, NULL },
{ "UPCASE", {HB_FS_PUBLIC | HB_FS_MESSAGE}, {NULL}, NULL },
{ "CAPITALIZE", {HB_FS_PUBLIC | HB_FS_MESSAGE}, {NULL}, NULL },
{ "CAPITALIZE", {HB_FS_PUBLIC}, {HB_FUNCNAME( CAPITALIZE )}, NULL },
{ "LEN", {HB_FS_PUBLIC}, {HB_FUNCNAME( LEN )}, NULL },
{ "DESTROY", {HB_FS_PUBLIC | HB_FS_MESSAGE}, {NULL}, NULL },
{ "LIN", {HB_FS_PUBLIC | HB_FS_LOCAL}, {HB_FUNCNAME( LIN )}, NULL },
{ "DBFNSX", {HB_FS_PUBLIC}, {HB_FUNCNAME( DBFNSX )}, NULL },
{ "HB_LANG_PT", {HB_FS_PUBLIC}, {HB_FUNCNAME( HB_LANG_PT )}, NULL }
HB_INIT_SYMBOLS_EX_END( hb_vm_SymbolInit_STR, "str.prg", 0x0, 0x0003 )

#if defined( HB_PRAGMA_STARTUP )
   #pragma startup hb_vm_SymbolInit_STR
#elif defined( HB_DATASEG_STARTUP )
   #define HB_DATASEG_BODY    HB_DATASEG_FUNC( hb_vm_SymbolInit_STR )
   #include "hbiniseg.h"
#endif

HB_FUNC( MAIN )
{
	static const HB_BYTE pcode[] =
	{
		13,2,0,36,16,0,101,143,194,245,40,92,255,88,
		64,10,2,80,1,36,18,0,48,1,0,176,2,0,
		12,0,112,0,80,2,36,21,0,176,3,0,106,3,
		112,116,0,20,1,36,23,0,176,4,0,20,0,176,
		5,0,121,121,20,2,36,24,0,176,6,0,106,41,
		83,116,114,44,32,67,111,112,121,114,105,103,104,116,
		40,99,41,32,50,48,49,56,44,32,86,105,108,109,
		97,114,32,67,97,116,97,102,101,115,116,97,0,20,
		1,36,25,0,176,6,0,106,18,86,101,114,115,97,
		111,32,72,97,114,98,111,117,114,32,58,32,0,176,
		7,0,121,12,1,20,2,36,26,0,176,6,0,106,
		18,67,111,109,112,105,108,101,114,32,67,43,43,32,
		32,32,58,32,0,176,7,0,122,12,1,20,2,36,
		27,0,176,6,0,106,18,67,111,109,112,117,116,101,
		114,32,32,32,32,32,32,32,58,32,0,176,8,0,
		12,0,20,2,36,28,0,176,6,0,20,0,36,29,
		0,176,6,0,20,0,36,30,0,176,6,0,176,9,
		0,106,2,61,0,95,1,12,2,20,1,36,31,0,
		176,6,0,20,0,36,34,0,176,6,0,176,10,0,
		92,27,12,1,20,1,36,35,0,176,6,0,176,11,
		0,12,0,20,1,36,36,0,176,6,0,176,12,0,
		12,0,20,1,36,38,0,176,6,0,106,10,118,97,
		108,116,121,112,101,32,58,0,176,13,0,95,2,12,
		1,20,2,36,39,0,176,6,0,106,10,99,104,97,
		110,103,101,100,32,58,0,48,14,0,95,2,112,0,
		20,2,36,40,0,176,6,0,106,10,103,101,116,32,
		32,32,32,32,58,0,48,15,0,95,2,112,0,20,
		2,36,41,0,176,6,0,106,10,108,101,110,32,32,
		32,32,32,58,0,48,16,0,95,2,112,0,20,2,
		36,42,0,176,6,0,106,10,118,97,108,117,101,32,
		32,32,58,0,48,17,0,95,2,112,0,20,2,36,
		44,0,176,6,0,176,9,0,106,2,61,0,95,1,
		12,2,20,1,36,46,0,176,6,0,106,10,115,101,
		116,32,32,32,32,32,58,0,48,18,0,95,2,106,
		17,118,105,108,109,97,114,32,99,97,116,97,102,101,
		115,116,97,0,112,1,20,2,36,47,0,176,6,0,
		106,10,103,101,116,32,32,32,32,32,58,0,48,15,
		0,95,2,112,0,20,2,36,48,0,176,6,0,106,
		10,116,121,112,101,32,32,32,32,58,0,48,19,0,
		95,2,112,0,20,2,36,49,0,176,6,0,106,10,
		108,101,110,32,32,32,32,32,58,0,48,16,0,95,
		2,112,0,20,2,36,50,0,176,6,0,106,10,99,
		104,97,110,103,101,100,32,58,0,48,14,0,95,2,
		112,0,20,2,36,51,0,176,6,0,106,10,118,97,
		108,117,101,32,32,32,58,0,48,17,0,95,2,112,
		0,20,2,36,52,0,176,6,0,106,10,117,112,99,
		97,115,101,32,32,58,0,48,20,0,95,2,112,0,
		20,2,36,53,0,176,6,0,106,10,118,97,108,117,
		101,32,32,32,58,0,48,17,0,95,2,112,0,20,
		2,36,54,0,176,6,0,106,13,99,97,112,105,116,
		97,108,105,122,101,32,58,0,48,21,0,95,2,112,
		0,20,2,36,55,0,176,6,0,106,13,99,97,112,
		105,116,97,108,105,122,101,32,58,0,176,22,0,12,
		0,20,2,36,57,0,176,6,0,176,9,0,106,2,
		61,0,95,1,12,2,20,1,36,59,0,176,6,0,
		106,10,118,97,108,117,101,32,32,32,58,0,48,18,
		0,95,2,176,9,0,106,2,42,0,92,10,12,2,
		112,1,20,2,36,60,0,176,6,0,106,10,103,101,
		116,32,32,32,32,32,58,0,48,15,0,95,2,112,
		0,20,2,36,61,0,176,6,0,106,10,108,101,110,
		32,32,32,32,32,58,0,48,16,0,95,2,112,0,
		20,2,36,62,0,176,6,0,106,10,99,104,97,110,
		103,101,100,32,58,0,48,14,0,95,2,112,0,20,
		2,36,63,0,176,6,0,106,10,118,97,108,117,101,
		32,32,32,58,0,48,17,0,95,2,112,0,20,2,
		36,65,0,176,6,0,176,9,0,106,2,61,0,95,
		1,12,2,20,1,36,67,0,176,6,0,106,10,118,
		97,108,116,121,112,101,32,58,0,176,13,0,48,17,
		0,95,2,112,0,12,1,20,2,36,68,0,176,6,
		0,106,10,108,101,110,32,32,32,32,32,58,0,176,
		23,0,48,17,0,95,2,112,0,12,1,20,2,36,
		69,0,48,24,0,95,2,112,0,73,36,70,0,176,
		6,0,106,10,108,101,110,32,32,32,32,32,58,0,
		176,23,0,48,17,0,95,2,112,0,12,1,20,2,
		36,72,0,176,6,0,176,25,0,12,0,20,1,7
	};

	hb_vmExecute( pcode, symbols );
}

HB_FUNC( LIN )
{
	static const HB_BYTE pcode[] =
	{
		36,75,0,176,9,0,106,2,61,0,92,100,20,2,
		7
	};

	hb_vmExecute( pcode, symbols );
}

#line 92 "str.prg"

	// synonymn for MS_* 
	HB_FUNC_TRANSLATE(TRIM,    	RTRIM)
	HB_FUNC_TRANSLATE(MS_TRIM,    RTRIM)
	HB_FUNC_TRANSLATE(MS_LTRIM,   LTRIM)
	HB_FUNC_TRANSLATE(MS_STRZERO, STRZERO)
	HB_FUNC_TRANSLATE(MS_LEN,     LEN)

	#include "hbapi.h"
	#include "hbapiitm.h"
	#include "hbapierr.h"
	#include "ctype.h"
	
	typedef char						MS_CHAR;
	typedef const char    			MS_TCHAR;
	typedef HB_UCHAR				   MS_UCHAR;
	typedef HB_SIZE               MS_SIZE;
	typedef int                   MS_INT;
	typedef unsigned long int     MS_ULINT;
	typedef short                 MS_SHORT;
	typedef size_t              	MS_SIZE_T;
	typedef char 						*TString;

	TString space(int x, char ch) {
		 TString buff = (char *)malloc(x * sizeof(char *));
		 
		 if(buff != 0)
			  memset(buff, ch, x);
			  
		 buff[x] = 0;
		 return buff;
	}

	
	HB_FUNC( STRZERO )
	{
		
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
	
	HB_FUNC( STR )
	{
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
		

	// trims from the left, and returns a new pointer to szText 
	// also returns the new length in lLen 
	const char * hb_strLTrim( const char * szText, HB_SIZE * nLen )
	{
		HB_TRACE( HB_TR_DEBUG, ( "hb_strLTrim(%s, %p)", szText, ( void * ) nLen ) );

		while( *nLen && HB_ISSPACE( *szText ) )
		{
			szText++;
			( *nLen )--;
		}

		return szText;
	}

	// return length of szText ignoring trailing white space (or true spaces) 
	HB_SIZE hb_strRTrimLen( const char * szText, HB_SIZE nLen, HB_BOOL bAnySpace )
	{
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

	// trims leading spaces from a string 

	HB_FUNC( LTRIM )
	{
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


	HB_FUNC( RTRIM )
	{
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


	// trims leading and trailing spaces from a string 
	// NOTE: The second parameter is a Harbour extension.

	HB_FUNC( ALLTRIM )
	{
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

#include "hbapi.h"
#include "hbapierr.h"
#include "hbapiitm.h"
#include "hbapicdp.h"

HB_FUNC( LEN )
{
   PHB_ITEM pItem   	= hb_param(1, HB_IT_ANY);
	PHB_ITEM pWidth 	= NULL;
	PHB_ITEM	pDec 		= NULL;

   if(pItem){		
		if( HB_IS_NUMERIC(pItem)){						
			char *pText = hb_itemStr(pItem, pWidth, pDec);
			if( pText ){
				HB_SIZE nLen, nSrc, nret;
				const char *szText = hb_itemGetCPtr( pText );
				nSrc   = strlen( pText );								
				nLen   = hb_strRTrimLen( pText, nSrc, HB_FALSE );
				szText = hb_strLTrim( pText, &nLen );				
				nret 	 = strlen(szText);
				
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

#line 487 "str.prg"
	#include "hbapi.h"
	#include "hbapiitm.h"
	
	HB_FUNC_TRANSLATE(MS_EMPTY,     EMPTY)	
	
	HB_FUNC( EMPTY )
	{
		PHB_ITEM pItem = hb_param( 1, HB_IT_ANY );
		PHB_SYMB pSym;
		long lDate;
		long lTime;
		
		switch( hb_itemType( pItem ) )
		{
			case HB_IT_ARRAY:
				hb_retl( hb_arrayLen( pItem ) == 0 );
				break;

			case HB_IT_HASH:
				hb_retl( hb_hashLen( pItem ) == 0 );
				break;

			case HB_IT_STRING:
			case HB_IT_MEMO:
				hb_retl( hb_strEmpty( hb_itemGetCPtr( pItem ), hb_itemGetCLen( pItem ) ) );
				break;

			case HB_IT_INTEGER:
				hb_retl( hb_itemGetNI( pItem ) == 0 );
				break;

			case HB_IT_LONG:
				hb_retl( hb_itemGetNInt( pItem ) == 0 );
				break;

			case HB_IT_DOUBLE:
				hb_retl( hb_itemGetND( pItem ) == 0.0 );
				break;

			case HB_IT_DATE:
				hb_retl( hb_itemGetDL( pItem ) == 0 );
				break;

			case HB_IT_TIMESTAMP:
				hb_itemGetTDT( pItem, &lDate, &lTime );
				hb_retl( lDate == 0 && lTime == 0 );
				break;

			case HB_IT_LOGICAL:
				hb_retl( ! hb_itemGetL( pItem ) );
				break;

			case HB_IT_BLOCK:
				hb_retl( HB_FALSE );
				break;

			case HB_IT_POINTER:
				hb_retl( hb_itemGetPtr( pItem ) == NULL );
				break;

			case HB_IT_SYMBOL:
				pSym = hb_itemGetSymbol( pItem );
				if( pSym && ( pSym->scope.value & HB_FS_DEFERRED ) && \
					 pSym->pDynSym )
					pSym = hb_dynsymSymbol( pSym->pDynSym );
				hb_retl( pSym == NULL || pSym->value.pFunPtr == NULL );
				break;

			default:
				hb_retl( HB_TRUE );
				break;
		}
	}
#line 563 "str.prg"
#include "hbapi.h"
#include "hbapigt.h"
#include "hbgtcore.h"
#include "hbapiitm.h"
#include "hbapicdp.h"
#include "hbset.h"
#include "hbstack.h"
#include "hbvm.h"

static void hb_inkeySetTextKeys( const char * pszText, HB_SIZE nSize, HB_BOOL fInsert )
{
   PHB_CODEPAGE cdp = hb_vmCDP();
   HB_SIZE nIndex   = 0;
   HB_WCHAR wc;

   if( fInsert )
   {
      HB_WCHAR buffer[ 32 ], * keys;
      HB_SIZE n = 0;

      keys = nSize <= HB_SIZEOFARRAY( buffer ) ? buffer : ( HB_WCHAR * ) hb_xgrab( nSize * sizeof( HB_WCHAR ) );
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

HB_FUNC( INKEY )
{
   int iPCount = hb_pcount();

   hb_retni( hb_inkey( iPCount == 1 || ( iPCount > 1 && HB_ISNUM( 1 ) ),
                       hb_parnd( 1 ), hb_parnidef( 2, hb_setGetEventMask() ) ) );
}

HB_FUNC( __KEYBOARD )
{
   /* Clear the typeahead buffer without reallocating the keyboard buffer */
   hb_inkeyReset();

   if( HB_ISCHAR( 1 ) )
      hb_inkeySetText( hb_parc( 1 ), hb_parclen( 1 ) );
}

HB_FUNC( HB_KEYCLEAR )
{
   hb_inkeyReset();
}

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

HB_FUNC( HB_KEYNEXT )
{
   hb_retni( hb_inkeyNext( HB_ISNUM( 1 ) ? hb_parni( 1 ) : hb_setGetEventMask() ) );
}

HB_FUNC( NEXTKEY )
{
   hb_retni( hb_inkeyNext( hb_setGetEventMask() ) );
}

HB_FUNC( HB_KEYLAST )
{
   hb_retni( hb_inkeyLast( HB_ISNUM( 1 ) ? hb_parni( 1 ) : hb_setGetEventMask() ) );
}

HB_FUNC( LASTKEY )
{
   hb_retni( hb_inkeyLast( HB_INKEY_ALL ) );
}

HB_FUNC( HB_KEYSETLAST )
{
   if( HB_ISNUM( 1 ) )
      hb_retni( hb_inkeySetLast( hb_parni( 1 ) ) );
}

#if defined( HB_LEGACY_LEVEL5 )

HB_FUNC_TRANSLATE( HB_SETLASTKEY, HB_KEYSETLAST )

#endif

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

HB_FUNC( HB_KEYCHAR )
{
   char szKeyChr[ HB_MAX_CHAR_LEN ];
   HB_SIZE nLen;

   nLen = hb_inkeyKeyString( hb_parni( 1 ), szKeyChr, sizeof( szKeyChr ) );
   hb_retclen( szKeyChr, nLen );
}

HB_FUNC( HB_KEYSTD )
{
   hb_retni( hb_inkeyKeyStd( hb_parni( 1 ) ) );
}

HB_FUNC( HB_KEYEXT )
{
   hb_retni( hb_inkeyKeyExt( hb_parni( 1 ) ) );
}

HB_FUNC( HB_KEYMOD )
{
   hb_retni( hb_inkeyKeyMod( hb_parni( 1 ) ) );
}

HB_FUNC( HB_KEYVAL )
{
   hb_retni( hb_inkeyKeyVal( hb_parni( 1 ) ) );
}

HB_FUNC( HB_KEYNEW )
{
   PHB_ITEM pText = hb_param( 1, HB_IT_STRING );
   int iMod = hb_parni( 2 );
   int iKey = pText ? hb_cdpTextGetU16( hb_vmCDP(), hb_itemGetCPtr( pText ),
                                                    hb_itemGetCLen( pText ) ) : hb_parni( 1 );

   if( iKey >= 127 )
      iKey = HB_INKEY_NEW_UNICODEF( iKey, iMod );
   else if( ! pText || ( iMod & ( HB_KF_CTRL | HB_KF_ALT ) ) != 0 )
      iKey = HB_INKEY_NEW_KEY( iKey, iMod );
   else
      iKey = HB_INKEY_NEW_CHARF( iKey, iMod );

   hb_retni( iKey );
}

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

