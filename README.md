[![Build Status](https://travis-ci.com/grascovit/peludo.svg?token=eayXJNrAe9LbNAcpFGsz&branch=master)](https://travis-ci.com/grascovit/peludo)

# Peludo

Peludo is a web application that helps people find their pets. The main idea is to centralize information about lost and found pets.

#### Requirements
- Ruby 2.6.3
- Rails 5.2.3
- PostgreSQL 9.5+

#### Setup
To get the application running, follow the steps below:
```shell
bundle install
```

Create a `config/application.yml` file, copy the content from `config/application.yml.example` file to it and fill the values.

After this, execute the following steps:
```shell
rails db:setup
```
Finally, run it:
```shell
rails s
```

#### Tests
To run the test suite, run:
```shell
bundle exec rspec
```

#### Static code analysis
To run the static code analysis with Rubocop, run:
```shell
rubocop
```

If you want Rubocop to fix them, use:
```shell
rubocop -a
```
