ddrescue -f -n /dev/sdb /dev/sda rescue.log &
tail -f rescue.log > out &
dialog                                         \
   --title 'Monitorando Mensagens do Sistema'  \
   --tailbox out                               \
   0 0
