
#!/usr/bin/env python3
import gi
import subprocess
from datetime import datetime
import pytz
import tzlocal

gi.require_version("Gtk", "3.0")
from gi.repository import Gtk, GLib

# ================================
# Componente de Data
# ================================
class DateComponent:
    def __init__(self):
        self.calendar = Gtk.Calendar()
        self.box = Gtk.Box(orientation=Gtk.Orientation.HORIZONTAL, spacing=10)
        self.label = Gtk.Label()
        self.label.set_markup('<span size="small">Data Atual:</span>')
        self.box.pack_start(self.label, False, False, 0)
        self.value_label = Gtk.Label()
        self.value_label.set_markup('<span size="xx-large">' + self.get_current_date() + '</span>')
        self.box.pack_start(self.value_label, False, False, 0)
        # Atualiza a data
        self.update()

    def get_current_date(self):
        return datetime.now().strftime("%d/%m/%Y")

    def update(self, dt=None):
        if dt is None:
            dt = datetime.now()
        date_str = dt.strftime("%d/%m/%Y")
        self.value_label.set_markup('<span size="xx-large">' + date_str + '</span>')

# ================================
# Componente de Hora
# ================================
class TimeComponent:
    def __init__(self):
        self.box = Gtk.Box(orientation=Gtk.Orientation.VERTICAL, spacing=10)
        self.label = Gtk.Label()
        self.label.set_markup('<span size="small">Hora Atual:</span>')
        self.box.pack_start(self.label, False, False, 0)
        self.value_label = Gtk.Label()
        self.value_label.set_markup('<span size="xx-large">' + self.get_current_time() + '</span>')
        self.box.pack_start(self.value_label, False, False, 0)
        # SpinButtons para hora e minuto (opcional, para ajustes manuais)
        self.hour_adjustment = Gtk.Adjustment(value=datetime.now().hour, lower=0, upper=23, step_increment=1)
        self.hour_spinner = Gtk.SpinButton(adjustment=self.hour_adjustment)
        self.hour_spinner.set_numeric(True)
        self.hour_spinner.set_digits(0)
        self.hour_spinner.set_wrap(True)
        self.hour_spinner.connect("output", self.format_value_callback)
        self.minute_adjustment = Gtk.Adjustment(value=datetime.now().minute, lower=0, upper=59, step_increment=1)
        self.minute_spinner = Gtk.SpinButton(adjustment=self.minute_adjustment)
        self.minute_spinner.set_numeric(True)
        self.minute_spinner.set_digits(0)
        self.minute_spinner.set_wrap(True)
        self.minute_spinner.connect("output", self.format_value_callback)

        # Inicia o temporizador para atualizar a hora a cada segundo
        GLib.timeout_add_seconds(1, self.update_time)

    def get_current_time(self):
        return datetime.now().strftime("%H:%M:%S")

    def update(self, dt=None):
        if dt is None:
            dt = datetime.now()
        time_str = dt.strftime("%H:%M:%S")
        self.value_label.set_markup('<span size="xx-large">' + time_str + '</span>')
        self.hour_spinner.set_value(dt.hour)
        self.minute_spinner.set_value(dt.minute)

    def format_value_callback(self, spin_button):
        value = int(spin_button.get_value())
        spin_button.set_text(f"{value:02d}")
        return True

    def update_time(self):
        # Atualiza a hora exibida a cada segundo
        self.update()
        return True  # Retorna True para que o temporizador continue

# ================================
# Componente de Zona Horária
# ================================
class ZoneInfoSearchComponent:
    def __init__(self):
        self.hbox = Gtk.Box(orientation=Gtk.Orientation.HORIZONTAL, spacing=10)
        self.label = Gtk.Label(label="Zona Horária:")
        self.hbox.pack_start(self.label, False, False, 0)
        self.combobox = Gtk.ComboBoxText()
        self.hbox.pack_start(self.combobox, True, True, 0)

    def populate(self):
        for tz in pytz.all_timezones:
            self.combobox.append_text(tz)

    def set_current(self):
        # Ajuste para pegar a zona corretamente com tzlocal
        local_zone = tzlocal.get_localzone()
        self.combobox.set_active_id(str(local_zone))  # Corrigido aqui, usando o nome da zona como string

# ================================
# Janela Principal
# ================================
class TimeUpdater(Gtk.Window):
    def __init__(self):
        super().__init__(title="Sincronizar data e hora")
        self.set_border_width(10)
        self.set_default_size(400, 450)

        # Container principal
        vbox = Gtk.Box(orientation=Gtk.Orientation.VERTICAL, spacing=6)
        self.add(vbox)

        # Instancia os componentes
        self.date_component = DateComponent()
        self.time_component = TimeComponent()
        self.zone_search_component = ZoneInfoSearchComponent()
        self.zone_search_component.populate()
        self.zone_search_component.set_current()

        # Empacota o calendário e o componente de data
        vbox.pack_start(self.date_component.calendar, True, True, 0)
        vbox.pack_start(self.date_component.box, False, False, 10)
        # Empacota o componente de hora e os spinbuttons
        vbox.pack_start(self.time_component.box, False, False, 10)
        vbox.pack_start(self.time_component.hour_spinner, False, False, 0)
        vbox.pack_start(self.time_component.minute_spinner, False, False, 0)
        # Empacota o componente de busca e combobox de timezone
        vbox.pack_start(self.zone_search_component.hbox, False, False, 10)
        # Botão para atualizar
        self.update_button = Gtk.Button(label="Sincronizar com NTP agora")
        self.update_button.connect("clicked", self.update_time)
        vbox.pack_start(self.update_button, False, False, 0)

    def run_as_root(self, commands):
        command_str = " && ".join(commands)
        try:
            result = subprocess.run(
                ["pkexec", "bash", "-c", command_str],
                check=True,
                text=True,
                capture_output=True,
            )
            print(f"Comando executado: {command_str}")
            print(f"Saída: {result.stdout.strip()}")
            return True
        except subprocess.CalledProcessError as e:
            print(f"Erro ao executar comandos: {command_str}")
            print(f"Saída de erro: {e.stderr.strip()}")
            return False

    def update_time(self, widget):
        # Obtém a timezone selecionada
        selected_zone = self.zone_search_component.combobox.get_active_text()
        if selected_zone:
            commands = [
                f"timedatectl set-timezone {selected_zone}",
                "timedatectl set-ntp true",
                "hwclock --systohc",
            ]
            if self.run_as_root(commands):
                print(f"Data e hora sincronizadas com sucesso para a zona: {selected_zone}.")
            else:
                print(f"Falha ao sincronizar data/hora para a zona: {selected_zone}.")

        # Obtém a hora atualizada via timedatectl; se não houver retorno, usa datetime.now()
        result = subprocess.run(
            ["timedatectl", "show", "--property=LocalTime", "--value"],
            capture_output=True,
            text=True
        )
        local_time = result.stdout.strip()  # Esperado: "YYYY-MM-DD HH:MM:SS"
        if local_time:
            try:
                new_dt = datetime.strptime(local_time, "%Y-%m-%d %H:%M:%S")
            except Exception as e:
                print("Erro ao converter local_time:", e)
                new_dt = datetime.now()
        else:
            new_dt = datetime.now()

        # Atualiza os componentes de data e hora com o novo datetime
        self.date_component.update(new_dt)
        self.time_component.update(new_dt)

        # Força a atualização completa da interface
        self.queue_draw()

if __name__ == "__main__":
    win = TimeUpdater()
    win.connect("destroy", Gtk.main_quit)
    win.show_all()
    Gtk.main()
