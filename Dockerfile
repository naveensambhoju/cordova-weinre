FROM node:18-bullseye

# Install Java and Ant
RUN apt-get update && apt-get install -y openjdk-11-jdk ant

# Set environment variables
ENV JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64
ENV PATH=$PATH:$JAVA_HOME/bin

# Set working directory
WORKDIR /app

# Copy all project files to the container
COPY . .

# Install CoffeeScript globally and locally
RUN npm install coffee-script && npm install -g coffee-script

# Make sure build.xml exists
RUN test -f build.xml

# Build Weinre
RUN ant

# Expose Weinre port
EXPOSE 8080

# Run Weinre
CMD ["node", "weinre", "--httpPort", "8080", "--boundHost", "0.0.0.0"]
