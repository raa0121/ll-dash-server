FROM lscr.io/linuxserver/ffmpeg:7.0-cli-ls133

ENV TINI_VERSION v0.19.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /tini
RUN chmod +x /tini

EXPOSE 1935
RUN mkdir -p /app /dash-data
WORKDIR /app
COPY ll-rtmpsrc-audio.sh .

ENTRYPOINT ["/tini", "--"]
CMD [ "/app/ll-rtmpsrc-audio.sh" ]
