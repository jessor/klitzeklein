Klitzeklein!
============

A simple URL shortener. I needed one and all the others sucked.
Buzzwords: Sinatra, DataMapper, Haml, Sass, Sprockets, Bootstrap-Sass (Git Submodule), jQuery, DataTables...

![Screenshot](http://i.imgur.com/8hWqj.png) 

Quick Setup
-----------

* rvm use 1.9.2@klitzeklein --create
* git clone git@github.com:username/klitzeklein.git
* rvm rvmrc trust klitzeklein/.rvmrc
* cd klitzeklein
* git submodule update --init
* gem install bundler && bundle install
* cp config.sample.yml config.yml
* shotgun config.ru
* Navigate your browser to "http://localhost:9393/items", Username: "admin", Password: api_key (see config.yml)

Acknowledgements
----------------

* Bootstrap by Twitter - http://twitter.github.com/
* Color Scheme by Bootswatch - http://bootswatch.com/

Licence
-------

Klitzeklein is licensed under the GPLv2+. Please drop me a line if you use or modify it.
