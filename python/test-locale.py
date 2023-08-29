#!/usr/bin/python

import gi
import subprocess
import sys
import os
import locale
gi.require_version('Pamac', '11')
from gi.repository import Pamac

# Import gettext module
import gettext
lang_translations = gettext.translation('big-store', localedir='/usr/share/locale', fallback=True)
lang_translations.install()
# define _ shortcut for translations
_ = lang_translations.gettext
TMP_FOLDER = os.environ['TMP_FOLDER']

print(locale.getlocale()[0])
