class nfs { 
  include 'nfs::install'
  include 'nfs::configuration'
  include 'nfs::services'
  include 'nfs::monitoring'

  Class['nfs::install'] -> Class['nfs::configuration'] -> Class['nfs::services']
}
