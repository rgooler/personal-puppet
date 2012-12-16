class nginx::defines {

    include nginx::defines::site
    include nginx::defines::enable
    include nginx::defines::disable
    include nginx::defines::redirect
}
