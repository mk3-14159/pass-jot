
FROM ubuntu:latest

RUN apt-get update && apt-get install -y \
    git \
    build-essential \
    jq \
    tree \
    vim

WORKDIR /app

COPY . /app

CMD ["/bin/bash"]
