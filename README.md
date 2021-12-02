# GDX Agreements Tracker Development Environment

Sets up a development environment for the GDX Agreements Tracker. This utility strives not to modify the contents of the underlying repositories but simply to set up a dockerized development environment
around them. It is thus meant to be a standalone repository that you use with the two GDX Agreement tracker repositories.

## Installation

Before proceeding make sure you've cloned the following repositories:

- [GDX Agreements Tracker API](https://github.com/bcgov/gdx-agreements-tracker-api/)
- [GDX Agreements Tracker Front End](https://github.com/bcgov/gdx-agreements-tracker-front-end)

Steps:

1. git clone _this-repository_
2. Update the .env file within with the absolute paths of the above two repositories on your machine.
3. Run `./install.sh` (you may first need to give it execute permissions with the `chmod` command).

## Run

`docker-compose up` in the current repository to stand up the development environment.

The front end app should be available at http://localhost:8081

The API should be available at https://localhost:8080

## To do

- Get nicer logs for development
- Run each app in development mode, not production mode
- Make sure volumes are being mounted(currently not updating upon local file change)
- Make sure services can talk to each other
