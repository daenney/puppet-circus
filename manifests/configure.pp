class circus::configure {
  file { "${::circus::conf_prefix}/circus":
    ensure => 'directory',
    owner  => '0',
    group  => '0',
    mode   => '0755',
  }

  file { "${::circus::conf_prefix}/circus/conf.d":
    ensure => 'directory',
    owner  => '0',
    group  => '0',
    mode   => '0755',
  }

  file { "${::circus::conf_prefix}/circus/circusd.ini":
    ensure => 'file',
    owner  => '0',
    group  => '0',
    mode   => '0644',
    notify => Class['::circus::services'],
  }

  file { "${::circus::log_prefix}/circus":
    ensure => 'directory',
    owner  => '0',
    group  => '0',
    mode   => '0755',
  }

  case $::circus::service_circus_provider {
    'sysv': {
      $dest_path = '/etc/init.d/circus'
      $dest_mode = '0755'
      $extension = 'init'
    }
    'upstart': {
      $dest_path = '/etc/init/circus.conf'
      $dest_mode = '0644'
      $extension = 'upstart'
    }
    'systemd': {
      $dest_path = '/lib/systemd/system/circus.service'
      $dest_mode = '0644'
      $extension = 'service'
    }
    default: {
      fail('Unsupported init-system')
    }
  }

  file { $dest_path:
    ensure => 'file',
    source => "puppet:///modules/${module_name}/circus.${extension}",
    owner  => '0',
    group  => '0',
    mode   => $dest_mode,
    notify => Class['::circus::services'],
  }

  file { "${::circus::logrotate_dir}/circus":
    ensure => 'file',
    source => "puppet:///modules/${module_name}/circus.logrotate",
    owner  => '0',
    group  => '0',
    mode   => '0644',
  }

  ::circus::setting { 'check_delay'    : value => 5, }
  ::circus::setting { 'endpoint'       : value => 'tcp://127.0.0.1:5555', }
  ::circus::setting { 'pubsub_endpoint': value => 'tcp://127.0.0.1:5556', }
  ::circus::setting { 'stats_endpoint' : value => 'tcp://127.0.0.1:5557', }
  ::circus::setting { 'include_dir'    : value => '/etc/circus/conf.d', }

  ::circus::setting { 'use':
    value   => 'circus.plugins.flapping.Flapping',
    section => 'plugin:flapping',
  }

  ::circus::setting { 'retry_in':
    value   => 3,
    section => 'plugin:flapping',
  }

  ::circus::setting { 'max_retry':
    value   => 2,
    section => 'plugin:flapping',
  }
}
