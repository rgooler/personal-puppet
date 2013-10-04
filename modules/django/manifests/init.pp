class django { 
  include 'django::install'
  include 'django::configuration'
  include 'django::services'
  include 'django::monitoring'

  Class['django::install'] -> Class['django::configuration'] -> Class['django::services']
}
