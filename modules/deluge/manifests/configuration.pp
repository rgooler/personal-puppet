class deluge::configuration { 

  file { '/etc/default/deluge-daemon':
    ensure => file,
    source => 'puppet:///modules/deluge/etc/default/deluge-daemon',
  }

  file { '/etc/init.d/deluge-daemon':
    ensure => file,
    mode   => 0755,
    source => 'puppet:///modules/deluge/etc/init.d/deluge-daemon',
  }

}
