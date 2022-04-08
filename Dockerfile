FROM golang

WORKDIR /app

COPY . .

RUN apt update && apt install  openssh-server -y
RUN ssh-keygen -q -t rsa -N '' -f ~/.ssh/id_rsa && cp ~/.ssh/id_rsa /app/devzat-sshkey
RUN set -x \
&& { \
echo 'port: 22'; \
echo 'alt_port: 443'; \
echo 'profile_port: 5555'; \
echo 'key_file: devzat-sshkey'; \
echo 'data_dir: devzat-data'; \
echo 'admins:'; \
echo ''; \
} > devzat-config.yml \
&& cat devzat-config.yml

RUN go build

ENTRYPOINT ["/bin/bash", "-c", "./devchat"]