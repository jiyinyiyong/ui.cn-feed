
var
  express $ require :express
  RSS $ require :rss
  http $ require :http
  cheerio $ require :cheerio

var app (express)

app.get :/ $ \ (req res)
  res.send ":seed /feed"

app.get :/feed $ \ (req res)
  var feed $ new RSS $ {}
    :title ":UI.cn Feed"
    :description ":Picture updates from UI.cn"
    :link :http://ui.cn
    :image :http://s6.ui.cn/img/ft-logo.png
    :copyright :MIT
    :author $ {}
      :name :jiyinyiyong
      :email :jiyinyiyong@gmail.com
      :link :http://tiye.me
  http.get
    {} (:host :www.ui.cn) (:path :/)
    \ (response)
      var html :
      response.on :data $ \ (chunk) (= html $ + html chunk)
      response.on :end $ \ ()
        var dom $ cheerio.load html
        var container $ dom :.Inspir-list
        var items $ container.find ":.iInspir-cover"

        items.each $ \ (index item)
          var target $ dom item
          var a $ ... target (find :a) (first)
          var img $ ... target (find :img) (first)
          var user $ ... target (find ":.iInspir-cover-user strong") (first)

          feed.item $ {}
            :title
              + (img.attr :alt) ": - " (user.text)
            :url $ a.attr :href
            :description (img.attr :data-original)
            :date $ new Date

        res.set :Content-Type :text/xml
        res.send (feed.xml)

app.listen 4002
console.log ":server started at 4002"
