FROM tommichiels/base
MAINTAINER tom.michiels@archimiddle.com

RUN apt-get update
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get install -q -y libkrb5-dev
RUN apt-get install -q -y libldap2-dev
RUN apt-get install -q -y libmysqlclient-dev
RUN apt-get install -q -y libsasl2-dev
RUN apt-get install -q -y libsasl2-modules-gssapi-mit
RUN apt-get install -q -y libsqlite3-dev
RUN apt-get install -q -y libssl-dev
RUN apt-get install -q -y libtidy-0.99-0
RUN apt-get install -q -y libxml2-dev
RUN apt-get install -q -y libxslt-dev
RUN apt-get install -q -y mysql-server
RUN apt-get install -q -y python-dev
RUN apt-get install -q -y python-setuptools
RUN apt-get install -q -y python-simplejson
RUN apt-get install -q -y libgmp3-dev
RUN ln -s /usr/lib/python2.7/plat-*/_sysconfigdata_nd.py /usr/lib/python2.7/
RUN git clone https://github.com/cloudera/hue.git
WORKDIR hue
RUN git checkout tags/cdh5.4.5-release
RUN make apps
RUN rm -rf .git
ADD ./config/pseudo-distributed.ini.template /root/hue/desktop/conf/
EXPOSE 8000
COPY config/bootstrap.sh /root/hue/bootstrap.sh
RUN chmod +x /root/hue/bootstrap.sh
CMD ["/root/hue/bootstrap.sh"]

