class icinga {

  include 'nginx::php'
  include 'icinga::install'
  include 'icinga::configuration'
  include 'icinga::service'

  Class['nginx'] -> Class['icinga::install']
  Class['icinga::install'] -> Class['icinga::configuration']
  Class['icinga::configuration'] -> Class['icinga::service']
}
