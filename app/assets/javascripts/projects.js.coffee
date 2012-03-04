# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
jQuery ->
  # Bind jQuery UI to datPicker class
  $('.datePicker').datepicker dateFormat: 'yy-mm-dd'

  # Unfold sites when you click on a project row
  $('.more_details').on "click", (e) ->
    e.preventDefault()
    $(this).closest(".project").toggleClass("closed").toggleClass "open"
    $(this).closest('.project').children(".more_details_box").toggleClass "is_hidden"
