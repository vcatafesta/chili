import datetime
# from mx import DateTime
from dbfpy import dbf
from funcoes import maxcol, strzero, mensagem
import random


def GetFieldName(campo, fieldnames):
    for index, fld in enumerate(fieldnames):
        if fld == campo:
            return index;
    return None


def ordena(t):
    return (t[0], t[1])


def recelan():
    ## create empty DBF, set fields
    db = dbf.Dbf("test.dbf", new = True)
    db.addField(
            ("CODI", "C", 5),
            ("NOME", "C", 40),
            ("SURNAME", "C", 40),
            ("INITIALS", "C", 10),
            ("BIRTHDATE", "D"),
            )
    # print(db)
    # print()

    ## fill DBF with some records

    for name, surname, initials, codi, birthdate in (
            ("John", "Miller", "JM", "00001", (1980, 1, 2)),
            ("Andy", "Larkin", "AL", "00002", datetime.date(1981, 2, 3)),
            ("Bill", "Clinth", "", "00003", datetime.date(1982, 3, 4)),
            ("Bobb", "McNail", "", "00004", "19830405"),
            ):
        rec = db.newRecord()
        rec["CODI"] = strzero(random.randint(0, 5), 5)
        rec["NOME"] = name
        rec["SURNAME"] = surname
        rec["INITIALS"] = initials
        rec["BIRTHDATE"] = birthdate
        rec.store()
    db.close()

    ## read DBF and print records

    db = dbf.Dbf("test.dbf")

    # for rec in db:
    #    print rec
    #    print
    # print

    ## change record
    recno, rec = db.dbgoto(2)
    # print "recno   :", recno
    # print "recno   :", db.reg
    # print "recno   :", db.recno()

    # rec = db[recno]
    # rec["NOME"] = "VILMAR CATAFESTA"
    # rec.store()

    # rec = db[0]
    # rec["NOME"] = "EVILI FRANCIELE"
    # rec.store()
    # del rec

    # print
    db.dbgobottom()
    # print "ultimo  :", db.reg
    # print "ultimo  :", db.recno()
    db.dbgotop()
    # print "topo    :", db.reg
    # print "topno   :", db.recno()
    # print "lastrec :", db.lastrec()
    # print

    mensagem("Aguarde, Ordenando", 15)

    db = dbf.Dbf("RECEBER.dbf")
    field = GetFieldName('NOME', db.fieldNames)
    # tabela = sorted(db, key=ordena)
    # tabela = sorted(db, key = lambda x: x[field])
    # tabela = sorted(db, key = lambda x: (x[1], [0]))
    tabela = sorted(db, key = lambda x: x[1])
    alista = []

    cline = '{:^158}'.format("Macrosoft Informatica Ltda", maxcol())
    # print(cline)
    alista.append(cline)

    cline = "=" * maxcol()
    # print(cline)
    alista.append(cline)

    cline = '{:5} {:5} {:40} {:10}'.format("REG", "REC", "NOME", "TIPO")
    # print(cline)
    alista.append(cline)

    cline = "=" * maxcol()
    # print(cline)
    alista.append(cline)

    for reg, rec in enumerate(tabela):
        # print '%10s: %10s (%10s)' % ("REGISTRO", recno, type(recno))
        campo = 'NOME'
        fieldrec = GetFieldName(campo, db.fieldNames)
        cline = '{:5} {:5} {:40} {:10}'.format(reg,
                                               rec[0],
                                               rec[fieldrec],
                                               type(rec[fieldrec])
                                               )
        # print(cline)
        alista.append(cline)

    cline = "=" * maxcol()
    # print(cline)
    alista.append(cline)
    cline = 'Registros impressos: {}'.format(reg)
    print(cline)
    alista.append(cline)
    return alista


recelan()
