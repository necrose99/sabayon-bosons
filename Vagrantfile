# -*- mode: ruby -*-
# vi: set ft=ruby :
Vagrant.configure(2) do |config|
  config.vm.box = "Sabayon/spinbase-amd64"
  config.vm.provider "virtualbox" do |vb|
     vb.memory = "1024"
     vb.cpus = 2
  end
  config.vm.synced_folder "artifacts", "/artifacts_dir", create: true
  config.vm.synced_folder "logs", "/log_dir", create: true
  config.vm.provision "shell", inline: <<-SHELL
    mkdir -p /usr/portage/licenses/
    rsync -av -H -A -X --delete-during "rsync://rsync.at.gentoo.org/gentoo-portage/licenses/" "/usr/portage/licenses/"
    ls /usr/portage/licenses -1 | xargs -0 > /etc/entropy/packages/license.accept

    sudo equo up && sudo equo u
    sudo echo -5 | equo conf update
    sudo equo i docker vixie-cron sabayon-devkit
    systemctl enable vixie-cron
    systemctl start vixie-cron
    crontab /vagrant/conf/crontab
    sudo systemctl enable docker
    sudo systemctl start docker
    docker pull sabayon/builder-amd64
    git clone https://github.com/mudler/sabayon-bosons.git
    pushd sabayon-bosons/
    /bin/bash install.sh
    popd
  SHELL
end
