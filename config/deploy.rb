set :application, "iSafePlayerHomePage"
set :repository,  "git://github.com/hlxwell/iSafePlayerHomePage.git"

set :scm, :git
set :keep_releases, 5
set :use_sudo, false
set :user, "isafeplayer"
set :deploy_to, "/home/isafeplayer/app"
set :branch, "master"
set :rails_env, "production"

role :web, "176.32.68.133"                          # Your HTTP server, Apache/etc
role :app, "176.32.68.133"                          # This may be the same as your `Web` server
role :db,  "176.32.68.133", :primary => true # This is where Rails migrations will run

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
    run "cd #{release_path}; ln -s #{shared_path}/production.sqlite3 #{release_path}/db/"
  end
end
before "deploy:symlink", "deploy:init_project"