FROM node:5
MAINTAINER Taro Matsuzawa <taro@georepublic.co.jp>

WORKDIR /usr/src/app
RUN npm install -g \
          mbtiles@0.8.2 \
          tilelive@5.12.2 \
          tilelive-http@0.12.2

VOLUME /export
ENV EXPORT_DIR=/export

COPY . /usr/src/app/
CMD ["/usr/src/app/export-local.sh"]
