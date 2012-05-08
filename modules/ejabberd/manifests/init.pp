class ejabberd {
  $packagelist = ['ejabberd', 'erlang', 'erlang-tools']

  package { $packagelist:
    ensure => present,
  }
}
