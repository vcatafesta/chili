#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <signal.h>  // kill

int main(int argc, char **argv)
{
    unsigned int pid;

    if (argc != 2) {
        printf("Macrosoft checkpid\n", argv[0]);
        printf("Uso: %s PID\n", argv[0]);
        return 1;
    }

    pid = (unsigned int) atoi(argv[1]);

    if (!kill(pid, 0))
        printf("%d esta em execucao.\n", pid);
    else
        printf("%d nao esta em execucao.\n", pid);

    return 0;
}
