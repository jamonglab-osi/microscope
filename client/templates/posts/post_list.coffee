Template.postList.helpers
  posts: Posts.find {}, {sort: {submitted: -1}}
