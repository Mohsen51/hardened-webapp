FROM nginx@sha256:c13d84b525bee78b8761523bf5ab1985b86a4aa6682a226c09c55eb875373cb0

COPY nginx-conf/nginx.conf /etc/nginx/

COPY nginx-conf/default.conf /etc/nginx/conf.d/

COPY index.html /usr/share/nginx/html/

COPY certs/server.crt /etc/nginx/certs/server.crt

COPY certs/server.key /etc/nginx/certs/server.key

# Create the directories that 
RUN mkdir /var/cache/nginx/client_temp && \
  mkdir /var/cache/nginx/proxy_temp && \
  mkdir /var/cache/nginx/fastcgi_temp && \
  mkdir /var/cache/nginx/uwsgi_temp && \
  mkdir /var/cache/nginx/scgi_temp && \
  chown -R nginx /var/cache/nginx && \
  chown -R nginx /etc/nginx/ && \
  chown -R nginx /var/log/nginx

RUN touch /var/run/nginx.pid && \
  chown -R nginx /var/run/nginx.pid /run/nginx.pid

# Further alpine linux hardening
RUN rm -rf /sbin/apk && \
  rm -rf /usr/bin/wget && \
  rm -rf /bin/su && \
  rm -rf /bin/ln && \
  rm -rf /bin/chmod && \
  rm -rf /bin/chgrp && \
  rm -rf /bin/chown && \
  rm -rf /etc/crontabs && \
  rm -rf /etc/periodic && \
  rm -rf /var/spool/cron

EXPOSE 8443

USER nginx

ENTRYPOINT ["nginx", "-g", "daemon off;"]
