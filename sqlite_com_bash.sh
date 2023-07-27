#!/usr/bin/env bash

# Nome do arquivo do banco de dados
DB_FILE="meu_banco_de_dados.db"

# Criar tabela e inserir registros
function criar_tabela_e_inserir_registros() {
  sqlite3 $DB_FILE <<EOF
    -- Criar tabela
    CREATE TABLE usuarios (
        id INTEGER PRIMARY KEY,
        nome TEXT,
        idade INTEGER
    );

    -- Inserir registros
    INSERT INTO usuarios (nome, idade) VALUES ('João', 25);
    INSERT INTO usuarios (nome, idade) VALUES ('Maria', 30);
    INSERT INTO usuarios (nome, idade) VALUES ('Pedro', 28);
EOF
}

# Consultar dados da tabela
function consultar_dados() {
  sqlite3 $DB_FILE <<EOF
    SELECT * FROM usuarios;
EOF
}

# Executar a função principal
function main() {
  if [ ! -f $DB_FILE ]; then
    echo "Criando banco de dados..."
    criar_tabela_e_inserir_registros
  fi

  echo "Consultando dados..."
  consultar_dados
}

# Chamada da função principal
main


