class common::defines::extract {}

define extract($path='/usr/local/src',$creates='') {
    # Extract the compressed file $name in folder $path
    # Currently only supports .tar.gz,.tar.bz2, and .zip
    #
    # NOTE: It assumes it creates a file/folder of the archive's basename
    # If this is not true, set $creates to the full path of a file that is
    # extracted by this define!
    #
    # Usage:
    #   extract{ "smokeping-2.6.2.tar.gz":
    #         path => '/usr/local/src',
    #         require => Download["smokeping-2.6.2.tar.gz"],
    #   }

    $matchstr = "(.*).(tar.(gz|bz2)|zip)"
    $extension = regsubst($name, $matchstr,'\2','G')
    $basename  = regsubst($name, $matchstr,'\1','G')

    if $creates == ''{
        $f = "${path}/${basename}"
    } else {
        $f = $creates
    }

    case $extension{
        'tar.bz2':{
            exec{"tar -xjf ${name}":
                cwd     => $path,
                creates => $f,
            }
        }
        'tar.gz':{
            exec{"tar -xzf ${name}":
                cwd     => $path,
                creates => $f,
            }
        }
        'tar':{
            exec{"tar -xf ${name}":
                cwd     => $path,
                creates => $f,
            }
        }
        'zip':{
            exec{"unzip ${name}":
                cwd     => $path,
                creates => $f,
            }
        }
        default: {
            err("Extension ${extension} not supported by extract define")
        }
    }
}
