class ejabberd {

  include 'ejabberd::install'
  include 'ejabberd::configuration'

  Class['ejabberd::install'] -> Class['ejabberd::configuration']
}
