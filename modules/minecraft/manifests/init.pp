class minecraft { 
  include 'minecraft::install'
  include 'minecraft::configuration'
  include 'minecraft::services'
  include 'minecraft::monitoring'

  Class['minecraft::install'] -> Class['minecraft::configuration'] -> Class['minecraft::services']
}
