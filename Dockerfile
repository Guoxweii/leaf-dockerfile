from arm64v8/ubuntu:20.04

RUN export http_proxy=http://192.168.11.114:7890
RUN export https_proxy=http://192.168.11.114:7890

RUN apt update # 2020-01-04.1

RUN apt install -y sudo

RUN apt install -y yasm perl
RUN apt install -y wget curl
RUN apt remove -y imagemagick

RUN apt install -y vim
RUN apt install -y git

RUN echo "${TZ}" > /etc/timezone && ln -sf /usr/share/zoneinfo/${TZ} /etc/localtime

RUN curl -L https://gist.github.com/Lupeipei/1e4f4470880b44c6c3e52a7e4ce965b3/raw/88bfd87be17bcd1c9225b6f84fcc4520f2b8d94c/install_ffmpeg_libfdkaac.sh | bash
RUN apt install -y ghostscript

RUN apt update
RUN apt install -y libxtst6 libnss3 libxss1 libgconf-2-4 libxtst6 libgtk-3-0 libatk-bridge2.0-dev
RUN apt install -y imagemagick mediainfo

RUN apt install -y link-grammar liblink-grammar-dev
RUN apt install -y libvips
RUN apt install -y unzip
RUN apt install -y zip

# # ruby 2.7.2
# RUN apt install -y git libssl-dev libreadline-dev zlib1g-dev autoconf bison
# RUN apt install -y build-essential libyaml-dev libreadline-dev libncurses5-dev libffi-dev libgdbm-dev
# RUN apt install -y libyaml-dev libreadline-dev libncurses5-dev libffi-dev libgdbm-dev
# RUN curl -fsSL https://github.com/rbenv/rbenv-installer/raw/HEAD/bin/rbenv-installer | bash
# RUN echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
# RUN echo 'eval "$(rbenv init -)"' >> ~/.bashrc
# RUN /root/.rbenv/bin/rbenv init -

# RUN git clone https://github.com/rbenv/ruby-build.git
# RUN PREFIX=/usr/local sudo ./ruby-build/install.sh
# RUN /root/.rbenv/bin/rbenv -v
# RUN /root/.rbenv/bin/rbenv install -l
# RUN /root/.rbenv/bin/rbenv install 2.7.2
# RUN /root/.rbenv/bin/rbenv global 2.7.2
# RUN /root/.rbenv/bin/rbenv rehash
# RUN /root/.rbenv/shims/gem update --system
# RUN /root/.rbenv/shims/gem install bundler

# node 14
RUN curl -sL https://deb.nodesource.com/setup_14.x | sudo -E bash -  && apt-get install -y nodejs  && npm install -g yarn

RUN sudo useradd -m -s /bin/bash app

# Allow app can login for SSH
# RUN passwd -u app

# Cleanup
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*