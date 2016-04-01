FROM eboraas/apache-php
MAINTAINER Jacob Michelsen <jacob.michelsen@tii.se>

RUN apt-get update && apt-get -y install git curl npm php5-mcrypt php5-json && apt-get -y autoremove && apt-get clean

RUN /usr/sbin/a2enmod rewrite

ADD 000-laravel.conf /etc/apache2/sites-available/
ADD 001-laravel-ssl.conf /etc/apache2/sites-available/
RUN /usr/sbin/a2dissite '*' && /usr/sbin/a2ensite 000-laravel 001-laravel-ssl

RUN /usr/bin/curl -sS https://getcomposer.org/installer |/usr/bin/php
RUN /bin/mv composer.phar /usr/local/bin/composer

# Copy the local repo files to the served laravel dir
ADD . /var/www/laravel

WORKDIR /var/www/laravel

RUN /usr/local/bin/composer install

RUN npm install

RUN /bin/chown www-data:www-data -R /var/www/laravel/storage /var/www/laravel/bootstrap/cache

RUN gulp

EXPOSE 80
EXPOSE 443

CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]
