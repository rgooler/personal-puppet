class minecraft::services { 

  file { '/etc/init.d/minecraft':
    ensure => file,
    owner  => 'root',
    group  => 'root',
    mode   => '0755',
    source => "puppet:///modules/minecraft/etc/init.d/minecraft",  
  }

  file { '/home/minecraft/minecraft/minecraft.sh'
    ensure  => file,
    owner   => 'minecraft',
    group   => 'minecraft',
    mode    => '0711',
    source  => "puppet:///modules/minecraft/home/minecraft/minecraft/minecraft.sh",
  }

  file { 'home/minecraft/minecraft/bukkit.yml'
    ensure  => file,
    owner   => 'minecraft',
    group   => 'minecraft', 
    mode    => '0600',
    source  => "puppet:///modules/minecraft/home/minecraft/minecraft/bukkit.yml",
  }
    
}



