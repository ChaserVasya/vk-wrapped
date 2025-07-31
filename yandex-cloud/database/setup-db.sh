#!/bin/bash

echo "🗄️ Setting up Yandex Database for VK Wrapped..."

# Переменные
DATABASE_NAME="vk-wrapped-db"
ENDPOINT="your-ydb-endpoint"
DATABASE_PATH="your-database-path"

echo "📋 Database configuration:"
echo "   Database: $DATABASE_NAME"
echo "   Endpoint: $ENDPOINT"
echo "   Path: $DATABASE_PATH"
echo ""

# Создание базы данных (если не существует)
echo "🔧 Creating database..."
yc ydb database create --name=$DATABASE_NAME --description="VK Wrapped Database" || echo "Database already exists"

# Получение endpoint и path
echo "🔗 Getting database connection info..."
DB_INFO=$(yc ydb database get --name=$DATABASE_NAME --format=json)
ENDPOINT=$(echo $DB_INFO | jq -r '.endpoint')
DATABASE_PATH=$(echo $DB_INFO | jq -r '.database_path')

echo "✅ Database created successfully!"
echo "🌐 Endpoint: $ENDPOINT"
echo "📁 Path: $DATABASE_PATH"
echo ""

# Создание таблиц
echo "📊 Creating tables..."
yc ydb table execute --endpoint=$ENDPOINT --database=$DATABASE_PATH --query="$(cat schema.sql)"

echo "✅ Tables created successfully!"
echo ""
echo "📋 Available tables:"
echo "   - listening_sessions"
echo "   - track_metadata"
echo "   - daily_stats"
echo "   - user_settings"
echo ""
echo "🔧 Next steps:"
echo "1. Update function environment with database connection"
echo "2. Test database connection"
echo "3. Deploy functions" 