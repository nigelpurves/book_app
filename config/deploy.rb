require "bundler/capistrano"
# require "capistrano/ext/multistage"

load "config/recipes/base"
load "config/recipes/nginx"
load "config/recipes/unicorn"
load "config/recipes/postgresql"
# load "config/recipes/nodejs"
load "config/recipes/rbenv"
load "config/recipes/check"

server "46.4.36.7", :web, :app, :db, primary: true
set :stages, %w(production)
set :default_stage, "production"

set :no_release, true
# set :deploy_via, :rsync_with_remote_cache

set :user, "qusic"
set :application, "qusic.co.uk"
set :deploy_to, "/home/#{user}/sites/#{application}"
set :deploy_via, :remote_cache
set :use_sudo, false

set :scm, "git"
set :repository, "git://github.com/nigelpurves/music_app.git"
set :branch, "master"

default_run_options[:pty] = true
ssh_options[:forward_agent] = true

after "deploy", "deploy:cleanup" # keep only the last 5 releases
