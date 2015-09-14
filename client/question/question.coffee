setAnswer = (answerObject) ->
  Session.set('answer', _.extend(Session.get('answer') or {}, answerObject))

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

Template.question.events
  'click #backButton': -> Router.go 'intake'
  'click #nextButton': (e, tpl)->
    answer = _.extend
      methodName: ''
      cannotBeNamedReason: ''
    , Session.get 'answer'
    if answer.methodName.length == 0 and !answer.cannotBeNamed
      sAlert.warning 'Please either enter a method name or check \'this method cannot be named\'.'
    else if answer.cannotBeNamed and answer.cannotBeNamedReason.length == 0
      sAlert.warning 'Please provide the rationale/reasons for choosing <i>this method cannot be named</i>.'
    else
      console.log answer
    #Router.go 'intake'
  'change #cannotBeNamed': (e, tpl)->
    tpl.$('#methodName').prop 'disabled', e.currentTarget.checked
    setAnswer cannotBeNamed: e.currentTarget.checked
  'input .registerAnswer': _.debounce (e, tpl) ->
    x = {}; x[e.target.id] = e.target.value
    setAnswer x
    console.log 'setAnswer', e.target.id, e.target.value
  , 1000
