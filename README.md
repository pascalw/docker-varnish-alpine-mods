Docker image for [Varnish](https://varnish-cache.org/) based on Alpine Linux, includes [Varnish mods](https://github.com/varnish/varnish-modules).

## Usage

Usage is similar as the official Varnish image (which doesn't include modules).

```sh
docker run -v /path/to/default.vlc:/etc/varnish/default.vcl:ro pascalw/varnish-alpine-mods
```
