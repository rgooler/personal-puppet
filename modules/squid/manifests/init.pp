class squid { 
  include 'squid::install'
  include 'squid::configuration'
  include 'squid::services'
  include 'squid::monitoring'

  Class['squid::install'] -> Class['squid::configuration'] -> Class['squid::services']
}
