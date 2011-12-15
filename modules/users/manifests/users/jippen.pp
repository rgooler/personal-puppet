class users::users::jippen{
  include 'users::util'

  #My non-root account I use everywhere
  user_acct {'jippen':
    fullname => "Jippen Faddoul",
    group    => 'wheel',
    uid      => 1000,
    pass     => $users::secret::jippen,
  }

  file {'/home/jippen/.ssh/':
    owner => 'jippen',
    group => 'wheel',
    mode => 0600,
    recurse => true,
    require => User_acct['jippen'],
    source => 'puppet:///modules/users/jippen/.ssh',
  }
}
