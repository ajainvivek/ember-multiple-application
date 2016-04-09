import { moduleForComponent, test } from 'ember-qunit';
import hbs from 'htmlbars-inline-precompile';

moduleForComponent('controls/ema-textfield', 'Integration | Component | controls/ema textfield', {
  integration: true
});

test('it renders', function(assert) {
  assert.expect(2);

  // Set any properties with this.set('myProperty', 'value');
  // Handle any actions with this.on('myAction', function(val) { ... });

  this.render(hbs`{{controls/ema-textfield}}`);

  assert.equal(this.$().text().trim(), '');

  // Template block usage:
  this.render(hbs`
    {{#controls/ema-textfield}}
      template block text
    {{/controls/ema-textfield}}
  `);

  assert.equal(this.$().text().trim(), 'template block text');
});
