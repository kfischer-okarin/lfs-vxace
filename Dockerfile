FROM allenwei/ruby-1.9.2

WORKDIR /usr/src/app

COPY Gemfile .

RUN bundle install
