#include <stdio.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <netdb.h>
#include <arpa/inet.h>

#define fir 16777216
#define sec 65536
#define the 256
 
int s;
struct sockaddr_in addr;
char rmt_host[100];
int skan(port)

int port;
{
	int r;
	s = socket(PF_INET, SOCK_STREAM, IPPROTO_TCP);
	if (s < 0) {
       printf("ERROR: socket() failed\n");
       exit(0);
    }
 
    addr.sin_family      = PF_INET;
    addr.sin_port        = htons(port);
    addr.sin_addr.s_addr = inet_addr(rmt_host);
 
    r = connect(s,(struct sockaddr *) &addr, sizeof(addr));
 
    close(s);
    if (r==-1) {
       return (1 == 0);
    }
 
    return (1 == 1);
}
 
int main(argc,argv) 
	int argc;
	char *argv[];
	{
	 int a,b,c,d,e,f,w;
	 struct hostent *foo,*rechner;
	 struct servent *bar; 
	 struct in_addr gesamt_ip;
	 int i1,i2,i3,i4;
	 unsigned long x,an;
	 FILE *savefile;
	   w=0;    
	   if (argc < 2) {
	      fprintf(stderr,"usage: %s <start IP> <number to scanning IP's>\n",argv[0]);
	      exit(0);
	   }
	inet_aton(argv[1],&gesamt_ip);
	sscanf(argv[1],"%d.%d.%d.%d",&i1,&i2,&i3,&i4);
	sscanf(argv[2],"%lu",&an);
	printf("Start IP: %s  - number to scanning IP's: %lu\n\n",inet_ntoa(gesamt_ip),an);
	for(x=0;x<an;x++)
	{
	foo = gethostbyname(inet_ntoa(gesamt_ip));
	rechner =gethostbyaddr((char *) &gesamt_ip, sizeof(gesamt_ip), AF_INET);
	printf("Scanning %s ...",inet_ntoa(gesamt_ip));
	  if (rechner == NULL) {
	     fprintf(stderr,"31mNot aviable28m\n");
	  }
	  if (rechner != NULL){
	  savefile=fopen("hosts","a+");
	  fprintf(savefile,"OK-Domain: %s (%d.%d.%d.%d)\n",rechner->h_name ,(unsigned char )foo->h_addr_list[0][0],
	              (unsigned char ) foo->h_addr_list[0][1], 
	              (unsigned char ) foo->h_addr_list[0][2], 
	              (unsigned char ) foo->h_addr_list[0][3]);
	  printf("32mOK28m-Domain: %s",rechner->h_name);
	  fclose(savefile);
	  }
	  sprintf(rmt_host,"%d.%d.%d.%d",(unsigned char )foo->h_addr_list[0][0],
	              (unsigned char ) foo->h_addr_list[0][1], 
	              (unsigned char ) foo->h_addr_list[0][2], 
	              (unsigned char ) foo->h_addr_list[0][3]);
	printf("\n");    
	i4=i4+1;
	gesamt_ip.s_addr=gesamt_ip.s_addr+fir;
	if (i4 == 256)
	{i4=0;i3=i3+1;w=3;gesamt_ip.s_addr=gesamt_ip.s_addr+sec;}
	if (i3 == 256)
	{i3=0;i2=i2+1;w=2;gesamt_ip.s_addr=gesamt_ip.s_addr+the;}
	if (i2 == 256)
	{i2=0;i1=i1+1;w=1;gesamt_ip.s_addr=gesamt_ip.s_addr+1;}
	if (i1 == 256)
	{exit(0);}
	 
	}
}
