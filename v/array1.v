fn main() {
  mut numeros := []int{}	// Criação de array vazio
  numeros << 5					// adicionou elemento 5
  println(numeros)			// [5]
  println(numeros[0])		// 5
  numeros[0] = 1
  println(numeros)			//[1]
  println(numeros.len)		// 1
  numeros << [2,3,4]			// adicionou 2,3,e 4
  println(numeros)			// [1,2,3,4]
  numeros.delete(1)			// deletou elemento de índice 1
  println(numeros)			//[1,3,4]
  println(3 in numeros)		// true
}
