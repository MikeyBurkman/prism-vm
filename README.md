# csv-analyze-es
A VM created with Vagrant/VirtualBox that provides Elasticsearch and Kibana instances, as well as a NodeJs application for parsing CSV files and inserting them into ES. 

## Preparation

### Required Installations
 * This is a self-contained VM, and requires you only to install Vagrant and Oracle VirtualBox on your machine. It should be platform independent. (Probably needs more testing to really claim this.)
 * If running on Windows, make sure both Vagrant and VirtualBox on your PATH, along with an SSH client. Git has an SSH client, so just make sure Git is on your PATH and you're good there.

### Prepare the Data
 1. Find a cool CSV file. It is expected that the headers for each column are listed at the top of the file.
 2. Drop your csv file in the ./data directory. (Actually it doesn't matter where it is, but nice to keep things organized.)
 3. Edit spec.js to point to this file. Follow the instructions in spec.js to figure out what else should go in there.
   - If you have multiple CSV files to analyze, create a new spec.js for each one. The indexer will automatically look for a file named `config.js` in the root folder, but you can override that with any other name.
   - Remember that spec.js is an ordinary NodeJs module. You can require external modules, and write any JS code you need, and the module just has to export the correct spec object. Just don't do anything too crazy.

### Starting the VM and ES/Kibana Servers
 1. Calling `vagrant up` will start the server. If this is your first time, it will take a few minutes to create the VM, install Elasticsearch (ES), Kibana, and NodeJs modules. These will be placed in the ./install directory.
 2. SSH into the VM by calling `vagrant ssh`. Now you're running commands from inside the VM.
 3. Start the ES and Kibana servers by calling `./bin/server.sh`. They will run in the background until you shut down the VM, so just Ctrl+C after it starts displaying some data.

## Do some real work!

### Indexing a CSV File
 1. Simply call `./prism index` to create the ES index and start reading/indexing the CSV file given in config.js
   - If your config is declared in a different file, add that to the end of the call. IE: `./prism index myConfig.js`
 2. That should do it! If your CSV file is large, it may take several minutes (or more) to complete!
 - Remember that if you index the same CSV file multiple times without clearing the index (below), you'll get duplicate data!

### Clearing an Index
 1. If you want to get rid of an index (this what the CSV file was converted into), then call `./prism clear`.
   - Just like when indexing, you can specify other spec files. IE: `./prism clear myConfig.js`

### Clearing and Re-Indexing
 - If experimenting with a CSV or spec file, it may be nice to clear and re-index in one step.
 - Use the `-c` or `--clear` argument when calling index to do just this. IE: `./prism index -c` or `./prism index --clear`

### Help!
 - Adding `--help` as an argument to any of the above calls will spit out some help. IE: `./prism --help` or `./prism index --help`

## See Some Cool Stuff!
 1. Navigate to `http://localhost:9201` in your browser (not in the VM) to bring up Kibana.
 2. Go read some documentation or blogs on Kibana. I'm not an expert at it by any stretch of the imagination.

## Finishing Up
 1. Exit out of SSH by calling `exit`
 2. If you wish to shutdown the VM, call `vagrant halt`. This will shutdown the ES and Kibana servers, but your indexed data will stick around unless you manually delete it or the ./install directory.
 3. Calling `vagrant up` again will restart your VM.
