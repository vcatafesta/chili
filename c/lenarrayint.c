#include <stdio.h>
#include <stdlib.h>
void metodo1(int arr[]){
    printf("\nMetodo 1");
    int result = *(&arr+1)-arr;
    printf("\nMETODO 1 - Resultado *(&arr+1)-arr: %d",result);
}
void metodo2(int arr[]){
    printf("\n\nMetodo 2");
    int res = sizeof(*(&arr));
    printf("\nResultado sizeof(*(&arr)): %d",res);
    int resu = sizeof(*(&arr+1));
    printf("\nResultado sizeof(*(arr+1)): %d", resu);
    int tamanho = res/resu;
    printf("\nMETODO 2 - Resultado de res/resu: %d",tamanho);
    printf("Numero: %d",(arr));
}

void metodo3(int arr[]){
    printf("\n\nMetodo 3");
    int *inicio;
    int *fim;
    int count=0;
    for (inicio = *(&arr), fim = *(&arr+1); inicio<fim; inicio++){
        count++;
        printf("\ninicio: %d",inicio);
    }
    printf("\nMETODO 3 - Count eh igual a: %d",count);
}

void metodo4(int arr[]){
    printf("\n\nMetodo 4");
    int *n = *(&arr+1);
    printf("\n\nResultado &arr+1: %d",*n);
    int *n1 = *(&arr);
    printf("\nResultado &arr: %d",*n1);
    int g = n-n1;
    printf("\n\nMetodo 4- Resultado de n-n1: %d",g);
}

int main(){
    int arr[12] = {1, 2, 3};
    int opcao;
    do {
	    printf("MENU: ");
	    printf("\n\n0 - Sair");
	    printf("\n1 - Metodo 1");
	    printf("\n2 - Metodo 2");
	    printf("\n3 - Metodo 3");
	    printf("\n4 - Metodo 4");
	    printf("\nOpcao: ");
	    scanf("%d",&opcao);
	  
	    switch(opcao){
	        case 1: metodo1(arr);
		        break;
	        case 2: metodo2(arr);
	   	     break;
	        case 3: metodo3(arr);
	      	  break;
	        case 4: metodo4(arr);
	        default: return 0;
	    }
	    getchar();
	    getchar();
	    system("cls");
  
    }while(opcao != 5);
  
}
