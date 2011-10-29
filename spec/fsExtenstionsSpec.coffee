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

            spyOn(fsExtensions.fs,"lstatSync").andReturn({isDirectory:-> true})
            spyOn(fsExtensions.fs,"readdirSync").andReturn({sort:-> []})

            expect( fsExtensions.readDirAsTree('empty')).toEqual({dirName:'empty',dirs:[],files:[]})

    describe 'when reading dir as tree and provided path to hidden dir', ->

        it 'empty dir tree should be returned', ->
            spyOn(fsExtensions.fs,"lstatSync").andReturn({isDirectory:-> true})

            expect( fsExtensions.readDirAsTree('_hidden')).toEqual({dirName:'_hidden',dirs:[],files:[]})

    describe 'when reading dir as tree and provided path to dir with two dirs nest', ->
        dirDepth = 0
        it 'dir tree with two nest level should be returned returned', ->

            spyOn(fsExtensions.fs,"lstatSync").andReturn(
                    {
                    isDirectory:->
                        if dirDepth++ < 5
                            true
                        else
                            false
                    }
                )
            spyOn(fsExtensions.fs,"readdirSync").andReturn(
                    {sort:->
                        ['one', 'two', 'three', 'four', 'five'].slice(dirDepth)
                    }
            )

            expect( fsExtensions.readDirAsTree('tst')).toEqual(
                    {
                    dirName : 'tst',
                    dirs : [ {dirName : 'two',dirs : [ {dirName : 'four', dirs : [  ], files : [  ] }],files : [ 'five' ]}],
                    files : [ 'three', 'four', 'five' ]
                    })
    describe 'when reading dir as tree and provided path to dir with two dirs nest and hidden dir and file', ->
        dirDepth = 0
        it 'dir tree with two nest level should be returned returned without hidden dir and file', ->

            spyOn(fsExtensions.fs,"lstatSync").andReturn(
                    {
                    isDirectory:->
                        if dirDepth++ < 5
                            true
                        else
                            false
                    }
                )
            spyOn(fsExtensions.fs,"readdirSync").andReturn(
                    {sort:->
                        ['one', 'two', 'three', '_four', 'five'].slice(dirDepth)
                    }
            )

            expect( fsExtensions.readDirAsTree('tst')).toEqual(
                    {
                    dirName : 'tst',
                    dirs : [ {dirName : 'two',dirs : [ {dirName : 'five', dirs : [  ], files : [] }], files : []}],
                    files : [ 'three', 'five' ]
                    })
