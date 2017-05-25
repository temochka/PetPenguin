Vagrant.configure('2') do |config|
  config.vm.box = 'bento/ubuntu-16.04'
  config.vm.network 'private_network', type: 'dhcp'

  config.vm.synced_folder '.', '/toolkit'
  config.vm.synced_folder "#{ENV['HOME']}/Downloads", '/media/sf_downloads'

  config.ssh.forward_agent = true

  config.vm.provider 'virtualbox' do |vb|
    vb.gui = true
    vb.memory = 2048
    vb.cpus = 2

    vb.customize ['modifyvm', :id, '--accelerate3d', 'on']
    vb.customize ['modifyvm', :id, '--audio', 'coreaudio']
    vb.customize ['modifyvm', :id, '--audiocontroller', 'hda']
    vb.customize ['modifyvm', :id, '--cableconnected1', 'on']
    vb.customize ['modifyvm', :id, '--clipboard', 'bidirectional']
    vb.customize ['modifyvm', :id, '--natdnsproxy1', 'off']
    vb.customize ['modifyvm', :id, '--nestedpaging', 'on']
    vb.customize ['modifyvm', :id, '--pae', 'on']
    vb.customize ['modifyvm', :id, '--paravirtprovider', 'kvm']
    vb.customize ['modifyvm', :id, '--vram', '128']
    vb.customize ['modifyvm', :id, '--vtxvpid', 'on']
    vb.customize ['modifyvm', :id, '--vtxux', 'on']
    vb.customize ['modifyvm', :id, '--uartmode1', 'disconnected']

    vb.customize ['setextradata', :id, 'GUI/HiDPI/UnscaledOutput', '1']
  end

  config.vm.provision 'shell', inline: 'apt-get update'
  config.vm.provision 'shell', inline: "cd /toolkit; ./install_linux#{'_artem' if ENV['IAMHOME']}.sh", privileged: false, run: 'always'
  config.vm.provision 'shell', inline: 'pkill -t tty1 || true', run: 'always'
end
