namespace :paseo do

  desc "Start Paseo for development"
  task :start do
    exec "bundle exec shotgun config.ru"
  end

  desc "Generate GitHub pages."
  task :pages => :check_dirty do
    require "mustache"
    require "rdiscount"
    view = Mustache.new
    view.template = File.read("docs/index.mustache")
    view[:content] = Markdown.new(File.read("README.md")).to_html
    File.open("new_index.html", "w") do |f|
      f.puts view.render
    end
    system "git checkout gh-pages"
    system "git pull origin gh-pages"
    system "mv new_index.html index.html"
    system "git commit -a -m 'auto update docs'"
    system "git push origin gh-pages"
    system "git checkout master"
  end

  task :check_dirty do
    if `git status -s` && $?.success?
      abort "dirty index - not publishing!"
    end
  end

  desc "Deploy the new release to heroku"
  task :deploy do
    exec "git push heroku master"
  end
end

# Needs bundler, uglifyjs, and uglifycss installed on the server.
#
# Bundler:
#   gem install bundler
# uglifyjs:
#   npm install uglify-js
# uglifycss:
#   curl https://github.com/fmarcia/UglifyCSS/raw/master/uglifycss > /usr/bin/uglifcss
task :bundle do
  system "bundle install"
  rm "public/js/bundle.js"   rescue nil # >:O
  rm "public/css/bundle.css" rescue nil
  system "cat $(ls -1 public/js/*.js | grep -v jquery.js) | uglifyjs -nc > public/js/bundle.js"
  system "uglifycss public/css/*.css > public/css/bundle.css"
end

desc "Start everything."
multitask :start => [ 'paseo:start' ]
