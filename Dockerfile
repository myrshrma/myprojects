FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive

# Update package lists and install necessary packages
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        cowsay \
        fortune \
        netcat \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Copy application files to /app directory
COPY . /app

# Set working directory to /app
WORKDIR /app

# Expose port 4499
EXPOSE 4499

# Command to run the application
CMD ["./wisecow.sh"]

