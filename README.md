# Tli [![NPM version][npm-image]][npm] [![Build Status][travis-image]][travis] [![Coverage Status][coveralls-image]][coveralls]

> Tree command emulator

## Installation
```bash
$ npm install tli --global
$ tli -V
# 0.0.0
```

# CLI
```bash
$ tli
.
├─ cli.spec.coffee
├─ fixtures
│  ├─ foo
│  │  ├─ bar
│  │  │  └─ beep
│  │  └─ baz
│  └─ hoge
│     ├─ fuga
│     ├─ ninja
│     │  └─ nande
│     │     └─ aieeee
│     └─ piyo
│        └─ guwa-
└─ index.coffee

8 directories, 6 files
```

## Options
```bash
$ tli --help
#
#  Usage: tli /path/to/dir
#
#  Options:
#
#    -h, --help          output usage information
#    -L --level <level>  Descend only level directories deep.
#    -j --json           Output json
```

# API
```bash
$ npm install tli
```

## `.treeSync(path)` -> `{file,directory,tree}`

File and directory synchronous searching.

```js
var tli= require('tli');

var result= tli.treeSync(__dirname);
console.log(result);
// {
//   file: 2,
//   directory: 3,
//
//   tree: {
//     baz: {
//       beep: 1024,//bytes
//       boop: 2048,
//     },
//     foo: {
//       bar: {},
//     },
//     noop: {},
//   },
// }
```

## `.stringify(tree)` -> `treeString`

Prettify the `tree` object

```js
var tli= require('tli');
var result= tli.treeSync(__dirname);
var tree= tli.stringify(result.tree);
console.log(tree);
//├─ baz
//│  ├─ beep
//│  └─ boop
//├─ foo
//│  └─ bar
//└─ noop
```

License
---
[MIT][License]

[License]: http://59naga.mit-license.org/

[npm-image]:https://img.shields.io/npm/v/tli.svg?style=flat-square
[npm]: https://npmjs.org/package/tli
[travis-image]: http://img.shields.io/travis/59naga/tli.svg?style=flat-square
[travis]: https://travis-ci.org/59naga/tli
[coveralls-image]: http://img.shields.io/coveralls/59naga/tli.svg?style=flat-square
[coveralls]: https://coveralls.io/r/59naga/tli?branch=master