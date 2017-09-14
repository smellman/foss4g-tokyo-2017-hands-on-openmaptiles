# OpenMapTiles で始める OpenStreetMap のベクトルタイル配信

こちらはFOSS4G Tokyo 2017 ハンズオンデイで行う[ハンズオン](https://www.osgeo.jp/events/foss4g-2017/foss4g-2017-tokyo/foss4g-2017-tokyo-handson#openmaptiles)のサポートページとなります。

コマンドはこちらからペーストして利用してください。

## 作業前のインストール

- Dockerがインストール済みであること

```bash
sudo apt -y install git make bc gawk docker.io docker-compose
sudo usermod -aG docker $USER
```

一旦リブートする、再度ログインしてから以下を確認

```bash
docker run hello-world
```

OKならOpenMapTilesをセットアップ

```bash
git clone https://github.com/openmaptiles/openmaptiles.git
cd openmaptiles
docker-compose pull
```

## OpenMapTilesについての講義

講義のみ

## OpenMapTilesを使ってベクトルデータの作成(簡易版)

最初の作成

```
./quickstart.sh
```

作成後のチェック

```bash
make start-tileserver
```

または

```bash
docker pull klokantech/tileserver-gl 
docker run -it --rm -v $(pwd)/data:/data -p 8080:80 klokantech/tileserver-gl
```


## tileserver-gl を使ってベクトルデータの配信サーバの作成

### Docker での配信

```bash
docker pull klokantech/tileserver-gl 
cd openmaptiles/data
docker run -it --rm -v $(pwd):/data -p 8080:80 klokantech/tileserver-gl
``` 

### npm install での配信

```bash
npm install -g tileserver-gl
cd openmaptiles/data
tileserver-gl
```

## Maputnikの起動及び簡単な操作説明

tileserver-glがSSLで外部から接続されている場合は以下のサイトを利用。

- https://editor.openmaptiles.org
- http://maputnik.com/editor

今回は Maputnikのエディタを直接動作させる。

### Docker での実行

```bash
docker run -d -p 8888:8888 maputnik/editor
```

### serve での実行

```bash
npm install -g serve
wget https://github.com/maputnik/editor/releases/download/v1.0.2/public.zip
unzip public.zip
serve -p 8888
```

## OpenMapTilesについての補足説明

### Zoom Levelの変更

再ダウンロードのパターン

```
vim .env
sudo rm -fr data
./quickstart.sh
```

docker-compose-config.yml を変更するパターン

```bash
vim data/docker-compose.yml
./quickstart.sh
```

### imposm3のキャッシュを覗く

```bash
docker volume ls
docker run -it -v openmaptiles_cache:/cache alpine /bin/sh
```
