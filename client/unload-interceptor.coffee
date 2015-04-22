
@UnloadInterceptor =
  interceptUnload: true
  install: ->
    window.onbeforeunload = =>
      "You haven't completed the survey!\n\nYour progress is saved and you can come back any time to finish the survey (on this pc)." if @interceptUnload
  disable: ->
    @interceptUnload = false

Meteor.startup ->
  UnloadInterceptor.install()
