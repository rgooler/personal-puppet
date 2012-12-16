class nginx::repository{ 

  case $::operatingsystem { 
    'ubuntu', 'debian': {
      include 'apt'

      apt::ppa{ 'ppa:nginx/stable': }

    }
  }

}
