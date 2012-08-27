class common::defines::configure {}

define configure($path='/usr/local/src',$creates='',$flags='') {
    # Run thorough the compile step to build a program from source.
    #
    # Usage:
    #   configure { "smokeping-2.6.2":
    #         flags   => '--with-lib-dir=/usr/lib',
    #         require => Extract["smokeping-2.6.2.tar.gz"],
    #   }

    if $creates == ''{
        $f = "${path}/${name}/Makefile"
    } else {
        $f = $creates
    }
    
    exec { "${path}/${name}/configure ${flags}":
      cwd     => "${path}/${name}",
      creates => $f,
    }

}
