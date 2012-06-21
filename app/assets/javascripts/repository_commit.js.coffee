$ ->
  firstrow = -1
  currentrow = -1
  dragging = false

 	$("td.line").mousedown((ev) ->
    if firstrow != -1 && currentrow != -1
      $(".highlight").removeClass("highlight")

    firstrow = Number($(this).parent().attr("data-line"))
    currentrow = Number($(this).parent().attr("data-line"))

    currentRow = -1
    dragging = true

    highlight_rows()

    ev.preventDefault()
  )

 	$("td.line").mouseup((ev) ->
    dragging = false
  )

  $('.add_comment a').click (event) ->
    event.preventDefault()
    insertCommentRow()

  insertCommentRow = ->
    alert("From " + firstrow + " to " + currentrow)

  highlight_rows = () ->
    if currentrow < firstrow
      temp = firstrow
      firstrow = currentrow
      currentrow = temp

    first = $('tr[data-line="' + firstrow + '"]')
    last = $('tr[data-line="' + currentrow + '"]')

    $(".highlight").removeClass("highlight")
    $("td.add_comment").css("opacity", 0)

    first.addClass("highlight")
    last.addClass("highlight")
    last.find("td.add_comment").css("opacity", 100)

    if firstrow != currentrow
      first.nextUntil(last, "tr").addClass("highlight")


  $("td.line").mousemove((ev) ->
    if firstrow != -1 && dragging
      currentrow = Number($(this).parent().attr("data-line"))

      highlight_rows()

      ev.preventDefault()
  )

