$(document).on "turbolinks:load", ->
  $.validator.setDefaults
    submitHandler: ->
      submitHandler: (form) ->
        # do other things for a valid form
        alert("hi")
        # form.submit()
        return false

  $('.album-form').validate
    rules:
      'album[posts][]':
        required: true

  $('.post-form').validate()

  $(".new-user-form").validate
    rules:
      "user[password_confirmation]":
        equalTo: "#user_password"

  $(".username-form").validate()

  return
