checker = require('../src/directoryTreeConflictChecker')

describe 'directory tree conflict checker',->

    describe 'when checking directory tree containing folder and file with the same name on the same level', ->

        dirStructure =
           dirName: 'tst1'
           files: ['a.txt', 'c.coffee']
           dirs: [
                   {
                   dirName: 'tst2'
                   files: ['conflicting', 'not-conflicting']
                   dirs:[
                           {
                           dirName: 'tst2'
                           dirs: []
                           files: []
                           },
                           {
                           dirName: 'conflicting'
                           dirs:[]
                           files:[]
                           }]
                   }
                 ]

        result = checker.check(dirStructure)

        it 'result success flag should be set to false', ->
            expect(result.success).toBeFalsy()

        it 'result conflictingDir should be set to conflicting dir name', ->
            expect(result.conflictingDir).toEqual('conflicting')

    describe 'when checking directory tree containing folder and file (with extension) with the same name on the same level', ->

        dirStructure =
           dirName: 'tst1'
           files: ['a.txt', 'c.coffee']
           dirs: [
                   {
                   dirName: 'tst2'
                   files: ['conflicting.txt', 'not-conflicting']
                   dirs:[
                           {
                           dirName: 'tst2'
                           dirs: []
                           files: []
                           },
                           {
                           dirName: 'conflicting'
                           dirs:[]
                           files:[]
                           }]
                   }
                 ]

        result = checker.check(dirStructure)

        it 'result success flag should be set to false', ->
            expect(result.success).toBeFalsy()

        it 'result conflictingDir should be set to conflicting dir name', ->
            expect(result.conflictingDir).toEqual('conflicting')

    describe 'when checking directory tree containing folder and file with the same name on different levels', ->

        dirStructure =
           dirName: 'repeating'
           files: ['a.txt', 'c.coffee']
           dirs: [
                   {
                   dirName: 'repeating'
                   files: ['repeating.txt', 'not-conflicting']
                   dirs:[
                           {
                           dirName: 'tst2'
                           dirs: []
                           files: []
                           },
                           {
                           dirName: 'tst4'
                           dirs:[]
                           files:[]
                           }]
                   }
                 ]

        result = checker.check(dirStructure)

        it 'result success flag should be set to false', ->
            expect(result.success).toBeTruthy()

        it 'should return error response containing conflicted file name', ->
            expect(result.conflictingDir).toBeUndefined()

    describe 'when checking directory tree containing no folders and file with the same name', ->

        dirStructure =
          dirName: 'repeating'
          files: ['a.txt', 'c.coffee']
          dirs: [
                  {
                  dirName: 'repeating'
                  files: ['repeating.txt', 'not-conflicting']
                  dirs:[
                          {
                          dirName: 'tst2'
                          dirs: []
                          files: []
                          },
                          {
                          dirName: 'tst4'
                          dirs:[]
                          files:[]
                          }]
                  }
                ]

        result = checker.check(dirStructure)

        it 'result success flag should be set to false', ->
           expect(result.success).toBeTruthy()

        it 'should return error response containing conflicted file name', ->
           expect(result.conflictingDir).toBeUndefined()



