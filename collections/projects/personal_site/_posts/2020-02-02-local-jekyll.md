---
title: "Setting Up a Local Jekyll Development Environment"
layout: single
classes: wide
---

Normally, Jekyll requires a full Ruby development environment. This isn't hard to setup, and the steps are described [here](https://jekyllrb.com/docs/). This is fine and good, but I wanted a fully portable environment without having to install Ruby or Bundler. For this I thought [Docker](https://www.docker.com) is a good solution. This way, the only thing that needs to be installed wherever I am working on the site is Docker itself.

## Docker

Docker is a platform that uses virtualization to deliver software in packages called containers. These containers are significantly more lightweight than full-blown virtual machines, as [OS-level virtualization](https://en.wikipedia.org/wiki/OS-level_virtualization) is used.

## docker-compose

`docker-compose` is a command-line utility to work with `docker-compose.yml` files. Docker compose can be used to quickly define and run multi-container Docker applications with a single command and configuration file. A `docker-compose.yml` file contains everything from image configuration, network configuration, and commands to run when the containers start.

Read more [here](https://docs.docker.com/compose/).

## Jekyll docker-compose

For my personal site, I want a local development environment that is highly portable - ideally as easy as `git clone`ing the repository and running `docker-compose up`. That's exactly what the `docker-compose.yml` file below does 👍.

```yml
version: '3'                        # docker-compose file format. Ex. 1, 2, or 3.
                                    # Different versions work with different versions of Docker

services:                           # Configs for the various services, we just have one
  jekyll:
    image: jekyll/jekyll:latest     # Image name to pull from Docker Hub
    command: jekyll serve --watch --force_polling --verbose     # Command to run when the container starts
    ports:
      - 4000:4000                   # Map local port 4000 to port 4000 in the container
    volumes:
      - ./src:/srv/jekyll           # Mount a volume so the container can access local data in the src directory
```
