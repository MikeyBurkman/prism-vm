# prism-vm
A VM created with Vagrant/VirtualBox that provides Elasticsearch and Kibana instances, as well as a NodeJs application [Prism](https://github.com/MikeyBurkman/prism) for parsing CSV or JSON files and inserting them into ES. 

## Preparation

### Required Installations
 * This is a self-contained VM, and requires you only to install Vagrant and Oracle VirtualBox on your machine. It should be platform independent. (Probably needs more testing to really claim this.)
 * If running on Windows, make sure both Vagrant and VirtualBox on your PATH, along with an SSH client. Git has an SSH client, so just make sure Git is on your PATH and you're good there.

### Prepare the Data
 1. Find a cool CSV or JSON file. For CSV files, it is expected that the headers for each column are listed at the top of the file. JSON files need to be line-delimited objects. See the Prism documentation for more details.
 2. Edit config.js to point to this file. Follow the instructions in config.js (and the Prism docs) to figure out what else should go in there.
   - If you have multiple files to analyze, create a new config.js for each one. Prism will look for a file named `config.js` in the root folder by default, but you can override that with any other name when you go to run it.
   - Remember that config.js is an ordinary NodeJs module. You can require external modules, and write any JS code you need, and the module just has to export the correct config object. Just don't do anything too crazy.

### Starting the VM and ES/Kibana Servers
 1. Calling `vagrant up` will start the server. If this is your first time, it will take a few minutes (or more) to create the VM, install Elasticsearch (ES), Kibana, and NodeJs modules. These will be placed in the ./install and node_modules directories.
 2. SSH into the VM by calling `vagrant ssh`. Now you're running commands from inside the VM.
 3. Start the ES and Kibana servers by calling `./bin/server.sh`. They will run in the background until you shut down the VM, so just Ctrl+C after it's stopped printing stuff out.

## Do some real work!

### Indexing a CSV/JSON File
 1. Simply call `./prism index` to create the ES index and start reading/indexing the CSV file given in config.js
   - If your config is declared in a different file, add that to the end of the call. IE: `./prism index myConfig.js`
 2. That should do it! If your file is large, it may take a while to complete!
 - Remember that if you index the same file multiple times without clearing the index (below), you'll get duplicate data!

### Clearing an Index
 1. If you want to get rid of an index in ES (this what the file was converted into), then call `./prism clear`.
   - Just like when indexing, you can specify other config files. IE: `./prism clear myConfig.js`

### Clearing and Re-Indexing
 - If experimenting with a CSV/JSON or config file, it may be nice to clear and re-index in one step.
 - Use the `-c` or `--clear` argument when calling index to do this. IE: `./prism index -c` or `./prism index --clear`

### Help!
 - Adding `--help` as an argument to any of the above calls will spit out some help. IE: `./prism --help` or `./prism index --help`

## See Some Cool Stuff!
 1. Navigate to `http://localhost:9201` in your browser (not in the VM) to bring up Kibana.
 2. Go read some documentation or blogs on Kibana. I'm not an expert at it by any stretch of the imagination.
 3. The Elasticsearch REST API is accessible from  `http://localhost:9200` in case you need more than what Kibana offers.

## Finishing Up
 1. Exit out of SSH by calling `exit`
 2. If you wish to shutdown the VM, call `vagrant halt`. This will shutdown the ES and Kibana servers, but your indexed data will stick around unless you manually delete it or the `./install` directory.
 3. Calling `vagrant up` again will restart your VM. (It shouldn't need to install anything this time, so it'll be much quicker.)
