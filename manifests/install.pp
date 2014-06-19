class circus::install {
  package { $::circus::package_circus:
    ensure   => $::circus::package_ensure,
    provider => $::circus::package_circus_provider,
    notify   => [Class['::circus::configure'], Class['::circus::services']],
  }

  unless empty($::circus::package_circus_dependencies) {
    package { $::circus::package_circus_dependencies:
      ensure => $::circus::package_ensure,
      before => Package[$::circus::package_circus],
      notify => Class['::circus::services'],
    }
  }

}
