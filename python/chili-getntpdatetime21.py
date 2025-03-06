import gi
import datetime
from gi.repository import GLib

gi.require_version('Gtk', '3.0')
from gi.repository import Gtk

# ================================
# Componente de Data
# ================================
class DateComponent:
    def __init__(self):
        # Caixa que agrupa o rótulo e o valor da data
        self.box = Gtk.Box(orientation=Gtk.Orientation.VERTICAL, spacing=10)
        self.label = Gtk.Label()
        self.label.set_markup('<span size="small">Data Atual:</span>')
        self.box.pack_start(self.label, False, False, 0)
        self.value_label = Gtk.Label()
        self.value_label.set_markup('<span size="xx-large">' + self.get_current_date() + '</span>')
        self.box.pack_start(self.value_label, False, False, 0)
        # Calendário para exibição/seleção da data
        self.calendar = Gtk.Calendar()

        # Cria o quadro para a data com bordas finas
        self.frame = Gtk.Frame()
        self.frame.set_border_width(2)  # Borda fina
        self.frame.add(self.box)

    def get_current_date(self):
        return datetime.datetime.now().strftime("%d/%m/%Y")

    def update(self, dt=None):
        if dt is None:
            dt = datetime.datetime.now()
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
        self.label.set_markup('<span size="small">Hora Atual:</span>')
        self.box.pack_start(self.label, False, False, 0)
        self.value_label = Gtk.Label()
        self.value_label.set_markup('<span size="xx-large">' + self.get_current_time() + '</span>')
        self.box.pack_start(self.value_label, False, False, 0)

        # Cria o quadro para a hora com bordas finas
        self.frame = Gtk.Frame()
        self.frame.set_border_width(2)  # Borda fina
        self.frame.add(self.box)

    def get_current_time(self):
        return datetime.datetime.now().strftime("%H:%M:%S")

    def update(self, dt=None):
        if dt is None:
            dt = datetime.datetime.now()
        time_str = dt.strftime("%H:%M:%S")
        self.value_label.set_markup('<span size="xx-large">' + time_str + '</span>')

    def format_value_callback(self, spin_button):
        value = int(spin_button.get_value())
        spin_button.set_text(f"{value:02d}")
        return True

# ================================
# Interface Principal
# ================================
class MyWindow(Gtk.Window):
    def __init__(self):
        Gtk.Window.__init__(self, title="Data e Hora")
        self.set_default_size(300, 200)

        # Caixa principal para empacotar os componentes
        self.main_box = Gtk.Box(orientation=Gtk.Orientation.VERTICAL, spacing=20)
        self.add(self.main_box)

        # Criando os componentes de Data e Hora
        self.date_component = DateComponent()
        self.time_component = TimeComponent()

        # Adicionando os quadros de data e hora à interface principal
        self.main_box.pack_start(self.date_component.frame, False, False, 10)
        self.main_box.pack_start(self.time_component.frame, False, False, 10)

        # Atualiza os valores de data e hora a cada segundo
        GLib.timeout_add(1000, self.update_time)

    def update_time(self):
        # Atualiza data e hora a cada segundo
        self.date_component.update()
        self.time_component.update()
        return True  # Continua chamando a cada 1000ms

# ================================
# Execução do Programa
# ================================
if __name__ == "__main__":
    window = MyWindow()
    window.connect("destroy", Gtk.main_quit)
    window.show_all()
    Gtk.main()
