# Apache Tika Server w/ Tesseract in Docker that peforms OCR on PDFs

Sets up a container based on
[java:7](https://hub.docker.com/\_/java/)

## Includes

  * [Apache Tika Server](http://wiki.apache.org/tika/TikaJAXRS) - latest development version (1.13-SNAPSHOT currently)
  * [Tesseract](https://code.google.com/p/tesseract-ocr/), with English and German languages

If you prefer the latest stable version of Tika-server (including OCR via Tesseract), you may want to consider
[`logicalspark/docker-tikaserver`](https://github.com/LogicalSpark/docker-tikaserver)

## Usage

To build and run the container, do the following:

    sudo docker build -t tika
    sudo docker run -d -p 9998:9998 tika

Test with commands like:

    curl -T testpdf.pdf http://localhost:9998/tika

This command will also perform OCR on images embedded within a PDF

## Deployment on Heroku

Heroku recently launched a beta for containers (Docker to you and me). https://devcenter.heroku.com/articles/container-registry-and-runtime

```
# Make sure Docker is running on your local machine
$ docker ps
$ heroku login
$ heroku plugins:install heroku-container-registry
$ heroku container:login -v
$ heroku create
$ heroku container:push web
```

## Differences from other Tika containers

This `Dockerfile` changes some config settings before building Tika as follows:

```
# in file tika-parsers/src/main/resources/org/apache/tika/parser/pdf/PDFParser.properties
extractInlineImages false -> true
extractUniqueInlineImagesOnly true -> false
```

This changes the default to enable OCR on images embedded within PDFs. This is disabled by default as it adds a large overhead
for general users, but many government PDFs are published in this format. If you don't need OCR inside PDFs it would be more
performant to disable these according to the Tika team (although I've not benchmarked to check).

I have also moved some actions from `install.sh` into the `Dockerfile` to take advantage of Docker caching.

Finally the Heroku container service doesn't use `ENTRYPOINT` and needs to use the `$PORT` environment variable which is set at runtime by Heroku. The changes in the `Dockerfile` and the run command reflect this.

## Author

  * Matt Fullerton (<matt.fullerton@gmail.com>)
  * Todd Tyree (<tatyree@gmail.com>)
  * Xavier Riley (<@xavriley>)

## Credits

  * Todd Tyree's version (http://github.com/ministryofjustice/tika) was inspired by Andreas Wålm's (<andreas@walm.net>) [tika app repo/container](https://github.com/walm/docker-tika)

## Disclaimer

Whilst I currently work for Heroku, this is a personal project and shouldn't be considered "official". All views my own.
