[![build status](https://secure.travis-ci.org/twojcik/a3.png)](http://travis-ci.org/twojcik/a3)
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

## Simple example:

Assuming we've got following code folders structure:

```coffee-script
    api\comments.coffee
    
    api\posts.coffee
    
    api\users.coffee
    
    api\admin\users.coffee
    
    api\admin\comments.coffee
```
With following file contents:
  
api\comments.coffee

```coffee
  exports.list  ->
    ## some code
  exports.add(comment)  ->
    ## some code
```

api\posts.coffee

```coffee
  exports.list  ->
    ## some code
  exports.add(post)  ->
    ## some code
```

api\users.coffee

```coffee
  exports.list  ->
    ## some code
  exports.add(user)  ->
    ## some code
```

api\admin\users.coffee

```coffee
  exports.list  ->
    ## some code
  exports.remove(user)  ->
    ## some code
```
api\admin\comments.coffee

```coffee
  exports.list  ->
    ## some code
  exports.remove(comment)  ->
    ##  some code
    
```
Invoke buildApiTree on api folder :

```coffee
    api = a3.buildApiTree('./api')
```

It will return following object with all modules in provided code folder loaded:

```coffee

{ 
    comments:{ 
                list: [Function],
                add: [Function] 
             },
      posts: { 
                list: [Function],
                add: [Function] 
             },
      users: {
                list: [Function],
                add: [Function] 
             },
      admin: { users:{ 
                          list: [Function],
                          remove: [Function] 
                     },
               comments:{
                          list: [Function],
                          remove: [Function] 
               
                     } 
              }
}

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