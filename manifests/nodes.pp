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
  #include 'nginx'
  #include 'icinga'
  #include 'virtualbox'
  #include 'phpvirtualbox'
}
