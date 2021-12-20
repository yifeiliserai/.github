FROM nginx:1.19.9
COPY ./default.conf /etc/nginx/conf.d/
COPY ./build/ /usr/share/nginx/html/
