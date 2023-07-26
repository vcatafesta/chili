// zombie.cpp, Copyright (c) 2023 Vilmar Catafesta <vcatafesta@gmail.com>
#include <iostream> 	// std::cout
#include <cstddef> 	// std::size_t
#include <valarray> 	// std::valarray, std::slice
#include <string>
#include <cctype>
#include <cstring>
#include <vector>
#include <array>
#include <algorithm>
#include <functional>
#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <string.h>
#include <signal.h>
#include <sys/wait.h> //wait
#include <unistd.h> 
#include "color.h"

#define SIGHUP  1   /* Hangup the process */ 
#define SIGINT  2   /* Interrupt the process */ 
#define SIGQUIT 3   /* Quit the process */ 
#define SIGILL  4   /* Illegal instruction. */ 
#define SIGTRAP 5   /* Trace trap. */ 
#define SIGABRT 6   /* Abort. */
using namespace std;

void waitexample() {
	int stat;
 
	// This status 1 is reported by WEXITSTATUS
	if (fork() == 0)
		exit(1);
	else
		wait(&stat);
	if (WIFEXITED(stat))
		printf("Exit status: %d\n", WEXITSTATUS(stat));
	else if (WIFSIGNALED(stat))
		psignal(WTERMSIG(stat), "Exit signal");
}

void waitexample2() {
	int i, stat;
	pid_t pid[5];
	for (i=0; i<5; i++) {
		if ((pid[i] = fork()) == 0) {
			sleep(1);
			exit(100 + i);
		}
	}
 
	// Using waitpid() and printing exit status
	// of children.
	for (i=0; i<5; i++) {
		pid_t cpid = waitpid(pid[i], &stat, 0);
		if (WIFEXITED(stat))
			printf("Child %d terminated with status: %d\n",
		cpid, WEXITSTATUS(stat));
    }
}


void pid_example3(){
	if (fork()== 0)
		printf("HC: hello from child\n");
	else {
		printf("HP: hello from parent\n");
		wait(NULL);
		printf("CT: child has terminated\n");
	}
	printf("Bye\n");
	return;
}

void pid_example2(){
	pid_t cpid;
	if (fork()== 0) {
		printf("HC: hello from child\n");
		exit(0);           /* terminate child */
	}
	else
		cpid = wait(NULL); /* reaping parent */
	printf("Parent pid = %d\n", getpid());
	printf("Child pid = %d\n", cpid);
	return;
}

void pid_example1(){
	while(true) {
		if(fork() == 0) {
			printf("zzzzzombie time! brainsssssssssssssss! (%s%d%s)\n", GREEN, getpid(), RESET);
			exit(EXIT_SUCCESS);			
		}
		sleep(1);
	}
	wait(NULL);
	return;
}

int main(int argc, char **argv) {
   std::cout << RED   << "zombie.cpp, Copyright (c) 2023 Vilmar Catafesta <vcatafesta@gmail.com>\n" << RESET << '\n';

//	pid_example1();
	pid_example2();
	pid_example3();
	waitexample();
	waitexample2();
	
   return EXIT_SUCCESS;
}

