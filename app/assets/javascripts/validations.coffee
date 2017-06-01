$(document).on "turbolinks:load", ->
  $.validator.setDefaults
    submitHandler: ->
      submitHandler: (form) ->
        # do other things for a valid form
        form.submit()
        return

  $('.album-form').validate
    rules:
      'album[posts][]':
        required: true

  $('.post-form').validate
  
  return
