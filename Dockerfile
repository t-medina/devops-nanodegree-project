FROM nginx:1.17.10

COPY app/* /usr/share/nginx/html/

EXPOSE 80 443