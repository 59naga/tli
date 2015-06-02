# Dependencies
Command= (require 'commander').Command
Glob= require 'glob'
_= require 'lodash'

path= require 'path'
fs= require 'fs'

# Public
class Tli extends Command
  constructor: ->
    super

    @usage '/path/to/dir'
    @option '-L --level <level>','Descend only level directories deep.',99
    @option '-j --json', 'Transform to json'

  parse: (argv)->
    super

    cwd=
      if @args[0]?
        path.resolve process.cwd(),@args[0]
      else
        process.cwd()

    result= @treeSync cwd,this
    return result.tree if @test

    if @json
      console.log JSON.stringify tree,null,2
    else
      console.log (path.relative process.cwd(),cwd) or '.'
      console.log @stringify(result.tree).join('\n')+'\n'
      console.log '%s directories, %s files',result.directory,result.file

  treeSync: (cwd,options={})->
    tree= {}

    root= path.join cwd,'**'
    lines= Glob.sync root
    lines.sort()

    file= 0
    directory= 0
    for line in lines
      stat= fs.statSync line
      lineRelative= path.relative cwd,line
      lineLevel= lineRelative.split path.sep
      continue unless lineRelative.length
      continue if lineLevel.length > options.level

      if stat.isDirectory()
        _.set tree, lineLevel, {}
        directory++

      else
        _.set tree, lineLevel, stat.size
        file++

    {tree,directory,file}

  stringify: (tree,replacer=null,indent='')->
    lines= []

    i= 0
    length= Object.keys(tree).length
    for key,value of tree
      rule= if i+1 is length then '└' else '├'
      lines.push indent+rule+'─ '+key

      if value instanceof Object
        padding= if i+1 is length then '   ' else '│  '

        children= @stringify value,replacer,indent+padding
        lines.push child for child in children

      i++

    lines

module.exports= new Tli
module.exports.Tli= Tli