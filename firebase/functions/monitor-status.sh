#!/bin/bash

# Скрипт для мониторинга статуса пользователя
# Поллинг каждые 10 секунд для определения времени жизни статуса

# Конфигурация
USER_ID="206942551"
SERVICE_TOKEN="e505d8ece505d8ece505d8ec7fe6321bbbee505e505d8ec8d8e9859a4d66773c2f64955"
POLL_INTERVAL=10

echo "🎵 Мониторинг статуса пользователя $USER_ID"
echo "🔑 Используем service token: ${SERVICE_TOKEN:0:20}..."
echo "⏱️  Интервал поллинга: $POLL_INTERVAL секунд"
echo ""
echo "📋 Инструкция:"
echo "1. Включите музыку в ВК"
echo "2. Выключите музыку и выйдите со страницы"
echo "3. Скрипт покажет, сколько времени ВК держит статус"
echo ""
echo "🚀 Начинаем мониторинг..."
echo ""

# Переменные для отслеживания
start_time=$(date +%s)
last_status_audio=""
status_changed=false
status_cleared_time=""

# Функция для получения текущего времени в секундах
get_current_time() {
    date +%s
}

# Функция для форматирования времени
format_duration() {
    local seconds=$1
    local minutes=$((seconds / 60))
    local remaining_seconds=$((seconds % 60))
    printf "%02d:%02d" $minutes $remaining_seconds
}

# Основной цикл мониторинга
while true; do
    current_time=$(get_current_time)
    elapsed_time=$((current_time - start_time))
    
    # Получаем статус
    response=$(curl -s \
        -H "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36" \
        -H "Accept: application/json" \
        -H "Content-Type: application/json" \
        -G \
        -d "method=users.get" \
        -d "user_ids=$USER_ID" \
        -d "fields=status_audio,status,last_seen" \
        -d "access_token=$SERVICE_TOKEN" \
        -d "v=5.131" \
        "https://api.vk.com/method/users.get")
    
    # Извлекаем status_audio
    current_status_audio=$(echo "$response" | jq -r '.response[0].status_audio // "null"')
    
    # Форматируем время
    time_str=$(format_duration $elapsed_time)
    
    # Проверяем изменения
    if [ "$current_status_audio" != "$last_status_audio" ]; then
        if [ "$current_status_audio" = "null" ] && [ "$last_status_audio" != "" ] && [ "$last_status_audio" != "null" ]; then
            # Статус очистился
            status_cleared_time=$elapsed_time
            echo "🔄 [$time_str] ❌ Статус очищен! Время жизни: $(format_duration $elapsed_time)"
            echo "📊 Статус был активен: $(format_duration $elapsed_time)"
            echo ""
            echo "✅ Мониторинг завершен. ВК держал статус активным $(format_duration $elapsed_time)"
            break
        elif [ "$current_status_audio" != "null" ]; then
            status_changed=true
        fi
        last_status_audio="$current_status_audio"
    fi
    
    # Выводим текущий статус
    if [ "$current_status_audio" = "null" ]; then
        echo "[$time_str] ⏳ Ожидание статуса..."
    else
        echo "[$time_str] 🎵 Активный статус: $current_status_audio"
    fi
    
    # Ждем перед следующим запросом
    sleep $POLL_INTERVAL
done

echo ""
echo "📈 Результаты мониторинга:"
echo "   - Время начала: $(date -d @$start_time '+%H:%M:%S')"
echo "   - Время жизни статуса: $(format_duration $elapsed_time)"
echo "   - Последний статус: $last_status_audio" 