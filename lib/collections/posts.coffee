#root = exports ? this
@Posts = new Mongo.Collection 'posts'

Posts.allow
  update: (userId, post)->
    ownsDocument userId, post
  remove: (userId, post)->
    ownsDocument userId, post

# post 는 update 이전의 post 객체를 의미함
# 변경된 post 는 modifier.$set 객
# deny 가 여러개인 경우 모든 deny callback 을 통과해야 함
Posts.deny
  update: (userId, post, fieldNames) ->
    _.without(fieldNames, 'url', 'title').length > 0

Posts.deny
  update: (userId, post, fieldNames, modifier) ->
    errors = validatePost modifier.$set
    return errors.title || errors.url

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

    errors = validatePost postAttributes
    if errors.title || errors.url
      throw new Meteor.Error 'Invalid-Post', "You must set a title and URL for your post"

#    if Meteor.isServer
#      postAttributes.title += '(server)'
#      Meteor._sleepForMs(5000)
#    else
#      postAttributes.title += '(client)'

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
      submitted: new Date()
      commentCount: 0
    postId = Posts.insert post
    {_id: postId}
