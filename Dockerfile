FROM registry.access.redhat.com/ubi8/nodejs-18:1-122.1724231540 as builder

RUN mkdir /build

WORKDIR /build


COPY  . .

RUN npm run build

FROM nginx:latest

COPY --from=builder /build/build/. /usr/share/nginx/html/
