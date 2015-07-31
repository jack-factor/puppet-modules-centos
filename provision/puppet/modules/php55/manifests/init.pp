class php55 {

    $packages = [
        "php55w",
        "php55w-cli",
        "php55w-fpm",
        "php55w-mysql",
        "php55w-devel",
        "php55w-gd",
        "php55w-pecl-memcache",
        "php55w-pspell",
        "php55w-snmp",
        "php55w-xmlrpc",
        "php55w-xml",
        "gcc",
        "pcre-devel",
        "make",
    ]
    package
    {
        $packages:
        ensure => latest,
        require => Exec['enable-php55'],
    }

    exec{
        'enable-php55':
            command => "rpm -Uvh  https://mirror.webtatic.com/yum/el6/latest.rpm",
            require => Class['Update'],
            unless => 'rpm -q webtatic-release-6-6.noarch'
    }

    exec{ 'enable_php-fpm':
        command => 'chkconfig php-fpm on',
        require => Package['php55w-fpm'],
    }

    exec{ 'service-fpm':
        command => 'service php-fpm restart',
        require => Exec['enable_php-fpm'],
    }

}
