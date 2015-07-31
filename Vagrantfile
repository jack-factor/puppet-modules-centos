# -*- mode: ruby -*-
# vi: set ft=ruby :
#
Vagrant.configure("2") do |config|
    config.vm.define :guest do |guest_config|
            guest_config.vm.box = "centos6"
            guest_config.vm.box_url = "https://www.dropbox.com/s/wplhvd105m4msub/package.box?dl=1"
            guest_config.ssh.forward_agent = true
             
            #HostManager Start

            guest_config.hostmanager.enabled = true
            guest_config.hostmanager.manage_host = false
            guest_config.hostmanager.ignore_private_ip = true
            guest_config.hostmanager.include_offline = true

            #HostManager Finish

            #guest_config.librarian_puppet.puppetfile_dir = "puppet"

            # This will give the machine a static IP uncomment to enable
            guest_config.vm.network :private_network, ip: "192.168.20.17"
            #virtualbox__intnet: true
            guest_config.vm.network "public_network"
            guest_config.vm.network :forwarded_port, guest: 80, host: 8888, auto_correct: true
            guest_config.vm.network :forwarded_port, guest: 3306, host: 8889, auto_correct: true
            guest_config.vm.network :forwarded_port, guest: 5432, host: 5433, auto_correct: true
            guest_config.vm.network :forwarded_port, guest: 27017, host: 8887, auto_correct: true
            guest_config.vm.network :forwarded_port, guest: 8080, host: 8881, auto_correct: true

            guest_config.vm.hostname = "centos6.local"
            guest_config.hostmanager.aliases = "centos6.local"

            #guest_config.vm.synced_folder "./","/tmp"
            guest_config.vm.synced_folder "./","/var/www/centos", {:mount_options => ['dmode=777','fmode=777']}

            guest_config.vm.provider :virtualbox do |v|
                v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
                v.customize ["modifyvm", :id, "--memory", "512"]
            end

            #guest_config.vm.provision :shell, :inline => "echo \"America/Bogota\" | sudo tee /etc/timezone && dpkg-reconfigure --frontend noninteractive tzdata"

            guest_config.vm.provision :puppet do |puppet|
                puppet.manifests_path = "provision/puppet/manifests"
                puppet.manifest_file  = "site.pp"
                puppet.module_path = ["provision/puppet/modules"]
                puppet.options = "--verbose --debug"
            end

            guest_config.vm.provision :hostmanager
            #guest_config.vm.provision :shell, :path => "provision/shell/composer.sh"
    end
end
