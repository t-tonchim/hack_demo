# how to setup
## rbenv install & setting
```
git clone https://github.com/sstephenson/rbenv.git ~/.rbenv
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bash_profile
echo 'eval "$(rbenv init -)"' >> ~/.bash_profile
source ~/.bash_profile
```

## ruby-build install
```
git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
rbenv rehash
```
## update repository
`sudo apt-get update`

## install rbenv dependency
`sudo apt-get install -y libssl-dev libreadline-dev`

## install ruby
```
rbenv install 2.3.1
rbenv global 2.3.1
```

## mysql & lib dependency install.
`sudo apt-get install -y mysql-server libmysqld-dev`

## create common options for "gem install"
```
touch ~/.gemrc
echo 'install: --no-document' >> ~/.gemrc
echo 'update: --no-document' >> ~/.gemrc
```

## gem update
`gem update --system`

## install bundler
```
gem install bundler
rbenv rehash
```

## clone hack_demo project
```
git clone https://github.com/tomoyuki-tanaka/hack_demo.git ~/hack_demo
cd ~/hack_demo
bundle install
```

## Let's type ' ruby ~/hack_demo/main.rb -o 0.0.0.0 '
