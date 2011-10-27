path = require("path")

#TODO: code review
#TODO: tests
#TODO: docs

exports.load = (tree, pathPrefix) ->
    apiTree = {}

    for file in tree.files
        apiTree[file.split('.')[0]]= require(path.join(pathPrefix,file))

    for dir in tree.dirs
        apiTree[dir.dirName] = exports.apiTree(dir,path.join(startDir,dir.dirName))

    apiTree





