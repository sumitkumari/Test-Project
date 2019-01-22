FROM ubuntu:14.04
EXPOSE 80
# Upgrade system
RUN apt-get update && apt-get -y upgrade
RUN apt-get install curl nginx supervisor -y
# Install NodeJS
RUN curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -
RUN apt-get install nodejs -y
RUN mkdir /usr/local/nodejs
COPY main.js /usr/local/nodejs/main.js
COPY default /etc/nginx/sites-available/default
COPY nodejs.conf /etc/supervisor/conf.d/nodejs.conf
COPY nginx.conf /etc/supervisor/conf.d/nginx.conf
# Start Supervisor daemon
CMD ["/usr/bin/supervisord", "-n", "-c", "/etc/supervisor/supervisord.conf"]
