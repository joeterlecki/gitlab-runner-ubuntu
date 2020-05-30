FROM ubuntu:18.04

LABEL maintainer="joe.terlecki@devinitly.com"
LABEL version="1.0"
LABEL description="This docker image is containerizes a gitlab runner on ubuntu for ecs"

RUN apt update && apt upgrade -y && apt install wget -y \
    && apt-get clean && rm -rf /var/lib/apt/lists/

RUN wget -O /usr/local/bin/gitlab-runner https://gitlab-runner-downloads.s3.amazonaws.com/latest/binaries/gitlab-runner-linux-amd64 \ 
    && chmod +x /usr/local/bin/gitlab-runner \ 
    && useradd --comment 'GitLab Runner' --create-home gitlab-runner --shell /bin/bash \ 
    && gitlab-runner install --user=gitlab-runner --working-directory=/home/gitlab-runner

ADD start.sh /start.sh
WORKDIR /home/gitlab-runner

CMD ["/start.sh"]