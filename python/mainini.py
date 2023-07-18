import configparser

config = configparser.ConfigParser()
config.add_section('database')
config.set('database', 'host', 'localhost')
config.set('database', 'dbname', 'example')
config.set('database', 'port', '1234')
config.set('database', 'user', 'admin')
config.set('database', 'password', 'secret')

config.add_section('repository')
config.set('repository', 'type', 'git')
config.set('repository', 'url', 'git@github.com:user/project.git')

with open('config.ini', 'w') as configfile:
    config.write(configfile)