FROM node:18-bullseye

RUN apt-get update && apt-get install -y openjdk-11-jdk ant
ENV JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64
ENV PATH=$PATH:$JAVA_HOME/bin

WORKDIR /app
COPY . .

WORKDIR /app/weinre.server
RUN npm install coffee-script

WORKDIR /app
RUN test -f weinre.server/node_modules/coffee-script/bin/coffee

RUN ant

EXPOSE 8080
CMD ["node", "weinre", "--httpPort", "8080", "--boundHost", "0.0.0.0"]
