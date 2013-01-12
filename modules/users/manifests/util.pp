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
    ensure       => directory,
    mode         => 0640,
    owner        => $name,
    group        => $group,
    require      => User[$name],
    recurse      => $recursehome,
    recurselimit => 3,
    purge        => false,
    checksum     => 'mtime',
    ignore       => ['.git'],
    source       => "puppet:///modules/users/${name}",
  }
}


class users::util{}
