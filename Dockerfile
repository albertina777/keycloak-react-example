FROM registry.access.redhat.com/ubi8/nodejs-18:1-122.1724231540 as builder

WORKDIR /tmp

COPY  . .

RUN npm install --no-save

RUN npm run build

FROM nginx:alpine

RUN chmod -R 777 /var/log/nginx /var/cache/nginx /var/run \
     && chgrp -R 0 /etc/nginx \
     && chmod -R g+rwX /etc/nginx \
     && rm /etc/nginx/conf.d/default.conf

COPY --from=builder /tmp/build /usr/share/nginx/html/

COPY nginx.conf /etc/nginx/nginx.conf

# Expose port 80
EXPOSE 8080

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]
