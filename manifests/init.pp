class circus (
  $package_ensure              = 'installed',
  $package_circus              = 'circus',
  $package_circus_provider     = 'pip',
  $package_circus_dependencies = [],
  $service_circus_provider     = 'sysv',
  $conf_prefix                 = '/etc',
  $log_prefix                  = '/var/log',
  $logrotate_dir               = '/etc/logrotate.d',
) {
  validate_re($package_ensure, ['present', 'installed', 'latest', 'absent'],
  '$package_ensure must be one of present, installed, latest or absent')
  validate_re($service_circus_provider, ['sysv', 'upstart', 'systemd'],
  '$service_circus_provider must be one of sysv, upstart or systemd')
  validate_string($package_circus)
  validate_string($package_circus_provider)
  validate_array($package_circus_dependencies)
  validate_string($service_circus_provider)
  validate_absolute_path($conf_prefix)
  validate_absolute_path($log_prefix)
  validate_absolute_path($logrotate_dir)

  include ::circus::install
  include ::circus::configure
  include ::circus::services

  Class['::circus::install']   ->
  Class['::circus::configure'] ->
  Class['::circus::services']  ->
  Class['::circus']

}
