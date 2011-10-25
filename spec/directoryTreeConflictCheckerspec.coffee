checker = require('../lib/directoryTreeConflictChecker')

describe 'directory tree conflict checker',->

    describe 'when checking directory tree containing folder and file with the same name and extension on the same level', ->
        dirStructure =
           currentDir: 'tst1'
           files: ['a.txt', 'c.rxr']
           dirs: [{ currentDir:'tst2', files:['conflicting','not-conflicting'], dirs:[{currentDir:'tst2', dirs:[], files:[]},{currentDir:'conflicting',dirs:[],files:[] }]}]

        response = checker.check(dirStructure)

        it 'should return false', ->

            expect(response.result).toBeFalsy()

        it 'should return error response containing conflicted file name', ->
            expect(response.error.indexOf('conflicting')!=-1).toBeTruthy()
