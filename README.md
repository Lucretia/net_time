# Net Time

This is an Ada 2012 library that implements the internet time protocol, [RTF3339](http://tools.ietf.org/html/rfc3339).

Leap seconds are not supported as yet as Ada's seconds range is 0 .. 59 which does not include 60, which the RFC does. I
also have no clue, yet, how to implement it.

# Building

## GNAT

```bash
$ cd build/gnat
$ make
```

# Dependencies

Ada 2012 compiler.

## Tested with

FSF GNAT 7.3.0

# Author

Copyright (C) 2019, Luke A. Guest

# Licence

New-style BSD, see LICENCE file in source root directory.
