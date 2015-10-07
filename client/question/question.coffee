setAnswer = (answerObject) ->
  resetErrorMessage()
  Session.set('answer', _.extend(Session.get('answer') or {}, answerObject))
isEmpty = (str) -> str == undefined or str == null or str.length == 0
showErrorMessage = (msg) -> Session.set 'errorMessage', msg
resetErrorMessage = -> showErrorMessage null

Template.question.onRendered ->
  Range = ace.require('ace/range').Range;
  editor = ace.edit("editor");
  editor.setTheme("ace/theme/eclipse");
  editor.getSession().setMode("ace/mode/java");
  editor.addSelectionMarker(new Range(1, 0, 6, 0));

  Meteor.call 'nextQuestion', (err, question) ->
    console.log 'nextQuestion', question
    editor.setValue question.methodCode

Template.question.helpers
  cannotBeNamedIsChecked: -> Session.get('answer')?.cannotBeNamed
  methodName: -> Session.get('answer')?.methodName
  methodNameEntered: -> Session.get('answer')?.methodName?.length > 0
  errorMessage: -> Session.get 'errorMessage'

Template.question.events
  'click #backButton': -> Router.go 'intake'
  'click #nextButton': (e, tpl)->
    answer = Session.get 'answer'
    if isEmpty(answer.methodName) and !answer.cannotBeNamed
      showErrorMessage 'Please either enter a method name or check \'this method cannot be named\'.'
    else if answer.cannotBeNamed and isEmpty(answer.cannotBeNamedReason)
      showErrorMessage 'Please provide the rationale/reasons for choosing <i>this method cannot be named</i>.'
    else
      resetErrorMessage()
      Meteor.call 'submitAnswer', answer, (err, res) ->
        if err
          sAlert.error '<h2>Sorry</h2>Your answer could not be submitted due to technical problems.'
        else
          sAlert.success '<h2>Submitted</h2>Your answer has been submitted.'
    #Router.go 'intake'
  'change #cannotBeNamed': (e, tpl)->
    tpl.$('#methodName').prop 'disabled', e.currentTarget.checked
    setAnswer cannotBeNamed: e.currentTarget.checked
  'input .registerAnswer': _.debounce (e, tpl) ->
    x = {}; x[e.target.id] = e.target.value
    setAnswer x
    console.log 'setAnswer', e.target.id, e.target.value
  , 1000
