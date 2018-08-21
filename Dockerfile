FROM ubuntu:16.04

WORKDIR /home/root/
COPY get-pip.py ffmpeg_4.02_release.tgz libx264-152_0.152.2854+gite9a5903-2_amd64.deb /home/root/
RUN apt-get update && apt-get upgrade -y && apt-get autoremove -y

RUN apt-get install -y python && python get-pip.py && dpkg -i /home/root/libx264-152_0.152.2854+gite9a5903-2_amd64.deb && tar -zxvf /home/root/ffmpeg_4.02_release.tgz --strip 1 -C / && apt-get install -y libfdk-aac-dev libxv1 libxcb-shm0 libxcb-shape0 libxcb-xfixes0 libasound2 libsdl2-2.0-0 libva1 libfreetype6 libx265-dev libva-drm1 libva-x11-1 curl unzip mediainfo --fix-missing && pip install ffmpeg-normalize && pip install awscli && rm -rf /var/lib/apt/lists/* /home/root/*

ADD fetch_and_run.sh /usr/local/bin/fetch_and_run.sh

USER nobody
ENTRYPOINT ["/usr/local/bin/fetch_and_run.sh"]
