# telegram-bot-skeleton-ruby

Skeleton project containing boilerplate to run a telegram bot.

## Features

- Simple setup and development with Docker and Docker Compose
- Live-reload via https://github.com/alexch/rerun

## Prerequisites

- [Docker Compose](https://docs.docker.com/compose/)

## Usage

Create .env file and add TELEGRAM_BOT_TOKEN

```bash
$ cp .env .env.example
```

Run docker container

```bash
$ docker-compose up --build
```
