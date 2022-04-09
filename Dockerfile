FROM golang

WORKDIR /app

COPY . .

RUN apt update && apt install  openssh-server -y
RUN ssh-keygen -q -t rsa -N '' -f ~/.ssh/id_rsa && cp ~/.ssh/id_rsa /app/devzat-sshkey

RUN go build

ENTRYPOINT ["/bin/bash", "-c", "./devchat"]
