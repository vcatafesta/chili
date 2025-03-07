import gi
import subprocess
from datetime import datetime
import pytz  # Para trabalhar com fusos horários

gi.require_version("Gtk", "3.0")
from gi.repository import Gtk

class TimeUpdater(Gtk.Window):
    def __init__(self):
        super().__init__(title="Atualizar Hora no XFCE")
        self.set_border_width(10)
        self.set_default_size(400, 300)

        vbox = Gtk.Box(orientation=Gtk.Orientation.VERTICAL, spacing=6)
        self.add(vbox)

        # Quadro para o calendário
        self.calendar = Gtk.Calendar()
        vbox.pack_start(self.calendar, True, True, 0)

        # Quadro para ajustar a hora
        self.hour_adjustment = Gtk.Adjustment(value=datetime.now().hour, lower=0, upper=23, step_increment=1)
        self.hour_spinner = Gtk.SpinButton(adjustment=self.hour_adjustment)
        self.hour_spinner.set_numeric(True)
        self.hour_spinner.set_digits(0)
        vbox.pack_start(self.hour_spinner, True, True, 0)

        # Quadro para ajustar os minutos
        self.minute_adjustment = Gtk.Adjustment(value=datetime.now().minute, lower=0, upper=59, step_increment=1)
        self.minute_spinner = Gtk.SpinButton(adjustment=self.minute_adjustment)
        self.minute_spinner.set_numeric(True)
        self.minute_spinner.set_digits(0)
        vbox.pack_start(self.minute_spinner, True, True, 0)

        # Quadro para selecionar o timezone
        self.timezone_label = Gtk.Label()
        self.timezone_combobox = Gtk.ComboBoxText()
        self.populate_timezones()
        self.timezone_combobox.connect("changed", self.on_timezone_changed)
        vbox.pack_start(self.timezone_combobox, True, True, 0)
        vbox.pack_start(self.timezone_label, True, True, 0)

        # Botão para atualizar a hora
        self.button = Gtk.Button(label="Atualizar Hora")
        self.button.connect("clicked", self.update_time)
        vbox.pack_start(self.button, True, True, 0)

        # Inicializa com o timezone atual
        self.update_timezone()

    def populate_timezones(self):
        # Adiciona fusos horários ao ComboBox
        timezones = pytz.all_timezones
        for tz in timezones:
            self.timezone_combobox.append_text(tz)

    def on_timezone_changed(self, combo):
        # Atualiza a label com o fuso horário selecionado
        tz = self.timezone_combobox.get_active_text()
        self.timezone_label.set_text(f"Timezone selecionado: {tz}")
        self.selected_timezone = tz

    def update_time(self, widget):
        # Obtém a data do calendário
        year, month, day = self.calendar.get_date()

        # Obtém a hora e minuto ajustados
        hour = int(self.hour_spinner.get_text())
        minute = int(self.minute_spinner.get_text())

        # Cria uma string de data e hora
        new_time = datetime(year, month + 1, day, hour, minute)

        # Se o timezone foi alterado, usa o novo fuso horário
        if hasattr(self, 'selected_timezone'):
            tz = pytz.timezone(self.selected_timezone)
            new_time = tz.localize(new_time)

        try:
            subprocess.run(["pkexec", "date", "--set", new_time.strftime("%Y-%m-%d %H:%M:%S")], check=True)
            self.show_message("Hora atualizada com sucesso!")
        except subprocess.CalledProcessError:
            self.show_message("Erro ao atualizar hora. Permissões necessárias.")
    
    def update_timezone(self):
        # Obtém o timezone local atual da máquina
        local_timezone = datetime.now(pytz.timezone("America/Sao_Paulo")).strftime("%Z")
        local_tz_name = datetime.now(pytz.timezone("America/Sao_Paulo")).tzname()

        # Atualiza o ComboBox para refletir o fuso horário atual
        self.timezone_combobox.set_active_id(local_tz_name)
        self.timezone_label.set_text(f"Timezone atual: {local_tz_name}")

    def show_message(self, message):
        dialog = Gtk.MessageDialog(
            transient_for=self, flags=0, message_type=Gtk.MessageType.INFO,
            buttons=Gtk.ButtonsType.OK, text=message
        )
        dialog.run()
        dialog.destroy()

if __name__ == "__main__":
    win = TimeUpdater()
    win.connect("destroy", Gtk.main_quit)
    win.show_all()
    Gtk.main()
