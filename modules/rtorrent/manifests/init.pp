class rtorrent{

  include 'rtorrent::install'
  include 'rtorrent::user'

  file{'/home/rtorrent/.rtorrentrc':
    ensure  => file,
    mode    => '0600',
    owner   => 'rtorrent',
    group   => 'rtorrent',
    content => template('rtorrent/rtorrentrc.erb'),
  }
}
