FROM node:18-bullseye

# Install Java and Ant
RUN apt-get update && apt-get install -y openjdk-11-jdk ant

# Set Java environment
ENV JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64
ENV PATH=$PATH:$JAVA_HOME/bin

# Set working directory
WORKDIR /app

# Copy everything
COPY . .

# Install CoffeeScript inside weinre.server
WORKDIR /app/weinre.server
RUN npm install coffee-script

# Return to root
WORKDIR /app

# Run Ant build
RUN ant

# Expose port
EXPOSE 8080

# Run Weinre
CMD ["node", "weinre", "--httpPort", "8080", "--boundHost", "0.0.0.0"]
