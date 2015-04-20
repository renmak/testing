FROM phusion/passenger-ruby21

ENV HOME /root

ENV RAILS_ENV production

CMD ["/sbin/my_init"]

RUN rm -f /etc/service/nginx/down
RUN rm /etc/nginx/sites-enabled/default
ADD nginx.conf /etc/nginx/sites-enabled/testing_website.conf

#Add rails-env.conf
#ADD rails-env.conf /etc/nginx/main.d/rails-env.conf

# Install bundle of gems
WORKDIR /tmp
ADD Gemfile /tmp/
ADD Gemfile.lock /tmp/
RUN bundle install

ADD . /home/app/testing
WORKDIR /home/app/testing
RUN chown -R app:app /home/app/testing

#RUN sudo -u app bundle install --deployment
RUN sudo -u app RAILS_ENV=production bundle exec rake assets:precompile

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

EXPOSE 80
