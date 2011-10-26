#TODO: code review
#TODO: tests
#TODO: docs

exports.check=(directoryTree)->
    for file in directoryTree.files
        for dir in directoryTree.dirs
            if file is dir.dirName
                return {result:false,error:dir.dirName}

    for dir in directoryTree.dirs
        res = exports.check(dir)
        if(res.result is false)
            return res

    {result:true}

        