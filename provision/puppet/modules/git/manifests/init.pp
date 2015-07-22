class git {
    package{ 'git':
        ensure => installed,
        require => Class['Update'],
    }
}
