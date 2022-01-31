FROM ubuntu
MAINTAINER Alberto Moreira Soares
RUN apt-get update
RUN apt-get install -y nginx && apt-get clean
RUN rm -v /etc/nginx/nginx.conf
ADD ./configs/nginx.conf /etc/nginx/
RUN ln -sf /dev/stdout /var/log/nginx/access.log
RUN ln -sf /dev/stderr /var/log/nginx/error.log
RUN echo "daemon off;" >> /etc/nginx/nginx.conf

EXPOSE 8000

COPY ./index.html /var/www/html/

CMD ["/usr/sbin/nginx"]
