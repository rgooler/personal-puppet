class rtorrent{

  include 'rtorrent::install'
  include 'rtorrent::user'
  include 'rtorrent::configuration'
  include 'rtorrent::services'

  Class['rtorrent::user'] -> Class['rtorrent::install']
  Class['rtorrent::install'] -> Class['rtorrent::config']
  Class['rtorrent::configuration'] -> Class['rtorrent::services']

}
