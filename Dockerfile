FROM johnfedoruk/under-construction:1.0.0

RUN echo conf/httpd.conf                  | xargs sed -i 's/Listen 80/Listen 3000/g'
RUN echo sites-available/000-default.conf | xargs sed -i 's/80/3000/g'

RUN apachectl restart
EXPOSE 3000
