# MariaDB Alpine Linux docker container

MariaDB docker container based on Alpine Linux

| Software | Version |
|-----|-----|
| MariaDB | [latest]((https://pkgs.alpinelinux.org/packages)) |
| Alpine Linux | [alpine:latest](https://hub.docker.com/_/alpine/) |

## Standalone usage
```
docker run -d --name mariadb -p 3306:3306 -e MYSQL_ROOT_PASSWORD=root -v mariadb-data:/var/lib/mysql frengky/mariadb
```

## Compose usage
```
mariadb:
    image: frengky/mariadb
    environment:
        TZ: Asia/Jakarta
        MYSQL_ROOT_PASSWORD: ${MYSQL_ROOT_PASSWORD:-root}
    ports:
        - 3306:3306
    volumes:
        - mariadb-data:/var/lib/mysql
    restart: always
```

## Reference
* [Official MariaDB container image](https://hub.docker.com/_/mariadb/)