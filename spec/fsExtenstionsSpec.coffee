fsExtensions = require('../src/fsExtensions')

describe 'file system extensions reading dir as tree',->

    describe 'when reading dir as tree and path was not provided', ->

        it 'error should be thrown', ->
            expect(fsExtensions.readDirAsTree).toThrow(new Error("please provide directory path to be read as tree"))

    describe 'when reading dir as tree and path was empty', ->

        it 'error should be thrown', ->
            expect((->fsExtensions.readDirAsTree(''))).toThrow(new Error("please provide directory path to be read as tree"))


    describe 'when reading dir as tree and path was non existent', ->

        it 'error should be thrown', ->
            spyOn(fsExtensions.fs,"lstatSync").andCallFake(->
                            throw new Error("No such file or directory")
                        )
            expect((-> fsExtensions.readDirAsTree('non existent'))).toThrow("No such file or directory")

    describe 'when reading dir as tree and provided path to empty dir', ->

        it 'empty dir tree should be returned', ->
            spyOn(fsExtensions.fs,"lstatSync").andReturn({isDirectory:-> false})

            expect( fsExtensions.readDirAsTree('empty')).toEqual({dirName:'empty',dirs:[],files:[]})

    describe 'when reading dir as tree and provided path to hidden dir', ->

        it 'empty dir tree should be returned', ->
            spyOn(fsExtensions.fs,"lstatSync").andReturn({isDirectory:-> true})

            expect( fsExtensions.readDirAsTree('_hidden')).toEqual({dirName:'_hidden',dirs:[],files:[]})


# gdy file jest hidden
# przyklad jakiś zagdniezdzonych katalogow