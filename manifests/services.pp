class circus::services {
  service { 'circus':
    ensure     => 'running',
    enable     => true,
    hasrestart => true,
  }
}
