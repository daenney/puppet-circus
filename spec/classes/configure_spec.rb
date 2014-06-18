require 'spec_helper'

describe 'circus::configure' do
  let :pre_condition do
    ["class circus {
     $conf_prefix             = '/etc'
     $log_prefix              = '/var/log'
     $service_circus_provider = 'sysv'
     $logrotate_dir           = '/etc/logrotate.d'
    }",
    "include circus" ]
  end

  it 'creates the required directories' do
    should contain_file('/etc/circus').with({
      :ensure => 'directory',
      :owner  => '0',
      :group  => '0',
      :mode   => '0755'
    })

    should contain_file('/etc/circus/conf.d').with({
      :ensure => 'directory',
      :owner  => '0',
      :group  => '0',
      :mode   => '0755'
    })

    should contain_file('/var/log/circus').with({
      :ensure => 'directory',
      :owner  => '0',
      :group  => '0',
      :mode   => '0755'
    })
  end


  it 'ensures circusd.ini exists' do
    should contain_file('/etc/circus/circusd.ini').with({
      :ensure => 'file',
      :owner  => '0',
      :group  => '0',
      :mode   => '0644'
    })
  end


  it 'installs the init script' do
    should contain_file('/etc/init.d/circus').with({
      :ensure => 'file',
      :source => 'puppet:///circus/circus.init',
      :owner  => '0',
      :group  => '0',
      :mode   => '0755',
      :notify => 'Class[Circus::Services]'
    })
  end

  it 'configures logrotate' do
    should contain_file('/etc/logrotate.d/circus').with({
      :ensure => 'file',
      :source => 'puppet:///circus/circus.logrotate',
      :owner  => '0',
      :group  => '0',
      :mode   => '0644'
    })
  end

  it 'uses circus::setting to manage entries in circusd.ini' do
    should contain_circus__setting('check_delay').with_value(5)
    should contain_circus__setting('endpoint').with_value('tcp://127.0.0.1:5555')
    should contain_circus__setting('pubsub_endpoint').with_value('tcp://127.0.0.1:5556')
    should contain_circus__setting('stats_endpoint').with_value('tcp://127.0.0.1:5557')
    should contain_circus__setting('include_dir').with_value('/etc/circus/conf.d')
    should contain_circus__setting('use').with({
      :value   => 'circus.plugins.flapping.Flapping',
      :section => 'plugin:flapping'
    })
    should contain_circus__setting('retry_in').with({
      :value   => 3,
      :section => 'plugin:flapping'
    })
    should contain_circus__setting('max_retry').with({
      :value   => 2,
      :section => 'plugin:flapping'
    })
  end

  it 'spawns ini_setting entries for circus::setting entries' do
    should contain_ini_setting('check_delay in /etc/circus/circusd.ini')
    should contain_ini_setting('endpoint in /etc/circus/circusd.ini')
    should contain_ini_setting('pubsub_endpoint in /etc/circus/circusd.ini')
    should contain_ini_setting('stats_endpoint in /etc/circus/circusd.ini')
    should contain_ini_setting('include_dir in /etc/circus/circusd.ini')
    should contain_ini_setting('use in /etc/circus/circusd.ini')
    should contain_ini_setting('retry_in in /etc/circus/circusd.ini')
    should contain_ini_setting('max_retry in /etc/circus/circusd.ini')
  end

  context 'service_circus_provider=upstart' do
    let :pre_condition do
      ["class circus {
       $conf_prefix             = '/etc'
       $log_prefix              = '/var/log'
       $service_circus_provider = 'upstart'
       $logrotate_dir           = '/etc/logrotate.d'
      }",
      "include circus" ]
    end
    it 'installs the init script' do
      should contain_file('/etc/init/circus.conf').with({
        :ensure => 'file',
        :source => 'puppet:///circus/circus.upstart',
        :owner  => '0',
        :group  => '0',
        :mode   => '0644',
        :notify => 'Class[Circus::Services]'
      })
    end
  end

  context 'service_circus_provider=systemd' do
    let :pre_condition do
      ["class circus {
       $conf_prefix             = '/etc'
       $log_prefix              = '/var/log'
       $service_circus_provider = 'systemd'
       $logrotate_dir           = '/etc/logrotate.d'
      }",
      "include circus" ]
    end
    it 'installs the init script' do
      should contain_file('/lib/systemd/system/circus.service').with({
        :ensure => 'file',
        :source => 'puppet:///circus/circus.service',
        :owner  => '0',
        :group  => '0',
        :mode   => '0644',
        :notify => 'Class[Circus::Services]'
      })
    end
  end
end
