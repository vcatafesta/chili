# Caja Admin - Extension for Caja to do administrative operations
# Copyright (C) 2015-2016 Bruno Nova <brunomb.nova@gmail.com>
#               2016 frmdstryr <frmdstryr@gmail.com>
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

import gettext, os, subprocess, traceback
from gi.repository import Caja, GObject, Gtk, GLib

ROOT_UID = 0
PKEXEC_PATH="/usr/bin/pkexec"
CAJA_PATH="/usr/bin/caja"
PLUMA_PATH="/usr/bin/pluma"
TERMINAL_PATH="/usr/bin/mate-terminal"

gettext.install('caja-admin')

class CajaAdmin(Caja.MenuProvider, GObject.GObject):
	"""Simple Caja extension that adds some administrative (root) actions to
	the right-click menu, using 'pkexec' to authenticate the administrator."""
	def __init__(self):
		pass

	def get_file_items(self, window, files):
		"""Returns the menu items to display when one or more files/folders are
		selected."""
		# Don't show when already running as root, or when more than 1 file is selected
		if os.geteuid() == ROOT_UID or len(files) != 1:
			return
		file = files[0]

		# Add the menu items
		items = []
		self.window = window
		if file.get_uri_scheme() == "file": # must be a local file/directory
			if file.is_directory():
				if os.path.exists(CAJA_PATH):
					items += [self._create_caja_item(file)]
			else:
				if os.path.exists(TERMINAL_PATH) and self._is_executable(file):
					items += [self._create_exec_item(file)]
				if os.path.exists(PLUMA_PATH):
					items += [self._create_gedit_item(file)]

		return items

	def get_background_items(self, window, file):
		"""Returns the menu items to display when no file/folder is selected
		(i.e. when right-clicking the background)."""
		# Don't show when already running as root
		if os.geteuid() == ROOT_UID:
			return

		# Add the menu items
		items = []
		self.window = window
		if file.is_directory() and file.get_uri_scheme() == "file":
			if os.path.exists(CAJA_PATH):
				items += [self._create_caja_item(file)]

		return items

	def _create_caja_item(self, file):
		"""Creates the 'Open as Administrator' menu item."""
		item = Caja.MenuItem(name="CajaAdmin::Caja",
		                     label=_("Open as A_dministrator"),
		                     tip=_("Open this folder with root privileges"))
		item.connect("activate", self._caja_run, file)
		return item

	def _create_exec_item(self, file):
		"""Creates the 'Run as Administrator' menu item."""
		item = Caja.MenuItem(name="CajaAdmin::ExecAdmin",
		                     label=_("Run as A_dministrator"),
		                     tip=_("Run this file with root privileges"))
		item.connect("activate", self._exec_run, file)
		return item

	def _create_gedit_item(self, file):
		"""Creates the 'Edit as Administrator' menu item."""
		item = Caja.MenuItem(name="CajaAdmin::Gedit",
		                     label=_("Edit as A_dministrator"),
		                     tip=_("Open this file in the text editor with root privileges"))
		item.connect("activate", self._gedit_run, file)
		return item

	def _show_warning_dialog(self):
		"""Shows a warning dialog it this is the first time the extension is
		used, and returns True if the user has pressed OK."""
		# Check if this is the first time the extension is used
		conf_dir = GLib.get_user_config_dir() # get "~/.config" path
		conf_file = os.path.join(conf_dir, ".caja-admin-warn-shown")
		if os.path.exists(conf_file):
			return True
		else:
			# Show the warning dialog
			dialog = Gtk.MessageDialog(self.window, 0, Gtk.MessageType.WARNING,
			                           Gtk.ButtonsType.OK_CANCEL,
			                           _("CAUTION!"))
			msg = _("Running the File Manager, the Text Editor or an executable with "
			        "Administrator privileges <b>is dangerous</b>! "
			        "<b>You can easily destroy your system if you are not careful!</b>\n"
			        "<b>Think twice</b> before doing so, especially before running "
			        "untrusted executables downloaded from the Internet. "
			        "<b>They can contain malware</b>, which can do <b>irreversible "
			        "damage to your system</b> when given Administrator privileges!\n"
			        "Proceed only if you know what you are doing and understand the risks.")
			dialog.format_secondary_markup(msg)
			response = dialog.run()
			dialog.destroy()

			if response == Gtk.ResponseType.OK:
				# Mark the dialog as shown
				try:
					if not os.path.isdir(conf_dir):
						os.makedirs(conf_dir)
					open(conf_file, "w").close() # create an empty file
				except:
					pass
				return True
			else:
				return False


	def _caja_run(self, menu, file):
		"""'Open as Administrator' menu item callback."""
		if self._show_warning_dialog():
			uri = file.get_uri()
			subprocess.Popen([PKEXEC_PATH, CAJA_PATH, "--no-desktop", uri])

	def _is_executable(self, file):
		"""Returns whether the current user can execute the given file."""
		try:
			path = file.get_location().get_path()
			return os.access(path,os.X_OK)
		except:
			return False

	def _exec_run(self, menu, file, gui=True):
		"""'Run as Administrator' menu item callback."""
		if self._show_warning_dialog():
			try:
				path = file.get_location().get_path()
				#is_app = not os.path.splitext(path)[-1]
				cmd = [PKEXEC_PATH]
				#cmd +=['env','DISPLAY='+os.environ['DISPLAY'],'XAUTHORITY='+os.environ['XAUTHORITY']]
				cmd +=[TERMINAL_PATH]
				cmd +=['--working-directory='+os.path.dirname(path)]
				cmd +=['-e',path]

				subprocess.Popen(cmd)
			except:
				traceback.print_exc()

	def _gedit_run(self, menu, file):
		"""'Edit as Administrator' menu item callback."""
		if self._show_warning_dialog():
			uri = file.get_uri()
			subprocess.Popen([PKEXEC_PATH, PLUMA_PATH, uri])
