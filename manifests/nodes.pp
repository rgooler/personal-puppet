node 'openmediavault.goolertech.com' inherits nas{
  include 'ejabberd'
}

node default {
  include 'users::users::jippen'
  include 'puppet::scripts'
}
