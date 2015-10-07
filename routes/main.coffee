
Router.map ->

  @route 'welcome',
    path: '/'

  @route 'intake',
    path: '/intake/:token'
    data: ->
      userToken: @params.token

  @route 'question',
    path: '/question/:token/:questionId'
    data: ->
      userToken: @params.token
      questionId: @params.questionId
