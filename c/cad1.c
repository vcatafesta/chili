
#include<stdio.h>
struct clientData
{
	int acctNum;
	char lastName[15];
	char firstName[10];
	double balance;
};
int main()
{
	int i;
	struct clientData client={0,"","",0.0};
	FILE *cfPtr;
	if ((cfPtr = fopen("credit.dat","rb+"))== NULL)
	{
		printf("File could not be opened.\n");
	}
	else
	{
		printf("Enter account number(1 to 100, 0 to end input\n");
		scanf("%d",&client.acctNum);
		while (client.acctNum!=0)
		{
			printf("Enter lastname, firstname, balance\n");
			fscanf(stdin,"%s%s%lf",client.lastName,client.firstName,&client.balance);
			//在文件中定位用户指定的记录
			fseek(cfPtr,(client.acctNum-1)*sizeof(struct clientData),SEEK_SET);
			//将用户指定的信息写入文件
			fwrite(&client,sizeof(struct clientData),1,cfPtr);
 
			//输入下一个账号
			printf("Enter account number:\n");
			scanf("%d",&client.acctNum);
		}
		fclose(cfPtr);
	}
	return 0;
}
