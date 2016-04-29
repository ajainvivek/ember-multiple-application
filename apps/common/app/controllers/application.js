import Ember from 'ember';
import _ from 'lodash/lodash';

export default Ember.Controller.extend({
  widgets : [{
    id : 1,
    name : "content/ema-label",
    data : "Hello"
  }, {
    id : 2,
    name : "content/ema-label",
    data : "World"
  }, {
    id : 3,
    name : "content/ema-label",
    data : "Ajain!!"
  }],
  actions: {
    pushLabel() {
      let widgets = this.get("widgets");
      widgets.pushObject({
        name : "content/ema-label",
        data : "Testing"
      });
    },
    popLabel() {
      let widgets = this.get("widgets");
      let index = _.findIndex(widgets, function(widget) {
        return widget.id === 2;
      });
      Ember.$("#2").slideUp("slow", function () {
        widgets.removeObject(widgets[index]);
      });
    }
  }
});
