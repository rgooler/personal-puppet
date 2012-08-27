class puppet::scripts {

  file { '/usr/local/sbin/update_puppet.sh':
    ensure => file,
    mode   => 0750,
    source => 'puppet:///modules/puppet/usr/local/sbin/update_puppet.sh',
  }

}
