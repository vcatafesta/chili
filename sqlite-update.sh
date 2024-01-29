#!/bin/bash

DB_FILE="pacman.db"
TABLE_NAME="pacman"

# Cria a tabela temporária
sqlite3 $DB_FILE "DROP TABLE IF EXISTS pacman_temp; CREATE TABLE pacman_temp (package TEXT, description TEXT);"



# Verifica se o arquivo do banco de dados existe. Se não, cria o banco de dados e a tabela.
# if [ ! -f "$DB_FILE" ]; then
    # echo "Criando banco de dados SQLite..."
    # sqlite3 $DB_FILE "CREATE TABLE IF NOT EXISTS $TABLE_NAME (package TEXT, description TEXT);"
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
}' | sqlite3 $DB_FILE "
INSERT INTO pacman (package, description)
SELECT package, description FROM pacman_temp
WHERE package NOT IN (SELECT package FROM pacman);
"

# Remove a tabela temporária
sqlite3 $DB_FILE "DROP TABLE IF EXISTS pacman_temp;"