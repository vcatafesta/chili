fn main() {
    let altura = 20;

    for i in 1..=altura {
        // Espaços à esquerda
        for _ in 0..(altura - i) {
            print!(" ");
        }

        // Caracteres no centro
        for _ in 0..(2 * i - 1) {
            print!("#");
        }

        // Nova linha após cada linha do triângulo
        println!();
    }
}
