Meteor.methods
  createTokens: ->
    user = Meteor.user()
    if user
      user.username # this is the user id
    else
      uuid = Meteor.uuid()
      userId = Accounts.createUser username: uuid
      Accounts.setPassword userId, uuid
      uuid

  #useToken: (token) ->
  #  @setUserId token

  intakeAnswers: (answers) ->
    console.log "intakeAnswers for #{@userId}", answers
    Meteor.users.update @userId, $set: intakeAnswers: answers

  nextQuestion: ->
    console.log "nextQuestion for #{@userId}"
    question = Methods.findOne {}
    Meteor.users.update @userId, $push: questions: question
    question._id

  submitAnswer: (answer) ->
    console.log "submitAnswer for #{userId}", answer
    #console.log User.update @userId, $push: answers: answer
    #console.log User.findOne _id: @userId
