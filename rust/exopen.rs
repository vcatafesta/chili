use std::fs::File;
use std::io::Read; // Trait para usar o método `read_to_string()`

fn main() {
   match File::open("exemplo.txt") {
      Ok(mut file) => {
         let mut txt = String::new();
         file.read_to_string(&mut txt).ok(); // `ok()` ignora o Result desta chamada
         println!("{}", txt);
      }
      Err(err) => eprintln!("Erro: {}", err),
   }
}
