'use strict';

const assert = require('chai').assert;

const LinkedList = require('../lib/linked-list');
const createNode = require('../lib/node');

describe('LinkedList', () => {

  beforeEach(() => {
    this.list = new LinkedList('head');
  });

  it('should return an object with a head', () => {
    assert.property(this.list, 'head');
  });

  it('should be able to get the last node with #tail', () => {
    this.list.head.next = createNode('intermediary');
    this.list.head.next.next = createNode('last');

    assert.equal('last', this.list.tail.data);
  });

  it('can count the number of nodes in the list', () => {
    this.list.append('two').append('three');

    assert.strictEqual(3, this.list.count);
  });

  describe('#append', () => {

    it('should put a node onto the end of the list', () => {
      this.list.append('new node');

      assert.equal('new node', this.list.tail.data);
    });

  });

  describe('#prepend', () => {

    it('should put a node onto the beginning of the list', () => {
      this.list.prepend('new node');

      assert.equal('new node', this.list.head.data);
    });

  });

  describe('#includes', () => {

    it('can find a node with given data in the list', () => {
      this.list.append('find me').append('red herring');

      assert.isTrue(this.list.includes('find me'));
    });

    it('returns false if the value is not in the list', () => {
      assert.isFalse(this.list.includes('totally not in here'));
    });

  });

  describe('#findByValue', () => {

    it('can find a node with a given data', () => {
      this.list.append('find me').append('red herring');

      assert.equal('find me', this.list.findByValue('find me').data);
    });

  });

  describe('#findByIndex', () => {

    it('can find a node with a given data', () => {
      this.list.append('find me').append('red herring');

      assert.equal('find me', this.list.findByIndex(1).data);
    });

  });

  describe('#pop', () => {

    it('should remove the last node from the list', () => {
      this.list.append('new tail').append('pop me');

      let oldTail = this.list.pop();

      assert.equal('pop me', oldTail.data);
      assert.equal('new tail', this.list.tail.data);
    });

  });

  describe('#insert', () => {

    it('should remove the last node from the list', () => {
      this.list.append('after me').append('before me');

      this.list.insert('two', 2);

      assert.equal('two', this.list.findByIndex(2).data);
    });

  });

  describe('#removeByValue', () => {

    it('can remove a node with a given data', () => {
      this.list.append('remove me').append('red herring');

      this.list.removeByValue('remove me');

      assert.isFalse(this.list.includes('remove me'));
    });

  });

  describe('#removeByIndex', () => {

    it('can remove a node with a given data', () => {
      this.list.append('remove me').append('red herring');

      this.list.removeByIndex(1);

      assert.isFalse(this.list.includes('remove me'));
    });

  });

});