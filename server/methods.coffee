Meteor.methods
  createToken: ->
    userId = User.insert {}
    @setUserId userId
    userId

  intakeAnswers: (answers) ->
    console.log 'recv', answers, @userId

    User.update @userId, $set: intakeAnswers: answers
