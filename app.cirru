
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
    var items $ container.find ":.iInspir-title a[title]"

    var fetchFuts $ items.map $ \ (item)
      var target $ dom this
      var href $ target.attr :href
      ajax.get href

    var allFuts $ Future.all $ Array.apply null fetchFuts
    allFuts.ready $ \ (htmlResults)
      htmlResults.forEach $ \ (workPage)
        var pageDom $ cheerio.load workPage.html $ {} (:decodeEntities false)
        var workContent $ pageDom :.work-content
        ... workContent
          find :img
          each $ \ ()
            var img $ pageDom this
            img.attr :src $ img.attr :data-original
        var item $ {}
          :title $ ... (pageDom :title) (text)
          :url workPage.url
          :description $ workContent.html
          :date $ ... (pageDom ":.cont-hd-l .msg-li") (find :span) (eq 1) (text)
          :author $ ... (pageDom :#list-author) (text)
        feed.item item
      res.set :Content-Type :text/xml
      res.send (feed.xml)

app.listen 4002
console.log ":server started at 4002"
