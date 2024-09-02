FROM registry.access.redhat.com/ubi8/nodejs-18:1-122.1724231540 as builder

RUN mkdir -p /tmp/build && chmod -R 777 /tmp/build

WORKDIR /tmp/build

COPY  . .

RUN npm install --no-save

RUN npm run build

FROM nginx:latest

RUN mkdir -p /etc/nginx/ssl/ && \
    chown -R nginx:nginx /etc/nginx/ssl/ && \
    chmod -R 755 /etc/nginx/ssl/

USER nginx

COPY --from=builder /tmp/build/build/. /usr/share/nginx/html/
