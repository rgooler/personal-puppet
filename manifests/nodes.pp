node default {
  include 'users::users::jippen'
  include 'puppet::scripts'
}

node /^tvmobili/ inherits default {
  include 'tvmobili'
}
