FROM ubuntu:latest
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y --no-install-recommends \
    cowsay \
    fortune \
    netcat \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*
COPY . /app
WORKDIR /app
EXPOSE 4499
CMD ["./wisecow.sh"]
