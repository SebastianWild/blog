---
title: "Better Docker workflow with multiple Compose files"
layout: single
classes: wide
excerpt: >
    docker-compose makes an easy way to deploy your entire service stack, for development *and* production! 📝
categories:
    - Self-hosting
tags:
    - docker
    - Self-hosting
    - traefik
    - reverse-proxy
---

In previous [posts]({{ '/categories/#self-hosting' | relative_url }}), I wrote about how I used Jekyll, Docker, and GitHub Actions to develop my blog. Today, I'll show how to use docker-compose to easily bring up a stack of services with separate configuration for development and production - making deployments a breeze 💨

## docker-compose Concepts

`docker-compose` helps when configuring and running multi-container Docker applications. Initially you might run your containers with a `docker run` command like below:

```shell
docker run -d -P --name iamfoo containous/whoami
```

Doing a `docker container ls` results in this:

```
CONTAINER ID   IMAGE               COMMAND     CREATED          STATUS          PORTS                   NAMES
849f748f3629   containous/whoami   "/whoami"   22 seconds ago   Up 21 seconds   0.0.0.0:55000->80/tcp   iamfoo
```

While this does give a good amount of info, it's not super easy to tell exactly what run command the container was run from. Though there are some [tools](https://github.com/nexdrew/rekcod) to do this.
A good alternative that makes configuring more than one container easy is `docker-compose`. You basically create some YAML files and use the `docker-compose up` to bring up all your services at once. The excellent documentation for this can be read [here](https://docs.docker.com/compose/).

Such a compose file could look like this (some stuff omitted):

```yml
version: '3'

services:
  jekyll:
    image: jekyll/jekyll:3.8.6
    container_name: "jekyll"
    restart: unless-stopped
    command: jekyll build --watch
    volumes:
      - ./blog:/srv/jekyll:Z
  
  website:
    image: flashspys/nginx-static
    container_name: swild.dev
    restart: unless-stopped
    depends_on:
      - jekyll
    volumes:
      - ./blog/_site/:/static:Z
    ports:
      - 4000:80        # Note the unusual port mapping!
      
# ...
```

In this compose file, there are two containers defined: `jekyll` and `website`. Often times though, we need to configure things differently depending on if we are running in a development environment or production. For example in the compose file above, we probably do not want to use port 4000 as the port for our website. `80` and `443` are meant for that! However during development, a port that's not `80` or `443` is used quite commonly. Less chance to conflict with other things that are running and likely not a privileged port.

A solution to tackle this problem is to use overrides and multiple compose files.

## Multiple Compose Files

- override files & their behavior
- additional files

## Working with multiple Services

- folder structure
- start shell script
