#!/usr/bin/python3
# -*- coding: utf-8 -*-

# pip install googletrans==4.0.0-rc1

from googletrans import Translator

def translate_text(text, target_language):
    translator = Translator()
    translated = translator.translate(text, dest=target_language)
    return translated.text

text_to_translate = "Hello, how are you?"
target_language = "es"  # Código de idioma para espanhol

translated_text = translate_text(text_to_translate, target_language)
print(f"Original: {text_to_translate}")
print(f"Translated: {translated_text}")
