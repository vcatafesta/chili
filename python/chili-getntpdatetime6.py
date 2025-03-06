import gi
import subprocess
from datetime import datetime

gi.require_version("Gtk", "3.0")
from gi.repository import Gtk

class TimeUpdater(Gtk.Window):
    def __init__(self):
        super().__init__(title="Sincronizar data e hora")
        self.set_border_width(10)
        self.set_default_size(400, 300)

        vbox = Gtk.Box(orientation=Gtk.Orientation.VERTICAL, spacing=6)
        self.add(vbox)

        # Mostrar o calendário
        self.calendar = Gtk.Calendar()
        vbox.pack_start(self.calendar, True, True, 0)

        # Caixa para mostrar a data
        self.date_box = Gtk.Box(orientation=Gtk.Orientation.VERTICAL, spacing=10)

        # Rótulo com fonte menor
        self.date_label = Gtk.Label(label="Data Atual:")
        self.date_label.set_markup('<span size="small">Data Atual:</span>')
        self.date_box.pack_start(self.date_label, False, False, 0)

        # Caixa com valor da data em fonte maior
        self.date_value = Gtk.Label(label=self.get_current_date())
        self.date_value.set_markup('<span size="xx-large">' + self.get_current_date() + '</span>')
        self.date_box.pack_start(self.date_value, False, False, 0)
        vbox.pack_start(self.date_box, False, False, 10)

        # Caixa para mostrar a hora
        self.time_box = Gtk.Box(orientation=Gtk.Orientation.VERTICAL, spacing=10)

        # Rótulo com fonte menor
        self.time_label = Gtk.Label(label="Hora Atual:")
        self.time_label.set_markup('<span size="small">Hora Atual:</span>')
        self.time_box.pack_start(self.time_label, False, False, 0)

        # Caixa com valor da hora em fonte maior
        self.time_value = Gtk.Label(label=self.get_current_time())
        self.time_value.set_markup('<span size="xx-large">' + self.get_current_time() + '</span>')
        self.time_box.pack_start(self.time_value, False, False, 0)
        vbox.pack_start(self.time_box, False, False, 10)

        # Botão para sincronizar
        self.button = Gtk.Button(label="Sincronizar com NTP agora")
        self.button.connect("clicked", self.update_time)
        vbox.pack_start(self.button, False, False, 0)

        self.update_time(None)

    def run_as_root(self, commands):
        """Executa múltiplos comandos com uma única chamada ao `pkexec`."""
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
        # Comandos para atualizar a hora via NTP
        commands = [
            "timedatectl set-ntp true",  # Ativa o NTP para sincronizar automaticamente com servidores de tempo
            "hwclock --systohc",  # Atualiza o relógio do sistema (hardware)
        ]

        if self.run_as_root(commands):
            print("Data e hora sincronizadas com sucesso via NTP.")
        else:
            print("Falha ao sincronizar data/hora com NTP.")

        # Atualiza a data e hora na interface
        self.time_value.set_text(self.get_current_time())
        self.date_value.set_text(self.get_current_date())

    def get_current_time(self):
        # Obtém a hora atual
        return datetime.now().strftime("%H:%M:%S")

    def get_current_date(self):
        # Obtém a data atual
        return datetime.now().strftime("%d/%m/%Y")


if __name__ == "__main__":
    win = TimeUpdater()
    win.connect("destroy", Gtk.main_quit)
    win.show_all()
    Gtk.main()
