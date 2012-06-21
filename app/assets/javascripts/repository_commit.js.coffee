$ ->
  firstrow = -1
  currentrow = -1
  dragging = false

 	$("tr").mousedown((ev) ->
    if firstrow != -1 && currentrow != -1
      $(".highlight").removeClass("highlight")

    firstrow = Number($(this).attr("data-line"))
    currentrow = Number($(this).attr("data-line"))

    currentRow = -1
    dragging = true

    highlight_rows()

    ev.preventDefault()
  )

 	$("tr").mouseup((ev) ->
    dragging = false
  )

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


  $("tr").mousemove((ev) ->
    if firstrow != -1 && dragging
      currentrow = Number($(this).attr("data-line"))

      highlight_rows()

      ev.preventDefault()
  )

