FROM node:18-bullseye

# Install Java and Ant
RUN apt-get update && apt-get install -y openjdk-11-jdk ant

# Set environment variables
ENV JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64
ENV PATH=$PATH:$JAVA_HOME/bin
ENV PROJECT_SERVER=/app

# Set working directory
WORKDIR /app

# Copy all project files
COPY . .

# Install CoffeeScript locally and globally
RUN npm install coffee-script && npm install -g coffee-script

# Build Weinre (Ant uses PROJECT_SERVER here)
RUN ant

# Expose port
EXPOSE 8080

# Start Weinre
CMD ["node", "weinre", "--httpPort", "8080", "--boundHost", "0.0.0.0"]
