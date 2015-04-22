
@UserActivity =
  timeActive: 0
  timeInactive: 0
  lastAction: new Date()

  recordActivity: ->
    @lastAction = new Date()

  timerActivity: ->
    if ((new Date()).getTime() - @lastAction.getTime()) > 5*60*1000
      @timeInactive += 1
    else
      @timeActive += 1

  install: ->
    idleInterval = setInterval (=> UserActivity.timerActivity()), 1* 1000
    $(window).mousemove @recordActivity
    $(window).keypress @recordActivity

Meteor.startup ->
  UserActivity.install()
