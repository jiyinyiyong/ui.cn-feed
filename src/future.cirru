
var Future $ \ ()
  = this.completed false
  = this.value null
  = this.slots $ []
  return this

= Future.prototype.ready $ \ (fn)
  if this.completed
    do $ fn this.value
    do $ this.slots.push fn
  return undefined

= Future.prototype.complete $ \ (value)
  if this.completed $ do
    throw $ + ":already completed: " this.value
  = this.value value
  = this.completed true
  this.slots.forEach $ \\ (fn)
    fn this.value
  = this.slots null

= Future.all $ \ (futs)
  var allFut $ new Future
  var check $ \ ()
    if
      futs.every $ \ (fut) fut.completed
      do
        allFut.complete $ futs.map $ \ (fut) fut.value
    return undefined

  futs.forEach $ \ (fut)
    fut.ready check

  return allFut

= module.exports Future
