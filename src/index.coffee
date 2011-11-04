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

    defaultOptions =
        moduleLoadedCallback: defaultModuleLoadedCallback
        allowDirectoryConflicts: false

    merge(defaultOptions, options)

    dirTree = fsExtensions.readDirAsTree(dirPath)

    checkResult = dirTreeChecker.check(dirTree)

    if checkResult.success or defaultOptions.allowDirectoryConflicts
        apiTreeLoader.load(dirTree,dirPath, defaultOptions.moduleLoadedCallback)
    else
        throw new Error(checkResult.conflictingDir)


exports.getBranch = (tree, ary, index = null, i = 0) ->
  index = (ary.length) unless index?
  return tree if i == index
  arguments.callee tree[ary[i]], ary, index, ++i


defaultModuleLoadedCallback = (apiTreeObject, moduleName, loadedModule)->
    apiTreeObject[moduleName] = loadedModule

merge = (a, b)->
  if a && b
    for key,value of b
      a[key] = value
  a



