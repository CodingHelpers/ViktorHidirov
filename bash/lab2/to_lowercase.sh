#!/bin/bash

# Если число аргументов меньше 2, показываем usage и выходим
if [[ $# != 2 ]]; then
	echo "Usage: to_lowercase.sh <input_file.txt> <output_file.txt> "
	exit 1
fi

# Читаем из аргументов имена файлов
input_file=$1
output_file=$2

# Проверка существования файла
if ! test -f $input_file; then
	echo "${input_file}: No such file"
	exit 2
fi

# Читаем первый файл в переменную
data=$(cat $input_file)

# Перенаправляем вывод содержимого в команду tr, 
# которая заменит все буквы верхнего регистра буквами нижнего регистра
data=$(echo "$data" | tr '[:upper:]' '[:lower:]')

# Перенаправляем вывод в итоговый файл
echo $data > $output_file

