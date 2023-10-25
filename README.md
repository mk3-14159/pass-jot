# pass-jot
A secure timestamped thought logger 

![The Social Network](https://media.tenor.com/2cKVhhxhPLsAAAAC/the-social-network-watching-movie.gif)

Pass-jot is a minimalistic yet effective way to capture fleeting thoughts. All entries into pass jot are PGP encrypted and secured. Inspired by the way Mark Zuckerberg used live journal in the movie "The Social Network," jot allows users to swiftly log their ideas, appending them with accurate timestamps.

## Installation

1. Download the project 
```bash
git clone https://github.com/mk3-14159/pass-jot.git
```

2. In the project repository
```bash
make install 
```

## Initialize pass-jot

1. To generate a gpg key 
```bash
gpg --gen-key
```

2. initialize a new pass store 
By default, pass-jot will be initialized in ```$HOME/.password-store```
```bash
pass init <pub key>
```

## Usage 
pass-jot retains all of it's functionality from password-manager, you can read the [passwordstore documentation](https://www.passwordstore.org/) for the usage of pass features.
The additional functionality this fork provides is the timestamped log feature, pass-jot help log and securely store your notes and deep thoughts in a pgp encrypted json format.
All logs are treated as a pass secret, which means that all pass commands to update and delete pass jots are valid. 

1. To start a new log or append to an existing log in pass-jot
```bash
pass jot <log_path/log>
```

2. To search for log entries using grep
```bash
pass grep <keyword>
```

3. To edit a an existing log
```bash
pass edit <log_path/log>
```
