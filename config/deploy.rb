
#IP: 184.106.216.162
#root/Administrator password: rails-01nb35tMDL1

set :use_sudo,            false
set :git_shallow_clone,   1
set :keep_releases,       5
set :application,         "linuxfi-lojas"
set :user,                "deployer"
set :password,            "asdfg"
set :deploy_to,           "/home/deployer/loja"
set :runner,              "deployer"
set :repository,          "git@github.com:mauricio/linuxfi-loja.git"
set :scm,                 :git
set :real_revision, 			lambda { source.query_revision(revision) { |cmd| capture(cmd) } }

ssh_options[:paranoid]    = false
default_run_options[:pty] = true

role :app, "184.106.214.155"
role :web, "184.106.214.155"
role :db,  "184.106.214.155", :primary => true

namespace :deploy do

  task :start do
    sudo "/etc/init.d/unicorn start"
  end

  task :stop do
    sudo "/etc/init.d/unicorn stop"
  end

  task :restart do
    sudo "/etc/init.d/unicorn reload"
  end

end
