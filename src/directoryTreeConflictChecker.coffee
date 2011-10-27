#### Directory tree conflict checker

# checks fo conflicts in directoryTree,
# returns first conflict found or success if there are no conflicts
exports.check = (directoryTree)->
    for file in directoryTree.files
        for dir in directoryTree.dirs
            if file.split('.')[0] is dir.dirName
                return { success: false, conflictingDir: dir.dirName}

    for dir in directoryTree.dirs
        #recurse for every nested dir and return first conflict if found
        res = exports.check(dir)
        if(res.success is false)
            return res

    { success: true }

        