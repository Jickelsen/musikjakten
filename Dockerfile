FROM ubuntu:14.04
MAINTAINER Jacob Michelsen <jacob.michelsen@tii.se>

RUN apt-get update && \
    apt-get -y install apache2 php5 libapache2-mod-php5 php5-mcrypt php5-json curl git nodejs npm php5-mysql && \
    apt-get clean && \
    update-rc.d apache2 defaults && \
    php5enmod mcrypt && \
    rm -rf /var/www/html && \
    curl -sS https://getcomposer.org/installer | php && \
    mv composer.phar /usr/local/bin/composer

RUN /usr/sbin/a2enmod rewrite

ADD dockerdeployment/000-default.conf /etc/apache2/sites-available/

# Copy the local repo files to the served laravel dir
ADD . /var/www/laravel

WORKDIR /var/www/laravel

RUN /usr/local/bin/composer install

RUN ln -s /usr/bin/nodejs /usr/bin/node

RUN npm install

RUN npm install gulp -g

RUN cp dockerdeployment/env-docker ./.env

RUN /bin/chown www-data:www-data -R /var/www/laravel/storage /var/www/laravel/bootstrap/cache

RUN gulp

EXPOSE 80
EXPOSE 443

CMD php artisan migrate && /usr/sbin/apache2ctl -D FOREGROUND