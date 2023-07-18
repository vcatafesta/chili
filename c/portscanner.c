/*
 * This example is a very simple Portscanner 
 * for c network programming
 * http://code-reference.com/c/examples/port_scanner
 */
 
#include <stdio.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <errno.h>
#include <netdb.h>
#include <signal.h>
 
int main(int argc, char **argv)
{
  int probeport = 0;
  struct hostent *host;
  int err, i, net,a,b,c,d,anz,x,w;
  struct sockaddr_in sa;
  struct servent *bar;
 
  if (argc != 2) {
    printf("Usage: %s Host\n", argv[0]);
    exit(1);
  }
  printf("\nVery simple PortScanner by http://code-reference.com\n\nHost\t\tPort\tService\n");
 
for (i = 1; i < 65536; i++) {
    strncpy((char *)&sa, "", sizeof sa);
    sa.sin_family = AF_INET;
    if (isdigit(*argv[1]))
      sa.sin_addr.s_addr = inet_addr(argv[1]);
    else if ((host = gethostbyname(argv[1])) != 0)
      strncpy((char *)&sa.sin_addr, (char *)host->h_addr, sizeof sa.sin_addr);
    else {
      herror(argv[1]);
      exit(2);
    }
    sa.sin_port = htons(i);
    net = socket(AF_INET, SOCK_STREAM, 0);
    if (net < 0) {
      perror("\nsocket");
      exit(2);
    }
    err = connect(net, (struct sockaddr *) &sa, sizeof sa);
    if (err < 0) {
      //printf("%s %-5d %s\r", argv[1], i, strerror(errno));
      fflush(stdout);
    } else {
    bar = getservbyport(htons(i),"tcp"); 
    printf("%s\t%d\t%s\n",argv[1],i,(bar == NULL) ? "UNKNOWN" : bar->s_name);
    if (shutdown(net, 2) < 0) {
	perror("\nshutdown");
	exit(2);
      }
    }
    close(net);
  }
  printf("                                                  \r");
  fflush(stdout);
  printf("\n");
  return (0);
}
