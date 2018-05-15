lock '3.10.1'

set :repo_url, 'git@github.com:IzotovDenis/krasota.git'
set :application, 'krasota'
application = 'krasota'
set :rvm_type, :user
set :rails_env, 'production'
set :rvm_ruby_version, '2.4.1'
set :deploy_to, '/home/deployer/apps/krasota'
set :whenever_identifier, ->{ "#{fetch(:application)}_#{fetch(:stage)}" }

namespace :foreman do
  desc 'Start server'
  task :start do
    on roles(:all) do
      sudo "systemctl start #{application}.target"
    end
  end

  desc 'Stop server'
  task :stop do
    on roles(:all) do
      sudo "systemctl stop #{application}.target"
    end
  end

  desc 'Restart server'
  task :restart do
    on roles(:all) do
      sudo "systemctl restart #{application}.target"
    end
  end

  desc 'Server status'
  task :status do
    on roles(:all) do
      execute "initctl list | grep #{application}"
    end
  end
end

namespace :git do
  desc 'Deploy'
  task :deploy do
    ask(:message, "Commit message?")
    run_locally do
      execute "git add -A"
      execute "git commit -m '#{fetch(:message)}'"
      execute "git push"
    end
  end
end

namespace :deploy do
  desc 'Setup'
  task :setup do
    on roles(:all) do
      execute "mkdir  #{shared_path}/config/"
      execute "mkdir  #{shared_path}/sys/"
      execute "mkdir  #{shared_path}/config/sphinx/"
      execute "mkdir  #{shared_path}/config/sphinx/tmp/"
      execute "mkdir  #{shared_path}/config/sphinx/db/"
      execute "mkdir  /home/deployer/uploads"
      execute "mkdir  /home/deployer/imports"
      execute "mkdir #{shared_path}/system"
      execute "mkdir /home/deployer/log/"
      execute "mkdir /home/deployer/apps/#{application}/run"
      execute "mkdir /home/deployer/apps/#{application}/run/sockets"
      execute "mkdir /home/deployer/apps/#{application}/run/pids"

      upload!('shared/database.yml', "#{shared_path}/config/database.yml")
      upload!('shared/secrets.yml', "#{shared_path}/config/secrets.yml")
      upload!('shared/application.yml', "#{shared_path}/config/application.yml")
      upload!('shared/Procfile', "#{shared_path}/Procfile")
      upload!('shared/nginx.conf', "#{shared_path}/nginx.conf")
      sudo 'service nginx stop'
      sudo "rm -f /etc/nginx/sites-enabled/default"
      sudo "ln -s #{shared_path}/nginx.conf /etc/nginx/sites-enabled/default"
      sudo 'service nginx start'

      within release_path do
        with rails_env: fetch(:rails_env) do
          execute :rake, "db:create"
        end
      end

    end
  end

  desc 'Create symlink'
  task :symlink do
    on roles(:all) do
      execute "ln -s #{shared_path}/config/database.yml #{release_path}/config/database.yml"
      execute "ln -s #{shared_path}/config/application.yml #{release_path}/config/application.yml"
      execute "ln -s #{shared_path}/config/secrets.yml #{release_path}/config/secrets.yml"
      execute "ln -s #{shared_path}/Procfile #{release_path}/Procfile"
      execute "ln -s #{shared_path}/sys #{release_path}/public/sys"
      execute "ln -s /home/deployer/uploads #{release_path}/public/uploads"
      execute "ln -s /home/deployer/imports #{release_path}/imports"
      execute "ln -s /home/deployer/apps/#{application}/run #{release_path}/run"
      execute "ln -s #{shared_path}/config/sphinx #{release_path}/config/sphinx"

    end
  end


  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      sudo "systemctl restart rails"
    end
  end

  after :finishing, 'deploy:cleanup'
  after :finishing, 'deploy:restart'

  after :updating, 'deploy:symlink'

  before :setup, 'deploy:starting'
  before :setup, 'deploy:updating'
  before :setup, 'bundler:install'
end
