Meteor.startup ->
  sAlert.config
    effect: 'flip'
    position: 'top-right'
    timeout: 2000
    html: true
    onRouteClose: false
    stack: true
    offset: 0
