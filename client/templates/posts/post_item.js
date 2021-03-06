// Generated by CoffeeScript 1.10.0
Template.postItem.helpers({
  ownPost: function() {
    return this.userId === Meteor.userId();
  },
  domain: function() {
    var a;
    a = document.createElement('a');
    a.href = this.url;
    return a.hostname;
  },
  submittedText: function() {
    return this.submitted.toString();
  }
});

//# sourceMappingURL=post_item.js.map
