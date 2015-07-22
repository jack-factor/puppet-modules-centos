class epel {
    package { 'epel-release':
        ensure => installed,
        require => Class['Update'],
    }
}
