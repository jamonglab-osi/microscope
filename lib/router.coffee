if Meteor.isClient
  Router.configure
    layoutTemplate: 'layout'
    loadingTemplate: 'loading'
    notFoundTemplate: 'notFound'
    waitOn: ->
      Meteor.subscribe('posts')

  Router.route '/', name:'postList'
  Router.route '/posts/:_id',
    name:'postPage'
    data: ()-> Posts.findOne(@.params._id)

# 유효하지만 Data가 없는 경우의 404 Display를 위한 Iron Router hook
  Router.onBeforeAction 'dataNotFound', only:'postPage'