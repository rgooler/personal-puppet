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

  file { '/home/minecraft/minecraft/bukkit.yml'
    ensure  => file,
    owner   => 'minecraft',
    group   => 'minecraft', 
    mode    => '0600',
    source  => "puppet:///modules/minecraft/home/minecraft/minecraft/bukkit.yml",
  }
  
  file { '/home/minecraft/minecraft/ops.txt'
    ensure  => file,
    owner   => 'minecraft',
    group   => 'minecraft',
    mode    => '0600',
    source  => "puppet:///modules/minecraft/home/minecraft/minecraft/ops.txt",
  }

  file {  '/home/minecraft/minecraft/craftbukkit-beta_1.4.6-RO.3.jar'
    ensure  => file,
    owner   => 'minecraft',
    group   => 'minecraft',
    mode    => '0600',
    source  => "puppet:///modules/minecraft/home/minecraft/minecraft/craftbukkit-beta_1.4.6-RO.3.jar",
  }

  file  {  '/home/minecraft/minecraft/craftbukkit.jar'
    ensure => file,
    owner  => 'minecraft',
    group  => 'minecraft',
    mode   => '0600',
    source => "puppet:///modules/minecraft/home/minecraft/minecraft/craftbukkit.jar",
  }

  file  {  '/home/minecraft/minecraft/minecraft_backups'
    ensure  => 'link',
    target  => '/home/minecraft/minecraft/Dropbox/minecraft_backups',
  } 
  
  }

