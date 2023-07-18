#!/usr/bin/awk -f
BEGIN {
	if( ARGV[1] == ""){
		print "Informe um numero"
	}else{
		print "Raiz quadradra de "ARGV[1]" : " int(sqrt(ARGV[1]))
	}
	{ print "Conteudo" }
	print 8 + 8
	print 8 * 8

	num=1
	while(num <= 10){
		print num
		num++
	}
}
