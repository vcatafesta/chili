#include<unistd.h>
#include<stdio.h>
#include<time.h>
#include<signal.h>

#define INTERVAL 5

void mensagem(int signum)
{
	time_t tp;
   time(&tp);
   printf("%s", ctime(&tp));
 }

void main()
{
	signal(SIGALRM, mensagem);
   printf("*** inicio do programa\n");
   while(1)
   {
   	alarm(INTERVAL);
      pause();
	}
}
