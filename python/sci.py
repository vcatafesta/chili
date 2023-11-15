#!/usr/bin/python3
# -*- coding: utf-8 -*-
# coding: cp860

from __future__ import print_function
from __future__ import division
from tmenu import *
from tini import *
from tdb import *
from funcoes import *
from clima import *
from main_dbfpy import *
import subprocess

global oAmbiente
global oMenu
global oIni

var = newvar()
var.value = 0
var.str = '10'


@sci_logger
def edicao():
    cscreen = savevideo()
    filenames = 'readme.txt'

    memo = TEdit()
    memo.MemoEdit(memo.MemoRead(filename = filenames), 1, 0, maxrow() - 2,
                  maxcol() - 1, ncor = oAmbiente.cormenu, ctitulo = filenames)
    alerta(memo.nchoice, 75)
    restvideo(cscreen)


# MemoWrit( Arquivo, MemoEdit( MemoRead( Arquivo ), 02, 01, 24-2, (MaxCol()-2), .T., "Linha", 132))

class TEdit():
    def __init__(self):
        self.file = file
        self.buffer = buffer
        self.nchoice = 0

    def MemoRead(self, filename):
        try:
            with open(filename) as self.file:
                self.buffer = [line for line in iter(self.file.readline, '')]
                # header_line = next(f)

        except Exception:
            pass
        finally:
            self.file.close()
            return self.buffer

            # for line in self.buffer:
            # for line in self.file:
            #   print(line.strip())

            # alerta(line, 75)
            # self.file.read()
            # self.file.seek(0)
            # self.file.next()
            # line = self.file.readline()
            # alerta(str(self.file.tell()), 75)

    def MemoEdit(self, aArray, nrow, ncol, nrow1, ncol1, ncor, ctitulo):
        box(nrow, ncol, nrow1, ncol1, cFrame = m_frame(), nCor = ncor,
            titulo = ctitulo.upper())

        #aArray = array_strzero(65, 10, NIL)
        #aArray = array_str(65, maxcol() - 2)
        #aArray = array_names(100, maxcol() - 2)
        aArray = recelan()
        self.nchoice = achoice(nrow, ncol, nrow1, ncol1, aArray, ncor, ctitulo)
        return self.nchoice


@sci_logger
def osshell():
    try:
        setcolor()
        clear()
        # subprocess.call("cmd" + " myarg", shell = True)
        subprocess.call(['ping', '10.0.0.80'])
        subprocess.call(['NET', 'USE'], shell = True)
        # subprocess.call(['NET', 'USE', 'LPT1', '/DELETE'], shell = True)
        # subprocess.call(['NET', 'USE', 'LPT2', '/DELETE'], shell = True)
        # subprocess.call(['NET', 'USE', 'LPT3', '/DELETE'], shell = True)
        # subprocess.call(['NET', 'USE', 'lpt1', '\\10.0.0.99\P1', '/PERSISTENT:YES'], shell = True)
        # subprocess.call(['NET', 'USE', 'lpt2', '\\10.0.0.99\P1', '/PERSISTENT:YES'], shell = True)
        # subprocess.call(['NET', 'USE', 'lpt3', '\\10.0.0.99\P1', '/PERSISTENT:YES'], shell = True)
        subprocess.call(['CALL', 'cap.bat'], shell = True)
        subprocess.call("PAUSE", shell = True)
        subprocess.call("CMD", shell = True)

        # os.system('NET USE LPT1 \\10.0.0.99\P1')
        # os.system('cmd')

    except Exception:
        alerta("Erro", oAmbiente.coralerta)
    finally:
        return


def info():
    alerta(
            oAmbiente.xsistema + ';' + oAmbiente.xversao + ';' + oAmbiente.xcopyright + ';;Tecle algo para continuar.',
            oAmbiente.coralerta, centralizar = True)
    return


def climatempo():
    cscreen = mensagem("Aguarde, consultando Cotacao e Clima",
                       oAmbiente.coralerta)
    if not check_host():
        restvideo(cscreen)
        alerta(
                "[Erro ao Consultar Clima e Cotacao];;Sem conexao com a internet.",
                75, centralizar = True)
        return
    var.cotacao = TCotacao()
    var.cotacao.new()
    var.clima = TClima()
    var.clima.new()
    restvideo(cscreen)

    aclima = {
        'Rain'  : 'Chuva',
        'Clouds': 'Nublado',
        'Clear' : 'Limpo'
        };

    alerta(
            '   Processador Cores: {}'.format(processor_core()) + ';' +
            '      Frequencia CPU: {}'.format(cpu_freq(porcpu = True)) + ';' +
            '       Memoria Total: {}'.format(total_memory()) + ';' +
            '        Memoria Swap: {}'.format(swap_memory()) + ';' +
            linhaembranco +
            '   Cotacao Dolar R$ : {}'.format(var.cotacao.dolar) + ';' +
            linhaembranco +
            "  Pimenta Bueno Clima " ';' +
            "                Ceu : {}".format(aclima[var.clima.tempo]) + ';' +
            "     Temperatura {}C : {} [min {}] [max {}]".format(chr(248),
                                                                 var.clima.temperatura,
                                                                 var.clima.temp_min,
                                                                 var.clima.temp_max) + ';' +
            "           Latitude : {}".format(var.clima.lat) + ';' +
            "          Longitude : {}".format(var.clima.lon) + ';' +
            "              Vento : {} ms/s".format(var.clima.vento),
            oAmbiente.coralerta)


def network_status():
    arede = [n for n in net_if_stats()]
    aduplex = {
        0: 'Half',
        2: 'Full'
        }
    astatus = {
        True : 'Ativa',
        False: 'Desativada'
        }

    cstr = ''

    for i in range(len(arede)):
        cstr += \
            '       Rede: {}'.format(arede[i]) + ';' + \
            '     Status: {}'.format(
                    astatus[net_if_stats()[arede[i]][0]]) + ';' + \
            '     Duplex: {}'.format(
                    aduplex[net_if_stats()[arede[i]][1]]) + ';' + \
            ' Velocidade: {} mbits'.format(net_if_stats()[arede[i]][2]) + ';' + \
            '        MTU: {}'.format(net_if_stats()[arede[i]][3]) + ';' + \
            linhaembranco

    alerta(cstr, oAmbiente.coralerta)


def configurarambiente():
    oAmbiente.panofundo = oIni.get('SCI', 'panofundo', oAmbiente.panofundo)
    oAmbiente.corcabec = oIni.getint('SCI', 'corcabec', oAmbiente.corcabec)
    oAmbiente.cormenu = oIni.getint('SCI', 'cormenu', oAmbiente.cormenu)
    oAmbiente.coralerta = oIni.getint('SCI', 'coralerta', oAmbiente.coralerta)
    oAmbiente.cordesativada = oIni.getint('SCI', 'cordesativada', oAmbiente.cordesativada)
    oAmbiente.corligthbar = oIni.getint('SCI', 'corlightbar', oAmbiente.corlightbar)
    oAmbiente.corhotkey = oIni.getint('SCI', 'corhotkey', oAmbiente.corhotkey)
    oAmbiente.corhklightbar = oIni.getint('SCI', 'corhklightbar', oAmbiente.corhklightbar)
    oAmbiente.corfundo = oIni.getint('SCI', 'corfundo', oAmbiente.corfundo)
    return


def oSciMenuSci():
    AtPrompt = []

    if oAmbiente.Get_Ativo:
        cStr_Get = "Desativar Get Tela Cheia"
    else:
        cStr_Get = "Ativar Get Tela Cheia"

    if oMenu.Sombra:
        cStr_Sombra = "DesLigar Sombra"
    else:
        cStr_Sombra = "Ligar Sombra"

    aadd(AtPrompt, ["Encerrar",
                    ["Encerrar Execucao do SCI", "", "Trocar de Empresa",
                     "Trocar de Usuario", "", "Copia de Seguranca",
                     "Restaurar Copia de Seguranca"]])
    aadd(AtPrompt, ["Modulos", ["Controle de Estoque", "Contas a Receber",
                                "Contas a Pagar", "Contas Correntes",
                                "Controle de Producao", "Controle de Ponto",
                                "Mala Direta", "Vendedores"]])
    aadd(AtPrompt,
         ["Vendas",
          ["Terminal PDV", "Terminal Consulta de Precos", "Relatorio Vendas *",
           "Relatorio Receber *", "Relatorio Recebido *",
           "Cadastra Senha Caixa", "", "Resumo Caixa Individual",
           "Detalhe Caixa Individual", "Detalhe Diario Caixa Geral *",
           "Detalhe Emissao Recibos em Carteira",
           "Detalhe Emissao Recibos Banco", "Detalhe Emissao Recibos Outros",
           "",
           "Rol Debito C/C Cliente", "Reajuste Debito C/C Cliente",
           "Consulta Debito C/C", "Baixar Debito C/C", "",
           "Comandos de Impressora Fiscal"]])
    aadd(AtPrompt, ["Backup",
                    ["Copia de Seguranca", "Restaurar Copia de Seguranca",
                     "Gerar Arquivo Batch de Copia Seguranca", "",
                     "Reindexar Normal", "Reindexar Verificando Duplicidade",
                     "Reindexar Parcialmente",
                     "Eliminar Arquivos Temporarios"]])
    aadd(AtPrompt, ["Editor", ["Editar Arquivo", "Imprimir Arquivo",
                               "Teste Reindexar Thread"]])
    aadd(AtPrompt,
         ["Ambiente",
          ["Spooler de Impressao", "Layout Janela", "", "Cor Pano de Fundo",
           "Cor de Menu", "Cor Cabecalho", "Cor Alerta", "Cor Borda",
           "Cor Item Desativado", "Cor Box Mensagem",
           "Cor Light Bar", "Cor HotKey", "Cor LightBar HotKey", "",
           "Pano de Fundo", "Frame", cStr_Sombra, cStr_Get, "Alterar Senha"]])

    aadd(AtPrompt, ["ArQuivos",
                    ["Manutencao Diretorios", "Arquivos da Base de Dados", "",
                     "Reindexar Normal", "Reindexar Verificando Duplicidade",
                     "", "Eliminar Arquivos Temporarios",
                     "Cadastra e Altera Usuario", "Configuracao de Base Dados",
                     "Retorno Acesso", "Separar Movimento Anual",
                     "Caixa Automatico", "Zerar Movimento de Conta",
                     "Cadastrar Impressora", "Alterar Impressora",
                     "Renovar Codigo de Acesso"]])
    aadd(AtPrompt, ["Reconstruir ",
                    ["Base de Dados", "Arquivo Nota", "Arquivo Printer",
                     "Arquivo EntNota", "Arquivo Prevenda"]])
    aadd(AtPrompt, ["Shell", ["Shell         ALT D", "Comandos DOS  ALT X"]])
    aadd(AtPrompt, ["Help", ["Sobre o Sistema", "Ultimas Alteracoes", "Help",
                             "Cotacao e Clima", "Placas de Rede"]])
    return (AtPrompt)


def oDispMenuSci():
    nlen = len(oAmbiente.menu)
    disp = []
    disp.append(
            [OK, OK, OK, OK, OK, OK, OK, OK, OK, OK, OK, OK, OK, OK, OK, OK, OK,
             OK, OK, OK, OK])
    disp.append(
            [OK, OK, OK, OK, OK, OK, OK, OK, OK, OK, OK, OK, OK, OK, OK, OK, OK,
             OK, OK, OK, OK])
    disp.append(
            [OK, OK, OK, OK, OK, OK, OK, OK, OK, OK, OK, OK, OK, OK, OK, OK, OK,
             OK, OK, OK, OK])
    disp.append(
            [OK, OK, OK, OK, OK, OK, OK, OK, OK, OK, OK, OK, OK, OK, OK, OK, OK,
             OK, OK, OK, OK])
    disp.append(
            [OK, OK, OK, OK, OK, OK, OK, OK, OK, OK, OK, OK, OK, OK, OK, OK, OK,
             OK, OK, OK, OK])
    disp.append(
            [OK, OK, OK, OK, OK, OK, OK, OK, OK, OK, OK, OK, OK, OK, OK, OK, OK,
             OK, OK, OK, OK])
    disp.append(
            [OK, OK, OK, OK, OK, OK, OK, OK, OK, OK, OK, OK, OK, OK, OK, OK, OK,
             OK, OK, OK, OK])
    disp.append(
            [OK, OK, OK, OK, OK, OK, OK, OK, OK, OK, OK, OK, OK, OK, OK, OK, OK,
             OK, OK, OK, OK])
    disp.append(
            [OK, OK, OK, OK, OK, OK, OK, OK, OK, OK, OK, OK, OK, OK, OK, OK, OK,
             OK, OK, OK, OK])
    disp.append(
            [OK, OK, OK, OK, OK, OK, OK, OK, OK, OK, OK, OK, OK, OK, OK, OK, OK,
             OK, OK, OK, OK])

    # disp = [True for i in oAmbiente.menu]
    # disp.append([True for i in oAmbiente.menu[0][1]])
    # disp.append([True for i in oAmbiente.menu[1]])
    # disp.append([True for i in oAmbiente.menu[1]])

    # for i in range(nlen):

    # for i in oAmbiente.menu:
    # disp.append([OK, OK, OK, OK, OK, OK, OK, OK, OK, OK, OK, OK, OK, OK, OK, OK, OK, OK, OK, OK, OK])
    #   disp.append([OK])
    #   for n in i:
    #      disp.append(OK)

    return disp


setcolor()
clear()
setcursor(0)
print("Iniciando variaveis de ambiente.")
oAmbiente = TAmbiente()
bar = InitBar("Configurando ambiente                 =>")
bar(100)
oMenu = TMenu()
bar = InitBar("Configurando menu                     =>")
bar(100)
oIni = TIni('sci.ini')
bar = InitBar("Configurando ini                      =>")
bar(100)
configurarambiente()
bar = InitBar("Incluindo registros no Banco de Dados =>")
bar(100)
cscreen = mensagem("Aguarde, incluindo registros...", oAmbiente.coralerta)

db = TDb()
db.create_table()
oAmbiente.StatInf('')
for i in range(10):
    oAmbiente.ContaReg()
    db.data_entry()
db.conn.commit()
db.conn.close()
restvideo(cscreen)
setcolor()
errorbeep()
info()


def main():
    oAmbiente.menu = oSciMenuSci()
    oAmbiente.menu = oSciMenuSci()
    oAmbiente.disp = oDispMenuSci()
    oAmbiente.limpa()
    while True:
        nchoice = oAmbiente.Show(False)
        if nchoice == '1.01' or nchoice == '0.00':
            if conf("Pergunta: Deseja encerrar?", oAmbiente.coralerta):
                setcolor()
                clear()
                alerta(oMenu.cabec, oAmbiente.coralerta)
                setcolor()
                # setpos(maxrow()-1,0)
                exit(0)
        elif nchoice == '2.02':
            recelan()

        elif nchoice == '6.04':
            oAmbiente.setacor(0)
            continue
        elif nchoice == '6.05':
            oAmbiente.setacor(1)
            continue
        elif nchoice == '6.06':
            oAmbiente.setacor(2)
            continue
        elif nchoice == '6.07':
            oAmbiente.setacor(3)
            continue
        elif nchoice == '6.09':
            oAmbiente.setacor(4)
            continue
        elif nchoice == '6.11':
            oAmbiente.setacor(5)
            continue
        elif nchoice == '6.12':
            oAmbiente.setacor(6)
            continue
        elif nchoice == '6.13':
            oAmbiente.setacor(7)
            continue
        elif nchoice == '6.14':
            oAmbiente.setacor(8)
            continue
        elif nchoice == '2.01':
            while True:
                nchoice = fazmenu(11, 11, oMenu.menuprincipal,
                                  oAmbiente.cormenu)
                if nchoice == K_ESC or nchoice == 0:
                    break
                elif nchoice == 1:
                    alteracor()
                elif nchoice == 2:
                    oAmbiente.setacor(nchoice)
                elif nchoice == 3:
                    alerta("TESTE", 15)

        elif nchoice == '9.01':
            osshell()
        elif nchoice == '9.02':
            osshell()
        elif nchoice == '10.02':
            edicao()
        elif nchoice == '10.01':
            info()
        elif nchoice == '10.04':
            climatempo()
        elif nchoice == '10.05':
            network_status()
        continue


def alteracor():
    aini = ['corfundo', 'cormenu', 'corcabec', 'coralerta', 'cordesativada',
            'corligthbar', 'corhotkey', 'corhkligthbar']
    cscreen = savescreen()
    while True:
        nchoice = fazmenu(13, 14, aini, oAmbiente.cormenu,
                          "ALTERAR CORES DO SISTEMA")
        if nchoice == K_ESC:
            return (restvideo(cscreen))
        else:
            oAmbiente.setacor(nchoice)


class Calculadora(object):
    def __init__(self, a, b):
        self.a = a
        self.b = b

    def soma(self):
        return self.a + self.b


if __name__ == "__main__":
    main()
