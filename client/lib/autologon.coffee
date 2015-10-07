@AutoLogon = ->
  if Meteor.userId() == null
    console.log 'no user context'
    data = Template.currentData()
    if data?.userToken
      Meteor.call 'useToken', data.userToken, (err, result) ->
        if err
          console.log err
        else
          console.log 'Token reuse is ok', data.userToken
