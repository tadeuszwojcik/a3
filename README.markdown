# a3

a3 module loads any folder of code into an 'API Tree'.

## Installation

    npm install a3


    
## Quick Start

First, require `a3`:

```coffee-script
  a3 = require('a3')
```

Next :

```coffee
    apiTree = a3.buildApiTree('./app')
    
```

Options: 

```coffee
    options:
        moduleLoadedCallback: customCallback #(default callback loads all export methods of module)
        allowDirectoryConflicts: true #(default is false, and throws exception when dir tree confilct found)
    
    apiTree = a3.buildApiTree('./app', options)
    
```


## Running Tests

To run the test suite first invoke the following command within the repo, installing the development dependencies:

    npm install
then run:

    jasmine-node --coffee spec
    
## **LICENSE**

Copyright (c) 2011 Tadeusz Wójcik <tadeuszwojcik@gmail.com>

The MIT License

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.