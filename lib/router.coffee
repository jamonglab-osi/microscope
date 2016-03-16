#if Meteor.isClient
Router.configure
  layoutTemplate: 'layout'
  loadingTemplate: 'loading'
  notFoundTemplate: 'notFound'
  waitOn: ->
    Meteor.subscribe('posts')

#Router.route '/',
#  name:'postList'
#Router.route '/posts/:_id',
#  name:'postPage'
#  data: ()-> Posts.findOne @params._id
#Router.route '/posts/:_id/edit',
#  name:'postEdit'
#  data: ()-> Posts.findOne @.params._id
#Router.route '/submit',
#  name:'postSubmit'

Router.map ->
  @route 'postList',
    path: '/'
  @route 'postPage',
    path: '/posts/:_id'
    data: ->
      Posts.findOne @params._id
  @route 'postEdit',
    path: '/post/:_id/edit'
    data: ->
      Posts.findOne @params._id
  @route 'postSubmit',
    path: '/submit'


requireLogin = ->
  if !Meteor.user()
#      Login 중인 경우 Spin 로딩중 Template Display
    if Meteor.loggingIn()
      @render @loadingTemplate
    else
      @render 'accessDenied'
  else
    @next()
  return

# 유효하지만 Data가 없는 경우의 404 Display를 위한 Iron Router hook
Router.onBeforeAction 'dataNotFound', only:'postPage'
Router.onBeforeAction requireLogin, only: 'postSubmit'