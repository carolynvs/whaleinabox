FROM nginx

MAINTAINER Carolyn Van Slyck <me@carolynvanslyck.com>

CMD ["/run.sh"]

RUN rm /etc/nginx/conf.d/default.conf
COPY default.conf /etc/nginx/conf.d/template.conf
COPY run.sh /run.sh
