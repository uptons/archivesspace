---
layout: page
title: ArchivesSpace
tagline: Version 0.6.x-dev
---
{% include JB/setup %}


## Overview

ArchivesSpace is a next-generation archives management tool. This page was developed by the Hudson Molonglo development team and only provides information about the development version.

For more information about the ArchivesSpace project, vist [ArchivesSpace.org](http://www.archivesspace.org/about/).  

## Source Code and Documentation
     
Visit the code repository at [https://github.com/archivesspace/archivesspace](https://github.com/archivesspace/archivesspace/).

Read the code and API documentation at [http://archivesspace.github.io/archivesspace/doc](doc/).

The application is divided into 2 parts. The backend application provides a RESTful API to the data layer. The frontend application provides a user interface built on the Rails framework. Both parts rely upon a common toolset for working with JSON representations of ASpace data.

Additional information can be found on the [ArchivesSpace wiki](https://github.com/archivesspace/archivesspace/wiki).
    
## Simple Install

Please see the [ArchivesSpace README](http://archivesspace.github.io/archivesspace/doc/).

## Building it yourself

If you have a burning desire to build the code yourself, you can run a
demo server with the following commands:

     git clone git://github.com/hudmol/archivesspace.git

     cd archivesspace

     build/run dist

This will produce a package called `archivesspace.zip`.  You can run
this by following the instructions in the previous section.

More information about the build system an be found in `build/README.md`.