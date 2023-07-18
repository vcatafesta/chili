#! /usr/bin/env ruby

require 'open-uri'
require 'nokogiri'

doc = Nokogiri::HTML(URI.open('https://chilios.com.br/packages'))
puts doc
