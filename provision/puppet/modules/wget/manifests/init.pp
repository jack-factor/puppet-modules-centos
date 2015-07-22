class wget {
    package { 'wget':
        ensure => installed,
        require => Class['Update'],
    }
}
