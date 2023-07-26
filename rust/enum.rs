#[allow(dead_code)]
#[derive(Debug)]
enum Estado {
    Vivo,
    Morto,
    Aderiva
}

#[derive(Debug)]
struct Pessoa {
    nome: String,
    idade: u8,
    estado: Estado
}

impl Pessoa {
    fn new(nome: String, idade: u8, estado: Estado) -> Pessoa {
        Pessoa {
            nome: nome,
            idade: idade,
            estado: estado
        }
    }
    fn show(&self) {
        println!("Nome: {nome}\nIdade: {idade}\nEstado: {estado:?}\n", nome=self.nome, idade=self.idade, estado=self.estado);
    }
}

fn main() {
    let p1: Pessoa = Pessoa::new(String::from("Roger"), 25, Estado::Aderiva);
    p1.show();
    // dbg!(p1);
}
