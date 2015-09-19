FROM debian:stable
MAINTAINER Andreas Krüger
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update -qq && apt-get install --no-install-recommends --no-install-suggests -y php5-cli php5-mysql gcc xinetd rsyslog

RUN echo "agi             4573/tcp                        # FAST AGI entry" >> /etc/services

RUN mkdir /agi
ADD agiLaunch.sh /
ADD agi.php /agi/
ADD xinetd_agi /etc/xinetd.d/agi

EXPOSE 4573

CMD service rsyslog start && xinetd -stayalive -dontfork -pidfile /var/run/xinetd.pid
