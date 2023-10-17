#!/bin/bash
#---------------------------------------------------------------------
# CRIADO POR @CRAZY_VPN
# CANAL OFICIAL @SSHPLUS (TELEGRAM)
#----------------------------------------------------------------------
clear

echo """
 _____ _____ _____ _____ _         
|   __|   __|  |  |  _  | |_ _ ___ 
|__   |__   |     |   __| | | |_ -|
|_____|_____|__|__|__|  |_|___|___|
"""
echo -e "\033[1;33mESSE SCRIPT RESTAURA O BANCO DE DADOS\n(BACKUP) DO PAINEL SSHPLUS WEB !\033[0m" 
echo -e "\n\033[1;33mÉ NECESSÁRIO O PAINEL INSTALADO E O\nAQUIVO (\033[1;32msshplus.sql\033[1;33m) NO DIRETORIO ROOT !\033[0m\n" 
echo -ne "\033[1;32mEnter para continuar...\033[0m"; read

[[ ! -e /opt/sshplus_painel/painel ]] && {
	echo -e "\n\033[1;31mO PAINEL NAO ESTA INSTALADO !\033[0m"; exit 0
}

[[ ! -e $HOME/sshplus.sql ]] && {
	echo -e "\n\033[1;31mARQUIVO (\033[1;32msshplus.sql\033[1;31m) NAO ENCONTRADO !\033[0m"; exit 0
}

passdb=$(sed -n 's/.*"mysql_pass": "\(.*\)".*/\1/p' /opt/sshplus_painel/config.json)
[[ $(mysql -h localhost -u sshplus -p$passdb -e "show databases" | grep -wc sshplus) == '0' ]] && {
	echo -e "\n\033[1;31mSEU PAINEL NAO É COMPATIVEL !\033[0m"; exit 0
}

mysql -h localhost -u sshplus -p$passdb -e "drop database sshplus"
mysql -h localhost -u sshplus -p$passdb -e 'create database sshplus'
mysql -h localhost -u sshplus -p$passdb --default_character_set utf8 sshplus < sshplus.sql
echo -e "\n\033[1;32mBACKUP RESTAURADO !\033[0m"
