class nginx::install { 
  
  package { 'nginx':
    ensure => "1.2.1-1ubuntu0ppa1~${lsbdistcodename}",
  }

  file { '/etc/nginx/sites-available':
    ensure  => directory,
    require => Package['nginx'],
  }

  file { '/etc/nginx/sites-enabled':
    ensure  => directory,
    require => Package['nginx'],
  }

  file { '/etc/nginx/conf.d':
    ensure  => directory,
    require => Package['nginx'],
  }

  file { '/etc/security/limits.d/nginx.nofile.conf':
    ensure => file,
    source => 'puppet:///modules/nginx/etc/security/limits.d/nginx.nofile.conf',
  }

  exec { 'sysctl -p':
    refreshonly => true,
    subscribe   => File['/etc/security/limits.d/nginx.nofile.conf'],
  }

}
