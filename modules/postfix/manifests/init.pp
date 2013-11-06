class postfix { 
  include 'postfix::install'
  include 'postfix::configuration'
  include 'postfix::services'
  include 'postfix::monitoring'

  Class['postfix::install'] -> Class['postfix::configuration'] -> Class['postfix::services']
}
