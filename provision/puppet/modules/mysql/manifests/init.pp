class mysql
{
    $mysqlPassword = '123456'

    exec{ 'mysql-rpm':
        command => 'rpm -Uvh https://dev.mysql.com/get/mysql-community-release-el7-5.noarch.rpm',
        unless => 'rpm -q mysql-community-release-el7-5.noarch',
    }

    package { 'mysql-community-server':
        ensure => '5.6.26-2.el7',
        require => Exec['mysql-rpm'],
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
