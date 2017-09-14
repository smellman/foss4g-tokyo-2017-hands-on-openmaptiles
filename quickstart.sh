#!/bin/bash
set -o errexit
set -o pipefail
set -o nounset

osm_area=albania                         #  default test country
testdata=${osm_area}.osm.pbf

# Dockerコンテナをクリーンアップ
make refresh-docker-images
make clean-docker
mkdir -p pgdata
mkdir -p build
mkdir -p data

# OSMデータ(pbfファイル)をGeofabrickからダウンロード
make download-geofabrik      area=${osm_area}

# openmaptiles-toolsでbuild以下にファイルを作成
docker-compose run --rm openmaptiles-tools make clean
docker-compose run --rm openmaptiles-tools make

# PostgreSQL(PostGIS)を起動
docker-compose up   -d postgres
make forced-clean-sql

# water, osmborder, natural earth, lakelinesをインポート
docker-compose run --rm import-water
docker-compose run --rm import-osmborder
docker-compose run --rm import-natural-earth
docker-compose run --rm import-lakelines

# imposm3を使ってOSMデータをインポート
docker-compose run --rm import-osm

# ベクトルタイルを出力するのに利用するSQL(関数)をインポート
docker-compose run --rm import-sql

# アナライズ
make psql-analyze

# postserveを起動(直接は関係ない処理)
docker-compose up -d postserve

# Mapbox Vector TileをMBTiles形式に出力
docker-compose -f docker-compose.yml -f ./data/docker-compose-config.yml  run --rm generate-vectortiles

# MBTilesにメタデータを付与
docker-compose run --rm openmaptiles-tools  generate-metadata ./data/tiles.mbtiles
docker-compose run --rm openmaptiles-tools  chmod 666         ./data/tiles.mbtiles

# PostgreSQL(PostGIS)を停止
docker-compose stop postgres

