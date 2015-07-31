
var
  Future $ require :./future
  http $ require :http
  url $ require :url

= exports.get $ \ (addr)

  var fut $ new Future

  var addrObj $ url.parse addr
  var req $ http.get
    {} (:host addrObj.hostname) (:path addrObj.pathname)
    \ (req)
      var result :
      req.on :data $ \ (chunk) (= result $ + result chunk)
      req.on :end $ \ ()
        fut.complete $ {}
          :url addr
          :html result

  return fut
