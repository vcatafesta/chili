// eecho.c, Copyright (c) 2023 Vilmar Catafesta <vcatafesta@gmail.com>
#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <stdint.h>
#include <string.h>
#include <ctype.h>
#include <time.h>
#include <unistd.h>
#include <sys/ioctl.h>
#include "ansi_color_code.h"
#include "color.h"

int main( const int argc, const char** const argv ){
	printf("%scecho.c%s, Copyright (c) 2023 Vilmar Catafesta <vcatafesta@gmail.com>%s\n\n", LIGHTYELLOW, RED, RESET);

    time_t rt;
    srand( ( unsigned ) time( &rt ) );

    if( argc < 2 ){
        printf("%sUsage: [color-name] [some-text] [endl|]\n", LIGHTCYAN);
        return 0;
    }

    const char* reset_color = "\033[m";
    const char** argv_iter  = argv;
    const char*  user_color = argv[ 1 ];
    int index_match = -1;

    for( int index = 0; index < 7 * 8; ++index ){
        if( !strcmp( user_color, color_name[ index ] ) ){
            index_match = index;
        }
        ++argv_iter;
    }

    argv_iter = argv;
    argv_iter += 2;

    if( index_match != -1 ){

        if( !strcmp( argv[ argc - 1 ], "endl" ) ){

            for( int index = 2; index < argc - 1; ++index ){
                printf( "%s%s%s\n", ANCI_color[ ( !strcmp( user_color, "random" ) ? rand() % 56 : index_match ) ], *argv_iter, reset_color );
                ++argv_iter;
            }

        } else {

            for( int index = 1; index < argc - 1; ++index ){
                printf( "%s%s %s", ANCI_color[ ( !strcmp( user_color, "random" ) ? rand() % 56 : index_match ) ], *argv_iter, reset_color );
                ++argv_iter;
            }
            printf( "\n" );
        }

    } else {
        printf( "Usage: [color-name] [some-text] [endl|]\n" );
    }

return 0;}
