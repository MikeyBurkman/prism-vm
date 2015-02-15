
# Java required for Elasticsearch
package { 'openjdk-7-jre':
  ensure => latest
}

# Curl required to download Elasticsearch and Kibana tarballs
package { 'curl':
  ensure => latest
}
