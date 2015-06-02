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
    @option '-N --no-summary', 'Hide summary'

  parse: (argv)->
    super

    cwd=
      if @args[0]?
        path.resolve process.cwd(),@args[0]
      else
        process.cwd()

    tree= @treeSync cwd,this
    return tree if @test

    if @json
      console.log JSON.stringify tree,null,2
    else
      console.log (path.relative process.cwd(),cwd) or '.'
      console.log @stringify(tree).join('\n')+'\n'

    if @summary
      console.log '%s directories, %s files',count_dir,count_file

  treeSync: (cwd,options={})->
    tree= {}

    root= path.join cwd,'**'
    files= Glob.sync root
    files.sort()

    count_dir= 0
    count_file= 0
    for file in files
      stat= fs.statSync file
      filePath= path.relative cwd,file
      fileLocale= filePath.split path.sep
      continue unless filePath.length
      continue if fileLocale.length > options.level

      if stat.isDirectory()
        _.set tree, fileLocale, {}
        count_dir++

      else
        _.set tree, fileLocale, stat.size
        count_file++

    tree

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