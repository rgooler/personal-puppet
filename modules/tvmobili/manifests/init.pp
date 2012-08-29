class tvmobili {

  include 'tvmobili::users'
  include 'tvmobili::install'
  include 'tvmobili::configuration'
  include 'tvmobili::service'

  Class['tvmobili::install'] -> Class['tvmobili::configuration']
  Class['tvmobili::configuration'] -> Class['tvmobili::service']
}
