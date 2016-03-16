#root = exports ? this
@Posts = new Mongo.Collection 'posts'

Posts.allow
  update: (userId, post)->
    ownsDocument userId, post
  remove: (userId, post)->
    ownsDocument userId, post

Posts.deny
  update: (userId, post, fieldName) ->
    _.without(fieldName, 'url', 'title').length > 0

@validatePost = (post)->
  errors = {}
  if !post.title
    errors.title = "Please fill in a headline"
  if !post.url
    errors.url = "Please fill in a URL"

  return errors

Meteor.methods
  postInsert: (postAttributes) ->
    check @userId, String
    check postAttributes,
      title: String
      url: String

    if Meteor.isServer
      postAttributes.title += '(server)'
      Meteor._sleepForMs(5000)
    else
      postAttributes.title += '(client)'

    postWithSameLink = Posts.findOne url: postAttributes.url

    if postWithSameLink
      return {
        postExists: true
        _id: postWithSameLink._id
      }
    user = Meteor.user()
    post = _.extend postAttributes,
      userId: user._id
      author: user.username
      submitted: new Date
    postId = Posts.insert post
    {_id: postId}
