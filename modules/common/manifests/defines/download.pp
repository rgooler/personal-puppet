class common::defines::download{}

define download($mirror,$to='/usr/local/src',$flags=''){

    exec{"/usr/bin/wget ${flags} ${mirror}/${name}":
        cwd     => $to,
        creates => "${to}/${name}"
    }
}
