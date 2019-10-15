# Crawler Challenge

Crawler Challenge made with Elixir/Erlang + Phoenix, ReactJS and PostgreSQL.
First of all you need to clone this repo to any folder you want.

    $ git clone https://github.com/tuliostarling/crawler-challenge.git

# Config Native

### Requisites:

> Elixir - 1.9.0
> Erlang - 22.0
> PostgreSQL - 11.4
> NodeJS - 10.16.2

### Install Postgres database server:

> MacOS
> Update your homebrew with **brew update**

    $ brew update

    $ brew install postgres

> Ubuntu

    $ sudo apt-get install postgresql

### Install Elixir/Erlang:

> MaxOS

    $ brew install elixir

> Ubuntu

Add Erlang Solutions repo:

    $ wget [https://packages.erlang-solutions.com/erlang-solutions_1.0_all.deb](https://packages.erlang-solutions.com/erlang-solutions_1.0_all.deb) && sudo dpkg -i erlang-solutions_1.0_all.deb

Then:

    $ sudo apt-get update

Install the Erlang/OTP platform and all of its applications:

    $ sudo apt-get install esl-erlang

Install Elixir:

    $ sudo apt-get install elixir

> asdf

Follow this link: [https://github.com/asdf-vm/asdf#setup](https://github.com/asdf-vm/asdf#setup)
Then run:

    $ asdf install

### Installing dependencies:

To start your Phoenix server, follow the instructions:

- Duplicate both **dev** and **test** configuration files from the **config/db** folder.

```bash
$ cp config/db/dev.secret.exs.example config/db/dev.secret.exs
$ cp config/db/test.secret.exs.example config/db/test.secret.exs
```

- Set up correctly with your credentials.
- Install dependencies with mix **deps.get**
```bash
$ mix deps.get
```
- Create and update your database with **mix ecto.setup**
```bash
$ mix ecto.setup
```
- Install Node.js (with nvm: https://github.com/creationix/Nvm#install-script)
- Install yarn
```bash
$ npm install -g yarn
```
- Install Node.js dependencies with **cd assets && yarn install**
```bash
$ cd assets && yarn install
```

### Run Phoenix app:

Start the Phoenix server and run the application.

    $ mix phx.server

**_or_**

    $ iex -S mix phx.server

> The difference between those two commands is that with **iex** command you can debug in terminal using **IEx.pry()** for example.

You can now access the **localhost:4000** link from your browser.

## Tests

Javascript tests:

    $ cd assets && yarn

Elixir tests:

    $ mix test
