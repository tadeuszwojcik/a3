# 1 load folder recursivelly
# add checks if folder name is the same as file name
# load tree into object
fsExtensions = require("./fileSystemExtensions")

apiTree: (dir, tree, action) ->
    recursively = (destination, ary, path, counter_name, index = 0) ->
      element = ary[index]
      dest = utils.getFromTree(destination, ary, index)
      if ary.length == (index + 1)
        mod = require(path)
        action(mod, element, dest, ary)
        SS.internal.counters.files_loaded[counter_name]++
      else
        dest[element] = {} unless dest.hasOwnProperty(element)
        arguments.callee(destination, ary, path, counter_name, (index+1))

    if tree
      path = dir.split('/')
      slashes_to_remove = path.length
      api_name = path.reverse()[0]
      tree.files.forEach (path) ->

        ary = path.split('/').slice(slashes_to_remove)
        mod_name = ary.pop()
        ary.push(mod_name.split('.')[0])

        recursively(SS[api_name], ary, path, api_name)

        # Turn the API tree into a string we can easily send to the client to be re-constructed into functions
        SS.internal.api_string[api_name] = apiToString(SS[api_name])
