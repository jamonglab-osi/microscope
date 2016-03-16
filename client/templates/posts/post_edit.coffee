Template.postEdit.created = ->
  Session.set 'postEditErrors', {}

Template.postEdit.helpers
  errorMessage: (field) ->
    Session.get('postEditErrors')[field]
  errorClass: (field) ->
    !!Session.get('postEditErrors')[field] ? 'has-error' : ''

Template.postEdit.events
  'submit form': (event)->
    event.preventDefault()

    currentPostId = @_id
    postProperties =
      url: $(event.target).find('[name=url]').val()
      title: $(event.target).find('[name=title]').val()

    errors = validatePost postProperties
    if errors.url || errors.title
      return Session.set 'postEditErrors', errors
    Posts.update currentPostId,
      $set: postProperties,
      (error)->
        if error
          throwError error.reason
        else
          Router.go 'postPage', _id:currentPostId

  'click .delete': (event)->
    event.preventDefault()

    if confirm('Delete this post ?')
      currentPostId = @_id
      Posts.remove currentPostId,
        (error)->
          if error
            throwError error.reason
          else
            Router.go 'postList'
