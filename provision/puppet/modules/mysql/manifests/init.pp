class mysql
{
    $mysqlPassword = '123456'

    package { 'mysql-community-server':
        provider => 'rpm',
        ensure => installed,
        source => '-Uvh http://dev.mysql.com/get/mysql-community-release-el7-5.noarch.rpm',
        require => Class['Update'],
    }
    
    service { 'mysqld':
        enable => true,
        ensure => running,
        require => Package['mysql-community-server'],
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
