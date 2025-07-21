FROM node:12-bullseye

# Install dependencies
RUN apt-get update && \
    apt-get install -y openjdk-11-jdk ant python3 && \
    ln -s /usr/bin/python3 /usr/bin/python

# Set environment variables
ENV JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64
ENV PATH=$PATH:$JAVA_HOME/bin

RUN mkdir -p /app/scripts

WORKDIR /app
COPY . .

# Install CoffeeScript
WORKDIR /app/weinre.server
RUN npm install coffee-script

# Back to build root
WORKDIR /app
RUN ant

RUN ls -la /app/scripts

# Run the server
EXPOSE 8080
CMD ["node", "weinre.server/lib/weinre.js", "--httpPort", "8080", "--boundHost", "0.0.0.0"]
