function minhaFuncao(objeto) {
  objeto.make = "Toyota";
}

var meucarro = {make: "Honda", model: "Accord", year: 1998};
var x, y;

x = meucarro.make;     	// x recebe o valor "Honda"
console.log(x)

minhaFuncao(meucarro);
y = meucarro.make;     	// y recebe o valor "Toyota"
                    		// (a propriedade make foi alterada pela função)
console.log(y)


var meuCarro = new Object();
	meuCarro.fabricacao = "Ford";
	meuCarro.modelo = "Mustang";
	meuCarro.ano = 1969;

console.log(meuCarro.fabricacao)
console.log(meuCarro.modelo)
console.log(meuCarro.ano)
console.log(meuCarro.semPropriedade)

meuCarro["fabricacao"] = "Ford";
meuCarro["modelo"] = "Mustang";
meuCarro["ano"] = 1969;

var meuObj = new Object(),
    str = "minhaString",
    aleat = Math.random(),
    obj = new Object();

meuObj.tipo               = "Sintaxe de ponto";
meuObj["data de criacao"] = "String com espaco";
meuObj[str]               = "valor de String";
meuObj[aleat]             = "Numero Aleatorio";
meuObj[obj]               = "Objeto";
meuObj[""]                = "Mesmo uma string vazia";

console.log(meuObj);

var nomeDaPropriedade = "fabricacao";
meuCarro[nomeDaPropriedade] = "Ford";

nomeDaPropriedade = "modelo";
meuCarro[nomeDaPropriedade] = "Mustang";


function mostrarProps(obj, nomeDoObj) {
  var resultado = "";
  for (var i in obj) {
    if (obj.hasOwnProperty(i)) {
        resultado += nomeDoObj + "." + i + " = " + obj[i] + "\n";
    }
  }
  return resultado;
}
console.log(mostrarProps(meuCarro, "meuCarro"))

const object = { a: 1, b: 2, c: 3 };
for (const property in object) {
  console.log(`${property}: ${object[property]}`);
}


