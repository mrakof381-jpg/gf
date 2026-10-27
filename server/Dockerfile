# Используем актуальную стабильную версию Debian (bookworm), чтобы избежать ошибок 404 с репозиториями
FROM node:18-bookworm

# Устанавливаем Java (для jarsigner и apktool), wget, unzip и Android SDK (для zipalign)
RUN apt-get update && apt-get install -y \
    default-jdk \
    wget \
    unzip \
    android-sdk-build-tools \
    && rm -rf /var/lib/apt/lists/*

# Настраиваем apktool (скачиваем скрипт-обертку и jar-файл)
RUN wget https://raw.githubusercontent.com/iBotPeaches/Apktool/master/scripts/linux/apktool -O /usr/local/bin/apktool \
    && wget https://bitbucket.org/iBotPeaches/apktool/downloads/apktool_2.9.3.jar -O /usr/local/bin/apktool.jar \
    && chmod +x /usr/local/bin/apktool

# Добавляем zipalign в PATH (он устанавливается вместе с android-sdk-build-tools)
RUN ln -s /usr/lib/android-sdk/build-tools/*/zipalign /usr/local/bin/zipalign

# Устанавливаем рабочую директорию
WORKDIR /app

# Копируем package.json и устанавливаем зависимости
COPY server/package.json ./server/
RUN cd server && npm install

# Копируем остальные файлы проекта
COPY . .

# Открываем порт (Render по умолчанию использует 10000)
EXPOSE 10000

# Команда запуска
CMD ["node", "server/server.js"]
