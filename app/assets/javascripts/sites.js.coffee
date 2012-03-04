# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ->
  $('.project_name_link').on "click", (e) ->
    e.preventDefault()
    $(this).toggleClass "open_list"
    $(this).siblings(".project_sites_list").toggleClass "is_hidden"