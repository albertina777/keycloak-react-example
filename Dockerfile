FROM registry.access.redhat.com/ubi8/nodejs-18:1-122.1724231540 as builder

RUN mkdir -p /tmp/build && chmod -R 777 /tmp/build

WORKDIR /tmp/build

COPY  . .

RUN npm install --no-save

RUN npm run build

FROM nginx:alpine

RUN chmod -R 777 /var/log/nginx /var/cache/nginx /var/run \
     && chgrp -R 0 /etc/nginx \
     && chmod -R g+rwX /etc/nginx \
     && rm /etc/nginx/conf.d/default.conf

COPY --from=builder /tmp/build/build/. /usr/share/nginx/html/

WORKDIR /usr/share/nginx/html/

CMD ["npm", "start"]
