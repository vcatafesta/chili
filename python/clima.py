from __future__ import print_function
import requests
import json
from funcoes import alerta, check_host, mensagem
from define import *


class TCotacao():
    def __init__(self):
        self.dolar = 0
        self.euro = 0
        self.btc = 0
        self.bitcoin = 0

    def create(self):
        self.new()

    def new(self):
        if not check_host():
            alerta("TCotacao: Conexao com internet inativa", 75)
        try:
            self.requisicao = requests.get('http://api.promasters.net.br/cotacao/v1/valores')
            self.cotacao = json.loads(self.requisicao.text)
            self.dolar = self.cotacao['valores']['USD']['valor']
            self.euro = self.cotacao['valores']['EUR']['valor']
            self.btc = self.cotacao['valores']['BTC']['valor']
            self.bitcoin = self.cotacao['valores']['BTC']['valor']
        except Exception:
            alerta("Nao foi possivel requisitar cotacao.;;Verifique conexao com internet.", 75, centralizar = True)
        finally:
            return


class TClima():
    def __init__(self):
        self.cidade = "Pimenta Bueno, BR"
        self.lat = 0
        self.lon = 0
        self.vento = 0
        self.temperatura = 0
        self.temp_min = 0
        self.temp_max = 0
        self.tempo = 0

    def create(self):
        self.new()

    def new(self):
        if not check_host():
            alerta("TClima: Conexao com internet inativa", 75)
        try:
            self.requisicao = requests.get('http://api.openweathermap.org/data/2.5/weather?q=Pimenta Bueno&lang=pt&appid=abcd40c8c7127bc88ef925f90175b5c2')
            self.clima = json.loads(self.requisicao.text)
            self.cidade = "Pimenta Bueno"
            self.lat = self.clima['coord']['lat']
            self.lon = self.clima['coord']['lon']
            self.vento = self.clima['wind']['speed']
            self.temperatura = self.clima['main']['temp'] - K_KelvinToCelsius
            self.temp_min = self.clima['main']['temp_min'] - K_KelvinToCelsius
            self.temp_max = self.clima['main']['temp_max'] - K_KelvinToCelsius
            self.tempo = self.clima['weather'][0]['main']
        except Exception:
            alerta("Nao foi possivel requisitar clima.;;Verifique conexao com internet.", 75, centralizar = True)
        finally:
            return
