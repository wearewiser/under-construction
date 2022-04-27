FROM httpd:2.4

# BEGIN SETUP ENV
RUN mkdir /var/log/apache/
RUN mkdir /usr/local/apache2/sites-available/
RUN mkdir /usr/local/apache2/sites-enabled/
# END SETUP ENV

# BEGIN FILE LOAD
COPY ./src/ /usr/local/apache2/htdocs/
# END FILE LOAD

# BEGIN VHOST CONFIG
COPY ./vhosts /usr/local/apache2/sites-available/
RUN ln -s /usr/local/apache2/sites-available/* /usr/local/apache2/sites-enabled/
# END VHOST CONFIG

# BEGIN SERVER CONFIG
RUN echo "LoadModule rewrite_module modules/mod_rewrite.so" >> /usr/local/apache2/conf/httpd.conf
RUN echo "ServerName localhost" >> /usr/local/apache2/conf/httpd.conf
RUN echo "IncludeOptional sites-enabled/*.conf" >> /usr/local/apache2/conf/httpd.conf
RUN sed -i "s/AllowOverride None/AllowOverride All/g" /usr/local/apache2/conf/httpd.conf
# END SERVER CONFIG

# BEGIN REVERSE PROXY SERVER
RUN echo "LoadModule proxy_module modules/mod_proxy.so" >> conf/httpd.conf
RUN echo "LoadModule proxy_http_module modules/mod_proxy_http.so" >> conf/httpd.conf
RUN echo "LoadModule ssl_module modules/mod_ssl.so" >> conf/httpd.conf
# BEGIN REVERSE PROXY SERVER

# BEGIN GZIP SERVER
RUN echo "LoadModule deflate_module modules/mod_deflate.so" >> conf/httpd.conf
RUN echo "<IfModule mod_deflate.c>" >> conf/httpd.conf
RUN echo "SetOutputFilter DEFLATE" >> conf/httpd.conf
RUN echo "SetEnvIfNoCase Request_URI \.(?:gif|jpe?g|png)$ no-gzip dont-vary" >> conf/httpd.conf
RUN echo "SetEnvIfNoCase Request_URI \.(?:exe|t?gz|zip|bz2|sit|rar)$ no-gzip dont-vary" >> conf/httpd.conf
RUN echo "SetEnvIfNoCase Request_URI \.(?:mp4|ogv|webm|mp3)$ no-gzip dont-vary" >> conf/httpd.conf
RUN echo "<IfModule mod_headers.c>" >> conf/httpd.conf
RUN echo "Header append Vary User-Agent" >> conf/httpd.conf
RUN echo "</IfModule>" >> conf/httpd.conf
RUN echo "</IfModule> " >> conf/httpd.conf
# END GZIP SERVER

RUN apachectl restart
EXPOSE 80
