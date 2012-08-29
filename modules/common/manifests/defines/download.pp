class common::defines::download{}

define download($mirror,$to='/usr/local/src',$flags=''){

    exec{"wget ${flags} ${mirror}/${name}":
        cwd     => $to,
        creates => "${to}/${name}"
    }
}
