fs = require("fs")
path = require("path")

#reads specified directory recursively and returns tree structure of nested dirs/files
exports.readDirTree = (startDir) ->
    #Use lstat to resolve symlink if we are passed a symlink
    stat = fs.lstatSync(startDir)
    found =
        currentDir:startDir.split('/').reverse()[0]
        dirs:[]
        files:[]

    if stat.isDirectory() and not isHidden(found.currentDir)
        files = fs.readdirSync(startDir).sort()

        for file in files when not isHidden(file)
            absoluteFilePath=path.join(startDir,file)
            if fs.lstatSync(absoluteFilePath).isDirectory()
                found.dirs.push exports.readDirTree(absoluteFilePath)
            else
                found.files.push file
    found

isHidden = (path)->
    path.match /(^_|^\.|~$)/

