# -*- mode: ruby -*-
# vi: set ft=ruby :
# Variaveis
VAGRANTFILE_API_VERSION=2
VAGRANT_DISABLE_VBOXSYMLINKCREATE=1

# Configurações das vms
vms = {
  'master' => {'memory' => '2048', 'cpus' => 2, 'ip' => 50},
  'worker01' => {'memory' => '1024', 'cpus' => 1, 'ip' => 60},
  'worker02' => {'memory' => '1024', 'cpus' => 1, 'ip' => 61},
}

# Configurações
Vagrant.configure('2') do |config|
  config.vm.box = 'bento/ubuntu-18.04'
  config.vm.box_check_update = false
  id_rsa_pub = File.read("#{Dir.home}/.ssh/id_rsa.pub")
  config.vm.provision "copy ssh public key", type: "shell",
    inline: "echo \"#{id_rsa_pub}\" >> /home/vagrant/.ssh/authorized_keys"
  config.vm.provision "shell", inline: <<-SHELL
    echo "192.168.1.50 master" >> /etc/hosts
    echo "192.168.1.60 worker01" >> /etc/hosts
    echo "192.168.1.61 worker02" >> /etc/hosts 
  SHELL

  config.vm.provision "Instalando Docker", type: "shell",
    inline: "sudo apt update && sudo apt upgrade -y && sudo curl -fsSL get.docker.com | sh"
  vms.each do |name, conf|
    config.vm.define "#{name}" do |k|
      k.vm.hostname = "#{name}.mandalorian.local"
      k.vm.network 'public_network', bridge: "enp2s0", use_dhcp_assigned_default_route: true , ip: "192.168.1.#{conf['ip']}"
      k.vm.provider 'virtualbox' do |vb|
        vb.memory = conf['memory']
        vb.cpus = conf['cpus']
      end
    end
  end
  # Provider
  config.vm.provider "virtualbox" do |v|
    v.vm.provision "shell", path: "scripts/kubelet.sh"
    v.gui = true
  end
end  
