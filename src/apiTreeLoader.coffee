path = require("path")

#TODO: code review
#TODO: tests
#TODO: docs


exports.load = (tree, pathPrefix, moduleLoadedCallback) ->

    apiTree = {}

    for dir in tree.dirs
        apiTree[dir.dirName] = exports.load(dir,path.join(pathPrefix,dir.dirName), moduleLoadedCallback)

    for file in tree.files
            moduleToLoad = require(path.join(pathPrefix,file))
            moduleLoadedCallback(apiTree,file.split('.')[0], moduleToLoad)
    apiTree





