FROM ubuntu:latest

RUN apt-get update && apt-get upgrade && apt-get install -y \
    wget \
    && apt-get clean && rm -rf /var/lib/apt/lists/

# Install GitLab-Runner 
RUN wget -O /usr/local/bin/gitlab-runner https://gitlab-runner-downloads.s3.amazonaws.com/latest/binaries/gitlab-runner-linux-amd64 \ 
    && chmod +x /usr/local/bin/gitlab-runner \ 
    && useradd --comment 'GitLab Runner' --create-home gitlab-runner --shell /bin/bash \ 
    && gitlab-runner install --user=gitlab-runner --working-directory=/home/gitlab-runner

ADD start.sh /start.sh
WORKDIR /home/gitlab-runner


CMD ["/start.sh"]
