FROM node:18-bookworm

RUN apt-get update && apt-get install -y \
    default-jdk \
    wget \
    unzip \
    android-sdk-build-tools \
    && rm -rf /var/lib/apt/lists/*

RUN wget https://raw.githubusercontent.com/iBotPeaches/Apktool/master/scripts/linux/apktool -O /usr/local/bin/apktool \
    && wget https://bitbucket.org/iBotPeaches/apktool/downloads/apktool_2.9.3.jar -O /usr/local/bin/apktool.jar \
    && chmod +x /usr/local/bin/apktool

# Добавляем каталог с zipalign в PATH
ENV PATH="/usr/lib/android-sdk/build-tools/debian:${PATH}"

WORKDIR /app

COPY server/package.json ./server/
RUN cd server && npm install

COPY . .

EXPOSE 10000

CMD ["node", "server/server.js"]
