
var
  express $ require :express
  RSS $ require :rss
  cheerio $ require :cheerio
  ajax $ require :./src/ajax
  Future $ require :./src/future
  info $ require :./src/info

var app (express)

app.get :/ $ \ (req res)
  res.send ":seed /feed"

app.get :/feed $ \ (req res)
  var feed $ new RSS info.rss

  var req $ ajax.get :http://www.ui.cn/new.html
  req.ready $ \ (newPage)
    var dom $ cheerio.load newPage.html $ {} (:decodeEntities false)
    var container $ dom :.Inspir-list
    var items $ container.find ":.iInspir-cover"
    items.each $ \ ()
      var block $ dom this
      var imgEl $ ... block (find :img) (first)
      imgEl.attr :src $ imgEl.attr :data-original
      var item $ {}
        :title $ ... block (find :.iInspir-title) (first) (text)
        :url $ ... block (find ":.iInspir-title a") (first) (attr :href)
        :description $ ... block (html)
        :author $ ... block (find ":.iInspir-cover-user strong") (first) (text)
      feed.item item
    res.set :Content-Type :text/xml
    res.send (feed.xml)

app.listen 4002
console.log ":server started at 4002"
