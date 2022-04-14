# syntax=docker/dockerfile:1
FROM jekyll/jekyll:latest

RUN apk add --no-cache imagemagick

CMD ["jekyll", "--help"]
ENTRYPOINT ["/usr/jekyll/bin/entrypoint"]
WORKDIR /srv/jekyll
VOLUME  /srv/jekyll
EXPOSE 35729
EXPOSE 4000