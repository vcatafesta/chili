struct Color {
	red: i8,
	blue: i8,
	green: i8
}

fn main(){

	let mut bg = Color{red: 18, blue: 20, green: 25};
	println!("{} {} {}", bg.red, bg.blue, bg.green);
	bg.red = 35;
	println!("{} {} {}", bg.red, bg.blue, bg.green);
}
