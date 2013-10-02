class mysql { 
  include 'mysql::install'
  include 'mysql::configuration'
  include 'mysql::services'
  include 'mysql::monitoring'

  Class['mysql::install'] -> Class['mysql::configuration'] -> Class['mysql::services']
}
