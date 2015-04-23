FROM ubuntu:12.04

RUN DEBIAN_FRONTEND=noninteractive apt-get update -qq \
    && apt-get install -y --no-install-recommends python python-dev python-pip supervisor nginx \
    && pip install -U pip virtualenv \
    && virtualenv -q /opt/devpi \
    && . /opt/devpi/bin/activate \
    && pip install devpi-server \
    && rm -rf /var/lib/apt/lists/*

ADD nginx.conf /etc/nginx/sites-enabled/default
ADD supervisor.conf /etc/supervisor/conf.d/devpi.conf

RUN echo "daemon off;" >> /etc/nginx/nginx.conf

EXPOSE 80
CMD /usr/bin/supervisord -n
