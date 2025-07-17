FROM nginx:latest
ARG USERNAME=user_1

COPY ./nginx/nginx.conf /etc/nginx/nginx.conf
COPY ./server/server.c /home/$USERNAME/app/server.c
COPY ./05/start.sh /home/$USERNAME/app/start.sh

WORKDIR /home/$USERNAME/app

RUN apt-get update \
    && apt-get install -y gcc spawn-fcgi libfcgi-dev \
    && gcc -o server server.c -lfcgi \
    && useradd -r -U -u 999 -s /bin/bash $USERNAME \
    && usermod -a -G $USERNAME nginx \
    && touch /var/run/nginx.pid /var/cache/nginx/client_temp \
    && chown -R $USERNAME:$USERNAME /var/run/nginx.pid /var/cache/nginx/ \
    && chmod +x ./start.sh \
    && chmod u-s /usr/bin/umount \
    && chmod u-s /usr/bin/chfn \
    && chmod g-s /usr/bin/chage \
    && chmod u-s /usr/bin/gpasswd \
    && chmod u-s /usr/bin/su \
    && chmod g-s /usr/bin/expiry \
    && chmod u-s /usr/bin/chsh \
    && chmod u-s /usr/bin/passwd \
    && chmod g-s /usr/sbin/unix_chkpwd \
    && chmod u-s /usr/bin/passwd \
    && chmod u-s /usr/bin/newgrp \
    && chmod u-s /usr/bin/mount \
    && chmod g-s /usr/bin/wall \
    && rm -rf /var/lib/apt/lists

HEALTHCHECK --interval=5m --timeout=3s \
  CMD curl -f http://localhost/ || exit 1

USER $USERNAME

ENTRYPOINT ["sh", "./start.sh"]
