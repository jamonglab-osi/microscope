if Posts.find().count() < 3
  Posts.insert
    title: 'Introducing Telescope-changed',
    url: 'http://sachagreif.com/introducing-telescope/'
  Posts.insert
    title: 'Meteor-changed'
    url: 'http://meteor.com'
  Posts.insert
    title: 'The Meteor Book-changed'
    url: 'http://themeteorbook.com'