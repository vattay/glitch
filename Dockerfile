FROM debian:stretch

RUN apt-get update && apt-get install -y \
  curl \
  git \
  psmisc \
  sudo \
  vim \
  zsh 
#  docker.io
# Consider using docker.io if docker client fails due to compatibility

# Get the docker client only. This could break as it is the master branch build of the client. Use the docker.io package in that case.
WORKDIR /tmp
RUN curl -s https://master.dockerproject.org/linux/x86_64/docker.sha256 \ 
  | sed "s/build\\/linux\\/docker\\/docker/-/g" > docker.sha256 \
  && curl -s https://master.dockerproject.org/linux/x86_64/docker \ 
  | tee docker \ 
  | sha256sum -c docker.sha256 \ 
  && mv docker /usr/bin/docker \
  && chmod ugo+x /usr/bin/docker

WORKDIR /root
RUN mkdir workspace \
  && mkdir workspace/bound 

RUN mkdir /var/shared 
VOLUME /var/shared

RUN git clone git://github.com/robbyrussell/oh-my-zsh.git .oh-my-zsh 

COPY zshrc.template .zshrc
COPY .glitch_aliases .

WORKDIR /root/workspace/bound

CMD ["/bin/zsh"]
