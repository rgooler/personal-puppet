class virtualbox { 
  include 'virtualbox::install'
  include 'virtualbox::configuration'
  include 'virtualbox::services'
  include 'virtualbox::monitoring'

  Class['virtualbox::install'] -> Class['virtualbox::configuration'] -> Class['virtualbox::services']
}
