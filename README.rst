============================================================
PaSEO - Quick SEO in a Second (hopefully...)
============================================================

------------------------------------------------------------
What is it...
------------------------------------------------------------

Paseo is an web application used to slice out the important
information about a site; by important I mean factors that
could influence search engine rankings.

------------------------------------------------------------
Like what
------------------------------------------------------------

Well lets walk through this list:

* page title
* meta attributes (not really used anymore)
* outbound links
* cookies
* headers
* robots.txt
* frequent words
* page load times
* page validation results
* and more to come!

------------------------------------------------------------
So now what
------------------------------------------------------------

Go SEO some people.

------------------------------------------------------------
How can I play
------------------------------------------------------------

Like this:

    git clone git@github.com:bashwork/paseo.git
    cd paseo
    sudo gem install bundler
    sudo bundle install
    rake start
    curl -d "url=http://google.com" "http://127.0.0.1:9393/api/seo/"

------------------------------------------------------------
What else
------------------------------------------------------------

Fork, tickets, etc...
