import 'templates'
import 'nodes'

filebucket { main: server => puppet }


Exec {
    path => "/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin",
}

