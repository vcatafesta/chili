#!/usr/bin/env bash
# shellcheck shell=bash disable=SC1091,SC2039,SC2166

echo "
PID do Shell....................'(\$$)'    = $$
Nome do script..................'(\$0)'    = $0
Qtde de argumentos..............'(\$#)'    = $#
1 argumento.....................'(\$1)'    = $1
11 argumento errado.............'(\$11)'   = $11
11 argumento certo..............'(\${11})' = ${11}
"
cat <<-EOF
PID do Shell....................'(\$$)'    = $$
Nome do script..................'(\$0)'    = $0
Qtde de argumentos..............'(\$#)'    = $#
1 argumento.....................'(\$1)'    = $1
11 argumento errado.............'(\$11)'   = $11
11 argumento certo..............'(\${11})' = ${11}
EOF


