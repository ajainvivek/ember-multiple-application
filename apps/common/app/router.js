import Ember from 'ember';

var Router = Ember.Router.extend({
  location: config.locationType
});

Router.map(function() {
  this.route('gettingStarted', {
    path : "/",

  });

  this.route('text-field');
});

export default Router;
