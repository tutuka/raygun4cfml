raygun4cfml
===========

Deploy under Components

Raygun.io API client for CFML.

Current Version: 1.1.0 (Jan 2 2016)

Dependencies: 

- Testbox 2 (for running unit and BDD tests only)

## Library organisation

/src contains the source code. The package structure is nz.co.ventego-creative.co.nz.raygun4cfml but the library's components themselves are independent of the package path. Therefore you can use the library in multiple ways:

Put the content of /src into your webroot and instantiate RaygunClient through something like the following:

    raygun = createObject("component","nz.co.ventego-creative.raygun4cfml.RaygunClient").init(
        apiKey = "YOURAPIKEYHERE"
    );

Put the contents of /src into any other place of your choice and create a mapping to /nz in your server administrator or through code and then use the instantiation code as above.

Put the contents of the raygun4cfml into a place of your choice where your CFML has some sort of a mapping pointing towards and and just instantiate RaygunClient like this:

    raygun = createObject("component","RaygunClient").init(
        apiKey = "YOURAPIKEYHERE"
    );
    
/samples contains a set of files that show how the library can be used in your code through a global error handler as well as a contributed example for ColdBox 3.6

/tests contains manual tests as well as a structure (but no tests at this stage) for Testbox unit and BDD tests.

## Getting and Using raygun4cfml

Option 1 (preferred):

Use Commandbox and Forgebox to get the library and then follow the ideas outlined in 'Library organisation' for further setup.

To get the latest from the master repository

    box install raygun4cfml 

To install a specific release or tag: 
    
    box install git://github.com/MindscapeHQ/raygun4cfml.git#{tagname}
    
Example tag names are 1.1.0, 1.0.2.0, 1.0.1.0 etc. Please check the list of tags on Github. Be aware that if you install any tag from before I introduced support for Commandbox and Forgebox there won't be a box.json file and therefore Commandbox will give you a warning as well as there won't be any dependency management for such an installation of the library.
    
Shortcut for the above:
 
    box install MindscapeHQ/raygun4cfml#{tagname}
    
To get the latest from my development repository (be warned, this might contain all sorts of untested code):
  
    box install TheRealAgentK/raygun4cfml

Option 2:

Fork and clone the repo to your local system. Move the src/test directories into places of your choice and suitable for your system and follow the ideas outlined in 'Library organisation'.

Option 3:

Download a zip file containing the current content of the repo or a release/tag of your choice. Unzip the resulting file. Move the src/test directories into places of your choice and suitable for your system and follow the ideas outlined in 'Library organisation'.

####Notes:

(1) Options 2 and 3 will not fulfill any necessary dependencies, you're on your own.

## Versions

See changelog.md for further information.

####Notes:

(1) All releases onwards from 0.5.0.0 will break your code if you've used 0.4 and older before and have used customRequestData. Please continue reading.

(2) If you are using the ACF Administrator setting: "Prefix serialized JSON with..." with anything else but the default prefix of "//", the library will not work.

(3) Version 1.1.0 and newer will not work on Adobe ColdFusion 8 and most likely not on Railo 3 (the latter not tested).


## How to contribute

The main repository of this project is https://github.com/MindscapeHQ/raygun4cfml. Please fork from there, create a local develop branch and merge changes back to your local master branch to submit a pull request. Even better, get in touch with me on Twitter (@AgentK) or here on Github before you undertake any work so that it can be coordinated with what I'm doing.

Most of the active development happens in my own fork: https://github.com/TheRealAgentK/raygun4cfml - feel free to peek around in there.

## License

Copyright 2013-2016 Kai Koenig, Ventego Creative Ltd

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

   http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.







