node default {
  include 'common'
  include 'users::users::jippen'
  include 'puppet'
  include 'tools'
}

node /^tvmobili.*/ inherits default {
  include 'tvmobili'
}

node 'NFS' inherits default {
  include 'nginx'
  include 'icinga'
}
