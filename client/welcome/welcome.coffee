Template.welcome.events
  'click #nextButton': ->
    user = Meteor.user()
    if user
      console.log 'already logged in, readirecting'
      Router.go 'intake', token: user.username
    else
      Meteor.call 'createTokens', (err, token) ->
        unless err
          console.log 'your token is', token, 'logging you in'
          Meteor.loginWithPassword token, token, (err) ->
            unless err
              Router.go 'intake', token: token
            else
              sAlert.error 'There was a problem logging you in.'
        else
          console.log err
          sAlert.error 'An error occured, check your network connectivity.'
