exports.check=(directoryTree)->
    for file in directoryTree.files
        for dir in directoryTree.dirs
            if file is dir.currentDir
                return {result:false,error:dir.currentDir}

    for dir in directoryTree.dirs
        res = exports.check(dir)
        if(res.result is false)
            return res

    {result:true}

        