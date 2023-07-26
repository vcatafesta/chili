fn produto_escalar(n f64, mut vetor [] f64) {
  for i in 0..vetor.len {
    vetor[i] *= 2
  }
}

fn main() {
  mut nums := [1.0, 2.0, 3.0]
  produto_escalar(4, mut nums)
  println(nums) // "[4.0, 8.0, 12.0]"
}
