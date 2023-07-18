#include <iostream>

using namespace std;

int main()
{
    int vetor[5];
    int vetor1[5] = {10,20,30,40,50};
    int x = 0;
    int nlen;
    int nlen1;
    int nbytes = 4;

    vetor[0] = 10;
    vetor[1] = 20;
    vetor[2] = 30;
    vetor[3] = 40;
    vetor[4] = 50;

    nlen     = sizeof(vetor)/nbytes;
    nlen1    = sizeof(vetor1)/nbytes;

    cout << "vetor[0] : " << vetor[0] << "\n";
    cout << "vetor1[0] : " << vetor1[0] << "\n";

    for(x=0; x<nlen; x++)
        printf("vetor[%d] : %d\n", x, vetor[x]);
    cout << "vetor["<< x <<"] : " << vetor[x] << "\n";
    x = 0;
    for(x=0; x<nlen1; x++)
        printf("vetor1[%d] : %d\n", x, vetor1[x]);
    cout << "vetor1["<< x <<"] : " << vetor1[x] << "\n";



    return 0;
}
