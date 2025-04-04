#include <stdio.h>
#include <stdlib.h>
//#include <conio.h>
#include <string.h>
#include <time.h>
#include <locale.h>
#include <unistd.h>
#include <termios.h>

#define NELEMS(a)       (sizeof(a) / sizeof((a)[0]))
#define len(s)          ((int)strlen(s))
#define BEEP()          (printf("\x7"))
#define errorbeep()     (printf("\x7"))
#define LIMPA()         (printf("\x1B[2J"))
#define POS(x,y)        (printf("\x1B[%d;%df", x, y))
#define REV()           (printf("\x1B[7m"))
#define CH219()         (printf("\xDB"));
#define nil             0
//#define space(y,c)      (memset((char*)malloc(sizeof(char*)*y),(char)c,y))
//#define replicate(c,y)  (memset((char*)malloc(sizeof(char*)*y),(char)c,y))
#define qout(s)         (puts(s))
#define qqout(s)        (printf("%s",s))
#define read(s)         (gets(s))
#define write(s)        (printf("%s",s))

#define byte unsigned   char
#define word unsigned   short
#define dword unsigned  long

typedef struct {
        word dia;
        word mes;
        word ano;
} TDATA, *PTDATA;


typedef struct {
   char   nome[40];
   char   fone[15];
   TDATA  niver;

} CONTATO, *PCONTATO;

void  exemplo01(void);
void  exemplo02(void);
void  exemplo03(void);
void  exemplo04(void);
void  exemplo05(void);
void  exemplo06(void);
void  exemplo07(void);

char  *procstr(char *lin, char ch);
int   strlen1(char s[]); // versao 1
int   strlen2(char *s);  // versao 2
int   strlen3(char *s);  // versao 3
int   strlen4(char *s);  // versao 4 - minha preferida
char *strcpy1(char s[], char t[]); /* copia t a s - versao 1 */
char *strcpy2(char *s, char *t);   /* copia t a s - versao 2 */
char *strcpy3(char *s, char *t);   /* copia t a s - versao 3 */
char *strcpy4(char *s, char *t);   /* copia t a s - versao 4 */
char  *now(void);
char *space(int y, char c);
char *replicate(char c, int y);
FILE *abrearquivo(char *modo);
void menu(void);
void cabecalho();
void inputData();
void listarData();
void pesquisarData();
void niverData();

/*
   1 - Toda matriz � inicializada como ponteiro constante.
   2 - Voce nao pode alterar o valor de um ponteiro constante, somente de um ponteiro variavel.
   3 -

*/

CONTATO ctt;
PCONTATO *pctt;

char getch(void)
{
    char buf = 0;
    struct termios old = {0};
    fflush(stdout);
    if(tcgetattr(0, &old) < 0)
        perror("tcsetattr()");
    old.c_lflag &= ~ICANON;
    old.c_lflag &= ~ECHO;
    old.c_cc[VMIN] = 1;
    old.c_cc[VTIME] = 0;
    if(tcsetattr(0, TCSANOW, &old) < 0)
        perror("tcsetattr ICANON");
    if(read(0, &buf, 1) < 0)
        perror("read()");
    old.c_lflag |= ICANON;
    old.c_lflag |= ECHO;
    if(tcsetattr(0, TCSADRAIN, &old) < 0)
        perror("tcsetattr ~ICANON");
    printf("%c\n", buf);
    return buf;
 }


void exemplo01(void)
{
   int iLen[5]   = {1, 2, 3, 4, 5};
   char s        = 65;
   char string[] = "VIL";
   char *ptr     = string;
   int x;
   char *ch  = space(40,48);
   char *rpl = replicate(49,40);


   //errorbeep();
   CH219();
   printf("Sizeof (iLen  ): %d \n", sizeof(iLen));
   printf("Sizeof (s     ): %d \n", sizeof(s));
   printf("Sizeof (string): %d \n", sizeof(string));
   printf("Nome           : %s \n %d\n", string, len(string));
   printf("\n");

   for(x=0; x<len(string); x++){
      printf("int  %3d ", string[x]);
      printf("ch   %3c ", string[x]);
      printf("\n");
   }
   printf("\n");

   while(*ptr) {
      printf("Letra : %c\n", *ptr++);
      printf("Letra : %p\n", ptr);
   }

   ptr = string;
   ptr = &string[0];   
   printf("string: %s \n %d\n", string, len(string));
   printf("ptr   : %s \n %d\n", ptr,    len(ptr));
   printf("\n%s = %i", rpl, len(rpl));
   printf("\n%s = %i", ch,  len(ch));
   qqout("\n");
   qout( ch);
   //qout(len(ch));
}

void exemplo02(void)
{

   static char resp[]="branca";
   char r1[40];
   static char chNome[1];
   int d;
   qout("Digite seu nome: ");
   read(chNome);

   for(d=0; d<len(chNome)+2; d++)
      printf("End=%5u pos=%i caractere='%c' = %3d\n",
         &chNome[d], d, chNome[d], chNome[d]);


   printf("\nEnd r1=%5u end resp=%5u\n", &r1, &resp);
   qout("Qual a cor do cavalo branco de Napoleao?");
   read(r1);
   
   //while(r1 != resp || r1 != "X"){ // errado
   while(strcmp(r1, resp) != 0){
      qout("Errado! Tente novamente.");
      printf("\nEnd r1=%5u end resp=%5u\n", &r1, &resp);
      qout("Qual a cor do cavalo branco de Napoleao?");
      read(r1);
   }
   qout("Correto");

   /* O codigo nao trabalhara direito, pois r1 e resp sao
      enderecos, ent�o a expressao
      r1 != resp
      
      realmente nao pergunta se as duas strings sao iguais
      e sim se os dois enderecos sao iguais. Como r1 e resp
      estao em enderecos distintos, nunca serao os mesmos.
   */

}

void exemplo03(void)
{

   int x1 = 5;
   int y1 = 6;
   int *px, *py;

   px = &x1;
   py = &y1;

   puts("");
   printf("px=%5u *px=%5d &px=%u\n", px, *px, &px);
   printf("py=%5u *py=%5d &py=%u\n", py, *py, &py);

}

void exemplo04(void)
{

   static int nums[] = {92,81,70,69,58};
   int d;

   for(d=0; d<5;d++){
      printf("nums=%d\n", nums[d]); // sem ponteiros

   }

   qout("");

   for(d=0; d<5;d++){
      printf("nums=%d\n", *(nums+d)); // certo com ponteiros = 92,81,70,69,58
      //printf("nums=%d\n", *nums++); // ERRO = nao pode incrementar ponteiros constantes
   }

   qout("");

   for(d=0; d<5;d++){
      printf("nums=%d\n", *nums+d);   // incrementar com ponteiros = 92,93,94,95,96
   }
}

void exemplo05(void)
{

   char *ptr;
   char ch;
   char lin[81];
   
   qout("Digite uma palavra :"); 
   gets(lin);
   qqout("Digite o caractere a ser procurado :"); 
   ch = getch();
   
   ptr = procstr(lin, ch);
   printf("\nA string comeca no Caractere : %c, no Endereco: %u.\n", *lin, lin);   
   printf("\nA string comeca no Caractere : %c, no Endereco: %u.\n", lin[0], lin); //equivalente a linha acima
   if(ptr){
      printf("Primeira ocorrencia do caractere: %u.\n", ptr);
      printf("E a posicao: %d", ptr-lin+1);
   }else
      printf("\nCaractere nao encontrado");
   getch();

}

void exemplo06(void)
{
   /*
   char lin[81];
   qout("Digite uma palavra :"); 
   gets(lin);
   */

   //char *lin = replicate('A', 416999999);
   char *lin = replicate('A', 4000);
   
   printf("A string comeca no Caractere : %c, no Endereco: %u. %u\n", *lin, lin, &lin);   
   printf("A string comeca no Caractere : %c, no Endereco: %u. %u\n", lin[0], lin, &lin);//equivalente a linha acima

   printf("TIni=%s - Tamanho da String :     len()=%d TFim=%s\n", now(), len(lin), now());
   printf("TIni=%s - Tamanho da String :     len()=%d TFim=%s\n", now(), strlen(lin), now());
   printf("TIni=%s - Tamanho da String :     len()=%d TFim=%s\n", now(), strlen1(lin), now());
   printf("TIni=%s - Tamanho da String :     len()=%d TFim=%s\n", now(), strlen2(lin), now());
   printf("TIni=%s - Tamanho da String :     len()=%d TFim=%s\n", now(), strlen3(lin), now());
   printf("TIni=%s - Tamanho da String :     len()=%d TFim=%s\n", now(), strlen4(lin), now());
   now();

}

void exemplo07(void)
{
   char  source[80] = "VILMAR, O GATINHO - BIG STRING - TEST";
   char destino[80] = "EVILI";
  
   printf("A string 1 comeca no Caractere : %c, no Endereco: %u. %u\n", *source,  source,  &source);
   printf("A string 2 comeca no Caractere : %c, no Endereco: %u. %u\n", *destino, destino, &destino);      
   //printf("A string 1 comeca no Caractere : %c, no Endereco: %u. %u\n", source[0],  source,  &source);//equivalente a linha acima
   //printf("A string 2 comeca no Caractere : %c, no Endereco: %u. %u\n", destino[0], destino, &destino);//equivalente a linha acima

   printf("TIni=%s - Source    = %s TFim=%s\n", now(), source, now());
   printf("TIni=%s - Destino   = %s TFim=%s\n", now(), destino,now());
   printf("TIni=%s - Resultado = %s TFim=%s\n", now(), strcpy3(destino, source),now());
   printf("TIni=%s - Source    = %s TFim=%s\n", now(), source, now());
   printf("TIni=%s - Destino   = %s TFim=%s\n", now(), destino,now());

}

char *procstr(char *lin, char ch)
{
   while(*lin != ch && *lin != nil) lin++;
   if(*lin != nil)
      return(lin);
   else 
      return(nil);   
}

int strlen1(char s[]) // versao 1
{
   int n;
   for(n=0; s[n] != nil; n++)
      ;
   return(n);

}

int strlen2(char *s) // versao 2
{
   int n;
   for(n=0; *s != nil; s++, n++)
      ;
   return(n);

}

int strlen3(char *s) // versao 3
{
   char *ap = s;

   while(*ap != nil)
      ap++;
   return(ap-s);

}

int strlen4(char *s) // versao 4 - minha preferida
{
   char *ap = s;

   while(*ap)
      ap++;
   return(ap-s);

}

char *now(void)
{
   time_t tempo;
   struct tm *infotempo;
   char *texto = space(80,32);

   time(&tempo);
   infotempo = localtime(&tempo);

   setlocale(LC_ALL, "ptb");
   strftime(texto, 81, "%T", infotempo);
   return( texto );  
}

char *strcpy1(char s[], char t[]) /* copia t a s - versao 1 */
{
   int i = 0;
   while ((s[i] = t[i] ) != nil)
         i++;
   return s;
}

char *strcpy2(char *s, char *t) /* copia t a s - versao 2 */
{
   int npos  = len(t); // para reposicionar ponteiro de *s - jeito 1 
   int count = 0;      // para reposicionar ponteiro de *s - jeito 2
   while ((*s = *t ) != nil){
      s++;
      t++;
      count++;
   }
   t -= count; // Reposiona ponteiro para 0;
   s -= npos;  // Reposiona ponteiro para 0;
   return t;
}

char *strcpy3(char *s, char *t) /* copia t a s - versao 3 */
{
   int npos  = len(t-1);   // para reposicionar ponteiro de *s - jeito 1 
   int count = 0;          // para reposicionar ponteiro de *s - jeito 2
   while ((*s++ = *t++) != nil){
      count++;
      ;
   }
   t -= count+1;  // Reposiona ponteiro para 0;
   s -= npos;     // Reposiona ponteiro para 0;
   return t;
}

char *strcpy4(char *s, char *t) /* copia t a s - versao 4 */
{
   int npos  = len(t-1); // para reposicionar ponteiro de *s - jeito 1 
   int count = 0;        // para reposicionar ponteiro de *s - jeito 2
   while (*s++ = *t++){
      count++;
      ;
   }
   t -= npos;     // Reposiona ponteiro para 0;
   s -= count+1;  // Reposiona ponteiro para 0;
   return t;
}

char *space(int y, char c)
{
	char *buf = (char*)malloc(y);

	if(buf){
		memset(buf, (char)c, y);
		buf[y]= nil;
		//printf("Sucesso! (%u) (%p) (%s)\n", *buf, &buf, buf);
	}
	return buf;
}

char *replicate(char c, int y)
{
	return( space(y, c));
}

void menu(void)
{
   int opcao;


   do{
      cabecalho();
      printf("1 - Inserir\n");
      printf("2 - Remover\n");
      printf("3 - Pesquisar por nome\n");
      printf("4 - Listar\n");
      printf("5 - Lista por uma inicial\n");
      printf("6 - Imprimir Aniversariantes do m�s\n");
      printf("7 - Sair\n\n");
      
      printf("Escolha uma opc�o: ");
      scanf("%d", &opcao);

      switch(opcao){
         case 1:
            inputData();
            break;

         case 2:
            break;

         case 3:  
            pesquisarData();          
            break;

         case 4:
            listarData();
            break;

         case 5:
            break;

         case 6:
            niverData();
            break;

         case 7:
            printf("Tenha um nice day.\n");
            getch();
            break; 

         default:
            printf("Opc�o inv�lida.\n");
            getch();
         break;
      }

   }while(opcao != 7);

}

void cabecalho()
{
   setlocale(LC_ALL, "ptb");
   system("cls");
   printf("%s\n", replicate('=',79));
   printf("AGENDA ELETRONICA\n");
   printf("%s\n\n", replicate('=', 79));
}

void inputData()
{
   FILE* Fhandle = abrearquivo("ab");

   if(Fhandle){
      do{
         cabecalho();
         fflush(stdin);
         printf("Digite o Nome: ");
         gets(ctt.nome);

         fflush(stdin);
         printf("Digite o Fone: ");
         gets(ctt.fone);

         printf("Digite o aniversario: ");
         scanf("%2d/%2d/%4d", &ctt.niver.dia, &ctt.niver.mes, &ctt.niver.ano);
     
         fwrite(&ctt, sizeof(CONTATO), 1, Fhandle);

         printf("Deseja continuar (s/n)?");

      }while(getch() == 's');
   }
   fclose(Fhandle);
}

FILE *abrearquivo(char *modo)
{
   FILE* arquivo;
   arquivo = fopen("agenda.dat", modo);

   if(arquivo){
      return arquivo;
   }
   printf("Erro na abertura de AGENDA.DAT\n");
   return NULL;
   
}

void listarData()
{

   FILE* Fhandle = abrearquivo("rb");

   cabecalho();
   if(Fhandle){         
      while(fread(&ctt, sizeof(CONTATO),1, Fhandle)==1){          
         printf("Nome: %s\n", ctt.nome);
         printf("Fone: %s\n", ctt.fone);
         printf("Aniversario: %02d/%02d/%04d\n", ctt.niver.dia, ctt.niver.mes, ctt.niver.ano);
         printf("%s\n", replicate('=',79));
      }
   }
   fclose(Fhandle);
   getch();
}

void pesquisarData()
{
   FILE* Fhandle = abrearquivo("rb");
   char nome[40];
   
   cabecalho();
   if(Fhandle){
      fflush(stdin);
      printf("Digite o nome a pesquisar :");
      gets(nome);
      while(fread(&ctt, sizeof(CONTATO),1, Fhandle) == 1){
         if(strcmp(nome, ctt.nome) == 0){
            printf("Nome: %s\n", ctt.nome);
            printf("Fone: %s\n", ctt.fone);
            printf("Aniversario: %02d/%02d/%04d\n", ctt.niver.dia, ctt.niver.mes, ctt.niver.ano);
            printf("%s\n", replicate('=',79));
         }else{
               printf("Nao localizado. Tecle algo.\n");
               break;
         }

       }
   }
   fclose(Fhandle);
   getch();
}

void niverData()
{
   FILE* Fhandle = abrearquivo("rb");
   int mes;

   cabecalho();
   if(Fhandle){
      fflush(stdin);
      printf("Digite o mes a pesquisar :");
      scanf("%d", &mes);
      while(fread(&ctt, sizeof(CONTATO),1, Fhandle) == 1){
         if(mes == ctt.niver.mes){
            printf("Nome: %s\n", ctt.nome);
            printf("Fone: %s\n", ctt.fone);
            printf("Aniversario: %02d/%02d/%04d\n", ctt.niver.dia, ctt.niver.mes, ctt.niver.ano);
            printf("%s\n", replicate('=',79));
         }else{
               printf("Nao localizado. Tecle algo.\n");
               break;
         }
       }
   }
   fclose(Fhandle);
   getch();
}


int main(void)
{
   //exemplo01();
   //exemplo02();
   //exemplo03();
   //exemplo04();
   //exemplo05();
   //exemplo06();
   //exemplo07();
   menu();



	getch();
   return 0;

}

