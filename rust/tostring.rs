struct Person {
	name: String,
	age: i32
}

impl Person {
	fn sayhi(&self) -> String {
		format!("Meu nome é {} eu tenho {} anos\n", self.name, self.age)
	}
}

fn main() {
	let person = Person { name: "Vilmar Catafesta".to_string(), age: 53};
	print!("{}\n", person.sayhi())
}
