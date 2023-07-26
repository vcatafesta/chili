#include "protype.h"

#define MAX_LEN 					1024
#define MAX_SUBSTRINGS 			100   	// define o número máximo de substrings permitido
#define MAX_SUBSTRING_LENGTH	200		// define o tamanho máximo de cada substring permitido

char *space(int x, char ch);
static char* replicate(char* str, int vezes);

size_t strlen1( char *str) {
	int i=0;
	while ( str[i] != '\0' ) {
      i++;
   }
   return i;
}

size_t strlen2( char *str) {
	int tam=0;
	while ( *str ) {
		tam++;
      *str++;
   }
   return tam;
}

int inkey() {
  	//int tecla = getchar();
  	int tecla = getch();
   return(tecla);
}

char *padr(char *str, size_t nwidth, char cfill) {
	size_t nlen   = strlen(str);
	size_t nsp    = (nwidth - nlen);
	char *buffer  = space(nwidth, 32);
	strcpy(buffer, str);
	strcat(buffer, space(nsp,cfill));
	return buffer;
}

char *padc(char *str, size_t nwidth, char cfill) {
	size_t nlen   = strlen(str);
	size_t pos    = (nwidth - nlen ) / 2 ;
	size_t nsp    = (nwidth - nlen)  / 2;
	char *buffer  = space(nwidth, 32);
	strcpy(buffer, space(nsp,cfill));
	strcat(buffer, str);
	strcat(buffer, space(nsp,cfill));
	return buffer;
}

void GETSTR(const char *pz, char *stringLida) {
	int nbuffer = sizeof(pz);
   printf("%s", pz);
	fflush(stdin);
   fgets(stringLida, nbuffer, stdin);
   stringLida[strlen(stringLida)-1] = '\0';
}

void GETNUM(const char *pz, int *nVar) {
   char buffer[10];
   printf("%s", pz);
	fflush(stdin);
   fgets(buffer, 10, stdin);
   sscanf(buffer, "%d", nVar); //leitura do numero com sscanf
}

int lenarrayofchar(char *a[]) {
   int nlen = 0;
   //while(*(a+nlen)){
   while( a[nlen] ){
     nlen++;
   }
   return nlen;
}

int buscaBinaria(int *V, int N, int elem) {
	int i, inicio, meio, final;
   inicio = 0;
   final  = N-1;
   while(inicio <= final){
      meio = (inicio + final)/2;
		if(elem < V[meio])
         final = meio-1;
      else
         if(elem > V[meio])
            inicio = meio +1;
         else
            return meio;
	}
	return -1;
}

int buscaOrdenada(int *V, int N, int elem) {
	int i;
	for(i=0;i<N;i++){
		if(elem == V[i])
			return i;
      else
         if(elem < V[i])
            return -1;
	}
	return -1;
}

int buscaLinear(int *V, int N, int elem) {
	int i;
	for(i=0;i<N;i++){
		if(elem == V[i])
			return i;
	}
	return -1;
}

void heapSort(int *vet, int N) {
	int i;
	int aux;
	for(i=(N -1)/2; i>= 0; i--){
		;
	}
}

void *malloc_s(size_t size) {
    void *p = malloc(size);
    if(p == NULL) {
        fprintf(stderr, "Memoria insuficiente. \n");
        exit(1);
    }
    memset(p, 0, size);
    return p;
}

char *space(int x, char ch=32) {
    char *buff = (char*)malloc(x * sizeof(char *));
    if(buff != 0)
        memset(buff, ch, x);
    buff[x] = '\0';
    return buff;
}

void *spaceset(size_t size, char ch) {
	return(memset((char *)malloc_s(size * sizeof(char *)), ch, size));
}

void strdisplay(char *str) {
    int i = 0;
    while(str[i]) {
        p("str[%i]   ", i);
        p("\tende[%s]", &str[i]);
        p("\tptr[%p] ", &str[i]);
        p("\tch=%3d  ", str[i]);
        p("\t %c \n  ", str[i++]);
    }
    puts("");
}

void display(char *str) {
	int x = 0;
	int max = strlen(str);

	printf("%s\n", spaceset(80, '='));
   printf("VETOR \t\tASCII \tDEC \tOCT \tHEX \tPOINTER \tVALUE\n");
	printf("%s\n", spaceset(80, '-'));
   for(x=0; x < max; x++){
		printf("str[%03d] \t%c \t%d \t%o \t%x \t%p \t%s \n", x, str[x], str[x], str[x],str[x], &str[x], &str[x]);
	}
}

void dump(char *str) {
	int x = 0;
	int max = strlen(str);

	printf("%s\n", spaceset(80, '='));
   printf("VETOR \t\tASCII \tDEC \tOCT \tHEX \tPOINTER \tVALUE\n");
	printf("%s\n", spaceset(80, '-'));
   for(x=0; x < max; x++){
		printf("str[%03d] \t%c \t%d \t%o \t%x \t%p \t%s \n", x, str[x], str[x], str[x],str[x], &str[x], &str[x]);
	}
}

char* memcpy2(char *dest, char *orig, int n) {
	int i;

	for(i=0 ; i < n ; i++){
		dest[i] = orig[i];
	}
	return dest;
}

void copiaString(char* dest, char* src) {
	if(dest)
		if(src)
			while((*dest++ = *src++))
			;
}

char* strleft(char* str, size_t pos) {
    char* ch = space(pos, 32);
    memcpy2(ch, str, pos);

    if(ch)
        return (ch);
    return (NULL);
}

char* strleft2(char* str, size_t pos) {
    char* dest 	= space(pos, 32);
    size_t 	i 		= 0;

    for(; i < pos ; i++)
        dest[i] = str[i];
    if(dest)
        return(dest);
    return (NULL);
}

int min(size_t value1, size_t value2) {
    if(value1 < value2)
        return value1;
    return value2;
}

int max(size_t value1, size_t value2) {
    if(value1 > value2)
        return value1;
    return value2;
}

char* strrigth(char* str, size_t pos) {
    char* dest = space(pos, 32);
    size_t   n = strlen(str);
    size_t   i = n - min(strlen(str), pos);
    int y = 0;

    for(; i < n ; i++)
        dest[y++] = str[i];
    if(dest)
        return (dest);
    fprintf(stderr, "Erro: strrigth()");
    return (NULL);
}

char* strsubstr(char* str, size_t ini, size_t fim) {
    int     max  = strlen(str);
    char*  dest  = space(max,32);
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

static char* replicate(char* str, int vezes) {
	int lenstr = (int) strlen(str);
	int tam    = lenstr * vezes;
	char* ptr   = (char*)malloc(tam * sizeof(char)); // (char*)malloc(tam+1);
	int x;
	int y;

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

static int len(char* str) {
	return((int)strlen(str));
}

char* chr(int n) {
	char* ch = (char *)malloc(sizeof(char*));
	ch[1]       = '\0';
	memset(ch, n, 1);
   return(ch);
}

char* spacechar(size_t stTamBlock, char chInit) {
   char* pBuf = (char *) malloc(stTamBlock +1);
   if( pBuf != 0 )
      memset( pBuf, chInit, stTamBlock );
   pBuf[stTamBlock] = '\0';
	return pBuf;
}

void remove_newline(char *str) {
	int len = strcspn(str, "\n");		// encontra o comprimento da string sem o caractere de line feed
	str[len] = '\0';  					// adiciona o caractere nulo ao final da string, removendo o caractere de line feed
}

int split(char *str, char **substrings, char delimiter=' ') {
	int count = 0;  // conta o número de substrings encontradas
	char *token;    // ponteiro para o token encontrado

	// encontra o primeiro token
	token = strtok(str, &delimiter);

	// percorre a string enquanto houver tokens
	while (token != NULL) {
		substrings[count] = token;  // armazena o token na matriz de substrings
		count++;  // incrementa o contador de substrings encontradas

		if (count == MAX_SUBSTRINGS) {
			break;  // atingiu o limite máximo de substrings permitido
		}

		// encontra o próximo token
		token = strtok(NULL, &delimiter);
	}

	return count;  // retorna o número de substrings encontradas
}

int strcount(char *str) {
	int count = 0;
	char *token = strtok(str, " \n");

	while (token != NULL) {
		count++;
		token = strtok(NULL, " \n");
	}
	printf("Texto na funcao            : %s\n", str);
	return count;
}

int wordstrcount(const char *str) {
	int count = 0;
	int inside_word = 0;

	while (*str != '\0') {
		if (isspace(*str) || ispunct(*str)) {
			inside_word = 0;
		} else if (!inside_word) {
			inside_word = 1;
			count++;
		}
		str++;
	}
	return count;
}

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

char *capitalize(char *s) {
	int  nlen = (int)strlen(s);
	char *buf = space(nlen);
	int     i = 0;

	if (!buf) {
		perror("Erro de alocação de memoria");
		exit(1);
	}

	for (i = 0; s[i] != '\0'; i++) {
		buf[i] = s[i];
//		s[i]   = tolower(s[i]);
//		if((i == 0 || s[i-1] == ' ') && (s[i] >= 'a' &&s[i] <= 'z')) {
		if(i == 0 || s[i-1] == ' ') {
			buf[i] = toupper(s[i]);
		}
	}
	buf[nlen] = '\0';
	return buf;
}

