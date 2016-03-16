#root = exports ? this
@Posts = new Mongo.Collection('posts')

Meteor.methods
  postInsert: (postAttributes) ->
    check @userId, String
    check postAttributes,
      title: String
      url: String

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