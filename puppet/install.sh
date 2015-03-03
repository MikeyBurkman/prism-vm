
INST_DIR=/vagrant/install
if [ ! -d "$INST_DIR" ]; then
	ES_VERSION=1.4.2
	KIBANA_VERSION=3.1.2

	mkdir $INST_DIR

	# Downoad/install ES and Kibana
	mkdir /vagrant/tmp
	cd /vagrant/tmp

	echo "Installing Elasticsearch"
	curl -L -O https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-$ES_VERSION.tar.gz
	tar -xvf elasticsearch-$ES_VERSION.tar.gz

	# Need to add some cors stuff to the ES config so Kibana can reach it
	echo "http.cors.enabled: true" >> elasticsearch-$ES_VERSION/config/elasticsearch.yml
	echo "htt.cors.allow-origin: http://localhost:9201" >> elasticsearch-$ES_VERSION/config/elasticsearch.yml

	mkdir $INST_DIR/elasticsearch
	mv elasticsearch-$ES_VERSION/* $INST_DIR/elasticsearch
	chmod -R a+rw elasticsearch-$ES_VERSION

	echo "Installing Kibana"
	curl -L -O https://download.elasticsearch.org/kibana/kibana/kibana-$KIBANA_VERSION.tar.gz
	tar -xvf kibana-$KIBANA_VERSION.tar.gz

	mkdir $INST_DIR/kibana
	mv kibana-$KIBANA_VERSION/* $INST_DIR/kibana
	chmod -R a+r $INST_DIR/kibana

	cd /vagrant
	rm -rf /vagrant/tmp

	echo "Elasticsearch version $ES_VERSION" > $INST_DIR/versions.txt
	echo "Kibana version $KIBANA_VERSION" >> $INST_DIR/versions.txt

	# Add some useful aliases
	echo "alias prismIndex='node /vagrant/node_modules/prism index'" >> /home/vagrant/.bashrc
	echo "alias prismErase='node /vagrant/node_modules/prism erase'" >> /home/vagrant/.bashrc

	# Add a line to bash rc so that it automatically goes to /vagrant on login
	echo "cd /vagrant" >> /home/vagrant/.bashrc

	# Add the PRISM_HOME environment variable so Prism knows where to find our configs
	echo "PRISM_HOME=\"/vagrant\"" >> /etc/environment

	# For some reason, the latest nodejs package available in Ubuntu is 0.6
	# So instead, just do it the old fashioned way
	echo "Installing NodeJs modules"
	curl -sL https://deb.nodesource.com/setup | sudo bash -
	sudo apt-get install -y nodejs

	# Download a nodejs file server
	npm install -g serve
fi

cd /vagrant
npm install

echo "Elasticsearch, Kibana, and NodeJs set up successfully"