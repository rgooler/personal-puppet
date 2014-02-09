class deluge::services { 

  service { 'deluge-daemon':
    ensure => running,
    enable => true,
  }

}
