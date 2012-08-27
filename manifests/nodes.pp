node default {
  include 'common'
  include 'users::users::jippen'
  include 'puppet'
}

node /^tvmobili.*/ inherits default {
  include 'tvmobili'
}
