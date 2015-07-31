class mysql
{
    $mysqlPassword = '123456'

    package { 'mysql-server':
        ensure => installed,
        require => Class['Update'],
    }
    
    service { 'mysqld':
        enable => true,
        ensure => running,
        require => Package['mysql-server'],
    }

    exec { 'set-mysql-password':
        onlyif => 'mysqladmin -uroot -pvagrant status',
        command => 'mysqladmin -uroot -pvagrant password $mysqlPassword',
        require => Service['mysqld'],
    
    }

    exec { 'enable-mysql':
        command => 'chkconfig mysqld on',
        require => Service['mysqld'],
    }

}
