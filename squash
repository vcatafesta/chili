#!/bin/bash
. /lib/lsb/init-functions

export XHOME="/home/vcatafesta"
export BASE="/home/vcatafesta/chilios-live"
export LIVE="/home/vcatafesta/chilios-live/cd/live"
export GRUB="/home/vcatafesta/chilios-live/cd/boot/grub"
export WORK="/home/vcatafesta/chilios-live/work/rootfs"
export WORKDEV="/home/vcatafesta/chilios-live/work/rootfs/dev"
export WORKDEVPTS="/home/vcatafesta/chilios-live/work/rootfs/dev/pts"
export WORKPROC="/home/vcatafesta/chilios-live/work/rootfs/proc"
export WORKSYS="/home/vcatafesta/chilios-live/work/rootfs/sys"
export WORKMEDIA="/home/vcatafesta/chilios-live/work/rootfs/media"
export WORKTMP="/home/vcatafesta/chilios-live/work/rootfs/tmp"

log_info_msg "mkdir -p $LIVE"
mkdir -p $LIVE
evaluate_retval

log_info_msg "mkdir -p $GRUB"
mkdir -p $GRUB
evaluate_retval

log_info_msg "mkdir -p $WORK"
mkdir -p $WORK
evaluate_retval

log_info_msg "rsync -av Aguarde, sincronizando diretorios..."
rsync -av 				\
--one-file-system 		\
--exclude=/proc/* 		\
--exclude=/etc/bashrc	\
--exclude=/dev/* 		\
--exclude=/sys/* 		\
--exclude=/tmp/* 		\
--exclude=/media/* 		\
--exclude=/mnt/* 		\
--exclude=/lost+found 	\
--exclude=/chili 		\
--exclude=/harbour 		\
--exclude=/tools		\
--exclude=/jhalfs		\
--exclude=/mazon		\
--exclude=/mazonos		\
--exclude=/sources		\
--exclude=/home/*		\
--exclude=/usr/src/*	\
--exclude=/var/log/journal/*	\
--exclude=/packages		\
--exclude=$BASE 		\
/ 						\
$WORK > /dev/null 2>&1
evaluate_retval

# Nessa etapa vamos entrar no sistema de trabalho e fazer as nossas personalizações (adicionar e remover programas, alterar
# configurações, instalar temas, papéis de parede etc). Essa é a etapa mais longa e dinâmica, mas também a mais interessante.

# Antes de entrar no sistema de trabalho, vamos fazer alguns preparativos para que ele possa acessar os recursos do sistema
# que está atualmente em execução (vamos "emprestar" alguns recursos do nosso sistema para o sistema de trabalho):

log_info_msg "mount --bind /dev $WORKDEV"
mount --bind /dev "$WORKDEV"
evaluate_retval

log_info_msg "mount -t devpts none $WORKDEVPTS"
mount -t devpts none "$WORKDEVPTS"
evaluate_retval

log_info_msg "mount -t devpts none $WORKDEVPTS"
mount --bind /proc "$WORKPROC"
evaluate_retval

log_info_msg "mount --bind /sys $WORKSYS"
mount --bind /sys "$WORKSYS"
evaluate_retval

log_info_msg "mount --bind /media $WORKMEDIA"
mount --bind /media "$WORKMEDIA"
evaluate_retval

log_info_msg "mount --bind /tmp $WORKTMP"
mount --bind /tmp "$WORKTMP"
evaluate_retval

# Agora sim podemos de fato entrar no sistema. Para isso execute o seguinte comando no terminal:
log_info_msg "chroot $WORK /bin/bash"
chroot $WORK /bin/bash
evaluate_retval

# A partir de agora todos os comandos que você executar nessa seção do terminal serão aplicados ao sistema que está na pasta
# de trabalho e não ao sistema que está instalado no seu computador.

# Quando desejar sair do sistema de trabalho e voltar para o seu sistema (não faça isso ainda, estou falando apenas para você
# tomar conhecimento), você pode executar o comando:

#exit

# Você pode entrar e sair do sistema de trabalho quantas vezes quiser, executando esses mesmos comandos.
# Antes de prosseguir à instalação de pacotes, se você desejar que o sistema de trabalho utilize repositórios diferentes dos
# que utiliza no seu sistema, pode apagar o arquivo "/etc/apt/sources.list" e criar um novo, contendo os novos repositórios
# (até indicação contrária, todos os comandos a seguir devem ser executados dentro do sistema de trabalho):

# rm -f /etc/apt/sources.list
# echo "deb http://ftp.br.debian.org/debian lenny main contrib non-free" >> /etc/apt/sources.list

# Repita o segundo comando para cada um dos repositórios que você deseja adicionar à lista de repositórios do sistema de
# trabalho. Lembre-se de depois atualizar a lista de pacotes desses repositórios executando o comando:

# apt-get update

# Observe que esses comandos são opcionais. Sua execução, como disse acima, só é necessária se você deseja que o sistema de
# trabalho utilize repositórios diferentes dos que você utiliza no seu sistema. Tenha em mente que esses serão os
# repositórios que serão utilizados para instalar programas não só agora, como também quando estiver utilizando seu LiveCD.

# Pronto, agora você pode efetuar quaisquer mudanças que desejar, inclusive instalar e remover pacotes e alterar arquivos de
# configuração, da mesma forma como faria no seu sistema normal. Você pode utilizar o terminal no qual você já está ou
# iniciar um ambiente gráfico, se achar mais cômodo.

# Antes de iniciar o ambiente gráfico pelo sistema de trabalho, você deve sair do sistema de trabalho e iniciar uma nova
# instância do X no seu sistema.

# Primeiramente, execute o seguinte comando, que permitirá ao ambiente gráfico do sistema de trabalho se conectar ao X do
# sistema em execução:

#xhost +

# Agora podemos iniciar uma nova instância do X de fato. Isso pode ser feito de duas formas: uma delas é a convencional, na
# qual a tela toda será utilizada para mostrar o ambiente gráfico. Para iniciar uma nova instância do X dessa forma execute o
# comando:

#X -dpi 75 :1

# Ele abrirá uma nova seção do X contendo apenas a tela cinza e o cursor do mouse. Volte para a seção principal do X (a que
# contém o ambiente gráfico do sistema instalado) pressionando Ctrl + Alt + F7.

# A outra forma é usar o xnest. O ambiente gráfico será então iniciado dentro de uma janela, como se o sistema de trabalho
# estivesse sendo executado em uma máquina virtual. Para isso, execute o seguinte comando como um usuário comum:

#Xnest -ac :1

# Em ambas as alternativas, você terá uma seção do X iniciada esperando pelo ambiente gráfico do sistema de trabalho. A
# segunda opção é a mais cômoda, visto que você não tem que utilizar combinações de teclas para alternar entre as seções
# do X que estão em execução, no entanto é a mais precária, e pode ocasionar alguns problemas que geralmente não ocorrem
# quando a seção é iniciada da forma convencional.

# Independente de qual forma você tenha iniciado uma nova seção do X, inicie agora uma nova seção do terminal, entre
# novamente no sistema de trabalho e execute os seguintes comandos, que iniciarão o ambiente gráfico do sistema de trabalho
# na seção do X que você acabou de iniciar:

#su vcatafesta
#export DISPLAY=localhost:1
#startxfce4

# Se você optou por iniciar o X da forma convencional, você verá agora o ambiente gráfico do sistema de trabalho. Você pode
# retornar a qualquer momento para o ambiente gráfico do sistema instalado pressionando Ctrl + Alt + F7. Depois, se quiser,
# você pode voltar para o ambiente gráfico do sistema de trabalho pressionando Ctrl + Alt + F8. Você pode alternar entre os
# ambientes gráficos dos dois sistemas quantas vezes quiser até concluir o seu trabalho.

# Uma observação que deve ser feita é com relação à capacidade de armazenamento da mídia que será utilizada: se você pretende
# criar um LiveCD, o sistema de trabalho não deve ocupar um espaço superior a 2 GB.

# Se ele ultrapassar esse tamanho, você tem duas opções: remover programas e arquivos até que atinja um tamanho o mais
# próximo possível de 2 GB, para que após a compactação (que faremos na etapa E) ele caiba em um CD, ou utilizar um DVD ao invés de um
# CD para armazenar o sistema (nesse caso, você não estaria criando um LiveCD, mas sim um LiveDVD), o que não afetará em nada
# a execução desse tutorial.

# Depois de fazer todas as alterações desejadas, feche o XFCE pelo Menu > Fechar Sessão > Finalizar sessão atual.


# ETAPA D - FAZER AS MODIFICAÇÕES NECESSÁRIAS NO SISTEMA DE TRABALHO

# Nessa etapa faremos mais modificações dentro do sistema de trabalho. A diferença dessa etapa para a anterior é que as
# alterações que faremos agora são necessárias para que o sistema possa ser executado a partir de um CD.

# Para começar, de volta ao terminal do sistema de trabalho, vamos instalar alguns pacotes:

#apt-get install live-initramfs aufs-modules-$(uname -r) discover1 xresprobe memtest86+

# Só para não passar em branco, uma breve explicação sobre os pacotes: o pacote live-initramfs contém os scripts que serão
# executados durante a inicialização do LiveCD. O pacote aufs-modules é responsável por instalar no sistema o AuFS, já
# explicado anteriormente, que permite que façamos alterações no sistema durante a execução do LiveCD, gravando essas
# alterações na memória RAM. Os pacotes discover1 e xresprobe são responsáveis por detectar e configurar o hardware na
# inicialização do sistema. Por fim, o pacote memtest86+ contém um programa que testa a memória do computador, também já
# citado anteriormente. Ele pode ser acessado pelo menu que aparece na inicialização do LiveCD. Sua instalação na verdade é
# opcional, mas como ele é incluído em quase todos os LiveCDs, vamos incluí-lo também no nosso.

# Feito isso, vamos atualizar o initramfs, incluindo nele os scripts que serão executados durante a inicialização do LiveCD.
# Para isso, execute os dois comandos a seguir no terminal:

#depmod -a $(uname -r)
#update-initramfs -u -k $(uname -r)

# Agora copie os arquivos da pasta pessoal do seu usuário (que no meu caso é "/home/vcatafesta") para a pasta "/etc/skel",
# sem se esquecer de restabelecer as permissões originais:

#cp -Rf /home/vcatafesta/* /etc/skel/
#chown -R root.root /etc/skel

# A pasta "/etc/skel" contém os arquivos e pastas que serão copiados para a pasta pessoal dos usuários quando forem criadas
# novas contas no sistema. Por isso a importância de copiar a nossa pasta pessoal para essa pasta: as configurações que
# fizemos na etapa passada não terão de ser refeitas no futuro, elas serão aplicadas automaticamente para cada nova conta de
# usuário que for criada no sistema.

# Remova os usuários que vieram do seu sistema durante a cópia na etapa B, de modo que o LiveCD não apresente nenhum usuário
# (é importante observar que esse comando não remove os usuários de sistema, apenas os usuários comuns, aqueles que podem
# fazer login):

#for i in `cat /etc/passwd | awk -F":" '{print $1}'`
#do
#uid=`cat /etc/passwd | grep "^${i}:" | awk -F":" '{print $3}'`
#[ "$uid" -gt "999" -a "$uid" -ne "65534" ] && userdel --force ${i} 2>/dev/null
#done

# Esse comando realmente é formado por várias linhas. Se você não souber como digitá-las no terminal, você pode apelar para o
# famoso "copia e cola" que funciona (foi o que eu fiz).

# Não se preocupe com o fato de excluirmos todos os usuários comuns do sistema. Quando o sistema é iniciado do LiveCD, um
# usuário é criado automaticamente durante a inicialização. Sua pasta pessoal é criada e os arquivos e pastas que estão na
# pasta "/etc/skel" são copiados para ela.

# Apague os arquivos que não são necessários no LiveCD e que podem atrapalhar o processo de inicialização:

#for i in "/etc/hosts /etc/hostname /etc/resolv.conf /etc/timezone /etc/fstab /etc/mtab /etc/shadow /etc/shadow- \
#/etc/gshadow /etc/gshadow- /etc/gdm/gdm-cdd.conf /etc/gdm/gdm.conf-custom /etc/X11/xorg.conf /boot/grub/menu.lst \
#/boot/grub/device.map"
#do
#rm $i
#done 2>/dev/null

# Apague os pacotes que foram baixados na etapa anterior:

#apt-get clean

# Remova os pacotes que não são necessários ao sistema:

#apt-get autoremove

# Você também pode apagar as listas de pacotes disponíveis, já que elas são atualizadas com frequência. Isso reduz o tamanho
# do sistema em alguns megabytes (não devemos apagar a pasta "/var/lib/apt/lists/partial", apenas os arquivos que estão
# dentro dela):

#rm -f /var/lib/apt/lists/*
#rm -f /var/lib/apt/lists/partial/*

#Continuando a série de exclusões, vamos excluir mais alguns arquivos desnecessários:

#find /var/run /var/log /var/mail /var/spool /var/lock /var/backups /var/tmp -type f -exec rm {} 
#\;
#rm -r /tmp/* /root/* /home/* 2>/dev/null

# Agora vamos criar arquivos em branco no lugar de alguns dos arquivos que foram apagados no passo anterior, apenas para que
# o sistema não acuse sua falta e sua inicialização possa ocorrer normalmente:

#for i in dpkg.log lastlog mail.log syslog auth.log daemon.log faillog lpr.log mail.warn 
#user.log boot debug mail.err \
#messages wtmp bootstrap.log dmesg kern.log mail.info
#do
#	touch /var/log/${i}
#done

# Resta fazer só mais uma alteração. Para fazê-la, no entanto, precisamos sair do sistema de trabalho:

#exit

# A última alteração consiste em apagar o arquivo que contém o histórico dos comandos que você executou nos passos
# anteriores:

#rm -f $WORK/root/.bash_history

# Não só não há necessidade de quem for usar o LiveCD saber desses comandos como também o histórico de comandos estar limpo
# causa a impressão de que o sistema nunca foi usado.

# Finalmente, podemos desmontar as pastas que montamos na etapa anterior para prosseguir à próxima etapa:


log_info_msg "rm -f $WORK/root/.bash_history"
rm -f $WORK/root/.bash_history
evaluate_retval

log_info_msg "umount -rl $WORKPTS"
umount -rl "$WORKPTS"
evaluate_retval

log_info_msg "umount -rl $WORKDEV"
umount -rl "$WORKDEV"
evaluate_retval

log_info_msg "umount -rl $WORKPROC"
umount -rl "$WORKPROC"
evaluate_retval

log_info_msg "umount -rl $WORKSYS"
umount -rl "$WORKSYS"
evaluate_retval

log_info_msg "umount -rl $WORKMEDIA"
umount -rl "$WORKMEDIA"
evaluate_retval

log_info_msg "umount -rl $WORKTMP"
umount -rl "$WORKTMP"
evaluate_retval

# A execução desses comandos é de extrema importância. Como desmontam pastas do seu sistema que foram "emprestadas" ao
# sistema de trabalho, se você não executá-los, muito provavelmente alguns arquivos do seu próprio sistema acabarão sendo
# excluídos quando você for apagar a pasta de trabalho

log_info_msg "cp -vp $WORK/boot/vmlinuz-$(uname -r) $BASE/cd/boot/vmlinuz"
#cp -vp $WORK/boot/vmlinuz-$(uname -r) $BASE/cd/boot/vmlinuz
cp -vp $WORK/boot/vmlinuz-4.18.5-lfs-8.3 $BASE/cd/boot/vmlinuz
evaluate_retval

log_info_msg "cp -vp $WORK/boot/initrd.img-$(uname -r) $BASE/cd/boot/initrd.gz"
cp -vp $WORK/boot/initrd.img-$(uname -r) $BASE/cd/boot/initrd.gz
evaluate_retval

log_info_msg "cp -vp $WORK/boot/memtest86+.bin $BASE/cd/boot/memtest86+.bin"
cp -vp $WORK/boot/memtest86+.bin $BASE/cd/boot/memtest86+.bin
evaluate_retval

log_info_msg "cat > $GRUB/menu.lst"

cat > $GRUB/menu.lst << "_EOF_"
# By default, boot the first entry.
default 0

# Boot automatically after 30 secs.
timeout 30

color cyan/blue white/blue

title Start Linux in Graphical Mode
kernel /boot/vmlinuz BOOT=live boot=live nopersistent rw quiet splash
initrd /boot/initrd.gz

title Start Linux in Safe Graphical Mode
kernel /boot/vmlinuz BOOT=live boot=live xforcevesa rw quiet splash
initrd /boot/initrd.gz

title Start Linux in Text Mode
kernel /boot/vmlinuz BOOT=live boot=live nopersistent textonly rw quiet
initrd /boot/initrd.gz

title Start Persistent Live CD
kernel /boot/vmlinuz BOOT=live boot=live persistent rw quiet splash
initrd /boot/initrd.gz

title Start Linux Graphical Mode from RAM
kernel /boot/vmlinuz BOOT=live boot=live toram nopersistent rw quiet splash
initrd /boot/initrd.gz

title Memory Test
kernel /boot/memtest86+.bin

title Boot the First Hard Disk
root (hd0)
chainloader +1

_EOF_

evaluate_retval

log_info_msg "mksquashfs $WORK $LIVE/filesystem.squashfs"
mksquashfs $WORK $LIVE/filesystem.squashfs -noappend
evaluate_retval

log_info_msg "cd $BASE/cd && find . -type f -print0 | xargs -0 md5sum | tee $BASE/cd/md5sum.txt"
cd $BASE/cd && find . -type f -print0 | xargs -0 md5sum | tee $BASE/cd/md5sum.txt
evaluate_retval'~9

log_info_msg "cd $BASE/cd"
cd $BASE/cd
evaluate_retval

log_info_msg "mkisofs -b boot/grub/stage2_eltorito -no-emul-boot -boot-load-size 4 -boot-info-table -V \
"CHILIOS" -cache-inodes -r -J -l -o $XHOME/live-cd.iso $BASE/cd"
mkisofs -b boot/grub/stage2_eltorito -no-emul-boot -boot-load-size 4 -boot-info-table -V \
"CHILIOS" -cache-inodes -r -J -l -o $XHOME/live-cd.iso $BASE/cd
evaluate_retval

