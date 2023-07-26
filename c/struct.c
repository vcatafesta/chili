#include "protype.h"

//=================================================================
int buscaLinear(int *V, int N, int elem){
	int i;
	for(i=0;i<N;i++){
		if(elem == V[i])
			return i;
	}
	return -1;
}
//=================================================================
void heapSort(int *vet, int N){
	int i;
	int aux;
	for(i=(N -1)/2; i>= 0; i--){
		;
	}

}
//=================================================================
void *malloc_s(size_t size){
    void *p = malloc(size);
    if(p == NULL) {
        fprintf(stderr, "Memoria insuficiente. \n");
        exit(1);
    }
    memset(p, 0, size);
    return p;
}
//=================================================================
char* space(int x, char ch) {
    char* buff = (char*)malloc(x * sizeof(char *));
    if(buff != 0)
        memset(buff, ch, x);
    buff[x] = 0;
    return buff;
}
//=================================================================
void* spaceset(size_t size, char ch) {
	return(memset((char *)malloc_s(size * sizeof(char *)), ch, size));
}
//=================================================================
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
//=================================================================
void display(char *str) {
    int x;
    int max = strlen(str);
    
	printf("%s\n", (char*)spaceset(80, '-'));
   printf("VETOR \t\tASCII \tDEC \tOCT \tHEX \tENDERECO \tPOINTER\n");
	printf("%s\n", (char*)spaceset(80, '-'));
   for(x=0; x < max; x++){
   	printf("str[%03d] \t%c \t%d \t%o \t%x \t%s \t%p \n", x, str[x], str[x], str[x],str[x], &str[x], &str[x]);
	}
	printf("%s\n", (char*)spaceset(80, '-'));
   printf("VETOR \t\tASCII \tDEC \tOCT \tHEX \tENDERECO \tPOINTER\n");
	printf("%s\n", (char*)spaceset(80, '-'));
}
//=================================================================
char* memcpy2(char *dest, char *orig, int n) {
    int i;
    
    for(i=0 ; i < n ; i++){
        dest[i] = orig[i];
	}
	return dest;
}
//=================================================================
void copiaString(char* dest, char* src) {
	if(dest)
		if(src)
			while((*dest++ = *src++))
			;
}
//=================================================================
char* strleft(char* str, size_t pos) {
    char* ch = space(pos, 32);
    memcpy2(ch, str, pos);
    
    if(ch)
        return (ch);
    return (NULL);
}
//=================================================================
char* strleft2(char* str, size_t pos) {
    char* dest 	= space(pos, 32);
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
//=================================================================
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
/*-----------------------------------------------------------------------------------------------*/	
static char* replicate(char* str, int vezes)
{
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

/*-----------------------------------------------------------------------------------------------*/	

static int len(char* str)
{
	return((int)strlen(str)); 
}	

/*-----------------------------------------------------------------------------------------------*/	
	
char* chr(int n){
	char* ch = (char *)malloc(sizeof(char*));
	ch[1]       = '\0';
	memset(ch, n, 1);	   
   return(ch);
}

//=================================================================
char* spacechar(size_t stTamBlock, char chInit)
{
   char* pBuf = (char *) malloc(stTamBlock +1);
   if( pBuf != 0 )
      memset( pBuf, chInit, stTamBlock );
   pBuf[stTamBlock] = '\0';
	return pBuf;
}
//=================================================================
/* modelo 1
typedef struct TFICHA{
	char nome[50];
	char disciplina[30];
   float nota_prova1;
   float nota_prova2;
}FICHA;
*/
//=================================================================
/* modelo 2
struct TFICHA{
	char nome[50];
	char disciplina[30];
   float nota_prova1;
   float nota_prova2;
};
typedef struct TFICHA FICHA;
*/
//=================================================================
// modelo 3
struct FICHA{
	char nome[50];
	char disciplina[30];
   float nota_prova1;
   float nota_prova2;
};
//=================================================================
int main(void)
{
	//FICHA aluno; 			// modelo 1
	//FICHA aluno; 			// modelo 2
	struct FICHA aluno;		// modelo 3
	printf("%s\n", (char*)spaceset(80, '-'));
	printf("\t\t\tCADASTRO\n");
	printf("%s\n", spacechar(80, '-'));
 	printf("Nome ................: "); fflush(stdin); fgets(aluno.nome, 50, stdin);
  	printf("Disciplina ..........: "); fflush(stdin); fgets(aluno.disciplina, 30, stdin);
  	printf("Informe a 1a. nota ..: "); scanf("%f", &aluno.nota_prova1);
  	printf("Informe a 2a. nota ..: "); scanf("%f", &aluno.nota_prova2);
  
  	printf("\n\n --------- Lendo os dados da struct ---------\n\n");
  	printf("Nome ...........: %s", aluno.nome);
  	printf("Disciplina .....: %s", aluno.disciplina);
  	printf("Nota da Prova 1 ...: %.2f\n" , aluno.nota_prova1);
  	printf("Nota da Prova 2 ...: %.2f\n" , aluno.nota_prova2);
	display(aluno.nome);	
  	return(0);
}
