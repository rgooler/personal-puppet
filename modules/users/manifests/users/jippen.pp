class users::users::jippen{
  include 'users::secret'

  #My non-root account I use everywhere
  user {'jippen':
    ensure     => present,
    gid        => 'wheel',
    home       => '/home/jippen',
    managehome => true,
    shell      => '/bin/bash',
    uid        => 1000,
    password   => $users::secret::jippen,
  }

  file {'/home/jippen':
    ensure  => directory,
    mode    => 0700,
    owner   => 'jippen',
    group   => 'wheel',
    require => User['jippen'],
    recurse => false,
  }

}
