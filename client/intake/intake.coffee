
setAnswer = (answerObject) ->
  Session.set('answers', _.extend(Session.get('answers') or {}, answerObject))

validateInput = ->
  answers = Session.get 'answers'
  answers?.employmentTitle == "" or answers?.experience == ""

Template.intake.helpers
  otherEmployment: -> Session.get('answers')?.employmentTitle == 'other'
  answers: -> Session.get 'answers'

Template.intake.events
  'click #backButton': -> Router.go 'welcome'
  'click #nextButton': (e, tpl) ->
    if validateInput()
      sAlert.warning 'Please provide answers to all questions in order to continue.'
    else
      Meteor.call 'intakeAnswers', Session.get('answers'), (error) ->
        unless error
          Router.go 'question'
        else
          sAlert.error 'An error occured, check your network connectivity.'

  'change .registerAnswer': (e, tpl) ->
    x = {}; x[e.target.id] = e.target.value
    setAnswer x

Handlebars.registerHelper 'selected', (foo, bar) ->
  if foo == bar then 'selected' else ''
