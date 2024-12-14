FROM nginx@sha256:c13d84b525bee78b8761523bf5ab1985b86a4aa6682a226c09c55eb875373cb0

COPY nginx-conf/nginx.conf /etc/nginx/

COPY nginx-conf/default.conf /etc/nginx/conf.d/

COPY index.html /usr/share/nginx/html/

RUN mkdir /var/cache/nginx/client_temp && \
  mkdir /var/cache/nginx/proxy_temp && \
  mkdir /var/cache/nginx/fastcgi_temp && \
  mkdir /var/cache/nginx/uwsgi_temp && \
  mkdir /var/cache/nginx/scgi_temp && \
  chown -R nginx /var/cache/nginx && \
  chown -R nginx /etc/nginx/ && \
  chmod -R 755 /etc/nginx/ && \
  chown -R nginx /var/log/nginx

RUN touch /var/run/nginx.pid && \
  chown -R nginx /var/run/nginx.pid /run/nginx.pid

EXPOSE 8080

USER nginx

ENTRYPOINT ["nginx", "-g", "daemon off;"]
