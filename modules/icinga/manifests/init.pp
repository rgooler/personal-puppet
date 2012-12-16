class icinga {

  include 'icinga::install'
  include 'icinga::configuration'
  include 'icinga::service'

  Class['icinga::install'] -> Class['icinga::configuration']
  Class['icinga::configuration'] -> Class['icinga::service']
}
