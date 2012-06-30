$ ->
  firstrow = -1
  currentrow = -1
  dragging = false

  removeRowHighlighting = () ->
    if firstrow != -1 && currentrow != -1
      $(".highlight").removeClass("highlight")


  $("td.line").mousedown((ev) ->
    removeRowHighlighting()
    hideNewComments()

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
    $.ajax "/comments/new"
      type: 'get'
      success: (response_data, textStatus, jqXHR) ->
        last = $('tr[data-line="' + currentrow + '"]')
        last.after(response_data)
        new_response = last.next()
        file_diff_div = last.closest(".file-diff")
        commit_div = last.closest(".diffs")

        file_name = file_diff_div.attr("data-file")
        repo_id = commit_div.attr("data-repository")
        commit_id = commit_div.attr("data-commit")

        new_response.find("#comment_start_line").val(firstrow)
        new_response.find("#comment_end_line").val(currentrow)
        new_response.find("#comment_file").val(file_name)
        new_response.find("#comment_commit").val(commit_id)
        new_response.find("#comment_repository_id").val(repo_id)
        new_response.find("form").submit(saveCommentRow)
      failure: (jqXHR, textStatus, errorThrown) ->
        alert(textStatus)

  saveCommentRow = (event) ->
    event.preventDefault()
    valuesToSubmit = $(this).serialize()
    $.ajax "/comments"
      type: "post"
      data: valuesToSubmit
      dataType: "JSON"
      success: (response_data, textStatus, jqXHR) ->
        hideNewComments()
        removeRowHighlighting()
      failure: (jqXHR, textStatus, errorThrown) ->
        alert(textStatus)
    return false

  hideNewComments = () ->
    rows = $("tr.new-comment-row")
    rows.remove()

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

