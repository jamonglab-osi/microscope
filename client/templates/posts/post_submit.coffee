Template.postSubmit.created = ->
  Session.set 'postSubmitErrors', {}

Template.postSubmit.helpers
  errorMessage: (field) ->
    Session.get('postSubmitErrors')[field]
  errorClass: (field) ->
    !!Session.get('postSubmitErrors')[field] ? 'has-error' : ''

Template.postSubmit.events
  'submit form': (e) ->
    e.preventDefault()
    post =
      url: $(e.target).find('[name=url]').val()
      title: $(e.target).find('[name=title]').val()

    error = validatePost post
    if error.title || error.url
      return Session.set('postSubmitErrors', error)

    Meteor.call 'postInsert', post, (error, result)->
      if error
        return throwError error.reason

      if result.postExists
        throwError 'This link has already been posted'

#      post._id = Posts.insert(post)
      Router.go 'postPage', _id: result._id
#    Router.go 'postList'
