#include "funcoes.c"
#include <threads.h>
#include <unistd.h>

void myturn(){
	while(1)
	{
		sleep(1);
		printf("My turn!\n");
	}
}

void yourturn(){
	while(1)
	{
		sleep(2);
		printf("Your turn!\n");
	}
}

int main()
{
	thrd_t newthread;
	int rc = thrd_create(&newthread, (thrd_start_t) myturn, (void *));

        if (rc == thrd_error) {
            printf("ERORR; thrd_create() call failed\n");
            exit(EXIT_FAILURE);
        }

	//myturn();
	yourturn();
	return 0;
}
