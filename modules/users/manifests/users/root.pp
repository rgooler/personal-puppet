class users::users::root{
  include 'users::secret'

  #My non-root account I use everywhere
  user {'root':
    ensure     => present,
    gid        => 'root',
    home       => '/root',
    managehome => true,
    shell      => '/bin/bash',
    uid        => 0,
    password   => $users::secret::root,
  }

}
