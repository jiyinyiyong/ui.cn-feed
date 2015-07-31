
var
  gulp $ require :gulp
  wrapper $ require :rsyncwrapper

gulp.task :rsync $ \ (cb)
  wrapper.rsync
    object
      :ssh true
      :src $ array :app.cirru :package.json :processes.json :src
      :recursive true
      :args $ array :--verbose
      :dest :tiye:~/server/uicn-feed
      :deleteAll true
    \ (error stdout stderr cmd)
      if (? error)
        do $ throw error
      console.error stderr
      console.log cmd
      cb
