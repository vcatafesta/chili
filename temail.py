#!/usr/bin/python3
# -*- coding: utf-8 -*-

import smtplib
from smtplib import SMTPException

try:
    mail = smtplib.SMTP("smtp.gmail.com", 587)
    mail.starttls()
    mail.login("vcatafesta@gmail.com", '')
    msg = "Email from Python"
    mail.sendmail
