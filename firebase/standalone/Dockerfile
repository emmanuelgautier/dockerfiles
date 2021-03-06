FROM node

RUN \
  apt-get update && \
    apt-get -y install wget && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/ \
  && \
  wget -cO - https://github.com/firebase/firebase-tools/releases/download/v9.5.0/firebase-tools-linux > /usr/local/bin/firebase && \
  chmod +x /usr/local/bin/firebase

CMD [ "firebase" ]
