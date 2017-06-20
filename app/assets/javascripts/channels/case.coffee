App.case = App.cable.subscriptions.create "CaseChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
  	$('#realtime_task').prepend data['message']

  accomplish: ->
    @perform 'accomplish'


$(document).ready ->
	$('[id^="my_stop_notify_"]').on 'click', (event) ->
		App.case.accomplish "cool"
		event.preventDefault()
