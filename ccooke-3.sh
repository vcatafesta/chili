#!/bin/bash

# Arkanon <arkanon@lsd.org.br>
# 2021/10/11 (Mon) 05:10:33 -03
# 2020/11/28 (Sat) 20:08:13 -03
# 2019/05/12 (Sun) 21:18:40 -03
# 2018/02/07 (Wed) 22:04:02 -02
# 2018/02/07 (Wed) 20:49:50 -02

clear

# [Mandelbrot Set]

mo() {
	# Charles Cooke - 2008/08/12 Tue 17:36:34 UTC <http://mailman.lug.org.uk/pipermail/gllug/2008-August/076698.html>
	for ((P = 10 ** 8, Q = P / 100, X = 320 * Q / ($(tput cols) - 1), Y = 210 * Q / $(tput lines), y = -105 * Q, v = -220 * Q, x = v; y < 105 * Q; x = v, y += Y)); do
		for (( ; x < P; a = b = i = k = c = 0, x += X)); do
			for (( ; a * a + b * b < 2 * P * P && i++ < 99; a = ((c = a) * a - b * b) / P + x, b = 2 * c * b / P + y)); do :; done
			(((j = (i < 99 ? i % 16 : 0) + 30) > 37 ? k = 1, j -= 8 : 0))
			echo -ne "\E[$k;$j"mE
		done
		echo -e \\E[0m
	done
}

m0() {
	d=\●
	for ((N = 30, I = 30, P = 10 ** 8, Q = P / 100, X = 320 * Q / (COLUMNS - 1), Y = 210 * Q / (LINES - 2), v = -220 * Q, y = -105 * Q; y < 105 * Q; y += Y)); do for ((x = v; x < P; x += X)); do
		for ((a = b = i = k = c = 0; a * a + b * b < 2 * P * P && i++ < I; a = ((c = a) * a - b * b) / P + x, b = 2 * c * b / P + y)); do :; done
		(((j = (i < I ? i % 16 : 0) + N) > N + 7 ? k = 1, j -= 8 : 0))
		printf "\e[$k;${j}m$d"
	done; done
	printf \\e[0m
}

#   d=\ ;for((N=40,I=99,P=10**8,Q=P/100,X=320*Q/(COLUMNS-1),Y=210*Q/(LINES-2),v=-220*Q,y=-105*Q;y<105*Q;y+=Y));{ for((x=v;x<P;x+=X));{ for((a=b=i=k=c=0;a*a+b*b<2*P*P&&i++<I;a=((c=a)*a-b*b)/P+x,b=2*c*b/P+y));{ :;};(((j=(i<I?i%16:0)+N)>N+7?k=1,j-=8:0));printf "\e[$k;${j}m$d";};};printf \\e[0m

# c=150 # 1000  153
# l=50  #  346   46

c=$((COLUMNS - 1))
l=$((LINES - 1))

d=${1:-●}

m1() {
	for ((N = 30, I = 99, P = 10 ** 8, Q = P / 100, X = 320 * Q / c, Y = 210 * Q / l, v = -220 * Q, y = -105 * Q; y < 105 * Q; y += Y)); do
		for ((x = v; x < P; x += X)); do
			for ((a = b = i = k = c = 0; a * a + b * b < 2 * P * P && i++ < I; a = ((c = a) * a - b * b) / P + x, b = 2 * c * b / P + y)); do :; done
			(((j = (i < I ? i % 16 : 0) + N) > N + 7 ? k = 1, j -= 8 : 0))
			printf "\e[$k;${j}m$d"
		done
	done
	printf \\e[0m
}

m2() {
	for ((\
	N = 30, \
	I = 99, \
	P = 10 ** 8, \
	Q = P / 100, \
	X = 320 * Q / c, \
	Y = 210 * Q / l, \
	v = -220 * Q, \
	y = -105 * Q;  \
	y < 105 * Q;  \
	y += Y)); do
		for ((\
		x = v;  \
		x < P;  \
		x += X)); do
			for ((\
			a = b = i = k = c = 0;  \
			a * a + b * b < 2 * P * P && i++ < I;  \
			a = ((c = a) * a - b * b) / P + x, \
			b = (2 * c * b) / P + y)); do
				:
			done
			(((\
			j = (i < I ? i % 16 : 0) + N) > N + 7 ? k = 1, j -= 8 : 0))

			printf "\e[$k;${j}m$d"
		done
	done
	printf \\e[0m
}

m3() {
	pc=2                         # proporção do caractere (h/w)
	pt=$((COLUMNS / LINES))      # proporção da tela (w/h)
	N=30                         # primeira cor ansi
	I=20                         # iterações
	s=47                         # escala
	L=$((-3 * s))                # left
	R=$((2 * s))                 # right
	B=$((-3 * s))                # bottom
	T=$((B + (R - L) / pt * pc)) # top
	X=1                          # incremento x
	Y=$pt                        # incremento y
	for ((y = T; y > B; y -= Y)); do
		for ((x = L; x < R; x += X)); do
			for ((\
			a = b = i = k = c = 0;  \
			a * a + b * b < 2 * R * R && i++ < I;  \
			a = ((c = a) * a - b * b) / R + x, \
			b = (2 * c * b) / R + y)); do
				:
			done
			(((\
			j = (i < I ? i % 16 : 0) + N) > N + 7 ? k = 1, j -= 8 : 0))

			printf "\e[$k;${j}m$d"
		done
		printf "\e[0m\n"
	done | LESS= less -RMSX
}

c1() {

	c=$((COLUMNS - 2))
	l=$((LINES - 2))

	pc=2                    # proporção do caractere (h/w)
	pt=$((COLUMNS / LINES)) # proporção da tela (w/h)

	s=50 # escala

	r=$((2 * s))

	xl=$((-2))             # left
	xr=$((2))              # right
	yb=$((-2))             # bottom
	yt=$((yb + (xr - xl))) # top

	L=$((xl * s))      # left
	R=$((xr * s))      # right
	B=$((yb * s))      # bottom
	T=$((yt * s / pt)) # top

	ix=$(((R - L) / c))
	iy=$(((T - B) / l))

	echo "
     c=$c
     l=$l

    pc=$pc
    pt=$pt

     s=$s

     r=$r

    xl=$xl
    xr=$xr
    yb=$yb
    yt=$yt

    L=$L
    R=$R
    B=$B
    T=$T

    ix=$ix
    iy=$iy
"
	return

	for ((y = T; y > B; y -= iy)); do
		for ((x = L; x < R; x += ix)); do
			((x * x * pc + y * y <= r * r)) && c=31 || c=34
			printf "\e[1;${c}m$d"
		done
		printf "\e[0m\n"
	done # | LESS= less -RMSX

}

# [Life Game]

lo() {
	# Charles Cooke - 2008/08/12 Tue 10:17:12 +0100 <http://mailman.lug.org.uk/pipermail/gllug/2008-August.txt> Message-ID: <20080812091711.GB32341@gkhs.net>
	echo -ne "\E#8"
	b=$((X = $(tput cols), Y = $(tput lines), d = 1, a = X / 2, Y / 2))
	while case $d in 0) ((a = a < 2 ? X : a - 1)) ;; 1) ((b = b < 2 ? Y : b - 1)) ;; 2) ((a = a == X ? 1 : a + 1)) ;; 3) ((b = b == Y ? 1 : b + 1)) ;; esac do
		((c = b + a * X))
		v=${k[c]:- }
		[ $v. = @. ] && {
			((d = d > 2 ? 0 : d + 1))
			k[c]=""
		} || {
			((d = d < 1 ? 3 : d - 1))
			k[c]=@
		}
		echo -ne "\E[$b;${a}H$v"
	done
}

l0() {
	printf "\e#8"
	b=$((X = COLUMNS, Y = LINES, d = 1, a = X / 2, Y / 2))
	while case $d in 0) ((a = a < 2 ? X : a - 1)) ;; 1) ((b = b < 2 ? Y : b - 1)) ;; 2) ((a = a == X ? 1 : a + 1)) ;; 3) ((b = b == Y ? 1 : b + 1)) ;; esac do
		((c = b + a * X))
		v=${k[c]:- }
		[[ $v == @ ]] && {
			((d = d > 2 ? 0 : d + 1))
			k[c]=''
		} || {
			((d = d < 1 ? 3 : d - 1))
			k[c]=@
		}
		printf "\e[$b;${a}H$v"
	done
}

# EOF
