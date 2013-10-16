require "bundler/capistrano"
require "delayed/recipes" #added for delayed job

server "82.223.75.65", :web, :app, :db, primary: true

set :application, "webllorens"
set :user, "angel"
set :deploy_to, "/home/#{user}/apps/#{application}"
set :deploy_via, :remote_cache
set :use_sudo, false
set :rails_env, "production" #added for delayed job

set :scm, "git"
set :repository, "git@github.com:AngelVillanueva/web_llorens.git"
set :branch, "master"

set :default_environment, {
  'PATH' => "$HOME/.rbenv/shims:$HOME/.rbenv/bin:$PATH"
}

default_run_options[:pty] = true
ssh_options[:forward_agent] = true

after "deploy", "deploy:cleanup" # keep only the last 5 releases

namespace :deploy do
  %w[start stop restart].each do |command|
    desc "#{command} unicorn server"
    task command, roles: :app, except: {no_release: true} do
      run "/etc/init.d/unicorn_#{application} #{command}"
    end
  end

  task :setup_config, roles: :app do
    sudo "ln -nfs #{current_path}/config/nginx.conf /etc/nginx/sites-enabled/#{application}"
    sudo "ln -nfs #{current_path}/config/unicorn_init.sh /etc/init.d/unicorn_#{application}"
    run "mkdir -p #{shared_path}/config"
    put File.read("config/database.example.yml"), "#{shared_path}/config/database.yml"
    puts "Now edit the config files in #{shared_path}."
  end
  after "deploy:setup", "deploy:setup_config"

  task :symlink_config, roles: :app do
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
  end
  after "deploy:finalize_update", "deploy:symlink_config"

  desc "Make sure local git is in sync with remote."
  task :check_revision, roles: :web do
    unless `git rev-parse HEAD` == `git rev-parse origin/master`
      puts "WARNING: HEAD is not the same as origin/master"
      puts "Run `git push` to sync changes."
      exit
    end
  end
  before "deploy", "deploy:check_revision"
  #added for delayed job
  after "deploy:stop",    "delayed_job:stop"
  after "deploy:start",   "delayed_job:start"
  after "deploy:restart", "delayed_job:restart"
end

# ==============================
# Uploads
# ==============================

namespace :paperclip do

  desc "Create a storage folder for Paperclip attachment in shared path"
  task :create_storage do
    run "mkdir -p #{shared_path}/uploads"
  end
  
  desc "Link the Paperclip storage folder into the current release"
  task :link_storage do
    run "ln -nfs #{shared_path}/uploads #{release_path}/uploads"
  end

end

before "deploy:setup", 'paperclip:create_storage'
after "deploy:update_code", "paperclip:link_storage"