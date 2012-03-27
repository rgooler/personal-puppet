class rtorrent::install{
  #Basic Client
  package{'rtorrent': ensure => present, } 

  #Init Script
  file{'/etc/init.d/rtorrent':
    ensure => file,
    mode   => '0755',
    source => 'puppet:///modules/rtorrent/etc/init.d/rtorrent',
  }

  #Ensure log dir exists
  file {'/var/log/rtorrent': 
    ensure => directory,
    owner  => 'rtorrent',
    group  => 'rtorrent',
    mode   => '0775',
  }
}
