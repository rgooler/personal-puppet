define user_acct($fullname, $group, $uid, $pass='!!',$groups=[]){
  user { $name:
    ensure     => present,
    gid        => $group,
    home       => "/home/${name}",
    managehome => true,
    shell      => '/bin/bash',
    uid        => $uid,
    password   => $pass,
  }

  file { "/home/${name}":
    ensure  => directory,
    mode    => 0700,
    owner   => $name,
    group   => $group,
    require => User[$name],
    recurse => false,
  }
}


class users::util{}
