class munki_ssl {
	if $::operatingsystem != 'Darwin' {
			fail('The munki_ssl module is only supported on Darwin/OS X')
	}

	file { 'munkitools.pkg':
		path	=>	"/Library/Puppet/munkitools2-latest.pkg",
		ensure	=>	present,
		source	=>	"puppet:///modules/munki_ssl/munkitools2-latest.pkg",
	}
	
	package { 'munkitools2-latest':
		ensure	=>	installed,
		source	=>	"/Library/Puppet/munkitools2-latest.pkg"
	}

	file { ['/Library/Managed Installs', '/Library/Managed Installs/certs/' ]:
		ensure	=>	directory,
		owner	=>	'root',
		group	=>	'wheel',
	}

	file { '/Library/Managed Installs/certs/ca.pem':
		mode   =>	'0640',
		owner  =>	root,
		group  =>	wheel,
		source =>	'/etc/puppet/ssl/certs/ca.pem',
		require =>	File['/Library/Managed Installs/certs/'],
	}
 
	file { '/Library/Managed Installs/certs/clientcert.pem':
		mode   =>	'0640',
		owner  =>	root,
		group  =>	wheel,
		source =>	"/etc/puppet/ssl/certs/${clientcert}.pem",
		require =>	File['/Library/Managed Installs/certs/'],
	}
 
	file { '/Library/Managed Installs/certs/clientkey.pem':
		mode   =>	'0640',
		owner  =>	root,
		group  =>	wheel,
		source =>	"/etc/puppet/ssl/private_keys/${clientcert}.pem",
		require =>	File['/Library/Managed Installs/certs/'],
	}
}