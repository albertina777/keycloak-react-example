FROM registry.access.redhat.com/ubi8/nodejs-18:1-122.1724231540 as builder

RUN mkdir /build

WORKDIR /build

COPY  . .

RUN npm install

RUN npm run build

FROM nginx:latest

COPY --from=builder /tmp/build/build/. /usr/share/nginx/html/
