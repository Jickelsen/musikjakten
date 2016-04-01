FROM eboraas/apache-php
MAINTAINER Jacob Michelsen <jacob.michelsen@tii.se>

RUN apt-get update && apt-get -y install git curl nodejs npm php5-mcrypt php5-json php5-mysql && apt-get -y autoremove && apt-get clean

RUN echo 'extension=pdo_mysql.so' >> /etc/php5/apache2/php.ini

RUN /usr/sbin/a2enmod rewrite

ADD dockerdeployment/000-laravel.conf /etc/apache2/sites-available/
ADD dockerdeployment/001-laravel-ssl.conf /etc/apache2/sites-available/
RUN /usr/sbin/a2dissite '*' && /usr/sbin/a2ensite 000-laravel 001-laravel-ssl

RUN /usr/bin/curl -sS https://getcomposer.org/installer |/usr/bin/php
RUN /bin/mv composer.phar /usr/local/bin/composer

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