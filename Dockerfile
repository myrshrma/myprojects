FROM ubuntu:latest
RUN apt-get update && apt-get install -y \
    cowsay \
    fortune \
    netcat
COPY . /app
WORKDIR /app
EXPOSE 4499
CMD ["./wisecow.sh"]
