use std::io;

fn main() {
	let numbers = (1, 2, 3, 4.5);
	println!("{:?}", numbers);
	println!("{:?}", numbers.0);
	println!("{:?}", numbers.3);

	let l0 = 'V';
	println!("{l0}");

	let s: String = "Vilmar, o gatinho".to_string();
	println!("{}", s);

	let mut vazia : String = String::new();
	vazia.push_str("Vilmar");
	vazia.push_str(" ");
	vazia.push_str("Catafesta");
	println!("{}", vazia);

	let nome   : String = String::from("vilmar");
	println!("{}", nome);

	let x: String = "Vilmar".into();
	println!("{s}");

	let mut cNome = String::new();
	println!("Digite : ");
	io::stdin().read_line(&mut cNome).expect("Erro: no input");
	println!("Digitou {}", cNome);
	println!("Letras {}", cNome.trim().len());


}
