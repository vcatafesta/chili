# unicode: utf-8

import sqlite3


def create_table(aowner):
    try:
        sql = 'CREATE TABLE {0} ({1}, {2}, {3})'.format('USUARIO', 'id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT', 'nome text', 'password text')
        print(sql)
        aowner.execute(sql)
        print('Tabela criada com sucesso!')
        aowner.close()
    except Exception:
        print("erro na criacao da tabela.")
        exit(0)


path = r'c:\python\teste'
database = r'sci.db'
fullpath = '{0}\{1}'.format(path, database)
print(fullpath)
conn = sqlite3.connect(fullpath)
c = conn.cursor()
create_table(c)
