# GenieACS v1.2 Dockerfile #
############################

FROM node:16-buster

RUN apt-get update && apt-get install -y sudo supervisor git
RUN mkdir -p /var/log/supervisor

WORKDIR /opt

# RUN git clone https://github.com/genieacs/genieacs.git -b master
RUN mkdir genieacs
WORKDIR /opt/genieacs
COPY . ./
RUN npm install
RUN npm run build

RUN useradd --system --no-create-home --user-group genieacs

RUN mkdir /opt/genieacs/ext
RUN chown genieacs:genieacs /opt/genieacs/ext

RUN mkdir /var/log/genieacs
RUN chown genieacs:genieacs /var/log/genieacs

ADD genieacs.logrotate /etc/logrotate.d/genieacs

WORKDIR /opt
RUN git clone https://github.com/DrumSergio/genieacs-services -b 1.2
RUN cp genieacs-services/supervisord.conf /etc/supervisor/conf.d/supervisord.conf
RUN cp genieacs-services/run_with_env.sh /usr/bin/run_with_env.sh
RUN chmod +x /usr/bin/run_with_env.sh

WORKDIR /var/log/genieacs

CMD ["/usr/bin/supervisord","-c","/etc/supervisor/conf.d/supervisord.conf"]