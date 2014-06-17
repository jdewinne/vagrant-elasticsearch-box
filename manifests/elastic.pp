# Install Elastic Search

class elastic {
    include apt

    apt::key { 'elastic':
        key => 'D50582E7',
        key_source => 'http://packages.elasticsearch.org/GPG-KEY-elasticsearch',
    }

    
    apt::source { 'elasticsearch':
      location   => 'http://packages.elasticsearch.org/elasticsearch/1.2/debian',
      key        => 'D50582E7',
      release    => 'stable',
      repos      => 'main',
      key_server => 'pgp.mit.edu',
      include_src => false,
      require => Apt::Key['elastic']
    }

    package {
      'elasticsearch':
        ensure  => installed,
        require => Apt::Source['elasticsearch'],
    }

    package {
      'openjdk-7-jdk':
        ensure  => installed,
        require => Apt::Source['elasticsearch'],
    }

    

    service {
      'elasticsearch':
        ensure  => running,
        enable  => true,
        require => [Package['elasticsearch'],Package['openjdk-7-jdk']]
    }

}

include elastic
