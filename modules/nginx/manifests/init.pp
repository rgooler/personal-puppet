class nginx { 
  include 'nginx::install'
  include 'nginx::configuration'
  include 'nginx::services'
  include 'nginx::monitoring'

  Class['nginx::install'] -> Class['nginx::configuration'] -> Class['nginx::services']
}
