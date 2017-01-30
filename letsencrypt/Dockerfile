FROM alpine

MAINTAINER Carolyn Van Slyck <me@carolynvanslyck.com>

CMD ["/run.sh"]

# Install curl
RUN apk add --update curl && \
    rm -rf /var/cache/apk/*

# Configure cron
COPY generate-certificate.sh /generate-certificate.sh
RUN ln -s /generate-certificate.sh /etc/periodic/monthly/reissue && \
    chmod a+x /etc/periodic/monthly/reissue

COPY run.sh /run.sh
RUN chmod u+x /run.sh
