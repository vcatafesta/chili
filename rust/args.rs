#[allow(unused_variables)]
use std::env;

fn main()
{
   let args = env::args();
   let str  = env::args().collect::<Vec<String>>();
   println!("{:?}", args);
   println!("{:?}", str);
}
