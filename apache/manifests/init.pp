class apache {
    class deploy {
        # ensure that all packages are installed.
        $packagelist = ["httpd"]
        package { $packagelist:
            ensure => "installed"
        }

        # ensure services are running.
        service { "httpd":
        enable      => "true",
	ensure      => "running",
	hasrestart  => "true",
 	hasstatus   => "true",
        require     => Package["httpd"]
        }
    }

    class config {
        file { "/etc/httpd/conf/httpd.conf":
            owner   => "root",
            group   => "root",
            mode    => 644,
            content => template("apache/httpd.erb"),
            notify  => Service["httpd"]
        }
    }

    define virtual_host ($server_name, $server_alias, $server_admin, $document_root, $ensure = "enabled") {
        file { "/etc/httpd/conf.d/$server_name.conf":
            ensure => $ensure ? {
                enabled => present,
                disabled => absent },
            content => template("apache/virtual_host.erb"),
            notify => Service["httpd"]
        }
    }
}
