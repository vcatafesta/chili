import time
from datetime import datetime
import gi
gi.require_version("Gtk", "3.0")
from gi.repository import Gtk

class TimezoneUpdater(Gtk.Window):
    def __init__(self):
        super().__init__(title="Timezone Updater")
        self.set_default_size(400, 200)
        
        # Criando o label para exibir a data e hora
        self.label = Gtk.Label()
        self.add(self.label)
        
        # Criando o calendário
        self.calendar = Gtk.Calendar()
        self.add(self.calendar)
        
        # Empacotando o label e o calendário na janela
        self.grid = Gtk.Grid()
        self.grid.attach(self.label, 0, 0, 1, 1)
        self.grid.attach(self.calendar, 0, 1, 1, 1)
        self.add(self.grid)

        self.update_timezone()

        self.show_all()

    def update_timezone(self):
        # Obtenha a hora e data atual
        localized_time = datetime.now()  # Pode ser substituído por hora local ou de servidor
        self.label.set_text(f"{localized_time.strftime('%a %d %b %Y %H:%M:%S')}")  # Formato para data e hora
        
        # Atualiza o calendário
        self.calendar.select_day(localized_time.day)
        self.calendar.select_month(localized_time.month - 1)  # O mês no calendário começa de 0
        self.calendar.select_year(localized_time.year)
        
        # Forçar atualização da interface
        self.queue_draw()

    def on_update_button_clicked(self, widget):
        self.update_timezone()

# Criação da janela principal
win = TimezoneUpdater()

# Conectando a função de destruição para sair do GTK
win.connect("destroy", Gtk.main_quit)

# Inicia o loop GTK
Gtk.main()
