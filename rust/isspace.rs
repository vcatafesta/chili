

fn is_whitespace(text: &str) -> bool {
   text.chars()
   .all(|c| c.is_whitespace())
}


fn main(){
   print!("{}\n", is_whitespace("Vilmar Catafesta"))
}



