use std::io::{stdin, stdout, Read, Write};
use termion::event::Key;
use termion::input::TermRead;

fn main() {
    let mut stdout = stdout();
    write!(stdout, "Pressione uma tecla: ").unwrap();
    stdout.flush().unwrap();

    for c in stdin().keys() {
        match c.unwrap() {
            Key::Char('q') => {
                write!(stdout, "\n\rSaindo...\n\r").unwrap();
                break;
            }
            Key::Char(c) => {
                write!(stdout, "\n\rVocê pressionou a tecla '{}'.\n\r", c).unwrap();
                write!(stdout, "Pressione outra tecla: ").unwrap();
                stdout.flush().unwrap();
            }
            _ => {}
        }
    }
}
