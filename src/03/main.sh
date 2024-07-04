#!/bin/bash

source check_input.sh     #Подключение файла
source clean_script.sh    #Подключение файла
logfile="./log.txt"       #Сохранение пути к файлу лога

check_arg "$@"            #вызов функции

case $clearMode in        #Кейс с проверкой значения clearMode, после чего вызываюся функции в зависимости от результата
    1)log_clean;;
    2)timedate_clean;;
    3)mask_clean;;
esac

check_freespace           #вызов функции
