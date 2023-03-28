FROM phusion/passenger-customizable:2.5.0-arm64
MAINTAINER guoxw <alphaguoxiongwei@gmail.com>

RUN export http_proxy=http://192.168.11.114:7890
RUN export https_proxy=http://192.168.11.114:7890

# RUN apt-get update
RUN /pd_build/utilities.sh
RUN apt install -y sudo

# Node 14 and yarn
RUN curl -sL https://deb.nodesource.com/setup_14.x | sudo -E bash - \
 && apt-get install -y nodejs \
 && npm install -g yarn

# Ruby 2.7
RUN rm -rf /var/lib/apt/lists/*
RUN /usr/local/rvm/bin/rvm list
RUN /usr/local/rvm/bin/rvm remove ruby
RUN /pd_build/ruby-2.7.*.sh
RUN gem update --system
RUN gem install bundler

# Imagemagick
RUN apt-get install -y imagemagick libmagickwand-dev

# Timezone
RUN echo Asia/Shanghai > /etc/timezone \
 && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
RUN apt-get install -y tzdata

# Logrotate
RUN sed -i 's/root syslog/root adm/g' /etc/logrotate.conf
RUN dpkg-divert --add --rename --divert /etc/cron.hourly/logrotate /etc/cron.daily/logrotate

RUN passwd -u app \
 && usermod -a -G docker_env app \
 && apt-get install -y rsync

# Utilities
RUN apt-get install -y vim inetutils-ping dnsutils fish jq man-db net-tools
RUN apt-get install -y link-grammar liblink-grammar-dev
RUN apt-get install -y libvips
RUN apt-get install -y chromium-browser
RUN apt-get install -y phantomjs
RUN apt-get install -y libqt5gui5 qt5-qmake
RUN export QT_DEBUG_PLUGINS=1
RUN echo 'export QT_DEBUG_PLUGINS=1' >> /home/app/.bashrc
RUN apt-get install -y libxcb-xinerama0 libxcb-xinerama0-dev
RUN export QT_QPA_PLATFORM=minimal
RUN echo 'export QT_QPA_PLATFORM=minimal' >> /home/app/.bashrc
RUN apt-get install -y mediainfo
RUN apt-get install -y wget
RUN curl -L https://gist.github.com/Lupeipei/1e4f4470880b44c6c3e52a7e4ce965b3/raw/88bfd87be17bcd1c9225b6f84fcc4520f2b8d94c/install_ffmpeg_libfdkaac.sh | bash
RUN apt-get install -y ghostscript