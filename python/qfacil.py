#!/usr/bin/python
# -*- coding: utf-8 -*-

#
# Minha primeira experiencia em pygtk, uma interface simples para o qemu
# Apenas para aprender como se faz.
# Ele pega as opcoes definida na interface e de acordo com elas
# preprara os parametros a serem enviados e finalemente chama o qemu 
#
# O Qemu deve estar instalado corretamente para que o script funcione
# E tambem o kqemu, caso queira usar essa opcao
#
# Muita coisa aqui nao foi feita da melhor forma possivel por ser meu primeiro script
# Qualquer dica, conselho, reclamacao etc é bem vindo
#
# Por diogosouza.eu (at) gmail.com
# Em 25-Fev-2007
# 


import pygtk
pygtk.require('2.0')
import gtk

# Importado para passar instrucoes ao sistema operacional
import os


# classe principal
class teste:
   
   # construtor da janela
   def __init__(self):
      
      #inicia variaveis que vou usar depois
      self.audio = ""
      self.tela = ""
      self.hora = ""
      self.cdx = ""
      self.hdx = ""
      self.floppyx = ""
      self.parametros ="qemu " 
      self.booton = "--> cdrom ON" 
      
      # Aqui e onde a janela e criada
      self.win = gtk.Window(gtk.WINDOW_TOPLEVEL)
      self.win.connect('delete-event',gtk.main_quit)
      self.win.set_border_width(8)
      self.win.set_title('Qemu Facil')
      
      # Dividi a janela em quatro conteiners. O vbox e onde organizo tudo
      # no grid ficam as opcoes gerais, nos hbox os que sobraram
      self.vbox = gtk.VBox(False, 8)
      self.grid = gtk.Table(5,4)
      self.hbox = gtk.HBox(False, 8)
      self.hbox2 = gtk.HBox(False, 8)
      
      # Abaixo a construcao geral da janela
      self.grid.set_col_spacings(10)
      self.intro = gtk.Label("Qemu Facil - uma simples interface")
      
      self.label = gtk.Label('Usar')
      
      self.usar_cdrom = gtk.CheckButton("-->")
      self.usar_hd = gtk.CheckButton("-->")
      self.usar_floppy = gtk.CheckButton("-->")
      
      # Esses chamam as funcoes para definir as variaveis de acordo com as escolhas
      self.usar_cdrom.connect('toggled', self.activar_cdrom, "-->")
      self.usar_hd.connect('toggled', self.activar_hd, "-->")
      self.usar_floppy.connect('toggled', self.activar_floppy, "-->")
      
      self.label2 = gtk.Label('Boot')
      
      # Aqui eu ja tive de anexar logo a tabela e definir a função por serem radio
      # e eu nao sei trata-los de outra forma...
      self.boots = gtk.RadioButton(None, "")
      self.grid.attach(self.boots, 4 , 5, 1, 2)
      self.boots.connect('toggled', self.boot_cdrom, "-->")
      self.boots= gtk.RadioButton(self.boots, "")
      self.grid.attach(self.boots, 4, 5, 2, 3)
      self.boots.connect('toggled', self.boot_hd, "-->")
      self.boots = gtk.RadioButton(self.boots, "")
      self.grid.attach(self.boots, 4, 5, 3, 4)
      self.boots.connect('toggled', self.boot_floppy, "-->")
      
      self.label3 = gtk.Label('CDROM')
      self.label4 = gtk.Label('HardDisk')
      self.label5 = gtk.Label('Floppy')
      
      # Esses são quem guarda o endereço das imagens a serem usadas
      self.cdrom = gtk.Entry() 
      self.hd = gtk.Entry()
      self.floppy = gtk.Entry()
      
      # Por default ficam os drivers físicos
      self.cdrom.set_text("/dev/cdrom")
      self.floppy.set_text("/dev/fd0")
      
      self.cdrom_busca = gtk.Button('Buscar')
      self.hd_busca = gtk.Button('Buscar')
      self.floppy_busca = gtk.Button('Buscar')
      
      self.cdrom_busca.connect("clicked", self.busca_cdrom)
      self.hd_busca.connect("clicked", self.busca_hd)
      self.floppy_busca.connect("clicked", self.busca_floppy)
      
      # Agora eu monto tudo no grid
      self.grid.attach(self.label, 0, 1, 0, 1)
      self.grid.attach(self.label2, 4, 5, 0, 1)
      
      self.grid.attach(self.usar_cdrom, 0, 1, 1, 2)
      self.grid.attach(self.label3, 1, 2, 1, 2)
      self.grid.attach(self.cdrom, 2, 3, 1, 2)
      self.grid.attach(self.cdrom_busca, 3, 4, 1, 2)
      
      self.grid.attach(self.usar_hd, 0, 1, 2, 3)
      self.grid.attach(self.label4, 1, 2, 2, 3)
      self.grid.attach(self.hd, 2, 3, 2, 3)
      self.grid.attach(self.hd_busca, 3, 4, 2, 3)
      
      self.grid.attach(self.usar_floppy, 0, 1, 3, 4)
      self.grid.attach(self.label5, 1, 2, 3, 4)
      self.grid.attach(self.floppy, 2, 3, 3, 4)
      self.grid.attach(self.floppy_busca, 3, 4, 3, 4)
      
      # Agora e o que entra no hbox, Memoria Ram e Kqemu
      self.label6 = gtk.Label('Ram(MB):')
      self.ram = gtk.combo_box_new_text()
      self.ram.append_text("64")
      self.ram.append_text("128")
      self.ram.append_text("256")
      self.ram.append_text("512")
      
      self.label7 = gtk.Label('Kqemu')
      self.kqemu = gtk.combo_box_new_text()
      self.kqemu.append_text("Sim - com kernel")
      self.kqemu.append_text("Sim - simples")
      self.kqemu.append_text("Nao usar")
      
      self.hbox.pack_start(self.label6)
      self.hbox.pack_start(self.ram)
      self.hbox.pack_start(self.label7)
      self.hbox.pack_start(self.kqemu)
      
      # Segundo hbox, Localtime, Audio e Fullscreen
      self.localtime_c = gtk.CheckButton("Hora Local")
      self.audio_c = gtk.CheckButton("Audio")
      self.fullscreen_c = gtk.CheckButton("Tela Cheia")
      
      self.localtime_c.connect('toggled', self.activar_hora, "-->")
      self.audio_c.connect('toggled', self.activar_audio, "-->")
      self.fullscreen_c.connect('toggled', self.activar_tela, "-->")
      
      self.hbox2.pack_start(self.localtime_c)
      self.hbox2.pack_start(self.audio_c)
      self.hbox2.pack_start(self.fullscreen_c)
      
      # Caso o usuario queira algo mais...
      self.label8 = gtk.Label("Parametros adcionais")
      self.extra = gtk.Entry()
      
      # Botão para chamar o qemu
      self.entrar = gtk.Button("Entrar")
      self.entrar.connect("clicked", self.emular)
      
      # Agora tudo entra no vbox na ordem certa
      self.vbox.pack_start(self.intro)
      self.vbox.pack_start(self.grid)
      self.vbox.pack_start(self.hbox)
      self.vbox.pack_start(self.hbox2)
      self.vbox.pack_start(self.label8)
      self.vbox.pack_start(self.extra)
      self.vbox.pack_start(self.entrar)
      
      self.win.add(self.vbox)
      self.win.show_all()
            
   # As funcoes a seguir sao do botao de busca das imagens
   # Ele abre uma caixa de selecao de arquivos e passa o arquivo
   # selecionado para a entrada devida, os gtk.Entry, que sao lidos mais tarde
   def file_ok_cdrom(self, w):
      self.fc = " %s " % self.filec.get_filename()
      self.cdrom.set_text(self.fc) 
      self.filec.hide()
      
   def file_ok_hd(self, w):
      self.fh = " %s " % self.fileh.get_filename()
      self.hd.set_text(self.fh) 
      self.fileh.hide()
      
   def file_ok_floppy(self, w):
      self.ff = " %s " % self.filef.get_filename()
      self.floppy.set_text(self.ff) 
      self.filef.hide()
      
   def destroy(self, widget):
      self.filec.hide()
      self.fileh.hide()
      self.filef.hide()
      
   def busca_cdrom(self, widget, data=None):
      self.filec = gtk.FileSelection("File selection")
      self.filec.connect("destroy", self.destroy)
      self.filec.ok_button.connect("clicked", self.file_ok_cdrom)
      self.filec.cancel_button.connect("clicked",lambda w: self.filec.destroy())
      self.filec.show()
      
   def busca_hd(self, widget, data=None):
      self.fileh = gtk.FileSelection("File selection")
      self.fileh.connect("destroy", self.destroy)
      self.fileh.ok_button.connect("clicked", self.file_ok_hd)
      self.fileh.cancel_button.connect("clicked",lambda w: self.fileh.destroy())
      self.fileh.show()
      
   def busca_floppy(self, widget, data=None):
      self.filef = gtk.FileSelection("File selection")
      self.filef.connect("destroy", self.destroy)
      self.filef.ok_button.connect("clicked", self.file_ok_floppy)
      self.filef.cancel_button.connect("clicked",lambda w: self.filef.destroy())
      self.filef.show()
      
   # As funcoes abaixo apenas servem para definir as variaveis que depois serao lidas
   # para passa-las ao qemu. Se ve quais Discos usar e em qual esta o Boot
   
   def activar_cdrom(self, widget, data=None):
      self.cdx = "%s cdrom %s" % (data, ("OFF", "ON")[widget.get_active()])
      
   def activar_hd(self, widget, data=None):
      self.hdx = "%s hd %s" % (data, ("OFF", "ON")[widget.get_active()])
   
   def activar_floppy(self, widget, data=None):
      self.floppyx = "%s floppy %s" % (data, ("OFF", "ON")[widget.get_active()])

   def boot_cdrom(self, widget, data=None):
      self.booton = "%s cdrom %s" % (data, ("OFF", "ON")[widget.get_active()])
   
   def boot_hd(self, widget, data=None):
      self.booton = "%s hd %s" % (data, ("OFF", "ON")[widget.get_active()])
   
   def boot_floppy(self, widget, data=None):
      self.booton = "%s floppy %s" % (data, ("OFF", "ON")[widget.get_active()])
   
   # Essa verifica as ultimas instruções passadas, Audio, Hora e TelaCheia
   
   def activar_audio(self, widget, data=None):
      self.audio = "%s audio %s" % (data, ("OFF", "ON")[widget.get_active()])
      
   def activar_hora(self, widget, data=None):
      self.hora = "%s hora %s" % (data, ("OFF", "ON")[widget.get_active()])
   
   def activar_tela(self, widget, data=None):
      self.tela = "%s tela %s" % (data, ("OFF", "ON")[widget.get_active()])
      
      
   def emular(self, button):
      # Essa funcao e que chama o qemu com os devidos parametros
      # Ele primeiro verifica quais itens usar.
      
      self.parametros = "qemu "
      self.imagem = 0
      self.boot = 0
      self.mram = 0
      
      self.active = self.ram.get_active()
      self.activek = self.kqemu.get_active()
      
      # Primeiro ve quais discos carregar e em qual boot
      # mas so deixa boot em disco carregado e so ativa disco com imagem selecionada
      
      if self.cdx == "--> cdrom ON" and self.cdrom.get_text() != "" :
         self.parametros = self.parametros +" -cdrom "+ self.cdrom.get_text()
         self.imagem = 1
         if self.booton == "--> cdrom ON":
            self.parametros = self.parametros +" -boot d"
            self.boot = 1
         
      if self.hdx == "--> hd ON" and self.hd.get_text() != "" :
         self.parametros = self.parametros +" -hda "+ self.hd.get_text()
         self.imagem = 1
         if self.booton == "--> hd ON":
            self.parametros = self.parametros +" -boot c"
            self.boot = 1
         
      if self.floppyx == "--> floppy ON" and self.floppy.get_text() != "":
         self.parametros = self.parametros +" -fda "+ self.floppy.get_text()
         self.imagem = 1
         if self.booton == "--> floppy ON":
            self.parametros = self.parametros +" -boot a" 
            self.boot = 1      
            
      # Depois define a RAM a ser usada
      if self.active == 0 :
         self.mram = "64"
      elif self.active == 1 :
         self.mram = "128"
      elif self.active == 2 :
         self.mram = "256"
      elif self.active == 3 :
         self.mram = "512"
      else:
         self.mram = "128"
      
      self.parametros = self.parametros +" -m "+ self.mram
      
      # Verifica se e ou nao para usar kqemu
      if self.activek == 0 :
         self.parametros = self.parametros +" -kernel-kqemu "
      elif self.activek == 2:
         self.parametros = self.parametros +" -no-kqemu "
         
      # E as opcoes extras
      
      if self.audio == "--> audio ON" :
         self.parametros = self.parametros +" -soundhw all "
         
      if self.tela == "--> tela ON" :
         self.parametros = self.parametros +" -full-screen "
         
      if self.hora == "--> hora ON" :
         self.parametros = self.parametros +" -localtime "
         
      # E por fim adciona os parametros extras
      self.parametros = self.parametros + " " + self.extra.get_text()
      
      # Agora verifica se o minimo foi configurado
      if self.boot == 1 and self.imagem == 1 :
         # Essa função envia a string ja definida para o sistema
         # e retorna o output para lugar nenhum(/dev/null)
          os.system(self.parametros)
      else:
         # Caso falte algum item ele exibe essa mensagem de erro.
         self.alert = gtk.MessageDialog(None, gtk.DIALOG_MODAL, buttons = gtk.BUTTONS_CLOSE, message_format = "Sistema nao esta pronto para iniciar, verifique suas opcoes")
         self.resp = self.alert.run()
         self.alert.show()
         if self.resp == gtk.RESPONSE_CLOSE:
            self.alert.destroy()
            
         
      
# Abaixo o programa e iniciado

   def main(self):
      gtk.main()


teste = teste() 
teste.main() 
