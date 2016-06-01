#!/bin/bash

# Быстрая сортировка
# Результат будет записан в qsorted
function quicksort() {
	# Если нет элементов, возвращаем
	if (($#==0)); then 
		qsorted=()
		return
	fi

	# Объявляем переменные локальными, чтобы не мусорить в глобальной области видимости
	# Считываем первый аргемент в разделитель
	local pivot=$1
	local greater=()
	local lower=()
	local i

	# Разделитель мы записали, сдвигаем список аргументов
	shift

	for i; do
		if (( "$i" > "$pivot" )); then
			lower+=("$i")
		else
			greater+=("$i")
		fi
	done

	# Рекурсивно сортируем части массива
	quicksort "${greater[@]}"
	greater=("${qsorted[@]}")
	quicksort "${lower[@]}"
	qsorted+=( "$pivot" "${greater[@]}" )
}

# Сортировка пузырьком
# Результат в bsorted
function bubblesort() {
	local length=$#
	bsorted=( "$@" )

	swapped=0
	while (( $swapped == 0 )); do
		swapped=1
		for (( i = 1; i < length; i++ )); do
			prev=$((i - 1))

			if (( "${bsorted[$prev]}" < "${bsorted[$i]}" )); then
				swap=${bsorted[$prev]}
				bsorted[$prev]=${bsorted[$i]}
				bsorted[$i]=$swap

				swapped=0
			fi
		done
	done
}

# Сортировка вставками
# Результат в isorted
function insertionsort() {
	local length=$#
	isorted=( "$@" )

	if (( $length < 2 )); then
		return
	fi

	for (( j = 1; j < length; j++ )); do
		key=${isorted[$j]}
		i=$((j - 1))
		while (( $i >= 0 && ${isorted[$i]} < $key )); do
			isorted[$((i+1))]=${isorted[$i]}
			i=$((i - 1))
		done
		isorted[$((i+1))]=$key
	done
}

echo "Original array: [ 1 2 3 4 5 6 7 8 9 ]"

# Сортировка пузырьком
bubblesort 1 2 3 4 5 6 7 8 9
printf "Bubble-sorted: [ "
printf '%s ' "${bsorted[@]}"
printf "]\n"

# Сортировка пузырьком
insertionsort 1 2 3 4 5 6 7 8 9
printf "Insertion-sorted: [ "
printf '%s ' "${isorted[@]}"
printf "]\n"

# Быстрая сортировка
quicksort 1 2 3 4 5 6 7 8 9
printf "Quick-sorted: [ "
printf '%s ' "${qsorted[@]}"
printf "]\n"


