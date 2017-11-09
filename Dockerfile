FROM debian:9.2
ENV DEBIAN_FRONTEND=noninteractive


RUN apt-get update \
    && apt-get install -y --force-yes --force-yes\
        wget \
        gnupg \
    && wget https://dl-ssl.google.com/linux/linux_signing_key.pub \
    && apt-key add linux_signing_key.pub \
    && echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list \
    && apt-get update \
    && apt-get install -y --force-yes --force-yes\
        sudo \
        bash-completion \
        vim git \
        xfce4 \
        xfce4-whiskermenu-plugin \
        terminator \
        google-chrome-stable \
        firefox-esr \
        pelican \
        curl \
    && rm /etc/apt/sources.list.d/google.list \
    && wget http://download.nomachine.com/download/5.3/Linux/nomachine_5.3.12_10_amd64.deb -O /nomachine.deb \
    && dpkg -i /nomachine.deb \
    && rm /nomachine.deb \
    && mkdir /root/.config \
    && apt-get autoremove \
    && apt-get autoclean 

EXPOSE 4000

#COPY xfce4 /root/.config/xfce4
COPY scripts /scripts

ENTRYPOINT ["/scripts/init.sh"]
