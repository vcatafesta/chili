import gi
import subprocess
from datetime import datetime
import pytz  # Para trabalhar com fusos horários
import tzlocal  # Para obter o fuso horário local
import os

print("DISPLAY:", os.environ.get("DISPLAY"))
print("XAUTHORITY:", os.environ.get("XAUTHORITY"))
print("DBUS_SESSION_BUS_ADDRESS:", os.environ.get("DBUS_SESSION_BUS_ADDRESS"))

gi.require_version("Gtk", "3.0")
from gi.repository import Gtk

class TimeUpdater(Gtk.Window):
    def __init__(self):
        super().__init__(title="Sincronizar data e hora")
        self.set_border_width(10)
        self.set_default_size(400, 400)

        vbox = Gtk.Box(orientation=Gtk.Orientation.VERTICAL, spacing=6)
        self.add(vbox)

        # Calendário para seleção da data
        self.calendar = Gtk.Calendar()
        vbox.pack_start(self.calendar, False, False, 0)

        # SpinButton para hora (com wrap e formatação com 2 dígitos via "output")
        self.hour_adjustment = Gtk.Adjustment(
            value=datetime.now().hour, lower=0, upper=23, step_increment=1
        )
        self.hour_spinner = Gtk.SpinButton(adjustment=self.hour_adjustment)
        self.hour_spinner.set_numeric(True)
        self.hour_spinner.set_digits(0)
        self.hour_spinner.set_wrap(True)
        self.hour_spinner.connect("output", self.format_value_callback)
        vbox.pack_start(self.hour_spinner, False, False, 0)

        # SpinButton para minutos (com wrap e formatação com 2 dígitos via "output")
        self.minute_adjustment = Gtk.Adjustment(
            value=datetime.now().minute, lower=0, upper=59, step_increment=1
        )
        self.minute_spinner = Gtk.SpinButton(adjustment=self.minute_adjustment)
        self.minute_spinner.set_numeric(True)
        self.minute_spinner.set_digits(0)
        self.minute_spinner.set_wrap(True)
        self.minute_spinner.connect("output", self.format_value_callback)
        vbox.pack_start(self.minute_spinner, False, False, 0)

        # Caixa de busca para cidade/timezone
        hbox_search = Gtk.Box(orientation=Gtk.Orientation.HORIZONTAL, spacing=6)
        self.search_entry = Gtk.Entry()
        self.search_entry.set_placeholder_text("Buscar cidade/timezone")
        self.search_entry.connect("activate", self.on_search_activate)  # Acionar a pesquisa ao pressionar Enter
        hbox_search.pack_start(self.search_entry, True, True, 0)

        # Botão de buscar
        self.search_button = Gtk.Button(label="Buscar")
        self.search_button.connect("clicked", self.on_search_activate)  # Acionar a pesquisa ao clicar
        hbox_search.pack_start(self.search_button, False, False, 0)

        vbox.pack_start(hbox_search, False, False, 0)

        # Combobox para selecionar o timezone
        self.timezone_label = Gtk.Label()
        self.timezone_combobox = Gtk.ComboBoxText()
        self.populate_timezones()
        vbox.pack_start(self.timezone_combobox, False, False, 0)
        vbox.pack_start(self.timezone_label, False, False, 0)

        # Botão para atualizar a hora e timezone
        self.button = Gtk.Button(label="Sincronizar agora")
        self.button.connect("clicked", self.update_time)
        vbox.pack_start(self.button, False, False, 0)

        # Seleciona automaticamente o timezone atual
        self.update_timezone()

    def format_value_callback(self, spin_button):
        """Callback para forçar a exibição com dois dígitos."""
        value = int(spin_button.get_value())
        formatted = f"{value:02d}"
        spin_button.set_text(formatted)
        return True

    def populate_timezones(self):
        """Popula o ComboBox com a lista de timezones."""
        self.timezone_list = list(pytz.all_timezones)
        for tz in self.timezone_list:
            self.timezone_combobox.append_text(tz)

    def update_timezone(self):
        """Seleciona automaticamente o timezone atual no ComboBox."""
        local_timezone = tzlocal.get_localzone()
        tz_name = local_timezone.key if hasattr(local_timezone, "key") else str(local_timezone)
        try:
            index = self.timezone_list.index(tz_name)
        except ValueError:
            index = 0
            tz_name = self.timezone_list[0]
        self.timezone_combobox.set_active(index)
        self.timezone_label.set_text(f"Timezone atual: {tz_name}")

    def on_search_activate(self, entry):
        """
        Callback da caixa de busca.
        Transforma espaços em underscores e procura um timezone que contenha o texto buscado.
        A busca é feita por aproximação e complementa as variações:
        'Porto Velho', 'porto_velho', 'porto velho' resultarão em 'Porto_Velho'.
        """
        search_text = self.search_entry.get_text().strip().lower().replace(" ", "_")
        found = False
        for idx, tz in enumerate(self.timezone_list):
            # Compara ignorando diferenças entre espaços e underscores
            if search_text in tz.lower().replace(" ", "_"):
                self.timezone_combobox.set_active(idx)
                self.timezone_label.set_text(f"Timezone atual: {tz}")
                found = True
                break
        if not found:
            self.timezone_label.set_text("Nenhum timezone encontrado.")

    def update_time(self, widget):
        """
        Atualiza o timezone e a data/hora do sistema.
        Usa o timezone selecionado, a data do calendário e os valores dos SpinButtons.
        """
        selected_timezone = self.timezone_combobox.get_active_text()
        if selected_timezone:
            # Obtém a data do calendário (month é 0-indexado)
            year, month, day = self.calendar.get_date()
            # Obtém os valores de hora e minuto
            hour = int(self.hour_spinner.get_value())
            minute = int(self.minute_spinner.get_value())
            new_time = datetime(year, month + 1, day, hour, minute)
            # Localiza o datetime para o timezone selecionado
            tz = pytz.timezone(selected_timezone)
            localized_time = tz.localize(new_time)
            time_str = localized_time.strftime("%Y-%m-%d %H:%M:%S")
            try:
                # Ativa a sincronização NTP
                subprocess.run(["pkexec", "timedatectl", "set-ntp", "true"], check=True)

                # Atualiza o timezone do sistema
                subprocess.run(
                    ["pkexec", "timedatectl", "set-timezone", selected_timezone],
                    check=True,
                )

                # Atualiza o relógio do sistema
                subprocess.run(["pkexec", "date", "--set", time_str], check=True)

                # Atualiza o relógio hardware
                subprocess.run(["pkexec", "hwclock", "--systohc"], check=True)

                # Exibe o resultado do timedatectl em uma msgbox
                result = subprocess.run(["timedatectl"], capture_output=True, text=True)
                self.show_message(
                    f"Timezone e data/hora atualizados com sucesso!\n{result.stdout}"
                )
            except subprocess.CalledProcessError:
                self.show_message(
                    "Erro ao atualizar timezone ou data/hora. Permissões necessárias."
                )
        else:
            self.show_message("Nenhum timezone selecionado.")

    def show_message(self, message):
        dialog = Gtk.MessageDialog(
            transient_for=self,
            flags=0,
            message_type=Gtk.MessageType.INFO,
            buttons=Gtk.ButtonsType.OK,
            text=message,
        )
        dialog.run()
        dialog.destroy()

if __name__ == "__main__":
    win = TimeUpdater()
    win.connect("destroy", Gtk.main_quit)
    win.show_all()
    Gtk.main()
