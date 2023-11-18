# syntax=docker/dockerfile:1
# Stage 1: Build the site
FROM ruby:2.7.8 as builder

# Install imagemagick for image resizing
RUN apt-get update \
    && apt-get install -y imagemagick

# Install Jekyll
RUN gem install bundler

# Set working directory
WORKDIR /srv/jekyll
VOLUME  /srv/jekyll

# Copy project files
COPY . .

# install deps
RUN bundle install

# Build the site
RUN bundle exec jekyll build

# Stage 2: Serve the site with Nginx
FROM nginx:alpine

# Copy static files from builder stage
COPY --from=builder /srv/jekyll/_site /usr/share/nginx/html

# Expose port for Nginx
EXPOSE 80

# Start Nginx
CMD ["nginx", "-g", "daemon off;", "-c", "/usr/share/nginx/html/nginx.conf"]