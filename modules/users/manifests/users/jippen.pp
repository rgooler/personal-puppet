class users::users::jippen{
  include 'users::util'

  #My non-root account I use everywhere
  user_acct {'jippen':
    fullname    => "Jippen Faddoul",
    uid         => 1000,
    recursehome => true,
  }

  file { '/home/jippen/.vimrc':
    ensure  => link,
    target  => '/home/jippen/.vim/.vimrc',
    owner   => 'jippen',
    group   => 'jippen',
    require => User_acct['jippen'],
  }

}
