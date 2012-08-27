class common::defines::make {}

define make($path='/usr/local/src',$creates='',$target='',$program='',$refreshonly=undef) {
    # Run thorough the compile step to build a program from source.
    #
    # Usage:
    #   make { "smokeping-2.6.2":
    #         require => Configure["smokeping-2.6.2"],
    #   }
    #   make { "smokeping-2.6.2-install":
    #         program => "smokeping-2.6.2",
    #         target  => 'install',
    #         require => Configure["smokeping-2.6.2"],
    #   }

    if $program == ''{
        $p = $name
    } else {
        $p = $program
    }

    #if $creates == ''{
    #    $f = "${path}/${p}/Makefile"
    #} else {
    #    $f = $creates
    #}
    
    exec { "make ${target}":
      cwd         => "${path}/${p}",
      refreshonly => $refreshonly,
    #  creates => $f,
    }

}
