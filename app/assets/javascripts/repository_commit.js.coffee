$ ->
  firstrow = -1
  currentrow = -1
  dragging = false
  parentFile = null

  removeRowHighlighting = () ->
    if firstrow != -1 && currentrow != -1
      $(".highlight").removeClass("highlight")

  removeFading = (fileDiv) ->
    fileDiv.find("tr.faded").removeClass("faded")

  $("td.line").mousedown((ev) ->
    removeRowHighlighting()
    hideNewComments()

    firstrow = Number($(this).parent().attr("data-line"))
    currentrow = Number($(this).parent().attr("data-line"))
    parentFile = $(this).closest(".file-diff")

    currentRow = -1
    dragging = true

    highlight_rows()

    ev.preventDefault()
  )

  $("td.line").mouseup((ev) ->
    dragging = false
  )

  focusRows = (fileDiv, firstRow, lastRow) ->
    first = fileDiv.find('tr[data-line="1"]')
    last = fileDiv.find('tr[data-line="1"]')
    beginning = fileDiv.find('tr[data-line="' + firstRow + '"]')
    end = fileDiv.find('tr[data-line="' + lastRow + '"]')

    previousRows = beginning.prevUntil(first, "tr")
    nextRows = end.nextUntil(last, "tr")

    previousRows.addClass("faded")
    nextRows.addClass("faded")

  $('.add_comment a').click (event) ->
    event.preventDefault()
    if $("tr.new-comment-row").length == 0
      insertCommentRow()
      fileDiv = $(this).closest(".file-diff")
      focusRows(fileDiv, firstrow, currentrow)

  insertCommentRow = ->
    $.ajax "/comments/new"
      type: 'get'
      success: (response_data, textStatus, jqXHR) ->
        last = parentFile.find('tr[data-line="' + currentrow + '"]')
        last.after(response_data)
        new_response = last.next()

        prepareNewCommentForm(new_response)

      failure: (jqXHR, textStatus, errorThrown) ->
        alert(textStatus)

  prepareNewCommentForm = (newForm) ->
    file_diff_div = newForm.closest(".file-diff")
    commit_div = newForm.closest(".diffs")

    file_name = file_diff_div.attr("data-file")
    repo_id = commit_div.attr("data-repository")
    commit_id = commit_div.attr("data-commit")

    newForm.find("#comment_start_line").val(firstrow)
    newForm.find("#comment_end_line").val(currentrow)
    newForm.find("#comment_file").val(file_name)
    newForm.find("#comment_commit").val(commit_id)
    newForm.find("#comment_repository_id").val(repo_id)
    newForm.find("form").submit(saveCommentRow)
    newForm.find("#save_new_comment").click (event) ->
      event.preventDefault()
      newForm.find("form").submit()

    newForm.find("#close_new_comment").click (event) ->
      event.preventDefault()
      removeRemoveAndResetCode(newForm)


  $("td.comments a").click (event) ->
    event.preventDefault()
    fileDiv = $(this).closest(".file-diff")
    id = $(this).attr("data-id")

    if fileDiv.find('tr.show-comment-row[data-id="' + id + '"]').length == 0
      showComment(id, fileDiv, $(this).attr("data-start"), $(this).attr("data-end"))

  showComment = (commentId, fileDiv, startLine, endLine) ->
    focusRows(fileDiv, startLine, endLine)
    $.ajax "/comments/" + commentId,
      type: "get"
      success: (responseData, textStatus, jqXHR) ->
        last = fileDiv.find('tr[data-line="' + endLine + '"]')
        last.after(responseData)
        commentForm = last.next()

        commentForm.find("#close_commit_comment").click (event) ->
          event.preventDefault()
          removeRemoveAndResetCode(commentForm)

        commentForm.find("#delete_commit_comment").click (event) ->
          event.preventDefault()
          removeRemoveAndResetCode(commentForm)
          $('td.comments a[data-id="' + commentId + '"]').remove()

      failure: (jqXHR, textStatus, errorThrown) ->
        alert(textStatus)

  removeRemoveAndResetCode = (toRemove) ->
    removeRowHighlighting()
    removeFading(toRemove.closest(".file-diff"))
    toRemove.remove()

  saveCommentRow = (event) ->
    event.preventDefault()
    valuesToSubmit = $(this).serialize()
    $.ajax "/comments"
      type: "post"
      data: valuesToSubmit
      dataType: "JSON"
      success: (response_data, textStatus, jqXHR) ->
        first = parentFile.find('tr[data-line="' + firstrow + '"]')
        comment = first.find("td.comments")
        comment.append(response_data.data)

        comment.find("a").click (event) ->
          event.preventDefault()
          fileDiv = $(this).closest(".file-diff")
          id = $(this).attr("data-id")

          if fileDiv.find('tr.show-comment-row[data-id="' + id + '"]').length == 0
            showComment(id, fileDiv, $(this).attr("data-start"), $(this).attr("data-end"))


        hideNewComments()
        removeRowHighlighting()
    return false

  hideNewComments = () ->
    newCommentRows = $("tr.new-comment-row")
    newCommentRows.remove()

    $("tr.faded").removeClass("faded")

  highlight_rows = () ->
    if currentrow < firstrow
      temp = firstrow
      firstrow = currentrow
      currentrow = temp

    first = parentFile.find('tr[data-line="' + firstrow + '"]')
    last = parentFile.find('tr[data-line="' + currentrow + '"]')

    parentFile.find(".highlight").removeClass("highlight")
    parentFile.find("td.add_comment").css("opacity", 0)

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

