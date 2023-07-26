#include <iostream>
using namespace std;

typedef struct Carro {
	string marca;
	string modelo;
	string cor;
	int ano;
	int velocidade = 0;
	int velmax     = 200;

	void add(string cmarca, string cmodelo, string ccor, int nano, int nvelocidade){
		marca      = cmarca;
		modelo     = cmodelo;
		cor        = ccor;
		ano        = nano;
		changevelocidade(nvelocidade);
	}
	void show(){
		cout << endl;
		cout << "Marca............: " << marca      << endl;
		cout << "Modelo...........: " << modelo     << endl;
		cout << "Cor..............: " << cor        << endl;
		cout << "Ano..............: " << ano        << endl;
		cout << "Velocidade atual.: " << velocidade << endl;
		cout << "Velocidade Max...: " << velmax     << endl;
	}
	void changevelocidade(int nmv){
		velocidade = nmv;		
		if(nmv < 0)
			velocidade = 0;	
		if(nmv > velmax)
			velocidade = velmax;
	}

}TCARRO;

int main()
{
	TCARRO car1;
	TCARRO moto1;

	car1.add("Toyota", "Hilux 3.0", "Prata", 2006, 200);
	car1.changevelocidade(100);
	car1.show();
	moto1.add("Yamaha", "Fazer 600", "Vermelha", 2007, 300);
	moto1.show();
	return 0;
}
