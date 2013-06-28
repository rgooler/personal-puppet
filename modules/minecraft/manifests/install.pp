class minecraft::install { 

  file {  '/home/minecraft/minecraft/plugins':
    ensure => directory,
    owner  => 'minecraft',
    group  => 'minecraft',
    mode   => '0600',
    source => "puppet:///modules/minecraft/home/minecraft/minecraft/plugins",
  }

  file  {  '/home/minecraft/minecraft/minecraft.sh':
    ensure  => file,
    owner   => 'minecraft',
    group   => 'minecraft',
    mode    => '0711',
    source  => "puppet:///modules/minecraft/home/minecraft/minecraft/minecraft.sh",
  }

  file { '/home/minecraft/minecraft/bukkit.yml':
    ensure  => file,
    owner   => 'minecraft',
    group   => 'minecraft',
    mode    => '0600',
    source  => "puppet:///modules/minecraft/home/minecraft/minecraft/bukkit.yml",
  }

  file { '/home/minecraft/minecraft/ops.txt':
    ensure  => file,
    owner   => 'minecraft',
    group   => 'minecraft',
    mode    => '0600',
    source  => "puppet:///modules/minecraft/home/minecraft/minecraft/ops.txt",
  }

  file {  '/home/minecraft/minecraft/craftbukkit-beta_1.4.6-RO.3.jar':
    ensure  => file,
    owner   => 'minecraft',
    group   => 'minecraft',
    mode    => '0600',
    source  => "puppet:///modules/minecraft/home/minecraft/minecraft/craftbukkit-beta_1.4.6-RO.3.jar",
  }

  file  {  '/home/minecraft/minecraft/craftbukkit.jar':
    ensure => file,
    owner  => 'minecraft',
    group  => 'minecraft',
    mode   => '0600',
    source => "puppet:///modules/minecraft/home/minecraft/minecraft/craftbukkit.jar",
  }

  file  {  '/home/minecraft/minecraft/minecraft_backups':
    ensure  => 'link',
    target  => '/home/minecraft/minecraft/Dropbox/minecraft_backups',
  }

  file {  '/home/minecraft/minecraft/plugins/DeathBukkit':
    ensure  => directory,
    owner   => 'minecraft',
    group   => 'minecraft',
    mode    => '0711',
    require => File["home/minecraft/minecraft/plugins"],
    source => "puppet:///modules/minecraft/home/minecraft/minecraft/plugins/DeathBukkit",
  }

  file {  '/home/minecraft/minecraft/plugins/DeathBukkit/config.yml':
    ensure  => 'file',
    owner   => 'minecraft',
    group   => 'minecraft',
    mode    => '0600',
    require => File["/home/minecraft/minecraft/plugins/DeathBukkit"],
    source  => "puppet:///modules/minecraft/home/minecraft/minecraft/plugins/DeathBukkit/config.yml",
  }

 file {  '/home/minecraft/minecraft/plugins/deathbukkit-0.2.1.jar':
    ensure  => file,
    owner   => 'minecraft',
    group   => 'minecraft',
    mode    => '0600',
    require => File["/home/minecraft/minecraft/plugins"],
    source  => "puppet:///modules/minecraft/home/minecraft/minecraft/plugins/deathbukkit-0.2.1.jar",
  }

  file {  '/home/minecraft/minecraft/plugins/iZone':
     ensure  => directory,
     owner   => 'minecraft',
     group   => 'minecraft',
     mode    => '0700',
     require => File["/home/minecraft/minecraft/plugins"],
     source  => "puppet:///modules/minecraft/home/minecraft/minecraft/plugins/iZone",
  }

  file {  '/home/minecraft/minecraft/plugins/iZone/config.yml':
     ensure  => file,
     owner   => 'minecraft',
     group   => 'minecraft',
     mode    => '0600',
     require => File["/home/minecraft/minecraft/plugins/iZone"],
     source  => "puppet:///modules/minecraft/minecraft/home/minecraft/minecraft/plugins/iZone/confg.yml",
  }

  file {  '/home/minecraft/minecraft/plugins/iZone/saves':
    ensure  => directory,
    owner   => 'minecraft',
    group   => 'minecraft',
    mode    => '0700',
    require => File["/home/minecraft/minecraft/plugins/iZone"],
    source  => "puppet:///modules/minecraft/minecraft/home/minecraft/minecraft/plugins/iZone/saves",
  }

  file {  '/home/minecraft/minecraft/plugins/iZone/saves/field.yml':
    ensure  => file,
    owner   => 'minecraft',
    group   => 'minecraft',
    mode    => '0600',
    require => File["/home/minecraft/minecraft/plugins/iZone/saves"],
    source  => "puppet:///modules/minecraft/minecraft/home/minecraft/minecraft/plugins/iZone/saves/field.yml",
  }

  file {  '/home/minecraft/minecraft/plugins/iZone/saves/GlassTower.yml':
    ensure  => file,
    owner   => 'minecraft',
    group   => 'minecraft',
    mode    => '0600',
    require => File["/home/minecraft/minecraft/plugins/iZone/saves"],
    source  => "puppet:///modules/minecraft/minecraft/home/minecraft/minecraft/plugins/iZone/saves/GlassTower.yml",
  }
 file {  '/home/minecraft/minecraft/plugins/iZone/saves/GuardTower.yml':
    ensure  => file,
    owner   => 'minecraft',
    group   => 'minecraft',
    mode    => '0600',
    require => File["/home/minecraft/minecraft/plugins/iZone/saves"],
    source  => "puppet:///modules/minecraft/minecraft/home/minecraft/minecraft/plugins/iZone/saves/GuardTower.yml",
  }

  file {  '/home/minecraft/minecraft/plugins/iZone/saves/JungleHouse.yml':
    ensure  => file,
    owner   => 'minecraft',
    group   => 'minecraft',
    mode    => '0600',
    require => File["/home/minecraft/minecraft/plugins/iZone/saves"],
    source  => "puppet:///modules/minecraft/minecraft/home/minecraft/minecraft/plugins/iZone/saves/JungleHouse.yml",
  }
  
  file {  '/home/minecraft/minecraft/plugins/iZone/saves/MineShack.yml':
    ensure  => file,
    owner   => 'minecraft',
    group   => 'minecraft',
    mode    => '0600',
    require => File["/home/minecraft/minecraft/plugins/iZone/saves"],
    source  => "puppet:///modules/minecraft/minecraft/home/minecraft/minecraft/plugins/iZone/saves/MineShack.yml",
  }

  file {  '/home/minecraft/minecraft/plugins/iZone/saves/Paddock.yml':
    ensure  => file,
    owner   => 'minecraft',
    group   => 'minecraft',
    mode    => '0600',
    require => File["/home/minecraft/minecraft/plugins/iZone/saves"],
    source  => "puppet:///modules/minecraft/minecraft/home/minecraft/minecraft/plugins/iZone/saves/Paddock.yml",
  }

  file {  '/home/minecraft/minecraft/plugins/iZone/saves/SafeHouse.yml':
    ensure  => file,
    owner   => 'minecraft',
    group   => 'minecraft',
    mode    => '0600',
    require => File["/home/minecraft/minecraft/plugins/iZone/saves"],
    source  => "puppet:///modules/minecraft/minecraft/home/minecraft/minecraft/plugins/iZone/saves/SafeHouse.yml",
  }

  file {  '/home/minecraft/minecraft/plugins/iZone/saves/SnowBunker.yml':
    ensure  => file,
    owner   => 'minecraft',
    group   => 'minecraft',
    mode    => '0600',
    require => File["/home/minecraft/minecraft/plugins/iZone/saves"],
    source  => "puppet:///modules/minecraft/minecraft/home/minecraft/minecraft/plugins/iZone/saves/SnowBunker.yml",
  }

file {  '/home/minecraft/minecraft/plugins/iZone/saves/TreeFarm.yml':
    ensure  => file,
    owner   => 'minecraft',
    group   => 'minecraft',
    mode    => '0600',
    require => File["/home/minecraft/minecraft/plugins/iZone/saves"],
    source  => "puppet:///modules/minecraft/minecraft/home/minecraft/minecraft/plugins/iZone/saves/TreeFarm.yml",
  }

  file {  '/home/minecraft/minecraft/plugins/iZone/saves/VillageHouse.yml':
    ensure  => file,
    owner   => 'minecraft',
    group   => 'minecraft',
    mode    => '0600',
    require => File["/home/minecraft/minecraft/plugins/iZone/saves"],
    source  => "puppet:///modules/minecraft/minecraft/home/minecraft/minecraft/plugins/iZone/saves/VillageHouse.yml",
 }

  file {  '/home/minecraft/minecraft/plugins/iZone/vault.yml':
    ensure  => file,
    owner   => 'minecraft',
    group   => 'minecraft',
    mode    => '0600',
    require => File["/home/minecraft/minecraft/plugins/iZone"],
    source  => "puppet:///modules/minecraft/minecraft/home/minecraft/minecraft/plugins/iZone/vault.yml",
  }

  file {  '/home/minecraft/minecraft/plugins/iZone.jar':
    ensure  => file,
    owner   => 'minecraft',
    group   => 'minecraft',
    mode    => '0700',
    require => File["/home/minecraft/minecraft/plugins"],
    source  => "puppet:///modules/minecraft/minecraft/home/minecraft/minecraft/plugins/iZone.jar",
  }

  file {  '/home/minecraft/minecraft/plugins/MobPlates':
    ensure  => directory,
    owner   => 'minecraft',
    group   => 'minecrarft',
    mode    => '0711', 
    require => File["/home/minecraft/minecraft/plugins"],
    source  => "puppet:///modules/minecraft/minecraft/home/minecraft/minecraft/plugins/MobPlates",
  }

  file {  '/home/minecraft/minecraft/plugins/MobPlates/config.yml':
    ensure  => file,
    owner   => 'minecraft',
    group   => 'minecraft',
    mode    => '0600',
    require => File["/home/minecraft/minecraft/plugins/MobPlates"],
    source  => "puppet:///modules/minecraft/minecraft/home/minecraft/minecraft/plugins/MobPlates/confg.yml",
  }

  file {  '/home/minecraft/minecraft/plugins/MobPlates/MobPlates.jar':
    ensure  => file,
    owner   => 'minecraft',
    group   => 'minecraft',
    mode    => '0600',
    require => File["/home/minecraft/minecraft/plugins/MobPlates"],
    source  => "puppet:///modules/minecraft/minecraft/home/minecraft/minecraft/plugins/MobPlates.jar",
  }

  file {  '/home/minecraft/minecraft/plugins/PluginMetrics':
    ensure  => directory,
    owner   => 'minecraft',
    group   => 'minecraft',
    mode    => '0711',
    require => File["/home/minecraft/minecraft/plugins"],
    source  => "puppet:///modules/minecraft/minecraft/home/minecraft/minecraft/plugins/PluginMetrics",
  }

  file {  '/home/minecraft/minecraft/plugins/PluginMetrics/config.yml':
    ensure  => file,
    owner   => 'minecraft',
    group   => 'minecraft',
    mode    => '0600', 
    require => File["/home/minecraft/minecraft/plugins/PluginMetreics"],
    source  => "puppet:///modules/minecraft/minecraft/home/minecraft/minecraft/plugins/PluginMetrics/config.yml",
  }

  file {  '/home/minecraft/minecraft/plugins/Vault.jar':
    ensure  => file,
    owner   => 'minecraft', 
    group   => 'minecraft',
    mode    => '0600', 
    require => File["/home/minecraft/minecraft/plugins"],
    source  => "puppet:///modules/minecraft/minecraft/home/minecraft/minecraft/plugins/Vault.jar",
  }

}

