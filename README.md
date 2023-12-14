<div align="center">

# pass-jot

A secure timestamped thought logger 

![The Social Network](https://media.tenor.com/2cKVhhxhPLsAAAAC/the-social-network-watching-movie.gif)

[![State-of-the-art Shitcode](https://img.shields.io/static/v1?label=State-of-the-art&message=Shitcode&color=7B5804)](https://github.com/trekhleb/state-of-the-art-shitcode)

Pass-jot is a minimalistic and secure way to capture fleeting thoughts. All entries into pass jot are GPG encrypted and secured. Inspired by the way Mark Zuckerberg used live journal in the movie "The Social Network," jot allows users to swiftly log their ideas, appending them with accurate timestamps.
</div>

## Installation

1. Download the project 
```bash
git clone https://github.com/mk3-14159/pass-jot.git
```

2. In the project repository
```bash
make install 
```

## Dependencies
To run this project, you will need to have the following software and libraries installed on your system:

1. [git](https://git-scm.com/downloads) - a distributed version control system
2. [jq](https://github.com/jqlang/jq) - a lightweight and flexible command-line JSON processor
3. [tree](https://www.linuxfromscratch.org/blfs/view/svn/general/tree.html) - a command-line utility that generates a hierarchical directory tree view

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

```bash
pass log <log_path/log>
```

2. To search for log entries using grep
```bash
pass grep <keyword>
```

3. To edit a an existing log
```bash
pass edit <log_path/log>
```
