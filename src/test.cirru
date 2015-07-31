
var
  Future $ require :./future

var a $ new Future
var b $ new Future

Future.all
  [] a b
  \ (results)
    console.log results

setTimeout
  \ ()
    a.complete 1
  , 1000

setTimeout
  \ ()
    b.complete 2
  , 2000
