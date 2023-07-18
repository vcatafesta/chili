#!/bin/bash
#
# Despertador usando Shell e Zenity
# Copyright 2009 Lucas Mazzardo Veloso <lmveloso#gmail-com>
#
# This is a Free Software relized under the terms of
# the GNU-GPL: http://www.gnu.org/licenses/gpl-3.0.html
#

IMGDIR=$(dirname $0)
P_SLEEP=15

function ajuda {
    echo "
     Despertador usando Shell e Zenity

     despertador [--text TEXTO] [--time 23:59] [--sleep 15]

 Parametros:
   --text TEXTO   Informa o texto do despertador, se não informado
                  será aberta uma caixa de diálogo para entrada do texto.
   --time 23:59   Informa o horário do despertador, se não informado.
                  será aberta uma caixa de diálogo para entrada do horário.
   --sleep 15     Informa o tempo de soneca em segundos, se não informado
                  assume 15 segundos;
   --help         Exibe essa tela de ajuda.
"
}

# Faz o parse da linha de comando
until [[ ! "$*" ]]; do
    if [[ ${1:0:2} = '--' ]]; then
        PARAMETRO=$(echo ${1:2} | tr [:lower:] [:upper:])
        case "$PARAMETRO" in 
        "TEXT")
            shift
            P_TEXT=$1
            ;;
        "TIME")
            shift
            P_TIME=$1
            ;;
        "SLEEP")
            shift
            [[ $1 =~ ^[0-9]+$ ]] && P_SLEEP=$1
            ;;
        "HELP")
            ajuda
            exit 0
            ;;
        *)
            ajuda
            exit 1
            ;;
        esac
    else
        ajuda
        exit 1
    fi
    shift
done

# Captura a Descrição da Atividade com o Zenity se não foi informado via 
# linha de comando como --text "Texto da atividade"
[ "$P_TEXT" ] && Atividade=$P_TEXT || 
{
    if ! Atividade=$(zenity --entry           \
            --title "Descrição "              \
            --entry-text "Bater o Ponto"      \
            --width 400                       \
            --window-icon $IMGDIR/despertador-add.svg \
            --text "Informe a Descrição da Atividade :") 
    then
        exit 1
    fi
    [ "$Atividade" ] || exit 1
}

# Captura o Horário com o Zenity se não foi informado via 
# linha de comando como --time 23:59
[ "$P_TIME" ] && Horario=$P_TIME ||
{
    until [ "$Horario" ]
    do
        Horario=$(echo "`echo $(date +%H)+1 | bc`:$(date +%M)")
        if ! Horario=$(zenity --entry                         \
                --title "Horário para Despertar "             \
                --entry-text "$Horario"                       \
                --width 300                                   \
                --window-icon $IMGDIR/despertador-add.svg     \
                --text "Informe o horário para despertar :") 
        then
            exit 1
        fi
        # Testa se o horário está no formato 23:59
        [[ "$Horario" =~ ^[0,1][0-9]:[0-5][0-9]$ || "$Horario" =~ ^2[0-3]:[0-5][0-9]$ ]] || \
            { 
                zenity --error                                            \
                    --title "Horário para Despertar "                     \
                    --text "\\n<b>O Horário informado '$Horario' é inválido !</b>   \
\\nInforme um horário no formato <b>23:59</b>"        \
                    --no-wrap \
                    --window-icon $IMGDIR/despertador-add.svg 
                Horario=""
            }    
    done
}

# Garante que o horário está no formato correto 23:59
[[ "$Horario" =~ ^[0,1][0-9]:[0-5][0-9]$ || "$Horario" =~ ^2[0-3]:[0-5][0-9]$ ]] || \
{
ERRO: Horário inválido. Informe um horário no formato 23:59"
    exit 1
}    

# Cria um ícone personalizado com o horário
TMPDIR=$( mktemp -d )
ICONE=$TMPDIR/despertador.svg
ICONEALERTA=$TMPDIR/despertador-alert.svg
sed -e "s/XXxXX/$Horario/" $IMGDIR/despertador-time.svg > $ICONE
sed -e "s/XXxXX/$Horario/" $IMGDIR/despertador-alert.svg > $ICONEALERTA

# Exibe o ícone de notificação
zenity --notification --text "[$Horario] $Atividade" \
    --window-icon $ICONE &
PIDZenity=$!

# Aguarda o Horário especificado
until [ $(date +%H:%M) == "$Horario" ] ; do 
    # Verifica se o usuário clicou no ícone de notificação do Zenity
    if ! [ "$(ps -p $PIDZenity --no-headers)" ]
    then
        if zenity --question                                         \
            --title "Cancelar Despertador"                           \
            --no-wrap                                                \
            --text "<b>Deseja realmente cancelar esse despertador ?</b> \
            \\n\n[<b>$Horario</b>] - <i><big>$Atividade</big></i>" \
            --window-icon $ICONEALERTA
        then
            exit 0
        else
            zenity --notification --text "[$Horario] $Atividade" \
                --window-icon $ICONE & 
            PIDZenity=$!
        fi
    fi
    sleep 0.3
done
kill $PIDZenity

# Horário atingido! Notifica o usuário
exec 6> >( zenity --notification --text "Atenção: [$Horario] $Atividade" \
    --window-icon $ICONEALERTA --listen )

# Exibe notificação até o usuário cancelar o despertador
until [ "$cancelar" ]
do
    echo "message:Atenção:\n\n [$Horario] $Atividade\n" >&6
    for ((int=1; int<=100; int++))
    do
        echo $int
        sleep 0.15
    done | zenity --progress                 \
        --title="Despertador $Horario"       \
        --text="Atenção:\n\n<big>[<b>$Horario</b>]  <b>$Atividade</b></big>\n\
            \n<i>Pressione Cancelar para desligar o Despertador.</i>" \
        --auto-close                         \
        --window-icon $ICONEALERTA
    out=$?
    [ $out == 0 ] && sleep $P_SLEEP || cancelar=sim
done

exec 6>&-
rm -rf $TMPDIR
