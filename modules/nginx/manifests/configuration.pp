class nginx::configuration { 

  file { '/etc/nginx/nginx.conf':
    ensure => file,
    source => 'puppet:///modules/nginx/etc/nginx/nginx.conf',
  }

  file { '/etc/nginx/mime.types':
    ensure => file,
    source => 'puppet:///modules/nginx/etc/nginx/mime.types',
  }

  file { '/etc/nginx/conf.d/default.conf':     ensure => absent, }
  file { '/etc/nginx/conf.d/example_ssl.conf': ensure => absent, }

  file { '/etc/nginx/conf.d/gzip.conf':
    ensure => file,
    source => 'puppet:///modules/nginx/etc/nginx/conf.d/gzip.conf',
  }

  file { '/etc/nginx/conf.d/drop':
    ensure => file,
    source => 'puppet:///modules/nginx/etc/nginx/conf.d/drop',
  }

}
