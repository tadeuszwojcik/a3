fs = require("fs")
path = require("path")
#TODO: should we handle gracefully when provided directoryPath?

#reads specified directory recursively and returns tree structure of nested dirs/files
exports.readDirAsTree = (dirPath) ->

    #Use lstat to resolve symlink if we are passed a symlink
    stat = fs.lstatSync(dirPath)
    dirTree =
        dirName: dirPath.split('/').reverse()[0]
        dirs: []
        files: []

    if stat.isDirectory() and not isHidden(dirTree.dirName)

        files = fs.readdirSync(dirPath).sort()

        for file in files when not isHidden(file)

            absoluteFilePath = path.join(dirPath, file)

            if fs.lstatSync(absoluteFilePath).isDirectory()
                #recurse
                dirTree.dirs.push exports.readDirAsTree(absoluteFilePath)
            else

                dirTree.files.push file
    dirTree

isHidden = (path)->
    path.match /(^_|^\.|~$)/




