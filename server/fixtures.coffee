if Posts.find().count() < 3
  now = new Date().getTime()

  osiId = Meteor.users.insert
    profile: name: 'OSI'
  osi = Meteor.users.findOne osiId

  mandoId = Meteor.users.insert
    profile: name: 'Mando'
  mando = Meteor.users.findOne mandoId

  telescopeId = Posts.insert
    title: 'Introducing Telescope-changed',
    userId: mando._id
    author: mando.profile.name
    url: 'http://sachagreif.com/introducing-telescope/'
    submitted: new Date(now - 7 * 3600 * 1000)

  Comments.insert
    postId: telescopeId
    userId: osi._id
    author: osi.profile.name
    submitted: new Date(now - 5 * 3600 * 1000)
    body: 'Interesting project Mando, can i get involved?'

  Comments.insert
    postId: telescopeId
    userId: mando._id
    author: mando.profile.name
    submitted: new Date(now - 3 * 3600 * 1000)
    body: 'You sure can osi!'

  Posts.insert
    title: 'Meteor'
    userId: osi._id
    author: osi.profile.name
    url: 'http://meteor.com'
    submitted: new Date(now - 10 * 3600 * 1000)
  Posts.insert
    title: 'The Meteor Book'
    userId: osi._id
    author: osi.profile.name
    url: 'http://themeteorbook.com'
    submitted: new Date(now - 12 * 3600 * 1000)
