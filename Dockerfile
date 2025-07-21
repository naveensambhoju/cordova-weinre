FROM node:18-bullseye

# Install Java and Ant
RUN apt-get update && apt-get install -y openjdk-11-jdk ant

# Set environment variables
ENV JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64
ENV PATH=$PATH:$JAVA_HOME/bin

# Set working directory
WORKDIR /app

# Copy source code
COPY . .

# Build weinre
RUN ant

# Expose weinre port
EXPOSE 8080

# Run weinre
CMD ["node", "weinre", "--httpPort", "8080", "--boundHost", "0.0.0.0"]
