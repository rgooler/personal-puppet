class rtorrent::services {

  service { 'rtorrent':
    ensure => running,
  }

}
