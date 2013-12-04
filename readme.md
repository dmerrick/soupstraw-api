# Soupstraw API

## What is the purpose of Soupstraw API?

This project is run on a host that you want to be accessible to the outside world. It provides an authenticated JSON API for running arbitrary commands.

For instance, I have it set up to run on my home network so that I can do things like controlling the lights in my apartment from my (EC2-hosted) website.

## How do I get started?

    bundle install

## How do I start the application?

Start the app by running:

    rake s

This rake command runs `rackup -p 9393 config.ru` behind the scenes for you and starts the app on port 9393 and will now be able to view the application in your web browser at this URL [http://localhost:9393](http://localhost:9393).

## Helper Rake Tasks

There are a few helper Rake tasks that will help you to clear and compile your Sass stylesheets as well as a few other helpful tasks. There is also a generate task, so you can generate a new project at a defined location based on the bootstrap.

    rake -T

    rake s                 # Run the app

