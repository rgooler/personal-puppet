class nginx { 
  include 'nginx::install'
  include 'nginx::defines'
  include 'nginx::repository'
  include 'nginx::configuration'
  include 'nginx::services'
  include 'nginx::monitoring'

  Class['nginx::repository'] -> Class['nginx::install'] -> Class['nginx::configuration'] -> Class['nginx::services']
}
