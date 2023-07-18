# coding: cp860
from simpledbf import Dbf5


dbf = Dbf5('receber.dbf')
dbf.to_csv('receber.csv')
# dbf.to_pandassql('sqlite:///foo.db')
# dbf.to_pandassql('foo.db')
dbf.to_textsql('junk.sql', 'junk.csv')
