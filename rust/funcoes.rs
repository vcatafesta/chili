struct Pair<T> {
	a: T,
	b: T,
}

struct Number {
	odd: bool,
	value: i32,
}

impl Number {
	fn is_positive(self) -> bool {
		self.value > 0
	}
}

fn print_number(n: Number) {
	match n.value {
		1 => println!("One"),
		2 => println!("Two"),
		_ => println!("{}", n.value),
	}
}

fn greet() {
	println!("Hi there!");
}

fn fair_dice_roll() -> i32 {
	4
}

fn main() {
	greet();
	println!("{}", fair_dice_roll());

	let a = (10, 20);
	let nick="vcatafesta";
	println!("{}",nick.len());

	let p1 = Pair {a:3, b:9};
	let p2 = Pair {a:true, b:false};

	let s1 = str::from_utf8(
		&[240, 159, 141, 137]
	);
	println!("{:?}", s1);


}
