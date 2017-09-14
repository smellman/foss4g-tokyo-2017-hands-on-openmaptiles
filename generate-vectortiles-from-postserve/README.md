# Generate Vector Tiles from Postserve

A Docker image to export MBTiles (containing gzipped MVT PBF) from the Postserve by OpenMapTiles project.

## Usage

You need to provide the server address and run `generate-vectortiles-from-postserve`.

```bash
docker run --rm \
    -v $(pwd):/export \
    -e POSTSERVE_IP=172.18.0.8 \
    -e POSTSERVE_PORT=6081 \
    -e MIN_ZOOM=0 \
    -e MAX_ZOOM=7 \
    -e BBOX="12.2550862, 36.3852967, 29.6194270, 45.9089096" \
    smellman/generate-vectortiles-from-postserve
```

