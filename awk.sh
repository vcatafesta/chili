fdisk -l /dev/sda | grep gpt | awk -F":" '{print $2}' 
echo
echo
awk -F":" 'NR==1,NR==10 {printf "%-25s %3d\n", $1, $3}' /etc/passwd
echo
echo

awk -F":" '
BEGIN {printf "%-25s %-3s\n", "User", "Uid"}
NR==1,NR==10 {printf "%-25s %3d\n", $1, $3}' /etc/passwd

echo
echo

cat /etc/passwd | \
awk -F":" '
BEGIN {
print "=================================================================="
printf "%-25s %-3s %-3s %-15s %-15s\n", "USER", "UID","GID","HOME","SHELL"
print "=================================================================="
}
NR==1,NR==1000 { printf "%-25s %-3s %-3s %-15s %-15s\n", $1, $3, $4, $6,$7 }'
echo
echo

#fdisk /dev/sda -o Device,Type,Size | sed -n /sd[a-z][0-9]/p | egrep '.{10}'
#fdisk /dev/sda -o Device,Type,Size | sed -n /sd[a-z][0-9]/p | grep .

grep [[:digit:]] /etc/passwd
echo
echo
    grep "[A-Z]" /etc/passwd
echo
echo
grep "[a-z]" /etc/passwd
grep "[0-9]" /etc/passwd

echo
echo
grep -n "[a-z]" /etc/passwd
echo
echo
grep -n "[aA]" /etc/passwd
echo
echo
grep -n "[vV]catafesta" /etc/passwd
echo
echo
# $ terminador de linha
grep -n "bash$" /etc/passwd
echo
echo
grep -n "^root" /etc/group
echo
echo
grep -n "ae" /etc/group
grep -n "a[eio]" /etc/group
echo
echo
echo "-E expressao extendida"
grep -E "(root|vcatafesta)" /etc/group

