define user_acct($fullname, $uid, $groups=[], $recursehome=false){
  group { $name:
    ensure => present,
    gid    => $uid,
  }
  
  user { $name:
    ensure     => present,
    gid        => $name,
    #home       => "/home/${name}",
    #managehome => true,
    shell      => '/bin/bash',
    uid        => $uid,
    require    => Group[$name],
  }

  file { "/home/${name}":
    ensure  => directory,
    mode    => 0700,
    owner   => $name,
    group   => $group,
    require => User[$name],
    recurse => $recursehome,
    source  => "puppet:///modules/users/${name}",
  }
}


class users::util{}
