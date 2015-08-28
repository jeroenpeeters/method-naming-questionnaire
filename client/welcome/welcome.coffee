Template.welcome.events
  'click #nextButton': ->
    Meteor.call 'createToken', (err, token) ->
      unless err
        console.log 'your token is', token
        Router.go 'intake'
      else
        console.log err
        sAlert.error 'An error occured, check your network connectivity.'
