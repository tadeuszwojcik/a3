#TODO:add some comments
#TODO: code review
#TODO: tests
#TODO: docs

fsExtensions = require('./fsExtensions')
dirTreeChecker = require('./directoryTreeConflictChecker')
apiTreeLoader = require('./apiTreeLoader')
path = require('path')
fs = require("fs")

exports.buildApiTree = (dirPath, options)->


    dirPath = path.join(fs.realpathSync(), dirPath)

    dirTree = fsExtensions.readDirAsTree(dirPath)

    checkResult = dirTreeChecker.check(dirTree)

    if checkResult.success
        apiTreeLoader.load(dirTree,dirPath, defaultModuleLoadedCallback)
    else
        throw new Error(result.conflictingDir)


defaultModuleLoadedCallback = (apiTreeObject, moduleName, loadedModule)->
    apiTreeObject[moduleName] = loadedModule









