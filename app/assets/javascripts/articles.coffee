# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

simplemde = null

cleanupSimpleMDE = ->
	if simplemde?
		simplemde.toTextArea()
		simplemde = null

$(window).on 'popstate', cleanupSimpleMDE
$(document).on 'turbolinks:before-visit', cleanupSimpleMDE

$(document).on "turbolinks:load", ->
	simplemde = new SimpleMDE()
