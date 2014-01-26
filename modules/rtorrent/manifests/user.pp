class rtorrent::user{
  user{'rtorrent':
    ensure  => present,
    gid     => 'rtorrent',
    require => Group['rtorrent'],
    home    => '/home/rtorrent'
  }

  group{'rtorrent':
    ensure => present,
  }

  file{'/home/rtorrent':
    ensure  => directory,
    owner   => 'rtorrent',
    group   => 'rtorrent',
    mode    => '0775',
    require => [ User['rtorrent'],Group['rtorrent'] ],
  }

}
