class deluge::user{
  user{'deluge':
    ensure  => present,
    gid     => 'deluge',
    require => Group['deluge'],
    home    => '/home/deluge'
  }

  group{'deluge':
    ensure => present,
  }

  file{'/home/deluge':
    ensure  => directory,
    owner   => 'deluge',
    group   => 'deluge',
    mode    => '0775',
    require => [ User['deluge'],Group['deluge'] ],
  }

}
