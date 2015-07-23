class nginx
{
    package { 'nginx':
        ensure => installed,
        require => Class['Update'],
    }

    service { 'nginx':
        enable => true,
        ensure => running,
        require => Package['nginx'],
    }

    exec { 'enable_nginx':
        command => 'chkconfig nginx on',
        require => Service['nginx'],
    }

    file { '/etc/nginx/sites-enabled':
        ensure => 'directory',
    }

    file { '/etc/nginx/sites-available':
        ensure => 'directory',
    }

}
