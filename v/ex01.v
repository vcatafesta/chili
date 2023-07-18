fn div(n1 f64, n2 f64) (bool, f64) {
	mut err := false
	mut ret := 0.0
	if n2 == 0 {
		err = true
	} else {
		ret = n1 / n2
	}
	return err, ret
}

fn main() {
	e, r := div(6, 2)
	println('$e $r')
}
