class rtorrent::configuration{

  file{'/home/rtorrent/.rtorrent.rc':
    ensure  => file,
    mode    => '0600',
    owner   => 'rtorrent',
    group   => 'rtorrent',
    content => template('rtorrent/rtorrentrc.erb'),
  }

}
