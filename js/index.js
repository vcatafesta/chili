let nome = 'vcatafesta'
let idade = 55
let altura = 1.80
str = nome
str += ' ' + idade
str += ' ' + altura

console.log(nome, idade, altura)
console.log(str)

let valorIngressoAdulto = 20
let valoringressoadulto = 10
console.log(valorIngressoAdulto)
console.log(valoringressoadulto)

function dizerNome() {
  console.log(nome)
}

function quadrado(num) {
  return num * num
}

dizerNome()
raiz = quadrado(2)
console.log(raiz)
console.log(--idade);

console.log(1 === 1);     // true
console.log(1 === '1');   // false
console.log(1 == 1);      // true
console.log(1 == '1');    // true

// 
let corA = 'vermelho'
let corB = 'azul'
console.log(corA);
console.log(corB);
console.log(corA.repeat(10))

if (corA === 'vermelho') {
  console.log('Cor é :', corA)
}
else if (corB === 'azul') {
  console.log('Cor é :', corB)
}
else {
  console.log('Qual a cor?')
}

// 
let usuario = 'diretor'
switch (usuario) {
  case 'comum':
    console.log('Usuário comum');
    break;
  case 'gerente':
    console.log('Usuário gerente');
    break;
  case 'diretor':
    console.log('Usuário diretor');
    break;
  default:
    console.log('Usuário não definido');
    break;
}

// 
for (let index = 1; index <= 10; index++) {
  console.log('Estou aprendendo:', index);
}
