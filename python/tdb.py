# coding: utf-8

import sqlite3
import time
import datetime
import random
from funcoes import mensagem


class TDb(object):
    def __init__(self):
        try:
            self.conn = sqlite3.connect('sci.db')
            self.c = self.conn.cursor()
            self.sql = ''
        except:
            raise
        finally:
            pass

    def create_table(self):
        self.sql = '''CREATE TABLE IF NOT EXISTS clientes(                   
                   nome TEXT NOT NULL,
                   idade INTEGER,
                   cpf VARCHAR(11) NOT NULL,
                   email TEXT NOT NULL,
                   fone TEXT,
                   cidade TEXT,
                   uf VARCHAR(2) NOT NULL)'''
        try:
            self.c.execute(self.sql)
        except Exception:
            self.conn.rollback()
            mensagem("Nao e possivel criar a tabela.", 15)
            raise NameError('create_table')
        finally:
            pass

    def data_entry(self):
        self.sql = "INSERT INTO clientes VALUES('VILMAR', 50, '62026917949', 'vcatafesta@gmail.com','(69)3451-3085', 'PIMENTA BUENO', 'RO')"
        try:
            self.c.execute(self.sql)
        except Exception:
            self.conn.rollback()
            mensagem("Nao e possivel incluir registros.", 15)
            raise NameError('data_entry')
            # self.conn.commit()
            # self.c.close()
            # self.conn.close()
        finally:
            pass

    def dynamic_data_entry(self):
        unix = time.time()
        date = str(datetime.datetime.fromtimestamp(unix).strftime('%Y-%m-%d %H:%M:%S'))
        keyword = 'Python'
        value = random.randrange(0, 10)
        self.sql = "INSERT INTO stuffToPlot (unix, datestamp, keyword, value) VALUES (?,?,?,?)"
        self.c.execute(self.sql, (unix, date, keyword, value))
        self.conn.commit()
