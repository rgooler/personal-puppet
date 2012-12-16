class phpvirtualbox { 
  include 'phpvirtualbox::install'
  include 'phpvirtualbox::configuration'
  include 'phpvirtualbox::services'
  include 'phpvirtualbox::monitoring'

  Class['phpvirtualbox::install'] -> Class['phpvirtualbox::configuration'] -> Class['phpvirtualbox::services']
}
