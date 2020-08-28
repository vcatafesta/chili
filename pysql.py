import sqlite3, time

path = r'/chili/'
db   = r'teste.db'
conn = sqlite3.connect(path+db)
sql  = "SELECT * FROM dados WHERE nome = ?"
c    = conn.cursor()

print(path)
def create_table():
	c.execute('CREATE TABLE IF NOT EXISTS dados (id integer, valor real, nome text, endereco text, total real)')

def inserirdados():
	c.execute("INSERT INTO dados VALUES(1, 1.0, 'VILMAR', 'AV CASTELO BRANCO', 500)")
	c.execute("INSERT INTO dados VALUES(2, 1.0, 'EVILI', 'AV CASTELO BRANCO', 500)")
	c.execute("INSERT INTO dados VALUES(3, 1.0, 'THALES', 'AV CASTELO BRANCO', 500)")
	c.execute("INSERT INTO dados VALUES(4, 1.0, 'GABI', 'AV CASTELO BRANCO', 500)")
	conn.commit()

def lerdados(vlrbusca):
	for row in c.execute(sql, (vlrbusca,)):
		print(row)
		for x in row:
			print(x)
	
create_table()
inserirdados()
lerdados("EVILI")

def criar_db():
	e.execute('CREATE TABLE IF NOT EXISTS cadastro (nome text, telefone varchar, email text, data text)')
	conectar.commit()

def main():
	conectar = sqlite3.connect('agenda.db')
	e = conectar.cursor()

	try:
		criar_db()
	except Exception as e:
		raise
	else:
		print("BD criado com sucesso.")
	finally:
		pass

def inserir():
	d = time.strftime('%d/%m/%Y')
	e.execute('INSERT INTO cadastro VALUES(?, ?, ?, ?)', (n, t, e, d))
	conectar.commit()

try:
	print('Cadastro na Agenda')
	n = input("nome    : ")
	t = input("Endereco: ")
	e = input("Email   : ")
	inserir(n, t, e)
except Exception as e:
	raise
else:
	print("sucesso")
finally:
	pass

if __name__ == "__main__":
    main()
