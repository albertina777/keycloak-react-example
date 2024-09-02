FROM registry.access.redhat.com/ubi8/nodejs-18:1-122.1724231540 as builder

RUN mkdir -p /tmp/build && chmod -R 777 /tmp/build

WORKDIR /tmp/build

COPY  . .

RUN npm install

RUN npm run build

FROM nginx:latest

COPY --from=builder /tmp/build/build/. /usr/share/nginx/html/
