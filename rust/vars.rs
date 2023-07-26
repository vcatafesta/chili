fn main(){
	let a;
	{
		let b = String::from("Vilmar");
		a = b;
	}
	println!("{}{}", a, b);
}
