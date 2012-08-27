class common::defines::download{}

define download($mirror,$to='/usr/local/src',$flags=''){
    #Download a file from somewhere on the internet.
    #Usage:
    #  download { "threatmetrix.png":
        #    mirror => "https://threatmetrix.com/wp-content/themes/threat/images",
        #    to     => '/var/www/html/images',
        #  }

    exec{"wget ${flags} ${mirror}/${name}":
        cwd     => $to,
        creates => "${to}/${name}"
    }
}
