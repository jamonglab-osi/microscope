// Generated by CoffeeScript 1.10.0
Template.postList.helpers({
  posts: Posts.find({}, {
    sort: {
      submitted: -1
    }
  })
});

//# sourceMappingURL=post_list.js.map
