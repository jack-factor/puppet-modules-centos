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

    file { '/etc/nginx/nginx.conf':
        ensure => file,
        source => '/var/www/centos/resources/nginx/nginx',
    }

    file { '/etc/nginx/sites-available/local.centos.conf':
        ensure => file,
        source => '/var/www/centos/resources/nginx/vhost',
    }

    file { 'local.centos.conf':
        ensure => link,
        path => '/etc/nginx/sites-enabled/local.centos.conf',
        target => '/etc/nginx/sites-available/local.centos.conf',
        require => File['/etc/nginx/sites-available/local.centos.conf'],
        notify => Exec['restart'],
    }

    exec { 'restart':
        command => 'service nginx restart',
    }
}
