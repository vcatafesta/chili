from dbf import *


def demo1():
    dbf1 = Dbf()
    dbf1.openFile('county.dbf', readOnly = 1)

    dbf1.reportOn()
    print 'sample records:'
    for i1 in range(min(3, len(dbf1))):
        rec = dbf1[i1]
        for fldName in dbf1.fieldNames():
            print '%s:\t %s' % (fldName, rec[fldName])
        print
    dbf1.close()


def demo2():
    dbfn = dbf_new()

    dbfn.add_field("name", 'C', 80)
    dbfn.add_field("price", 'N', 10, 2)
    dbfn.add_field("date", 'D', 8)
    dbfn.write("tst.dbf")
    # test new dbf
    print "*** created tst.dbf: ***"
    dbft = Dbf()
    dbft.openFile('tst.dbf', readOnly = 0)
    dbft.reportOn()

    # add a record
    rec = DbfRecord(dbft)
    rec['name'] = 'something'
    rec['price'] = 10.5
    rec['date'] = (2000, 1, 12)
    rec.store()
    # add another record
    rec = DbfRecord(dbft)
    rec['name'] = 'foo and bar'

    rec['price'] = 12234
    rec['date'] = (1992, 7, 15)
    rec.store()
    dbft.close()


demo1()
demo2()
