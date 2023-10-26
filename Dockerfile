
FROM ubuntu:latest

RUN apt-get update && apt-get install -y \
    git \
    build-essential \
    jq \
    tree \
    vim

# You can specify your timezone change here 
ENV TZ=Asia/Kuala_Lumpur 
# Install TZ data seperately in non interactive mode
RUN DEBIAN_FRONTEND=noninteractive TZ=$TZ apt-get -y install tzdata

WORKDIR /app

COPY . /app

CMD ["/bin/bash"]
