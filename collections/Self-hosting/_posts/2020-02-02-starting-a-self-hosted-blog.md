---
title: "Starting a Self-hosted Blog"
layout: single
classes: wide
excerpt: >
  Kicking off the blog series on how I develop & host this very website 😎
categories: 
    - Self-hosting
tags:
    - Self-hosting
    - Jekyll
---

## Motivation

I'm a professional iOS developer - most of the web development world is unknown to me. I have done some small projects at work with SAPUI5, but I have to admin I was never really good at it. But, I think any good developer should know a little bit of everything, and that includes diving into some web development. A lot of developers also have blogs and personal sites hosted on places like Medium or GitHub pages. So, I wanted to get my feet wet - but rather than hosting on GitHub pages or writing posts on Medium, I wanted to self-host all the way.

I knew I wanted to start off with a static site using Jekyll. Jekyll caters super well to blogs, with tons of readily available themes and markdown-powered posting. It's a good way for me to start my web learning journey 👍.

I also knew that I wanted to self-host. Something like GitHub pages is enticing, and super quick to set up. But by self-hosting, I can learn some more about setting up a web server, a good CI/CD pipeline, linting, and server hardening.

## Overview

I spent some time planning what I wanted my web stack to look like, but as this project goes on odds are some of this will change 😀
As I figure out & create my site, I will write some blogs detailing the entire setup ✅

## Key Components

1. __Jekyll__: Static website generator to be used for the content of the site.
2. __Docker__: Will run Jekyll & a web server in a container for easy local environment and production deployment.
3. __Server__: Probably a DigitalOcean droplet or cheap dedicated server.
4. __CI/CD__: GitHub actions to build, lint, and deploy the site automatically.
5. __CDN__: CloudFlare to provide a speedy site.

## Related Posts

[Running Jekyll with Docker](/collections/Self-hosting/2020-02-20-local-jekyll.md)
