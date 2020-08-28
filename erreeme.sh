#/bin/bash
#
#  Salvando Copia de Arquivo Antes de Remove-lo
#

if  [ $# -eq 0 ]  #  Tem de ter um ou mais arquivos para remover
then
    echo "Erro -> Uso: erreeme arq [arq] ... [arq]"
    echo "  O uso de metacaracteres e’ permitido. Ex. erreeme arq*"
    exit 1
fi


MeuDir="/tmp/$LOGNAME" # Variavel do sist. Contém o nome do usuário.
if  [ ! -d $MeuDir ]   # Se não existir o meu diretório sob o /tmp...
then
    mkdir $MeuDir      # Vou cria-lo
fi


if  [ ! -w $MeuDir ]   # Se não posso gravar no diretório...
then
    echo Impossivel salvar arquivos em $MeuDir. Mude permissao...
    exit 2
fi


Erro=0                 # Variavel para indicar o cod. de retorno do prg
for Arq                # For sem o "in" recebe os parametros passados
do
    if  [ ! -f $Arq ]  # Se este arquivo não existir...
    then
        echo $Arq nao existe.
        Erro=3
        continue       # Volta para o comando for
    fi


 DirOrig=`dirname $Arq` # Cmd. dirname informa nome do dir de $Arq
    if  [ ! -w $DirOrig ]  # Verifica permissão de gravacaoo no diretório
    then
        echo Sem permissao de remover no diretorio de $Arq
        Erro=4
        continue           # Volta para o comando for
    fi


    if  [ "$DirOrig" = "$MeuDir" ] # Se estou "esvaziando a lixeira"...
    then
        echo $Arq ficara sem copia de seguranca
        rm -i $Arq         # Pergunta antes de remover
        [ -f $Arq ] || echo $Arq removido  # Será que o usuario removeu?
        continue
    fi


    cd $DirOrig     # Guardo no fim do arquivo o seu diretorio
    pwd >> $Arq  # original para usa-lo em um script de undelete
    mv $Arq $MeuDir  # Salvo e removo
    echo $Arq removido
done
exit $Erro # Passo eventual numero do erro para o codigo de retorno
