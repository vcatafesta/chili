#[allow(unused_variables)]

fn main()
{
	let s = String::from("hello");
	let rect: (u32, u32 ) = (30,50);
	let mut s = String::from("hello");
	s.push_str(", world!"); // push_str() appends a literal to a String

	println!("{}", s); // This will print `hello, world!`
	println!(
		"Area: {}",
		area(rect)
	);
}

fn area(dimensions: (u32,u32)) ->u32 {
	dimensions.0 * dimensions.1
}

fn divide(dividend: i32, divisor: i32) -> Option<i32> {
	if divisor == 0 { return None; }
	Some(dividend / divisor)
}
