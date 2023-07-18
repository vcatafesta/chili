import configparser
import os
from funcoes import *


class TIni():
    def __init__(self, cfile):
        self.cfile = cfile
        self.configfile = str()
        self.config = ConfigParser.ConfigParser()
        self.cfile = cfile
        self.create()

    def create(self):
        if not os.path.isfile(self.cfile):
            self.configfile = open(self.cfile, 'w+b')
            self.configfile.close()

    def read(self):
        self.config.read(self.cfile)

    def write(self):
        self.configfile = open(self.cfile, 'w+b')
        self.config.write(self.cfile)

    def open(self):
        self.configfile = open(self.cfile, 'w+b')

    def close(self):
        self.configfile.close()

    def getint(self, section, option, default):
        result = default

        try:
            self.read()
            result = self.config.getint(section, option)
        except ConfigParser.Error:
            self.set(section, option, default)
        finally:
            #result = self.config.getint(section, option)
            return result

    def get(self, section, option, default):
        result = default

        try:
            self.read()
            result = self.config.get(section, option)
        except ConfigParser.Error:
            self.set(section, option, default)
        finally:
            self.read()
            result = self.config.get(section, option)
            return result

    def set(self, section, option, value):
        self.open()
        try:
            self.config.set(section, option, value)
        except ConfigParser.NoSectionError:
            self.config.add_section(section)
            self.config.set(section, option, value)
        except ConfigParser.NoOptionError:
            self.config.set(section, option, value)
        finally:
            self.config.write(self.configfile)
            self.close()
        return
