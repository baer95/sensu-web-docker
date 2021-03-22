FROM node:14-alpine as build

WORKDIR /home/node/sensu/web

ENV NODE_ENV="production"

ARG VERSION

RUN apk add git && \
    git clone --depth 1 --branch "${VERSION}" https://github.com/sensu/web.git . && \
    yarn install --network-timeout 100000 && \
    yarn build

FROM nginx:alpine

COPY --from=build /home/node/sensu/web/build/app/ /usr/share/nginx/html

COPY ./etc/nginx/ /etc/nginx/

# uncomment this if you are deploying to openshift
#RUN mkdir /var/cache/nginx/client_temp && \
#    mkdir /var/cache/nginx/proxy_temp && \
#    mkdir /var/cache/nginx/fastcgi_temp && \
#    mkdir /var/cache/nginx/uwsgi_temp && \
#    mkdir /var/cache/nginx/scgi_temp && \
#    chmod -R a+rwx /var/cache/nginx && \
#    chown -R 1001:0 /var/cache/nginx && \
#    chmod -R a+rwx /var/run/

EXPOSE 5000
