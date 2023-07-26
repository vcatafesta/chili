use std::io;
use libc::{kill, SIGKILL};

fn main() {
	println!("Digite o PID do processo a ser morto:");
	let mut input = String::new();
	io::stdin().read_line(&mut input).unwrap();
	let pid: i32 = input.trim().parse().unwrap();

	let result = unsafe { kill(pid, SIGKILL) };
	if result == 0 {
		println!("Processo com PID {} foi morto.", pid);
	} else {
		println!("Erro ao matar processo com PID {}.", pid);
	}
}
