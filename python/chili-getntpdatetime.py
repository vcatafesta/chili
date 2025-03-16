#!/usr/bin/env python
import gi
import subprocess
from datetime import datetime
import pytz
import tzlocal
from gi.repository import GLib

gi.require_version("Gtk", "3.0")
from gi.repository import Gtk

# ================================
# Componente de Data
# ================================
class DateComponent:
    def __init__(self):
        # Caixa que agrupa o rótulo e o valor da data
        self.box = Gtk.Box(orientation=Gtk.Orientation.VERTICAL, spacing=10)
        self.label = Gtk.Label()
#        self.label.set_markup('<span size="small">Data Atual:</span>')
        self.label.set_markup('<span size="small"></span>')
        self.box.pack_start(self.label, False, False, 0)

        self.value_label = Gtk.Label()
        self.value_label.set_markup('<span size="xx-large">' + self.get_current_date() + '</span>')
        self.box.pack_start(self.value_label, False, False, 0)
        # Calendário para exibição/seleção da data
        self.calendar = Gtk.Calendar()

    def get_current_date(self):
        return datetime.now().strftime("%d/%m/%Y")

    def update(self, dt=None):
        if dt is None:
            dt = datetime.now()
        date_str = dt.strftime("%d/%m/%Y")
        self.value_label.set_markup('<span size="xx-large">' + date_str + '</span>')
        # Atualiza o calendário: observe que o mês é 0-indexado
        self.calendar.select_month(dt.month - 1, dt.year)
        self.calendar.select_day(dt.day)

# ================================
# Componente de Hora
# ================================
class TimeComponent:
    def __init__(self):
        self.box = Gtk.Box(orientation=Gtk.Orientation.VERTICAL, spacing=10)
        self.label = Gtk.Label()
#        self.label.set_markup('<span size="small">Hora Atual:</span>')
        self.label.set_markup('<span size="small"></span>')
        self.box.pack_start(self.label, False, False, 0)

        self.value_label = Gtk.Label()
        self.value_label.set_markup('<span size="xx-large">' + self.get_current_time() + '</span>')
        self.box.pack_start(self.value_label, False, False, 0)

        # Temporizador para atualizar a hora automaticamente
        GLib.timeout_add_seconds(1, self.update_time)  # Atualiza a cada segundo

    def get_current_time(self):
        return datetime.now().strftime("%H:%M:%S")

    def update(self, dt=None):
        if dt is None:
            dt = datetime.now()
        time_str = dt.strftime("%H:%M:%S")
        self.value_label.set_markup('<span size="xx-large">' + time_str + '</span>')

    def update_time(self):
        # Atualiza a hora atual
        self.update(datetime.now())
        return True  # Retorna True para continuar o temporizador

# ================================
# Componente de Busca e ZoneInfo
# ================================
class ZoneInfoSearchComponent:
    def __init__(self):
        # Caixa horizontal para agrupar campo de busca, botão e combobox
        self.hbox = Gtk.Box(orientation=Gtk.Orientation.HORIZONTAL, spacing=6)
        self.search_entry = Gtk.Entry()
        self.search_entry.set_placeholder_text("Buscar por zona")
        self.hbox.pack_start(self.search_entry, True, True, 0)
        self.search_button = Gtk.Button(label="Buscar")
        self.hbox.pack_start(self.search_button, False, False, 0)
        self.combobox = Gtk.ComboBoxText()
        self.combobox.set_entry_text_column(0)
        self.hbox.pack_start(self.combobox, False, False, 0)
        self.timezone_list = []  # Será preenchida no método populate()
        # Conecta a ação de busca ao pressionar Enter e ao clicar no botão
        self.search_entry.connect("activate", self.on_search)
        self.search_button.connect("clicked", self.on_search)

    def populate(self):
        # Usa pytz para obter todas as timezones disponíveis
        self.timezone_list = list(pytz.all_timezones)
        for tz in self.timezone_list:
            self.combobox.append_text(tz)

    def set_current(self):
        # Obtém a timezone atual do sistema via timedatectl e a define como selecionada
        result = subprocess.run(
            ["timedatectl", "show", "--property=Timezone", "--value"],
            capture_output=True,
            text=True
        )
        current_zone = result.stdout.strip()
        for idx, tz in enumerate(self.timezone_list):
            if tz == current_zone:
                self.combobox.set_active(idx)
                break

    def on_search(self, widget):
        # Normaliza o texto de busca: converte espaços para underscores e transforma em minúsculas
        search_text = self.search_entry.get_text().strip().lower()
        normalized_search = search_text.replace(" ", "_")
        found = False
        for idx, tz in enumerate(self.timezone_list):
            normalized_tz = tz.lower().replace(" ", "_")
            if normalized_search in normalized_tz:
                self.combobox.set_active(idx)
                found = True
                break
        if not found:
            print("Nenhum timezone encontrado.")

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
        date_frame = Gtk.Frame(label="Data atual:", shadow_type=Gtk.ShadowType.IN)  # Removido o rótulo
        date_frame.add(self.date_component.box)
        vbox.pack_start(date_frame, False, False, 10)
        vbox.pack_start(self.date_component.calendar, True, True, 0)

        # Empacota o componente de hora
        time_frame = Gtk.Frame(label="Hora atual:", shadow_type=Gtk.ShadowType.IN)
        time_frame.add(self.time_component.box)
        vbox.pack_start(time_frame, False, False, 10)

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
                # Exibe o resultado do timedatectl
                result = subprocess.run(["timedatectl"], capture_output=True, text=True)
                self.show_message(
                    f"Timezone e data/hora atualizados com sucesso!\n{result.stdout}"
                )
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
