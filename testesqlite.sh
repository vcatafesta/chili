#!/bin/bash

DB_FILE="pacman.db"
TABLE_NAME="pacman"

# Remove se existir arquivo anterior
rm -f $DB_FILE

# Verifica se o arquivo do banco de dados existe. Se não, cria o banco de dados e a tabela.
# if [ ! -f "$DB_FILE" ]; then
    echo "Criando banco de dados SQLite..."
    sqlite3 $DB_FILE "CREATE TABLE IF NOT EXISTS $TABLE_NAME (package TEXT, description TEXT);"
# fi

# Processa a saída do pacman e utiliza um pipe para importar diretamente no SQLite
pacman -Ss | awk '{
    if (NF > 0) {
        if ($0 ~ /^[^ ]/) {
            if (pkgname != "") print "\""pkgname"\";\""description"\"";
            pkgname = $0; description = "";
        } else {
            gsub(/^[ \t]+/, "");
            description = description $0 " ";
        }
    }
    gsub(/"/, "\"\"", pkgname);
    gsub(/"/, "\"\"", description);
}
END {
    if (pkgname != "") print "\""pkgname"\";\""description"\"";
}' | sqlite3 $DB_FILE ".mode csv" ".separator ;" ".import /dev/stdin $TABLE_NAME"
