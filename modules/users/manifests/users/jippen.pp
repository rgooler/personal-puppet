class users::users::jippen{
  include 'users::util'

  #My non-root account I use everywhere
  user_acct {'jippen':
    fullname => "Jippen Faddoul",
    group    => 'wheel',
    uid      => 1000,
  }

  file {'/home/jippen/.ssh/':
    owner   => 'jippen',
    group   => 'wheel',
    mode    => 0600,
    recurse => true,
    require => User_acct['jippen'],
    source  => 'puppet:///modules/users/jippen/.ssh',
  }

  file { '/home/jippen/.bashrc':
    owner   => 'jippen',
    group   => 'wheel',
    mode    => 0600,
    require => User_acct['jippen'],
    source  => 'puppet:///modules/users/jippen/.bashrc'
  }

  file { '/home/jippen/.inputrc':
    owner   => 'jippen',
    group   => 'wheel',
    mode    => 0600,
    require => User_acct['jippen'],
    source  => 'puppet:///modules/users/jippen/.inputrc'
  }

  file { '/home/jippen/.vim':
    owner   => 'jippen',
    group   => 'wheel',
    ensure  => directory,
    mode    => 0600,
    require => User_acct['jippen'],
    recurse => true,
    source  => 'puppet:///modules/users/jippen/.vim'
  }

  file { '/home/jippen/.vimrc':
    ensure => link,
    target => '/home/jippen/.vim/.vimrc',
    owner   => 'jippen',
    group   => 'wheel',
    require => [ User_acct['jippen'], File['/home/jippen/.vim'] ],
  }

}
