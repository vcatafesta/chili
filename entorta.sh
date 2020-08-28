#!/bin/bash
#  Montando uma animação no ImageMagick

#  Vou fazer uma figura que servirá como base da animação.
#+ Ela será composta por 1 quadrado azul com 2 retângulos
#+ inscritos, formando a figura base.png
convert -size 150x150 xc:blue                   \
    -fill yellow -draw 'rectangle 5,5 145,72.5' \
    -fill yellow -draw 'rectangle 5,77.5 145,145' base.png

for ((i=1; i<=40; i++))
{
    convert -swirl $((35*$i)) base.png Trab_$i.png #  Gero 40 imagens de trabalho, torcendo (swirl)
                                                   #+ a imagem base.png com incrementos de 35 graus
    Arqs="$Arqs Trab_$i.png"                       #  Concateno o nome de todas as imagens em Arqs
}
#  A animação a seguir é garantida pela opção -coalesce.
#+ A opção -dither é usada para diminuir a perda de qualidade com a redução da qtd de cores.
#+ A opção -colors 32 reduz a qtd de cores.
#+ A opção -layers optimize, usada com a anterior visam acelerar o processo.

convert -coalesce -dither -colors 32 -layers optimize $Arqs Anim.gif

#  Agora, se vc abrir Anim.gif no browser, verá a animação.
