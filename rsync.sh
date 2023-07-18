Salve, 
para quem não sabe, comandos para fazer rsync de arquivos/pasta com servidor
remoto

Puxar do servidor remoto:
```
#rsync --progress -Cravzp --rsh='ssh -l user -p 22' user@host:/home/user/dir/ /home/user/dir/"
```

Empurrar para o servidor remoto:
```
#rsync --progress -Cravzp --rsh='ssh -l user -p 22' /home/user/dir/ user@host:/home/user/dir/"
```
