fs = require("fs")
path = require("path")
#### fs extensions

#TODO: should we handle gracefully when provided directoryPath is not a directory?

#reads specified directory (non hidden) recursively and returns tree structure of nested dirs/files
exports.readDirAsTree = (dirPath) ->
    throw new Error("please provide directory path to be read as tree") unless dirPath
    #Use lstat to resolve symlink if we are passed a symlink
    stat = exports.fs.lstatSync(dirPath)
    # tree like directory structure
    dirTree =
        dirName: dirPath.split('/').reverse()[0]
        dirs: []
        files: []

    if stat.isDirectory() and not isHidden(dirTree.dirName)

        files = exports.fs.readdirSync(dirPath).sort()

        for file in files when not isHidden(file)

            absoluteFilePath = path.join(dirPath, file)

            if exports.fs.lstatSync(absoluteFilePath).isDirectory()
                #recurse
                dirTree.dirs.push exports.readDirAsTree(absoluteFilePath)
            else

                dirTree.files.push file
    dirTree

isHidden = (path)->
    path.match /(^_|^\.|~$)/
exports.fs = fs




