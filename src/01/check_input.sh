#!/bin/bash

definition() {
check_arg "$@"
check_absolutePath "$1"
check_number_subfolders "$2"
check_folders_name "$3"
check_number_files "$4"
check_file_name "$5"
check_file_size "$6"
}

#Проверка количества параметров, заданных при запуске

check_arg() {
    if [ $# -ne 6 ]; then
        echo "Error: Введите 6 аргументов для запуска!"
        exit 1
    fi
}

#Проверка корректности пути, в  котором в случае несуществования директории будет предлагаться создать новую

check_absolutePath() {
    if [ -d "$1" ]; then
        absolutePath="$1"
    else
        echo "Error: Директории не существует!"
        read -p "Создать "$1" директорию? (y/n) " answer
        if [ "$answer" == "${answer#[Yy]}" ]; then #условие проверяет что ввел пользователь после вопроса, если это Y или y, будет переход в условие else, а потом создастся новая директория
            exit 1
        else
            sudo mkdir -p "$1" #создание новой директории по пути заданном пользователем
            if [ -d "$1" ]; then
                absolutePath="$1"
            else
                echo "Не удалось создать директорию! Пожалуйста, укажите абсолютный путь в первом параметре при запуске скрипта."
                exit 1
            fi
        fi
    fi
}


#Проверка количества вложенных папок

check_number_subfolders () {   
    if  [[ "$1" =~ ^[0-9]+$ ]];then #проверяет является ли первый параметр целым числом
    foldersNumber="$1"
    else
        echo "ERROR: Введите вторым аргументом количество вложенных папок"
        exit 1
    fi
}

#Проверка списка букв английского алфавита, используемый в названии папок (не более 7 знаков).
check_folders_name () {
    if [[ ${#1} -le 7 && "$1" =~ ^[a-zA-Z_]+$ ]]; then
        foldersName="$1"
    else
        echo "ERROR: Введите 3 аргументом список букв (не более 7 знаков) и только из букв английского алфавита"
        exit 1
    fi
}

#Проверка количествa файлов в каждой созданной папке. 

check_number_files () {
    if  [[ "$1" =~ ^[0-9]+$ ]];then
    numberFiles="$1"
    else
        echo "ERROR: Введите 4 аргументом количество файлов в каждой созданной папке"
        exit 1
    fi
}

check_file_name () {
    if  [[ "$1" =~ ^[a-zA-Z_]{1,7}\.[a-zA-Z]{1,3}$ ]]; then
    fileNames="$1"
    else
        echo "ERROR: Укажите в качестве пятого аргумента имя файла и его расширение в виде 'name.txt', где имя файла не должно превышать 7 символов, а расширение - 3 символа. Используйте только английские буквы."
        exit 1       
    fi
}


# Проверяем размер файлов (в килобайтах, но не более 100)
check_file_size() {
    if [[ "${1:(-2)}" == "kb" && "${1:0:(-2)}" =~ ^[0-9]+$ && "${1:0:(-2)}" -ge 1 && "${1:0:(-2)}" -le 100 ]]; then
        filesize="$1"
    else
        echo "ERROR: Введите размер файла в kb (от 1 до 100)"
        exit 1
    fi
}

