if Meteor.isClient
  Router.route '/', name:'postList'

#  Router.map ->
#    @route 'postList', path: '/'

  Router.configure
    layoutTemplate: 'layout',
    loadingTemplate: 'loading',
    waitOn: ->
      Meteor.subscribe('posts')

