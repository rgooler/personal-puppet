filebucket { main: server => puppet }


Exec {
    path => "/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin",
}

node default {
  include 'common'
  #Broken until I figure out submodules
  #include 'users::users::jippen'
  include 'puppet'
  include 'tools'
}

node /^tvmobili.*/ inherits default {
  include 'tvmobili'
}

node 'NFS' inherits default {
  include 'nginx'
  #include 'rtorrent'
  include 'deluge'
  #include 'icinga'
  #include 'virtualbox'
  #include 'phpvirtualbox'
  #include 'minecraft' # Currently busted
  include 'squid'
}

node 'uk.thisstuffismine.com' inherits default {
  #include 'nginx'
  #include 'nginx::php'
  include 'mysql'
  include 'imagemagick'
  include 'postfix'
  include 'git_server'
}
