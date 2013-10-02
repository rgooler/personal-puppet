class mysql::install { 

  package { 'mysql-server':
    ensure => '5.5.32-0ubuntu0.12.04.1',
  }

  package { 'mysql-client':
    ensure => '5.5.32-0ubuntu0.12.04.1',
  }

}
