# Используйте образ Node.js (на основе Debian)
FROM node:18-bullseye

# Установите Java (для jarsigner), wget и unzip
RUN apt-get update && apt-get install -y \
    default-jdk \
    wget \
    unzip \
    && rm -rf /var/lib/apt/lists/*

# Скачайте и настройте apktool (скрипт-обертка + jar)
RUN wget https://raw.githubusercontent.com/iBotPeaches/Apktool/master/scripts/linux/apktool -O /usr/local/bin/apktool \
    && wget https://bitbucket.org/iBotPeaches/apktool/downloads/apktool_2.9.3.jar -O /usr/local/bin/apktool.jar \
    && chmod +x /usr/local/bin/apktool

# Примечание: jarsigner входит в состав JDK и уже доступен
# Примечание: zipalign необходимо получить из Android SDK build-tools
# Если в проекте есть готовый бинарный файл zipalign для Linux, можно использовать COPY:
# COPY ./bin/zipalign /usr/local/bin/zipalign
# RUN chmod +x /usr/local/bin/zipalign
# Если его нет, потребуется дополнительная настройка Android SDK для установки, что увеличит размер образа

# Установите рабочую директорию
WORKDIR /app

# Скопируйте package.json и установите зависимости
COPY server/package.json ./server/
RUN cd server && npm install

# Скопируйте остальные файлы проекта
COPY . .

# Откройте порт (Render по умолчанию использует 10000)
EXPOSE 10000

# Команда запуска
CMD ["node", "server/server.js"]
