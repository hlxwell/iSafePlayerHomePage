require "bundler/capistrano"
$:.unshift(File.expand_path("./lib", ENV["rvm_path"]))
require "rvm/capistrano"
set :rvm_ruby_string, "ree"
set :rvm_type, :system

set :application, "iSafePlayerHomePage"
set :repository,  "git://github.com/hlxwell/iSafePlayerHomePage.git"

set :scm, :git
set :keep_releases, 5
set :use_sudo, false
set :user, "app"
set :deploy_to, "/home/app/app"
set :branch, "master"
set :rails_env, "production"

role :web, "58.215.160.129"                          # Your HTTP server, Apache/etc
role :app, "58.215.160.129"                          # This may be the same as your `Web` server
role :db,  "58.215.160.129", :primary => true # This is where Rails migrations will run

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
namespace :deploy do
  # unicorn scripts cribbed from https://github.com/daemon/capistrano-recipes/blob/master/lib/recipes/unicorn.rb
  desc "Restart unicorn"
  task :restart, :roles => :app do
    run "kill -USR2 `cat #{shared_path}/pids/unicorn.pid`"
  end
  task :stop, :roles => :app do
    run "kill -QUIT `cat #{shared_path}/pids/unicorn.pid`"
  end
  task :start, :roles => :app do
    run "cd #{current_path} && bundle exec unicorn -E #{rails_env} -D -c #{current_path}/config/unicorn.rb"
  end

  task :init_project do
    run "cd #{release_path}; ln -s #{shared_path}/database.yml #{release_path}/config/database.yml"
    run "cd #{release_path}; bundle install"
    run "cd #{release_path}; bundle exec rake db:migrate RAILS_ENV=production"
    # run "cd #{release_path}; bundle exec rake assets:precompile RAILS_ENV=production"
  end
end
after "deploy:symlink", "deploy:init_project"