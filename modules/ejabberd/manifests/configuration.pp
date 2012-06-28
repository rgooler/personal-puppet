class ejabberd::configuration {

  file { '/etc/ejabberd':
    ensure => directory,
  }

  file { '/etc/ejabberd/ejabberd.cfg':
    ensure => file,
    source => 'puppet:///modules/ejabberd/ejabberd.cfg',
    require => File['/etc/ejabberd'],
  }

  file { '/etc/ejabberd/inetrc':
    ensure => file,
    source => 'puppet:///modules/ejabberd/inetrc',
    require => File['/etc/ejabberd'],
  }

}
