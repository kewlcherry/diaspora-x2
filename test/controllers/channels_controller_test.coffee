
runTests ->
  module('channels controller');

  $("<div id='content' />").addClass('invisible').appendTo 'body'

  new ChannelFixtures
  new UserFixtures

  # If we were using jasmine or qunit-mock we could stub... :/
  window.$c = {
    getChannel : ->
      # ...
  }

  $("<div id='main'></div>").addClass('invisible').appendTo 'body'
  
  app.currentUser = Users.first()
  
  asyncTest 'show', 1, ->
    window.location.hash = "channels/welcome"
    Backbone.history.loadUrl()

    waitForRender ->
      equal 1, $("#content h1:contains('Welcome')").length
      start()
      
  # test "post", ->
  #   ta = $("#main form:first textarea")
  #   
  #   ok ta[0]
  #   
  #   ta.val("test post").parents("form").submit()
  # 
  #   ok 