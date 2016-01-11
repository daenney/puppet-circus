class circus::services {
  $service_provider = $::operatingsystem ? {
    /(Debian|Ubuntu)/ => 'systemd',
    default           => 'init',
  }

  service { 'circus':
    ensure     => 'running',
    enable     => true,
    hasrestart => true,
    provider   => $service_provider,
  }
}
