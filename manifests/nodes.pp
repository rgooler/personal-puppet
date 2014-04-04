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
}

node 'uk.thisstuffismine.com' inherits default {
  #include 'nginx'
  #include 'nginx::php'
  include 'mysql'
  include 'imagemagick'
  include 'postfix'
  include 'git_server'
}
