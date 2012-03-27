class vim{
  include 'vim::install'

  file{'/etc/vim/vimrc':
    ensure  => file,
    source  => 'puppet:///modules/vim/etc/vim/vimrc',
    require => Class['vim::install'],
  }
}
