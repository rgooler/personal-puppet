class minecraft::services { 

  file { '/etc/init.d/minecraft':
    ensure => file,
    owner  => 'root',
    group  => 'root',
    mode   => '0755',
    source => "puppet:///modules/minecraft/etc/init.d/minecraft",  
  }

}
