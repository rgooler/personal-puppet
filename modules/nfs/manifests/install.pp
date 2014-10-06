class nfs::install { 
  file { '/media/NAS/jippen':
    ensure => directory,
  }
  
  file { '/media/NAS/jippen/torrents':
    ensure  => directory,
    require => File['/media/NAS/jippen'], 
  }

}
