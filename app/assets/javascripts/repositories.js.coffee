$ ->
  $('tr.commit').click (event) ->
    window.location = $(this).attr("data-url");