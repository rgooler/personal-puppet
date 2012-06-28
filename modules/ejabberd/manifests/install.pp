class ejabberd::install {
  $packagelist = ['ejabberd', 'erlang', 'erlang-tools']

  package { $packagelist:
    ensure => present,
  }
}
