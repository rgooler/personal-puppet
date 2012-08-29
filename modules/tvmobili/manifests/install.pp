class tvmobili::install {

  download { 'tvmobili-all-universal.deb':
    mirror => 'http://www.tvmobili.com/binaries/stable',
    to     => '/opt',
  }

  dpkg_install { '/opt/tvmobili-all-universal.deb': 
    require => Download['tvmobili-all-universal.deb'],
  }

}
