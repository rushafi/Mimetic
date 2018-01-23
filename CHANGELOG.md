Porting to Xcode: January 23, 2018

* Download mimetic: http://www.codesink.org/download/mimetic-0.9.8.tar.gz
* ./configure (add executable permission if necessary)
* Create Xcode Static Lib project
* Add source files to Xcode project (May recreate the directory structure according to mimetic
* Add header search path to $SRCROOT/Mimetic (or according to your directory structure)
* Defined HAVE_MIMETIC_CONFIG preprocessor flag in libconfig.h
* Add type casting to void pointer in os/mmfile.cxx to pass compilation
