class squid-adblock { 
  include 'squid-adblock::install'
  include 'squid-adblock::configuration'
  include 'squid-adblock::services'
  include 'squid-adblock::monitoring'

  Class['squid-adblock::install'] -> Class['squid-adblock::configuration'] -> Class['squid-adblock::services']
}
