# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).on "turbolinks:load", ->
  $(".photo-selector > img").click ->
    $(this).toggleClass("selected")
    $(this).next().click()

  # album form validation
  $('.album-form').validate
    rules:
      'album[posts][]':
        required: true

    submitHandler: (form) ->
      # do other things for a valid form
      form.submit();
