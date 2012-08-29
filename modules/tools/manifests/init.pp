class tools {

  package { 
    'screen':     ensure => present;
    'tree':       ensure => present;
    'htop':       ensure => present;
    'vim':        ensure => present;
    'python-pip': ensure => present;
  }

}
