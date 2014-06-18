define circus::setting (
  $value,
  $option  = $title,
  $section = 'circus',
  $setting_ensure = 'present',
){

  $target_file = "${::circus::conf_prefix}/circus/circusd.ini"

  ini_setting { "${title} in ${target_file}":
    ensure  => $setting_ensure,
    section => $section,
    setting => $option,
    value   => $value,
    path    => $target_file,
    notify  => Class['::circus::services'],
    require => File[$target_file],
  }

}
