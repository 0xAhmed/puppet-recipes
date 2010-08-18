class dhcp {
    class deploy {
        # ensure that all packages are installed.
        $packagelist = ["dhcp" , "dhclient"]
        package { $packagelist:
            ensure => "installed"
        }

	# ensure services are running.
        service { "dhcpd":
        enable      => "true",
        ensure      => "running",
        hasrestart  => "true",
        hasstatus   => "true",
        require     => Package["dhcp"]
        }
    }

    define dhcp_def ($lease_time, $subnet_mask, $dns, $domain_name, $range, $router, $network_ip) {
        file { "/etc/dhcpd.conf":
		owner => "root",
		group => "root",
		mode  => 644,
                content => template("dhcp/dhcpd.conf.erb"),
                notify  => Service["dhcpd"]
        }
    }

}   


