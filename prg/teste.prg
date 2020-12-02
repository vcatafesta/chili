function main()
	cls
	if !File("teste.dbf")
		dbcreate("teste.dbf", {{"NOME", "C", 40, 0},;
							   {"CIDA", "C", 40, 0}})
		alert("Database criado")
	endif
	use teste new
	browse()
	quit
