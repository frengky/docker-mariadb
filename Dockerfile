FROM alpine:latest

RUN mkdir /docker-entrypoint-initdb.d && \
    apk -U upgrade && \
    # setup tzdata
    apk add --update --no-cache tzdata && \
    cp /usr/share/zoneinfo/Asia/Jakarta /etc/localtime && \
    echo "Asia/Jakarta" > /etc/timezone && \
    # setup mariadb
    apk add --update --no-cache mariadb mariadb-client && \
    sed -Ei 's/^(bind-address|log)/#&/' /etc/my.cnf && \
    sed -i  's/^skip-networking/#&/' /etc/my.cnf.d/mariadb-server.cnf && \
    sed -i '/^\[mysqld]$/a skip-host-cache\nskip-name-resolve' /etc/my.cnf && \
    sed -i '/^\[mysqld]$/a user=mysql' /etc/my.cnf && \
    echo -e '\n!includedir /etc/mysql/conf.d/' >> /etc/my.cnf && \
    mkdir -p /etc/mysql/conf.d/ && \
    # clean up
    rm -rf /var/cache/apk/*

ENV TZ Asia/Jakarta
ENV LC_ALL en_US.UTF-8
ENV LANG en_US.UTF-8

VOLUME ["/var/lib/mysql"]

COPY docker-entrypoint.sh /usr/local/bin/
ENTRYPOINT ["docker-entrypoint.sh"]

EXPOSE 3306
# Default arguments passed to ENTRYPOINT if no arguments are passed when starting container
CMD ["mysqld_safe"]