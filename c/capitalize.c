#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>

#define BUFFER 1000000

int amaxstrlen(int cont, int argc, char *argv[]) {
    int m    = -1;
    int x    = 0;

    for(; cont < argc; cont++) {
        x = strlen(argv[cont]);
        if(x > m)
            m = x;
    }
    return m;
}


char *capitalize(char s[]) {
    int nlen  = (int)strlen(s);
    char *buf = (char *)malloc(nlen * sizeof(char *));
    int i;

    if(buf)
        memset(buf, 32, nlen);

    if(s) {
        for(i = 0; i< nlen; i++) {
            buf[i] = s[i];
            if((i == 0 || s[i-1] == ' ') && (s[i] >= 'a' &&s[i] <= 'z'))
                buf[i] = toupper(s[i]);
        }
        //printf("Saida Formatada : %s", s);
    }
    buf[nlen] = '\0';
    return buf;
}

void uso() {
    printf("Capitalize.c, Copyright (c), 1991-2018, Vilmar Catafesta\n");
    printf("Uso  capitalize -l linha digitavel,  ou\n");
    printf("     capitalize -t <texto texto texto>, ou\n");
    printf("     capitalize -f <arquivo.ext>, ou\n");
    printf("     capitalize <arquivo.ext stdin\n");
}

int main(int argc, char *argv[]) {
    char *s     = (char *)malloc(BUFFER);
    char *buf   = argv[1];
    char *linha = (char *)malloc(200);;
    int  n    	= 0;
    int  cont 	= 0;
    int  ntam 	= 0;
    int  c;
    FILE *fp;

    uso();
    printf("\n");
    /*
    for(cont=0; cont < argc; cont++){
    	printf("Parametro #%d : %s\n", cont, argv[cont]);
    }
    */

    //printf("%s:%d\n","teste0", argc);
    //printf("%c\n", *argv[1]);
    //if(*argv[1] != '<')
    //system("pause");

    if(buf) {
        if(buf[0] == '-' && buf[1] == 'l') {
            cont = 2;
            goto linha;
        }

        if(buf[0] == '-' && buf[1] == 't') {
            cont = 2;
            goto formatada;
        }

        if(buf[0] == '-' && buf[1] == 'f') {
            if(argv[2]) {
                cont = 2;
                buf  = argv[2];
                goto arquivolinha;
            }
            exit(1);
        }

        cont = 1;
        goto formatada;
    }

    if(argc == 1)
        goto entrada;

formatada:
    ntam = amaxstrlen(cont, argc, argv);

    for(; cont < argc; cont++) {
        printf("Entrada #%-2d : %-*s \tSaida formatada: %-s\n", cont, ntam, argv[cont], capitalize(argv[cont]));
        //while(*(argv[cont]++) != '\0'){
        //printf("Parametro #%d : %s \n", cont, argv[cont]);
        //}
    }
    exit(0);

entrada:
    printf("%s\n","Entre com o texto, ctrl+Z finaliza");
    do {
        c = fgetc(stdin);
        if(feof(stdin)) {
            s[n] = '\0';
            printf("\n\n<Saida capitalizada>\n%s\n", capitalize(s));
            printf("\nfeito! (%d) caracteres no texto/arquivo\n", n);
            break;
        }
        s[n] = c;
        //printf("%c", c);
        //printf("%d", c);
        n++;
    } while(1);
    exit(0);

arquivo:
    fp = fopen(buf, "r");
    if(!fp)
        perror("Erro abertura arquivo");
    else {
        do {
            c = fgetc(fp);
            if(feof(fp)) {
                s[n] = '\0';
                printf("\n\n<Saida capitalizada>\n%s\n", capitalize(s));
                printf("\nfeito! (%d) caracteres no texto/arquivo\n", n);
                break;
            }
            s[n] = c;
            //printf("%c", c);
            //printf("%d", c);
            n++;
        } while(1);
        exit(0);
    }
    exit(1);

arquivolinha:
	fp = fopen(buf, "r");
	if(!fp)
		perror("Erro abertura arquivo");
	else {
		while(!feof(fp))
			{
            n++;
            if(fgets(linha, 200, fp) != NULL)
					;
            if(linha)
					{
               	printf("%-2d: %s", n, capitalize(linha));
                	//system("pause");
            	}

        }
        exit(0);
    }
    exit(1);


linha:
    printf("\nEnter uma linha : ");
    fgets(s, BUFFER, stdin);
    printf("Saida Formatada : %s", capitalize(s));
    exit(0);

}

