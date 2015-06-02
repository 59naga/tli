# Dependencies
CLI= (require '../src').Tli

path = require 'path'

# Fixture
$tree= (args)->
  argv= ['node',__filename]
  for arg in args.match /".*?"|[^\s]+/g
    argv.push arg.replace /^"|"$/g,''

  cli= new CLI
  cli.test= yes
  cli.parse argv

# Environment

# Specs
describe 'CLI',->
  it '$ tree test/fixtures/foo',->
    result= $tree (path.join 'test','fixtures','foo')

    expect(result).toEqual {
      bar:
        beep: 0

      baz: 0
    }

  it '$ tree test/fixtures/hoge',->
    result= $tree (path.join 'test','fixtures','hoge')

    expect(result).toEqual {
      fuga: {}
      ninja:
        nande:
          aieeee: 0

      piyo:
        'guwa-': 0
    }

  it '$ tree test/fixtures/hoge --level 1',->
    result= $tree (path.join 'test','fixtures','hoge')+' --level 1'

    expect(result).toEqual {
      fuga: {}
      ninja: {}
      piyo: {}
    }