class deluge { 
  include 'deluge::install'
  include 'deluge::configuration'
  include 'deluge::services'
  include 'deluge::monitoring'
  include 'deluge::user'

  Class['deluge::repo'] -> Class['deluge::install']
  Class['deluge::user'] -> Class['deluge::install']
  Class['deluge::install'] -> Class['deluge::configuration'] -> Class['deluge::services']
}
