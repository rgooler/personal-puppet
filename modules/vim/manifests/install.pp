class vim::install{
  package{'vim':
    ensure => present,
  }

  package{'vim-addon-manager':
    ensure => present,
    require => Package['vim'],
  }

  package{'vim-puppet':
    ensure  => present,
    require => Package['vim-addon-manager'],
  }

  exec{'/usr/bin/vim-addons -w install puppet':
    creates => '/var/lib/vim/addons/syntax/puppet.vim',
  }

}
