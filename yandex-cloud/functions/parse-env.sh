#!/bin/bash

# Скрипт для парсинга .env файла и преобразования в формат для yc
# Использование: ./parse-env.sh .cloud.env

if [ $# -eq 0 ]; then
    echo "Usage: $0 <env-file>"
    exit 1
fi

ENV_FILE=$1

if [ ! -f "$ENV_FILE" ]; then
    echo "Error: File $ENV_FILE not found"
    exit 1
fi

# Читаем файл, исключаем комментарии и пустые строки
# Преобразуем в формат key=value для yc используя paste
sed -n '/^[^#]/p' "$ENV_FILE" | grep -v '^$' | paste -sd, - 