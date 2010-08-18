class ssh {
    class deploy {
        $sshd_package_list = ["openssh", "openssh-clients", "openssh-server"]
        package { $sshd_package_list: ensure => installed }

        service { "sshd":
                ensure => "running",
                enable      => "true",
                hasrestart  => "true",
                hasstatus  => "true",
                require => Package[$sshd_package_list],
        }
    }

    define config ($listenaddress="0.0.0.0",$ssh_protocol,$sshd_port,$root_login,$password_auth) {
        
        file { "/etc/ssh/sshd_config":
            path    => "/etc/ssh/sshd_config",
            owner   => root,
            group   => root,
            mode    => 600,
            content => template("sshdconfig/sshd_config.erb"),
            notify  => Service[sshd],
        }
    }
}
