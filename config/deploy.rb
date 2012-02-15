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
set :user, "isafeplayer"
set :deploy_to, "/home/isafeplayer/app"
set :branch, "master"
set :rails_env, "production"

role :web, "58.215.184.207"                          # Your HTTP server, Apache/etc
role :app, "58.215.184.207"                          # This may be the same as your `Web` server
role :db,  "58.215.184.207", :primary => true # This is where Rails migrations will run

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end

  task :init_project do
    run "cd #{release_path}; ln -s #{shared_path}/database.yml #{release_path}/config/database.yml"
    run "cd #{release_path}; bundle install"
    run "cd #{release_path}; bundle exec rake db:migrate RAILS_ENV=production"
    # run "cd #{release_path}; bundle exec rake assets:precompile RAILS_ENV=production"
  end
end
after "deploy:symlink", "deploy:init_project"