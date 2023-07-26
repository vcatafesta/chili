for i := 0; i < 1000; i++ {
	// Pula o número 3
	if i == 3 {
		continue
	}
	// Para no número 7
	if i > 999 {
		break
	}
	println(i)
}
