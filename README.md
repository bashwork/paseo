=====================================================================
paSEO
=====================================================================

paSEO was created as a quick project idea because I wanted to quickly
see the current seo content for various pages. I hope it is useful.

<http://paseo.it/>

---------------------------------------------------------------------
Installation
---------------------------------------------------------------------

paSEO requires Ruby 1.8.6+

First download paSEO and cd into the directory:

    git clone git://github.com/bashwork/paseo
    cd paseo

Or download [the zip](http://github.com/bashwork/paseo/zipball/master).

Next make sure you have [RubyGems](https://rubygems.org/pages/download) installed.

Then install [Bundler](http://gembundler.com/)::

    gem install bundler

Now install the dependencies::

    bundle install

---------------------------------------------------------------------
Run Locally
---------------------------------------------------------------------

    bundle exec shotgun config.ru

Now visit <http://localhost:9393>


---------------------------------------------------------------------
Issues
---------------------------------------------------------------------

Find a bug? Want a feature? Submit an [issue
here](http://github.com/bashwork/paseo/issues). Patches welcome!


---------------------------------------------------------------------
Screenshot
---------------------------------------------------------------------

[![paSEO](http://img.skitch.com/20091020-xtiqtj4eajuxs43iu5h3be7upj.png)](http://paseo.it)


---------------------------------------------------------------------
Authors
---------------------------------------------------------------------

* [Galen Collins][1]

[1]: http://github.com/bashwork
