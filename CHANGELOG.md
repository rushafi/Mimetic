# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/en/1.0.0/)
and this project adheres to [Semantic Versioning](http://semver.org/spec/v2.0.0.html).

## [0.0.4] - 2018-02-15
- Add shared framework scheme

## [0.0.3] - 2018-02-14
- Reaplce all NSASCIISTRINGENCODING with NSUTF8STRINGENCODING
- Replace c-style casts with static_cast

## [0.0.2] - 2018-02-13
- Add native class to handle Mailbox and Group
- Add support for replyto, cc, bcc
- to, replyto, cc, bcc now supports multiple mailbox

## [0.0.1] - 2018-01-29
- Wrapper methods to get/set
  - Content-Type
  - Content-Transfer-Encoding
  - From
  - To
  - Date
  - Mime-Version
  - Message-ID
  - Content-Language
  - Subject
  - Body
- Initializer for existing mime message
- Method for generating MIME with fields
- Basic unit tests

### Steps to Port Mimetic as a Static Lib on Xcode
- Download mimetic: http://www.codesink.org/download/mimetic-0.9.8.tar.gz
- ./configure (add executable permission if necessary)
- Create Xcode Static Lib project
- Add source files to Xcode project (May recreate the directory structure according to mimetic
- Add header search path to $SRCROOT/Mimetic (or according to your directory structure)
- Defined HAVE_MIMETIC_CONFIG preprocessor flag in libconfig.h
- Add type casting to void pointer in os/mmfile.cxx to pass compilation
- Fix warnings by adding proper type casting
