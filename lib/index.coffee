#TODO:add some comments
#TODO: additional callback
#TODO: code review
#TODO: tests
#TODO: docs

fsExtensions = require('./fsExtensions')
dirTreeChecker = require('./directoryTreeConflictChecker')
apiTreeLoader = require('./apiTreeLoader')
path = require('path')
fs = require("fs")

exports.buildApiTree = (dirPath, options, callback)->

    dirPath = path.join(fs.realpathSync(), dirPath)
    dirTree = fsExtensions.readDirAsTree(dirPath)
    dirTreeChecker.check(dirTree)

    apiTreeLoader.load(dirTree,dirPath)







