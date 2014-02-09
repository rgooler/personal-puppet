class deluge::services { 

  service { 'deluge-daemon':
    ensure  => running,
    enabled => true,
  }

}
