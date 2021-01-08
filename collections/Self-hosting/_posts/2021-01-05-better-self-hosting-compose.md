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
---

In previous [posts]({{ '/categories/#self-hosting' | relative_url }}), I wrote about how I used Jekyll, Docker, and GitHub Actions to develop my blog. Today, I'll show how to use docker-compose to easily bring up a stack of services with separate configuration for development and production - making deployment a breeze 💨

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
A good alternative that makes configuring more than one container easy is `docker-compose`. You create some YAML files and run `docker-compose up` to bring up all your services at once. The excellent documentation for this can be read [here](https://docs.docker.com/compose/).

Such a compose file could look like this:

```yml
version: '3'

services:
  website:
    image: example/my_website
    depends_on:
      - db
    ports:
      - 4000:80
  
  db:
    image: example/my_db
    ports:
      - 3306:3306
```

In this compose file, there are two containers defined: `website` and `db`. Often times though, we need to configure things differently depending on if we are running in a development environment or production. For example in the compose file above, we probably do not want to use port 4000 as the port for our website. `80` and `443` are meant for that! However during development, a port that's not `80` or `443` is used quite commonly. Less chance to conflict with other things that are running and likely not a privileged port.

A solution to tackle this problem is to use overrides and multiple compose files.

## Multiple Compose Files  

Full docs can be read in the [Docker Documentation](https://docs.docker.com/compose/extends/#different-environments). 
{: .notice--info}

Out of the box, when you run `docker-compose up`, Docker will read two compose files (should they exist):

- `docker-compose.yml`
- `docker-compose.override.yml`

If we take a look at the compose file above, there are a couple configurations we immediately want to change if we want to host our website and database productively:

1. the `website` service should not run on port 4000 ✅
2. add a `restart-policy` - if Docker or containers exit they should be restarted ✅ 

This, of course, is not an exhaustive list.

Let's start by adding two more YAML files: `docker-compose.override.yml` and `docker-compose.prod.yml`. 
Roughly, their roles will be as follows:

:-:|:-:
`docker-compose.yml` | bare-bones configuration
`docker-compose.override.yml` | overrides for development
`docker-compose.prod.yml` | overrides for production

Our original, plain `docker-compose.yml` will now be slightly more compact:

```yml
# docker-compose.yml

version: '3'

services:
  website:
    image: example/my_website
    depends_on:
      - db
  
  db:
    image: example/my_db
```

Notice that we've omitted the port mappings. Where will those go? Into the override file!

```yml
# docker-compose.override.yml

services:
  website:
    ports:
      - 4000:80
  
  db:
    ports:
      - 3306:3306
```

Notice that `docker-compose.override.yml` by itself is not a complete compose file. It's missing the `image:` tag too! That's ok though as `docker-compose` will merge the configuration options. The rules for this are detailed [here](https://docs.docker.com/compose/extends/#adding-and-overriding-configuration).

At this stage, we really haven't done much. Running `docker-compose up` will do the exact same thing - just that the two compose files are merged into one configuration. Now let's take a look at `docker-compose.prod.yml`:

```yml
# docker-compose.prod.yml

services:
  website:
    restart-policy: unless-stopped
    ports:
      - 80:80
  
  db:
    restart-policy: unless-stopped
    ports:
      - 3306:3306
```

Note the different port mapping and addition of a `restart-policy`. Now we need to explicitly pass files as arguments to the `docker-compose` command:

`docker-compose -f docker-compose.yml -f docker-compose.prod.yml up`

The effective compose file would look like so:

```yml
services:
  website:
    image: example/my_website
    restart-policy: unless-stopped
    depends_on:
      - db
    ports:
      - 80:80
  
  db:
    image: example/my_db
    restart-policy: unless-stopped
    ports:
      - 3306:3306
```

## Working with multiple Services

For my own self-hosting stack, I came up with what I think is a (somewhat) reasonable solution to split compose files even further. Let's say you like to run several services: `traefik`, `netdata`, and `blog`. Putting those configurations into even separate compose files might lead to them getting quite large. So you could use a folder structure like so:

```
.
├── traefik/
│   ├── action.sh
│   ├── docker-compose.yml
│   ├── docker-compose.override.yml
│   └── docker-compose.prod.yml
├── netdata/
│   ├── action.sh
│   ├── docker-compose.yml
│   ├── docker-compose.override.yml
│   └── docker-compose.prod.yml
├── blog/
│   ├── action.sh
│   ├── docker-compose.yml
│   ├── docker-compose.override.yml
│   └── docker-compose.prod.yml
└── action.sh
```

Each compose file would have services related to that category. The shell script files are custom, and wrap the `docker-compose` commands needed to spin up all the services. The outer `action.sh` will call the nested `action.sh` shell scripts depending on options passed. 

To run all services in development mode, run:

`./action.sh up -d --dev`

To do the same except for development mode, run:

`./action.sh up -d --dev`

For an individual service:

`./action.sh up -s netdata -d --dev`

To stop an individual service:

`./action.sh down -s netdata --dev`

To stop all services:

`./action.sh down`

To be frank, the shell scripts aren't for the faint of heart - especially if you're unfamiliar with shell programming. It took me quite a while to iron out all the kinks - and I'm sure there are still some lurking. However in the end wrapping the compose commands in my own shell script helped a lot, and I was also able to invoke them as part of my GitHub actions pipeline!

If you're interested, the shell scripts are available as gists. They'll need to be modified for use with different services, but that's mostly straightforward string replacement and is highlighted in the header of each script.

Root `action.sh`: 
Nested `action.sh`:
