Template.question.onRendered ->
    Range = ace.require('ace/range').Range;
    editor = ace.edit("editor");
    editor.setTheme("ace/theme/eclipse");
    editor.getSession().setMode("ace/mode/java");
    editor.addSelectionMarker(new Range(1, 0, 6, 0));

Template.question.events
  'click #backButton': -> Router.go 'intake'
  'click #nextButton': -> #Router.go 'intake'
  'change #cannotBeNamed': (e, tpl)->
    tpl.$('#methodName').prop 'disabled', e.currentTarget.checked
